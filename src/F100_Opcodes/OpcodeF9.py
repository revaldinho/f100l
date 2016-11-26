from .F100_Opcode import *
'''
ADD - Add (with carry)
----------------------

'''

class OpcodeF9(F100_Opcode) :
    '''
    
    Perform addition of the accumulator and an operand with the result being stored in 
    the accumulator. 

    When the multi-length 'M' flag is set, the carry bit from a previous operation is 
    included in the addition.

    **Function**
    
    When 'M' is clear

    ::

       ADD N      A <- (N) + A 
       ADD ,D     A <- D + A 
       ADD /P     A <- (P) + A 
       ADD /P+    P <- P + 1 ; A <- (P) + A 
       ADD /P-    A <- (P) + A ;  P <- P - 1
       ADD .W     A <- (W) + A 

    When 'M' is set

    ::
       
       ADD N      A <- (N) + A + C 
       ADD ,D     A <- D + A + C 
       ADD /P     A <- (P) + A + C 
       ADD /P+    P <- P + 1 ; A <- (P) - A + C 
       ADD /P-    A <- (P) + A + C ;  P <- P - 1 
       ADD .W     A <- (W) + A + C 
    
    **Instruction Encoding**

    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b1001|1`b0|     11`b<non-zero addr>    |           none      | ADD N    | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b1001|1`b0|     11`b000000000000       |        16`b<data>   | ADD ,D   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b1001|1`b1|1`bx|2`bx0|8`b<non-zero ptr>|           none      | ADD /P   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b1001|1`b1|1`bx|2`b01|8`b<non-zero ptr>|           none      | ADD /P+  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b1001|1`b1|1`bx|2`b11|8`b<non-zero ptr>|           none      | ADD /P-  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b1001|1`b1|1`bx|2`bxx|8`b00000000      |1`bx|   15b'<addr>   | ADD .W   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
     Condition Register
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- | \-| * | * | * | * |\- | 
     +---+---+---+---+---+---+---+ 
    
     * C is set if the operation results in a carry out, otherwise cleared
     * Z is set if the result is all-zeroes, otherwise cleared
     * S is set if the MSB of the result is a '1', otherwise cleared
     * V is set if the addition of two numbers with the same sign results in a value with the opposite sign
    '''    

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "ADD":9}, CPU=CPU)
        self.F = 9

    def exec(self):
        cycle_count = 0
        (self.CPU.OR, operand_address, cycle_count) = self.get_operand()           

        result = self.CPU.OR + self.CPU.ACC

        if (self.CPU.CR.M==1) :
            result = result + self.CPU.CR.C
        if ((self.CPU.ACC & 0x8000) == (self.CPU.OR & 0x8000)) and ((result & 0x8000) != (self.CPU.ACC & 0x8000)):
            self.CPU.CR.V = 1
        else:
            self.CPU.CR.V = 0

        self.CPU.ACC = result
            
        self.CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0

        return cycle_count        
        


