from .F100_Opcode import *
'''
STO - Store accumulator to memory
---------------------------------
'''

class OpcodeF4(F100_Opcode) :
    '''
    Store the value in the accumulator to the specified memory location
    
    **Function**
    
    ::

       STO N      (N) <- A 
       STO ,D     (PC+1) <- A 
       STO /P     (P) <- A 
       STO /P+    P <- P + 1 ; (P) <- A
       STO /P-    (P) <- A ;  P <- P - 1 ;
       STO .W     (W) <- A 

    **Instruction Encoding**

    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b0100|1`b0|     11`b<non-zero addr>    |           none      | STO N    | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b0100|1`b0|     11`b000000000000       |        16`b<data>   | STO ,D   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b0100|1`b1|1`bx|2`bx0|8`b<non-zero ptr>|           none      | STO /P   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b0100|1`b1|1`bx|2`b01|8`b<non-zero ptr>|           none      | STO /P+  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b0100|1`b1|1`bx|2`b11|8`b<non-zero ptr>|           none      | STO /P-  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b0100|1`b1|1`bx|2`bxx|8`b00000000      |1`bx|   15`b<addr>   | STO .W   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
     Condition Register
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- | \-| \-| * | 0 | * |\- | 
     +---+---+---+---+---+---+---+ 
    
     * Z is set if the accumulator value is all-zeroes, otherwise cleared
     * S is set if the MSB of the accumulator is a '1', otherwise cleared
     * V is always cleared

    '''    

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "STO":4}, CPU=CPU)
        self.F = 4

    def exec(self):
        cycle_count = 0
        (self.CPU.OR, cycle_count) = self.get_operand()

        if self.addr_mode == ADM_IMMEDIATE:
            # Special handling for the immediate data mode where the Accumulator is stored in
            # already incremented PC rather than using the immediate data
            self.CPU.OR = self.CPU.PC

        self.CPU.memory_write(self.CPU.OR, self.CPU.ACC)
        self.CPU.CR.Z = 1 if (self.CPU.ACC & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (self.CPU.ACC & 0x8000) != 0 else 0
        self.CPU.CR.V = 0
        return cycle_count        
        


