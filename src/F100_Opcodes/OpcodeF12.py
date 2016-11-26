from .F100_Opcode import *
'''
AND - Logical AND of Accumulator and Operand
============================================
'''
class OpcodeF12(F100_Opcode) :
    '''
    Logical AND of accumulator with specified operand
        
    Function
    
    ::
       
       AND N      A <- A & (N)
       AND ,D     A <- A & D
       AND /P     A <- A & (P)
       AND /P+    P <- P + 1 ; A <- A & (P) 
       AND /P-    A <- A & (P) ; P <- P - 1
       AND .W     A <- A & (W)
    
    Instruction Encoding
    
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
    
      
     Condition Register
    
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
    
    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "AND":12}, CPU=CPU )
        self.F = 12

    def exec(self):
        cycle_count = 0
        (self.CPU.OR, cycle_count) = self.get_operand()           
        result = self.CPU.ACC ^ self.CPU.OR
        self.CPU.ACC  = result
        
        self.CPU.CR.C = 1
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        cycle_count += 0
        return cycle_count        


