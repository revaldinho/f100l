'''
ADS - Add (with carry), Store to Memory
=======================================
    
Perform addition of the accumulator and an operand with the result being stored in 
the operand's original location. 

When the multi-length 'M' flag is set, the carry bit from a previous operation is 
included in the addition.

**Function**

When 'M' is clear

::

   ADS N      (N) <- (N) + A 
   ADS ,D     (PC+1) <- D + A 
   ADS /P     (P) <- (P) + A 
   ADS /P+    P <- P + 1 ; (P) <- (P) + A 
   ADS /P-    (P) <- (P) + A ;  P <- P - 1
   ADS .W     (W) <- (W) + A 

When 'M' is set

::
   
   ADS N      (N) <- (N) + A + C 
   ADS ,D     (PC+1) <- D + A + C 
   ADS /P     (P) <- (P) + A + C 
   ADS /P+    P <- P + 1 ; (P) <- (P) - A + C 
   ADS /P-    (P) <- (P) + A + C ;  P <- P - 1 
   ADS .W     (W) <- (W) + A + C 


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
|4`b0101|1`b0|     11`b<non-zero addr>    |           none      | ADS N    | TBC                  |
+-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
|4`b0101|1`b0|     11`b000000000000       |        16`b<data>   | ADS ,D   | TBC                  |
+-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
|4`b0101|1`b1|1`bx|2`bx0|8`b<non-zero ptr>|           none      | ADS /P   | TBC                  |
+-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
|4`b0101|1`b1|1`bx|2`b01|8`b<non-zero ptr>|           none      | ADS /P+  | TBC                  |
+-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
|4`b0101|1`b1|1`bx|2`b11|8`b<non-zero ptr>|           none      | ADS /P-  | TBC                  |
+-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
|4`b0101|1`b1|1`bx|2`bxx|8`b00000000      |1`bx|   15b'<addr>   | ADS .W   | TBC                  |
+-------+----+----+-----+-----------------+----+----------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--| * | * | * | * |\--| 
+---+---+---+---+---+---+---+ 

* C is set if the operation results in a carry out, otherwise cleared
* Z is set if the result is all-zeroes, otherwise cleared
* S is set if the MSB of the result is a '1', otherwise cleared
* V is set if the addition of two numbers with the same sign results in a value with the opposite sign

'''
from .F100_Opcode import *


class OpcodeF5(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "ADS":5}, CPU=CPU)
        self.F = 5

    def exec(self):
        cycle_count = 0


        (operand, operand_address, cycles) = self.get_operand()
        
        result = operand + self.CPU.ACC
        if (self.CPU.CR.M==1) :
            result = result + self.CPU.CR.C

        self.CPU.memory_write(operand_address, result) 
            
        if ((self.CPU.ACC & 0x8000) == (self.CPU.OR & 0x8000)) and ((result & 0x8000) != (self.CPU.ACC & 0x8000)):
            self.CPU.CR.V = 1
        else:
            self.CPU.CR.V = 0
            
        self.CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0

        return cycle_count        
        


