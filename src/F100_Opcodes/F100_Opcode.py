## ============================================================================
## F100_Opcode.py 
##
## COPYRIGHT 2016 Richard Evans, Ed Spittles
##
## This file is part of f100l - an set of utilities for programming and 
## emulation of the Ferranti F100-L CPU and peripheral components.
##
## f100l is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## f100l is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##
## See  <http://www.gnu.org/licenses/> for a copy of the GNU Lesser General 
## Public License
##
## ============================================================================
'''
Instruction Definitions
=======================

The following pages present complete descriptions for all instructions implemented in the F100-L.

Addressing Modes
----------------

The F100-L CPU supports 4 addressing modes and these are described below together
with the assembler syntax.

**Direct addressing**
  
The address of the operand data is encoded in an 11 bit field in the opcode word. In the 
assembler this mode is denoted by providing just a bare operand. e.g. 

  ::

    AND 0x444  ;  A <- A & (0x444)

If an operand is used which is larger than 11 bits, the assembler will emit a warning
and instead assemble the instruction using the Immediate Indirect Addressing mode below.
This will always achieve the correct behaviour, but the latter mode requires two instruction
words where Direct Addressing, with a smaller operand, needs only one.

**Immediate addressing**

The 16 bit operand data is placed in the word immediately following the opcode. In the 
assembler this mode is denoted by a comma (,) immediately before the operand e.g. 

  ::

    AND ,0x4444 ; A <- A & 0x4444

**Pointer addressing**

The address of the operand data is encoded in an 8 bit field in the opcode word. 
Optionally the value of this pointer can be pre-incremented or post-decremented. 
This mode is denoted in the assembler by a slash (/) immediately in front of the 
operand and optionally a plus (+) or minus (-) symbol following. e.g.

  :: 

    AND /0x44  ;  A <- A & (0x44)
    AND /0x44+ ;  (0x44) <- (0x44) + 1 ; A <- A & (0x44)
    AND /0x44- ;  A <- A & (0x44) ; (0x44) <- (0x44) -1

**Immediate indirect addressing**

The 15 bit address of the operand data is placed in the word immediately following
the opcode. This mode is denoted in the assembler by a dot (.) immediately in front
of the operand, e.g.

  ::

    AND .0x4444  ;  A <- A & (0x4444)

Instruction Encoding
--------------------

All instruction encodings are defined as overlapping but mutually exclusive bit fields.

The bit fields are defined as follows

  +------+---------------+---------------+----------------------------------------------------------------+
  |Field |Number of bits | Bit positions | Comment                                                        | 
  +------+---------------+---------------+----------------------------------------------------------------+
  |  F   |      4        |  15..12       | Instruction class or function                                  |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  I   |      1        |      11       | Address Mode                                                   |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  T   |      2        |   11,10       | General field to qualify F=0 instructions                      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  R   |      2        |     9,8       | Register field or auto-index mode for indirect addressing      | 
  +------+---------------+---------------+----------------------------------------------------------------+
  |  S   |      2        |     7,6       | General field to qualify F=0 instructions                      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  J   |      2        |     5,4       | General field to qualify F=0 instructions                      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  N   |     11        |   10..0       | Memory address for direct addressing                           |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  P   |      8        |    7..0       | Memory address used as pointer for pointer indirect addressing |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  B   |      4        |    3..0       | Shift number or bit significance                               |
  +------+---------------+---------------+----------------------------------------------------------------+

Where a don't care (x) bit is presented in the tables, the assembler will consistently use a '0'. The 
emulator will ignore this field during decoding.

Instruction Timings
-------------------

All instruction timings are defined using the following definitions

  * Ra1 = Program memory read access time
  * Ra2 = Data memory read access time
  * Rc1 = Program memory read cycle time
  * Rc2 = Data memory read cycle time
  * M   = Read-modify-write cycle time
  * Wc  = Data memory write cycle time
  * L   = 1 Logic cycle time (2x period of the CPU clock input)

Abbrieviations
--------------

Definitions ::

  N   11 bit memory address (associated with opcode field N above)
  P    8 bit memory address (associated with opcode field P above)
  W   15 bit memory address
  D   16 bit immediate data 
  \(N\)   Contents of memory location N
  \(P\)   Contents of memory location P
  \(W\)   Contents of memory location W
'''
import re

ADM_DIRECT = 0
ADM_IMMEDIATE = 1
ADM_IMMEDIATE_INDIRECT = 2
ADM_POINTER_INDIRECT = 3
ADM_POINTER_INDIRECT_PREINC = 4
ADM_POINTER_INDIRECT_POSTDEC = 5

prefix_postfix_re = re.compile( r'([\.\/\,])?((?:.*(?=[+-]$))|(?:.*))([+-])?')
address_mode_keys = { 
    None: ADM_DIRECT, 
    ',' : ADM_IMMEDIATE, 
    '.' : ADM_IMMEDIATE_INDIRECT, 
    '/' : ADM_POINTER_INDIRECT,    
    '+' : ADM_POINTER_INDIRECT_PREINC, 
    '-' : ADM_POINTER_INDIRECT_POSTDEC }


def validate_operand( operand, lo=0, hi=0, bits=0 ):
    if not ( lo <= operand <= hi ):
        raise UserWarning("Error: Operand 0x%04X out of range for this addressing mode, %d bit operand must be between 0x%04X and 0x%04X." % (operand, bits, lo, hi))
    return True
                          
def get_operand_value( operand_string, symbol_table, suppress_errors):
    try:
        operand_val = symbol_table.eval_expr(operand_string)
    except ValueError as v:
        if suppress_errors:
            operand_val = 0x0F
            return(operand_val, v)
        else:
            raise(v)
    return(operand_val, None)

class F100_Opcode :
    def __init__ (self, opcode_fn = {}, CPU=None):
        # Define fields as on p13 of the F100-L Hardware Manual
        self.F = None   # Function field
        self.I = None   # Address Mode
        self.N = None   # Memory Address (11 bit - direct addressing)
        self.W = None   # Memory Address (15 bit - imm. ind. addressing)
        self.W1 = None  # Memory Jump Address (15 bit - imm. ind. addressing)
        self.P = None   # Memory Address containing pointer for ptr ind. addressing
        self.R = None   # Register field or auto-index mode for ind. addressing
        self.J = None   # General field to qualify F=0 instructions
        self.T = None   #                 "
        self.S = None   #                 "
        self.D = None   # 16 bit immediate data
        self.B = None   # Shift Number of bit significance
        self.opcode_regexp = re.compile(r'AND')    
        self.code = []
        self.CPU = CPU  # CPU resources for use in emulation
        ## Opcode_fn will be a dictionary of opcode names and F field values
        self.opcode_fn = opcode_fn
        ## Pack the names into a regexp for matching
        self.opcode_regexp = re.compile(r'%s' % '|'.join(self.opcode_fn.keys()))    

         
    def get_address_mode(self, operand):
        # Determine the address mode and strip the prefix/postfix from the operand string
        (prefix, stripped_operand, postfix) = prefix_postfix_re.match(operand.strip()).groups()
        mode = address_mode_keys[prefix] 
        if mode == ADM_POINTER_INDIRECT and postfix:
            mode = address_mode_keys[postfix]
        elif postfix:
            raise UserWarning( "Error: Invalid addressing mode")
        return(mode, stripped_operand)

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        ## This is the method to override to process the token and raw operands
        ## into an array of data to return to the calling process. The generic 
        ## definition is the one which covers the vast majority of opcodes
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])

        warnings = []
        words = []

        (first_operand_val, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)

        if opcode_token in self.opcode_fn:
            self.F = self.opcode_fn[opcode_token]
        else:
            raise UserWarning( "Error: Cannot deal with opcode %s" % opcode_token)
            
        # Cannot use direct mode with operand of 0 so silently transform to more suitable mode        
        if addr_mode == ADM_DIRECT and first_operand_val == 0:
            addr_mode = ADM_IMMEDIATE_INDIRECT
            warnings.append("Warning: Cannot use direct mode with operand of 0 so will assemble to immediate indirect instead")

        # Set the various Opcode fields now based on addressing modes and instruction function
        if addr_mode == ADM_DIRECT:
            validate_operand(first_operand_val, 1, 0x7FF, 11)
            self.N = first_operand_val
            self.I = 0       
        elif addr_mode == ADM_IMMEDIATE:
            validate_operand(first_operand_val, 0, 0xFFFF, 16)
            self.N = 0
            self.I = 0       
            self.D = first_operand_val
        elif addr_mode in ( ADM_POINTER_INDIRECT, ADM_POINTER_INDIRECT_PREINC, ADM_POINTER_INDIRECT_POSTDEC):
            validate_operand(first_operand_val, 1, 0xFF, 8)
            self.P = first_operand_val
            self.I = 1
            if addr_mode == ADM_POINTER_INDIRECT:
                self.R = 0
            elif addr_mode in (ADM_POINTER_INDIRECT_POSTDEC, ADM_POINTER_INDIRECT_PREINC):
                self.R = 1 if addr_mode == ADM_POINTER_INDIRECT_PREINC else 3
        elif addr_mode == ADM_IMMEDIATE_INDIRECT:
            validate_operand(first_operand_val, 0, 0x7FFF, 15)
            self.P = 0
            self.I = 1
            self.W = first_operand_val

        return (self.bitassemble(), warnings)

    def bitassemble( self ) :        
        # assemble the opcode bits and pieces
        self.code = []    

        opcode = self.F << 12
        if self.T :
            opcode |= self.T << 10
        if self.R : 
            opcode |= self.R << 8
        if self.S : 
            opcode |= self.S << 6
        if self.J : 
            opcode |= self.J << 4
        if self.B : 
            opcode |= self.B
        if self.I:
            opcode |= self.I << 11
        if self.P:
            opcode |= self.P
        if self.N:
            opcode |= self.N
            
        self.code.append(opcode)

        if self.D != None:
            self.code.append(self.D)
        for W in ( self.W, self.W1 ) :
            if W != None:
                self.code.append(W)

        return self.code   


    
    def get_operand(self):
        '''
        Return operand for use with standard addressing modes in emulation
        '''
        cycles = 0
        IR = self.CPU.IR
        CR = self.CPU.CR
        
        operand = None
        if ( IR.F != self.F):
            raise UserWarning("Cannot execute opcode %04X using opcode class %s" % (opcode, self.__name__) )
        elif IR.I==0 and IR.N==0:
            operand = self.CPU.memory_fetch()
        elif IR.I==0:
            operand = self.memory_read(IR.N)           
        elif IR.I==1 and IR.P==0:
            operand = self.CPU.memory_fetch()
            operand = self.CPU.memory_read(operand)
        elif IR.I==1:
            if IR.R==1: 
                IR.P += 1
            operand = self.CPU.memory_read(IR.P)           
            if IR.R==3:
                IR.P -= 1        
        return (operand, cycles)


    def exec(self):
        '''
        On entry the CPU instruction register is already populated and the PC is pointing
        to the next instruction or the first operand
        '''
        pass    
    
    def disassemble(self):
        pass

    
class OpcodeClass0a(F100_Opcode) :
    '''
    JBC d A|CR|mMMM mMMM
    JBS d A|CR|mMMM mMMM
    JCS d A|CR|mMMM mMMM
    JSC d A|CR|mMMM mMMM
    '''

    def __init__ (self):
        super().__init__( opcode_fn = { "JBC":0, "JBS":0, "JCS":0, "JSC":0 } )

        
    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        warnings = []
        words = []

        (first_operand_val, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)

        if opcode_token in self.opcode_fn:
            self.F = self.opcode_fn[opcode_token]
        else:
            raise UserWarning( "Error: Cannot deal with opcode %s" % opcode_token)

        if addr_mode != ADM_DIRECT or len(operands) != 3 :
            raise UserWarning("Error: %s instruction can use only direct addressing with a 4 bit operand, register or 15 bit second operand and a 15 bit jump address")

        self.T = 0
        self.S = 2

        validate_operand(first_operand_val, 0, 0x0F, 4)
        if opcode_token == "JBC":                
            self.J = 0
        elif opcode_token == "JBS":
            self.J = 1
        elif opcode_token == "JCS":                
            self.J = 2
        elif opcode_token == "JSC":
            self.J = 3

        self.B = first_operand_val

        if operands[1] == "A":
            self.R = 0
        elif operands[1] == "CR":
            self.R = 1
        else:
            self.R = 3

            (second_operand_val, w ) = get_operand_value(operands[1], symbol_table, suppress_errors)
            if w != None:
                warnings.append(w)
            validate_operand(second_operand_val, 0, 0x7FFF, 15)
            self.W = second_operand_val

        (third_operand_val, w ) = get_operand_value(operands[2], symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)
        validate_operand(third_operand_val, 0, 0x7FFF, 15)            

        if self.W == None:
            self.W = third_operand_val
        else:
            self.W1 = third_operand_val

        return( self.bitassemble(), warnings)


class OpcodeClass0b(F100_Opcode) :
    '''
    SRE  d  A|CR|mMMM
    SLE  d  A|CR|mMMM
    SRA  d  A|CR|mMMM
    SLA  d  A|CR|mMMM
    SRL  d  A|CR|mMMM
    SLL  d  A|CR|mMMM
    CLR  d  A|CR|mMMM
    SET  d  A|CR|mMMM
    '''

    def __init__ (self):
        super().__init__(opcode_fn = { "SRE":0, "SLE":0, "SLA":0, "SRA":0, "SRL":0, "SLL":0, "CLR":0, "SET":0 } )

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        # Shift, SET, CLR can use one or two operands 
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        warnings = []
        words = []

        (first_operand_val, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)
        
        if opcode_token in self.opcode_fn:
            self.F = self.opcode_fn[opcode_token]
        else:
            raise UserWarning( "Error: Cannot deal with opcode %s" % opcode_token)

        if addr_mode != ADM_DIRECT or len(operands) != 2:
            raise UserWarning("Error: %s instruction can use only direct addressing with a 4 bit operand and optional register or 15 bit second operand")

        self.T = 0                  
        if opcode_token == "SRA":                
            self.S = 0
            self.J = 0
        elif opcode_token == "SRL":
            self.S = 0
            self.J = 2
        elif opcode_token == "SLA":                
            self.S = 1
            self.J = 0
        elif opcode_token == "SLL":
            self.S = 1
            self.J = 2
        elif opcode_token == "SRE":                
            self.S = 0
            self.J = 3
        elif opcode_token == "SLE":
            self.S = 1
            self.J = 3
        elif opcode_token == "CLR":
            self.S = 3
            self.J = 3
        else: # SET
            self.S = 3
            self.J = 2
            
        validate_operand(first_operand_val, 0, 0x0F, 4)

        self.B = first_operand_val

        if ( len(operands) == 1 ) :
            self.R = 0
        else:
            if operands[1] == "A":
                self.R = 0
            elif operands[1] == "CR":
                self.R = 1
            else:
                self.R = 3

                (second_operand_val, w ) = get_operand_value(operands[1], symbol_table, suppress_errors)
                if w != None:
                    warnings.append(w)

                validate_operand(second_operand_val, 0, 0x7FFF, 15)
                self.W = second_operand_val

        return( self.bitassemble(), warnings)


class OpcodeClass013(F100_Opcode) :
    '''
    HALT
    SJM
    RTN
    RTC
    '''

    def __init__ (self):
        super().__init__(opcode_fn = { "HALT":0, "SJM":1, "RTN":3, "RTC":3 } )

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        if len(operands) > 0:
            warnings.append("Warning: Instruction %s takes no operands, so operand field%s will be ignored" % (opcode_token, '' if len(operands)< 2 else 's'))
            
        if opcode_token in self.opcode_fn:
            self.F = self.opcode_fn[opcode_token]
        else:
            raise UserWarning( "Error: Cannot deal with opcode %s" % opcode_token)

        if opcode_token == "HALT":
            self.T = 1        
        elif opcode_token == "SJM":
            pass
        elif opcode_token == "RTN":
            self.I = 0
        elif opcode_token == "RTC":
            self.I = 1

        return( self.bitassemble(), warnings)



        

        
class OpcodeClass4(F100_Opcode) :
    '''
    OPD   dDD     
    OPD .mMMM     
    OPD   /DD(+-) 
    OPD ,DDDD     


   where OPD is one of SUB, ADD, LDA, SBS, ADS, STO

    
    '''

    def __init__ (self):
        super().__init__( opcode_fn = { "SUB":10, "ADD":9, 
                                        "LDA":8, "SBS":6, "ADS":5, 
                                        "STO":4 } )



