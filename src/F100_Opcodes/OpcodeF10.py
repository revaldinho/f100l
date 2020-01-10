'''
SUB - Subtract (With Carry)
===========================

Perform either a single or multi length substraction of the accumulator from the value of
a provided operand depending on the state of the multi-length flag 'M' in the condition
register.

**Function**

When M is clear, perform a simple subtraction

::

   SUB N      A <- (N) - A
   SUB ,D     A <- D - A
   SUB /P     A <- (P) - A
   SUB /P+    P <- P + 1 ; A <- (P) - A
   SUB /P-    A <- (P) - A ; P <- P - 1
   SUB .W     A <- (W) - A

When M is set, include the carry from a previous operation in the subtraction

::

   SUB N      A <- (N) - A + C - 1
   SUB ,D     A <- D - A + C - 1
   SUB /P     A <- (P) - A + C - 1
   SUB /P+    P <- P + 1 ; A <- (P) - A + C - 1
   SUB /P-    A <- (P) - A + C - 1 ; P <- P - 1
   SUB .W     A <- (W) - A + C - 1



**Instruction Encoding**

+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|        Opcode Word          |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | | N                    |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1010|0|  11'b<non-zero addr> |        none      | SUB N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1010|0|  11'b000000000000    |     16'b<data>   | SUB ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1010|1|x|x0|8'b<non-zero ptr>|        none      | SUB /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1010|1|x|01|8'b<non-zero ptr>|        none      | SUB /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1010|1|x|11|8'b<non-zero ptr>|        none      | SUB /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1010|1|x|xx|8'b00000000      |x|   15'b<addr>   | SUB .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+


**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--| * | * | * | * |\--|
+---+---+---+---+---+---+---+

* C is cleared if the operation results in a borrow (carry), otherwise set
* Z is set if the result is all-zeroes, otherwise cleared
* S is set if the MSB of the result is a '1', otherwise cleared
* V is set if the subtraction of two numbers of different sign results in
  a number with the same sign as the subtrahend, otherwise cleared

'''
from .F100_Opcode import *

class OpcodeF10(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "SUB":10}, CPU=CPU )
        self.F = 10

    def execute(self):
        cycle_count = 0
        self.execstats[self.CPU.IR.name] += 1

        (self.CPU.OR, operand_address, cycle_count) = self.get_operand()

        result = (self.CPU.OR + ~self.CPU.ACC + 1) & 0xFFFFFF
        if (self.CPU.CR.M==1) :
            result = (result + self.CPU.CR.C - 1 ) & 0xFFFFFF

        self.CPU.CR.C = 0 if (result & 0x010000) != 0 else 1
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        
        if ((self.CPU.ACC & 0x8000) != (self.CPU.OR & 0x8000)) and ((result & 0x8000) != (self.CPU.OR & 0x8000)):
            self.CPU.CR.V = 1
        else:
            self.CPU.CR.V = 0
        self.CPU.ACC = result & 0xFFFF

        return cycle_count
