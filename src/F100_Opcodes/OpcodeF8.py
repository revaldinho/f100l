'''
LDA - Load Accumulator from Memory
==================================

Load the accumulator with a value from the specified memory location

**Function**

::

   LDA N      A <- (N)
   LDA ,D     A <- D
   LDA /P     A <- (P)
   LDA /P+    P <- P + 1 ; A <- (P)
   LDA /P-    A <- (P) ;  P <- P - 1
   LDA .W     A <- (W)

The operand register (OR) will have the same value as the accumulator at the
end of this instruction.

**Instruction Encoding**

+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|        Opcode Word          |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | | N                    |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1000|0|  11`b<non-zero addr> |        none      | LDA N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1000|0|  11`b000000000000    |     16`b<data>   | LDA ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1000|1|x|x0|8`b<non-zero ptr>|        none      | LDA /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1000|1|x|01|8`b<non-zero ptr>|        none      | LDA /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1000|1|x|11|8`b<non-zero ptr>|        none      | LDA /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1000|1|x|xx|8`b00000000      |x|   15`b<addr>   | LDA .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--| * | 0 | * |\--|
+---+---+---+---+---+---+---+

* Z is set if the new accumulator value is all-zeroes, otherwise cleared
* S is set if the MSB of the new accumulator value is a '1', otherwise cleared
* V is always cleared

'''

from .F100_Opcode import *

class OpcodeF8(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "LDA":8}, CPU=CPU)
        self.F = 8

    def execute(self):
        cycle_count = 0
        CPU = self.CPU
        self.execstats[CPU.IR.name] += 1

        (CPU.OR, operand_address, cycle_count) = self.get_operand()

        CPU.ACC = CPU.OR
        CPU.CR.Z = 1 if (CPU.ACC & 0xFFFF) == 0 else 0
        CPU.CR.S = 1 if (CPU.ACC & 0x8000) != 0 else 0
        CPU.CR.V = 0
        return cycle_count
