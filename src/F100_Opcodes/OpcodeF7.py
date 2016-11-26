from .F100_Opcode import *
'''
ICZ - Jump to (PC) if non-zero
------------------------------
    
'''
class OpcodeF7(F100_Opcode) :
    '''
    Increment the contents of a counter or address and jump to a specified location if the result is non-zero

    Function
    
    ::
       
       ICZ N   W1  (N) <- (N)+1 ; if (Z==0) PC <- W1
       ICZ ,D  W1  D <- D+1 ; if (Z==0) PC <- W1
       ICZ /P  W1  (P) <= (P)+1 ; if (Z==0) PC <- W1
       ICZ /P+ W1  P <- P+1 ; (P) <- (P)+1 ; if (Z==0) PC <- W1
       ICZ /P- W1  (P) <- (P)+1 ;  P <- P-1; ; if (Z==0) PC <- W1
       ICZ .W  W1  (W) <- (W)+1 ; if (Z==0) PC <- W1
    
    Instruction Encoding
    
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+
     |              Opcode Word                |     Operand Word   | 2nd Operand Word    | Function  | Cycle count          |
     +-------+----+----+-----+-----------------+                    |                     |           |                      |
     |       |    | N                          |                    |                     |           |                      |
     |       |    +----+-----+-----------------+                    |                     |           |                      |
     |  F    |  I |    | R   | P               |                    |                     |           |                      |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+
     |4'b0111|1'b0|     11'b<non-zero addr>    |1'bx|15b'<jump addr>|           none      | ICZ N   W1| TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+ 
     |4'b0111|1'b0|     11'b000000000000       |        16b'<data>  |1'bx|15b'<jump addr> | ICZ ,D  W1| TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+
     |4'b0111|1'b1|1'bx|2'bx0|8'b<non-zero ptr>|1'bx|15b'<jump addr>|           none      | ICZ /P  W1| TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+
     |4'b0111|1'b1|1'bx|2'b01|8'b<non-zero ptr>|1'bx|15b'<jump addr>|           none      | ICZ /P+ W1| TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+ 
     |4'b0111|1'b1|1'bx|2'b11|8'b<non-zero ptr>|1'bx|15b'<jump addr>|           none      | ICZ /P- W1| TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+ 
     |4'b0111|1'b1|1'bx|2'bxx|8'b00000000      |1'bx|   15b'<addr>  |1'bx|15b'<jump addr>x| ICZ .W  W1| TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+----+----------------+-----------+----------------------+

    
     Condition Register
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- |\- |\- |\- |\- |\- |\- | 
     +---+---+---+---+---+---+---+ 
    
     * The condition code register is unchanged after this operation
    '''
    
    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "ICZ":7 }, CPU=CPU )

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


    def exec(self):
        raise UserWarning("Execution for Opcode F7 (ICZ) not yet implemented")
    
