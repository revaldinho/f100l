'''
CMP - Compare
=============

Perform either a single or multi-length comparison of the accumulator and an operand,
depending on the state of the multi-length flag 'M' in the condition register.

When M is set, a sequence of these instructions performs a multi-length subtraction
without overwriting any of the operands. Multi-length compare is performed by including
the carry from a previous compare in at the LSB end of the current instruction

For both single and multi-length comparisons the results are discarded but the appropriate
flags are set in the condition register.

The 'M' flag is always set at the end of this operation.

**Function**

When 'M' is clear, single length comparison

::

   CMP N      x <- (N) - A
   CMP ,D     x <- D - A
   CMP /P     A <- (P) - A
   CMP /P+    P <- P + 1 ; x <- (P) - A
   CMP /P-    x <- (P) - A ;  P <- P - 1 ;
   CMP .W     x <- (W) - A

When 'M' is set

::

   CMP N      x <- (N) - A + C - 1
   CMP ,D     x <- D - A + C - 1
   CMP /P     A <- (P) - A + C - 1
   CMP /P+    P <- P + 1 ; x <- (P) - A + C - 1
   CMP /P-    x <- (P) - A + C - 1;  P <- P - 1 ;
   CMP .W     x <- (W) - A + C - 1

**Instruction Encoding**


+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|       Opcode Word           |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | |                      |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1011|0|  11'b<non-zero addr> |        none      | CMP N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1011|0|  11'b000000000000    |     16'b<data>   | CMP ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1011|1|x|x0|8'b<non-zero ptr>|        none      | CMP /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1011|1|x|01|8'b<non-zero ptr>|        none      | CMP /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1011|1|x|11|8'b<non-zero ptr>|        none      | CMP /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1011|1|x|xx|8'b00000000      |x|   15'b<addr>   | CMP .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+

Condition Register

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--| 1 | * | * | * | * |\--|
+---+---+---+---+---+---+---+

* C is set if the operation results in a borrow (carry), otherwise cleared
* M is always set to 1
* Z is set if the result is all-zeroes, otherwise cleared
* S is set if the MSB of the result is a '1', otherwise cleared
* V is set if the subtraction of two numbers of different sign results in
  a number with the same sign as the subtrahend, otherwise cleared

'''

from .F100_Opcode import *


class OpcodeF11(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "CMP":11}, CPU=CPU)
        self.F = 11

    def exec(self):
        cycle_count = 0
        (self.CPU.OR, operand_address, cycle_count) = self.get_operand()
        result = self.CPU.OR - self.CPU.ACC
        if (self.CPU.CR.M==1) :
            result = result + self.CPU.CR.C - 1

        self.CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        self.CPU.CR.V = 1 if (result & 0x8000) == (self.CPU.ACC & 0x8000) else 0
        return cycle_count
