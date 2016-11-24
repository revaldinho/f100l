from .F100_Opcode import *

class OpcodeF11(F100_Opcode) :
    '''

    CMP
    ===
    
    Perform a multi-length comparison of two operands. A sequence of these instructions performs a
    multi-length subtraction without overwriting any of the operands. The results are discarded
    but the appropriate flags are set in the condition register.

    Multi-length compare is performed by including the carray from a previous compare in at the 
    LSB end of the current instruction
    
    Function
    --------
    
    ::
       
       CMP N      x <- (N) - A + C - 1
       CMP ,D     x <- D - A + C - 1
       CMP /P     A <- (P) - A + C - 1
       CMP /P+    P <- P + 1 ; x <- (P) - A + C - 1
       CMP /P-    x <- (P) - A + C - 1;  P <- P - 1 ;
       CMP .W     x <- (W) - A + C - 1
    
    Instruction Encoding
    --------------------
    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1011|1'b0|     11'b<non-zero addr>    |           none      | CMP N    | Ra1 + Ra2 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1011|1'b0|     11'b000000000000       |        16b'<data>   | CMP ,D   | Ra1 + Rc1 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1011|1'b1|1'bx|2'bx0|8'b<non-zero ptr>|           none      | CMP /P   | Ra1 + Ra2 + 18L      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1011|1'b1|1'bx|2'b01|8'b<non-zero ptr>|           none      | CMP /P+  | Ra1 + M + 34L        |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1011|1'b1|1'bx|2'b11|8'b<non-zero ptr>|           none      | CMP /P-  | Ra1 + M + 34L        |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1011|1'b1|1'bx|2'bxx|8'b00000000      |1'bx|   15b'<addr>   | CMP .W   | Ra1 + Ra2 + Rc1 + 18L|
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
     Condition Register
     ------------------
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- | 1 | * | * | * | * |\- | 
     +---+---+---+---+---+---+---+ 
    
     * C is set if the operation results in a borrow (carry), otherwise cleared
     * M is always set to 1
     * Z is set if the result is all-zeroes, otherwise cleared
     * S is set if the MSB of the result is a '1', otherwise cleared
     * V is set if the subtraction of two numbers of different sign results in 
         a number with the same sign as the subtrahend, otherwise cleared

    '''    

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "CMP":11}, CPU=CPU)
        self.F = 11

    def exec(self):
        cycle_count = 0
        (self.CPU.OR, cycle_count) = self.get_operand()           
        result = self.CPU.OR - self.CPU.ACC + self.CPU.CR.C - 1
        
        self.CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        self.CPU.CR.V = 1 if (result & 0x8000) == (self.CPU.ACC & 0x8000) else 0
        cycle_count += 0
        return cycle_count        
        


