
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
F100_Opcode
===========

Basic class for all F100 opcodes which defines all the required bit fields and
a method for assembling these into an opcode word. Individual instruction definitions
should overrire the opcode_regexp (to register which opcode will be handled by the
subclass) and then provide the assemble() method to fill out the opcodes.

TODO:
- OpcodeClass01 
  o HALT could take a 10bit operand
  o EXTFN with an 11 bit identified is not implemented yet
- OpcodeClass0b
  o Syntax for double length SHIFTs is not implemented (not clear how this works
    given than internal state needs setting to enable a double length shift...)
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
    def __init__ (self, opcode_fn = {}):
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


class OpcodeClass0a(F100_Opcode) :
    '''
    JBC d A|C|mMMM mMMM
    JBS d A|C|mMMM mMMM
    JCS d A|C|mMMM mMMM
    JSC d A|C|mMMM mMMM
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
        elif operands[1] == "C":
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
    SRE  d  A|C|mMMM
    SLE  d  A|C|mMMM
    SRA  d  A|C|mMMM
    SLA  d  A|C|mMMM
    SRL  d  A|C|mMMM
    SLL  d  A|C|mMMM
    CLR  d  A|C|mMMM
    SET  d  A|C|mMMM
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
            elif operands[1] == "C":
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


class OpcodeClass2(F100_Opcode) :
    '''
    CAL   dDD     
    CAL .mMMM     
    CAL   /DD 
    CAL ,DDDD     
    '''
    def __init__ (self):
        super().__init__( opcode_fn = { "CAL":2 } )

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        # CAL instruction cannot use pointer post/pre inc/dec addressing modes but otherwise
        # is the same as the generic opcode class
        if addr_mode in (ADM_POINTER_INDIRECT_POSTDEC, ADM_POINTER_INDIRECT_PREINC):
            raise UserWarning("Error: Illegal address mode for this operation - pre increment/post decrement not supported")
        else:
            return(super().assemble(opcode_token, operands, symbol_table, suppress_errors))


class OpcodeF12(F100_Opcode) :
    '''
    AND
    ===
    
    Logical AND of accumulator with specified operand
    
    Function
    --------
    
    ::
       
       AND N      A <- A & (N)
       AND ,D     A <- A & D
       AND /P     A <- A & (P)
       AND /P+    P <- P + 1 ; A <- A & (P) 
       AND /P-    A <- A & (P) ; P <- P - 1
       AND .W     A <- A & (W)
    
    Instruction Encoding
    --------------------
    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1100|1'b0|     11'b<non-zero addr>    |           none      | AND N    | Ra1 + Ra2 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1100|1'b0|     11'b000000000000       |        16b'<data>   | AND ,D   | Ra1 + Rc1 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1100|1'b1|1'bx|2'bx0|8'b<non-zero ptr>|           none      | AND /P   | Ra1 + Ra2 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1100|1'b1|1'bx|2'b01|8'b<non-zero ptr>|           none      | AND /P+  | Ra1 + M + 34L        |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1100|1'b1|1'bx|2'b11|8'b<non-zero ptr>|           none      | AND /P-  | Ra1 + M + 34L        |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1100|1'b1|1'bx|2'bxx|8'b00000000      |1'bx|   15b'<addr>   | AND .W   | Ra1 + Ra2 + Rc1 + 18L|
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
    where
    
    * Ra1 = Program memory read access time
    * Ra2 = Data memory read access time
    * Rc1 = Program memory read cycle time
    * Rc2 = Data memory read cycle time
    * M   = Read-modify-write cycle time
    * Wc  = Data memory write cycle time
    * L   = 1 Logic cycle time (2x period of the CPU clock input)
    
      
     Condition Register
     ------------------
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- |\- | 1 | * | x | * |\- | 
     +---+---+---+---+---+---+---+ 
    
     * C is always set to 1
     * Z is set if the result is all-zeroes, otherwise cleared
     * S is set if the MSB of the result is a '1', otherwise cleared
     * V is undefined after this operation
    '''    
    def __init__ (self):
        super().__init__( opcode_fn = { "AND":12} )


class OpcodeF13(F100_Opcode) :
    '''
    NEQ (XOR)
    =========
    
    Logical XOR of accumulator with specified operand
    
    Function
    --------
    
    ::
       
       NEQ N      A <- A & (N)
       NEQ ,D     A <- A & D
       NEQ /P     A <- A & (P)
       NEQ /P+    P <- P + 1 ; A <- A & (P) 
       NEQ /P-    A <- A & (P) ; P <- P - 1
       NEQ .W     A <- A & (W)
    
    Instruction Encoding
    --------------------
    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1100|1'b0|     11'b<non-zero addr>    |           none      | NEQ N    | Ra1 + Ra2 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1100|1'b0|     11'b000000000000       |        16b'<data>   | NEQ ,D   | Ra1 + Rc1 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1100|1'b1|1'bx|2'bx0|8'b<non-zero ptr>|           none      | NEQ /P   | Ra1 + Ra2 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1100|1'b1|1'bx|2'b01|8'b<non-zero ptr>|           none      | NEQ /P+  | Ra1 + M + 34L        |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1100|1'b1|1'bx|2'b11|8'b<non-zero ptr>|           none      | NEQ /P-  | Ra1 + M + 34L        |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1100|1'b1|1'bx|2'bxx|8'b00000000      |1'bx|   15b'<addr>   | NEQ .W   | Ra1 + Ra2 + Rc1 + 18L|
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
    where
    
    * Ra1 = Program memory read access time
    * Ra2 = Data memory read access time
    * Rc1 = Program memory read cycle time
    * Rc2 = Data memory read cycle time
    * M   = Read-modify-write cycle time
    * Wc  = Data memory write cycle time
    * L   = 1 Logic cycle time (2x period of the CPU clock input)
    
      
     Condition Register
     ------------------
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- |\- | 1 | * | x | * |\- | 
     +---+---+---+---+---+---+---+ 
    
     * C is always set to 1
     * Z is set if the result is all-zeroes, otherwise cleared
     * S is set if the MSB of the result is a '1', otherwise cleared
     * V is undefined after this operation
    '''    
    def __init__ (self):
        super().__init__( opcode_fn = { "NEQ":13, "XOR":13} )
        

        
class OpcodeClass4(F100_Opcode) :
    '''
    OPD   dDD     
    OPD .mMMM     
    OPD   /DD(+-) 
    OPD ,DDDD     


   where OPD is one of JMP, CMP, SUB, ADD, LDA, SBS, ADS, STO

    
    '''
    def __init__ (self):
        super().__init__( opcode_fn = { "JMP":15, 
                                        "CMP":11, "SUB":10, "ADD":9, 
                                        "LDA":8, "SBS":6, "ADS":5, 
                                        "STO":4 } )


class OpcodeClass7(F100_Opcode) :
    '''
    ICZ   dDD     mMMM
    ICZ .mMMM     mMMM
    ICZ   /DD(+-) mMMM
    ICZ ,DDDD     mMMM
    '''
    def __init__ (self):
        super().__init__( opcode_fn = { "ICZ":7 } )

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        words = []

        if len(operands) != 2:
           raise UserWarning("Error: Instruction ICZ requires two operands, but %d provided" % len(operands))         

        (addr_mode, first_operand ) = self.get_address_mode(operands[0])

        operand_values = []
        for o in (first_operand, operands[1]):
            (operand_val, w ) = get_operand_value(o, symbol_table, suppress_errors)
            if w != None:
                warnings.append(w)
            operand_values.append(operand_val)

        if opcode_token in self.opcode_fn:
            self.F = self.opcode_fn[opcode_token]
        else:
            raise UserWarning( "Error: Cannot deal with opcode %s" % opcode_token)
            
        # Cannot use direct mode with operand of 0 so silently transform to more suitable mode        
        if addr_mode == ADM_DIRECT and operand_values[0] == 0:
            addr_mode = ADM_IMMEDIATE_INDIRECT
            warnings.append("Warning: Cannot use direct mode with operand of 0 so will assemble to immediate indirect instead")

        validate_operand( operand_values[1], 0, 0x7FFF, 15)
        # Set the various Opcode fields now based on addressing modes and instruction function
        if addr_mode == ADM_DIRECT:
            validate_operand( operand_values[0], 1, 0x07FF, 11)            
            self.N = operand_values[0]
            self.W = operand_values[1]
            self.I = 0       
        elif addr_mode == ADM_IMMEDIATE:
            validate_operand( operand_values[0], 0, 0xFFFF, 16)                        
            self.N = 0
            self.I = 0       
            self.D = operand_values[0]
            self.W = operand_values[1]
        elif addr_mode in ( ADM_POINTER_INDIRECT, ADM_POINTER_INDIRECT_PREINC, ADM_POINTER_INDIRECT_POSTDEC):
            validate_operand( operand_values[0], 1, 0xFF, 8)                                    
            self.P = operand_values[0]
            self.I = 1
            if addr_mode == ADM_POINTER_INDIRECT:
                self.R = 0
            elif addr_mode in (ADM_POINTER_INDIRECT_POSTDEC, ADM_POINTER_INDIRECT_PREINC):
                self.R = 1 if addr_mode == ADM_POINTER_INDIRECT_PREINC else 3
            self.W = operand_values[1]
        elif addr_mode == ADM_IMMEDIATE_INDIRECT:
            validate_operand( operand_values[0], 0, 0x7FFF, 15)            
            self.P = 0
            self.I = 1
            self.W = operand_values[0]
            self.W1 = operand_values[1]

        return (self.bitassemble(), warnings)
