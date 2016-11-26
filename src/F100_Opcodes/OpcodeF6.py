from .F100_Opcode import *
'''
SBS - Subtract (With Carry), Store to Memory
--------------------------------------------
'''

class OpcodeF6(F100_Opcode) :
    '''

    Perform substraction of the accumulator from the value of an operand with the 
    result being stored in the operand's original location.

    When the multi-length 'M' flag is set, the carry bit from a previous operation is 
    included in the subtraction.


    **Function**

    When M is clear, perform a simple subtraction 
    
    ::
       
       SBS N      (N) <- (N) - A 
       SBS ,D     (PC+1) <- D - A 
       SBS /P     (P) <- (P) - A 
       SBS /P+    P <- P + 1 ; (P) <- (P) - A 
       SBS /P-    (P) <- (P) - A ; P <- P - 1
       SBS .W     (W) <- (W) - A 

    When M is set, include the carry from a previous operation in the subtraction

    ::
       
       SBS N      (N) <- (N) - A + C - 1
       SBS ,D     (PC+1) <- D - A + C - 1
       SBS /P     (P) <- (P) - A + C - 1
       SBS /P+    P <- P + 1 ; (P) <- (P) - A + C - 1
       SBS /P-    (P) <- (P) - A + C - 1 ; P <- P - 1
       SBS .W     (W) <- (W) - A + C - 1

    In the immediate mode operation, data 'D' is taken from the location (PC+1), ie the word immediately
    after the opcode, and the the result is returned to that location.
    
    **Instruction Encoding**
    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b0110|1`b0|     11`b<non-zero addr>    |           none      | SBS N    | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b0110|1`b0|     11`b000000000000       |        16`b<data>   | SBS ,D   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4`b0110|1`b1|1`bx|2`bx0|8`b<non-zero ptr>|           none      | SBS /P   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b0110|1`b1|1`bx|2`b01|8`b<non-zero ptr>|           none      | SBS /P+  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+  
     |4`b0110|1`b1|1`bx|2`b11|8`b<non-zero ptr>|           none      | SBS /P-  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4`b0110|1`b1|1`bx|2`bxx|8`b00000000      |1`bx|   15`b<addr>   | SBS .W   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
      
     Condition Register
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- |\- | * | * | * | * |\- | 
     +---+---+---+---+---+---+---+ 
    
     * C is set if the operation results in a borrow (carry), otherwise cleared
     * Z is set if the result is all-zeroes, otherwise cleared
     * S is set if the MSB of the result is a '1', otherwise cleared
     * V is set if the subtraction of two numbers of different sign results in 
         a number with the same sign as the subtrahend, otherwise cleared

    '''
    
    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "SBS":6}, CPU=CPU )
        self.F = 6

    def exec(self):
        cycle_count = 0
        
        (operand, operand_address, cycles) = self.get_operand()
        
        result = self.CPU.OR - self.CPU.ACC
        if (self.CPU.CR.M==1) :
            result = result + self.CPU.CR.C - 1

        self.CPU.memory_write(operand_address, result)     
            
        self.CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        if ((self.CPU.ACC & 0x8000) != (self.CPU.OR & 0x8000)) and ((result & 0x8000) == (self.CPU.ACC & 0x8000)):
            self.CPU.CR.V = 1
        else:
            self.CPU.CR.V = 0
    
        return cycle_count        

