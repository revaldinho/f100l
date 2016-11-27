from .F100_Opcode import *

class OpcodeF0_Jump(F100_Opcode) :
    '''
    JBC d A|CR|mMMM mMMM
    JBS d A|CR|mMMM mMMM
    JCS d A|CR|mMMM mMMM
    JSC d A|CR|mMMM mMMM
    '''

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "JBC":0, "JBS":0, "JCS":0, "JSC":0 }, CPU=CPU )
        self.F = 0
        
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


class OpcodeF0_Shift(F100_Opcode) :
    '''
    SRE  d  A|CR|mMMM
    SLE  d  A|CR|mMMM
    SRA  d  A|CR|mMMM
    SLA  d  A|CR|mMMM
    SRL  d  A|CR|mMMM
    SLL  d  A|CR|mMMM
    '''

    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "SRE":0, "SLE":0, "SLA":0, "SRA":0, "SRL":0, "SLL":0 }, CPU=CPU )
        self.F = 0
        
    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        # Shift can use one or two operands
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


class OpcodeF0_Bit(F100_Opcode) :
    '''
    SRE  d  A|CR|mMMM
    SLE  d  A|CR|mMMM
    SRA  d  A|CR|mMMM
    SLA  d  A|CR|mMMM
    SRL  d  A|CR|mMMM
    SLL  d  A|CR|mMMM
    '''

    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "CLR":0, "SET":0 }, CPU=CPU )
        self.F = 0

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        # SET, CLR can use one or two operands 
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

        if opcode_token == "CLR":
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


class OpcodeF0_Halt(F100_Opcode) :
    '''
    The HALT instruction stops the CPU and prevents the F100-L from executing any further instructions.

    Once stopped the CPU can only be restarted by driving the RUN* pin high (the 'STOP' state) and then
    low again.

    The least significant 10 bits of the Opcode are ignored by the processor but can be used by the
    programmer to provide a halt number. The assembler allows the HALT instruction to appear either
    with or without an operand and in the latter case the 10 LSBs will be encoded into the opcode.

    ::
       
       HALT       Stop processor execution
       HALT ,D    Stop processor execution

    **Instruction Encoding**
    
     +-------+----+----------------------------+----------+----------------------+
     |              Opcode Word                | Function | Cycle count          |
     +-------+----+----------------------------+          |                      |
     |  F    |  T |    Halt Number             |          |                      |
     +-------+----+----------------------------+----------+----------------------+
     |4`b0000|2`b1|    10`b<Halt Number>       | HALT     | TBC                  |
     +-------+----+----+-----+-----------------+----------+----------------------+ 
      
     **Condition Register**
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- | \-| \-| \-| \-| \-| \-|
     +---+---+---+---+---+---+---+

     * The condition register is unaffected by this instruction
    '''

    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "HALT":0 }, CPU=CPU )
        self.F = 0

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        halt_number = 0        
        if len(operands) == 1:
            (addr_mode, first_operand ) = self.get_address_mode(operands[0])        
            if addr_mode != ADM_IMMEDIATE:
                raise UserWarning("Error: HALT instruction supports only immediate addressing for specifying a halt number")
            (halt_number, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
            if w != None:
                warnings.append(w)
            validate_operand(halt_number, 0, 0x03FF, 10)
        
        self.N = halt_number & 0x3FF        
        self.T = 1        

        return( self.bitassemble(), warnings)

    def exec(self):
        cycle_count = 0
        halt_number = self.CPU.IR.content & 0x03FF
        raise F100HaltException("CPU Halted with halt number 0x%04X" % halt_number )
        return cycle_count


    
