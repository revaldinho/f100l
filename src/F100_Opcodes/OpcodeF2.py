from .F100_Opcode import *

class OpcodeF2(F100_Opcode) :
    '''
    CAL - Store Link in Link Stack
    
    Jump to location provided by operand, store link in link stack
    
    Function
    
    ::
       
       CAL N   (X+1) <- PC+1; (X+2) <- CR ; PC <- (N); X<- X+2
       CAL ,D  (X+1) <- PC+1; (X+2) <- CR ; PC <- PC+1; X<- X+2
       CAL /P  (X+1) <- PC+1; (X+2) <- CR ; PC <- (P); X<- X+2
       CAL .W  (X+1) <- PC+2; (X+2) <- CR ; PC <- W; X<- X+2
    
    where X is the address stored in location 0 at the start of the operation

    NB X MUST be an ODD number.

    CAL ,D is a special case where only the link is stored in the link stack and the 'D' operand is 
    treated as the next instruction.

    Instruction Encoding
    
     +-------+----+----+-----+-----------------+----+---------------+---------+----------------------+
     |              Opcode Word                |     Operand Word   | Function| Cycle count          |
     +-------+----+----+-----+-----------------+                    |         |                      |
     |       |    | N                          |                    |         |                      |
     |       |    +----+-----+-----------------+                    |         |                      |
     |  F    |  I |    | R   | P               |                    |         |                      |
     +-------+----+----+-----+-----------------+----+---------------+---------+----------------------+
     |4'b0010|1'b0|     11'b<non-zero addr>    |1'bx|15b'<jump addr>| CAL N   | TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+---------+----------------------+ 
     |4'b0010|1'b0|     11'b000000000000       |        none        | CAL ,D  | TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+---------+----------------------+
     |4'b0010|1'b1|1'bx|2'bxx|8'b<non-zero ptr>|1'bx|15b'<jump addr>| CAL /P  | TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+---------+----------------------+
     |4'b0010|1'b1|1'bx|2'bxx|8'b00000000      |1'bx|   15b'<addr>  | CAL .W  | TBC                  |
     +-------+----+----+-----+-----------------+----+---------------+---------+----------------------+

    
     Condition Register
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- | 0 |\- |\- |\- |\- |\- | 
     +---+---+---+---+---+---+---+ 
    
     * M is always cleared by this operation
    '''
    
    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "CAL":2 }, CPU=CPU )
        self.F = 2
  
    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        if addr_mode in (ADM_POINTER_INDIRECT_POSTDEC, ADM_POINTER_INDIRECT_PREINC):
            raise UserWarning("Error: Illegal address mode for this operation - pre increment/post decrement not supported")

        (code, warnings) = super().assemble(opcode_token, operands, symbol_table, suppress_errors)

        if addr_mode == ADM_IMMEDIATE:
            # In immediate mode the operand is discarded and execution will pass to the next instruction word
            code = code[:-1]

        return (code, warnings)

            
    def exec(self):
        raise UserWarning("Execution for Opcode F2 (CAL) not yet implemented")
 

