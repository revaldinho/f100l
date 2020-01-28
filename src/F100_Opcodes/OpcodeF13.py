'''
NEQ - Logical XOR
=================

Perform a bitwise logical exclusive-OR of the Accumulator and specified operand.

**Function**

::

   NEQ N      A <- A ^ (N)
   NEQ ,D     A <- A ^ D
   NEQ /P     A <- A ^ (P)
   NEQ /P+    P <- P + 1 ; A <- A ^ (P)
   NEQ /P-    A <- A ^ (P) ; P <- P - 1
   NEQ .W     A <- A ^ (W)

**Instruction Encoding**

+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|       Opcode Word           |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | |N                     |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1101|0|  11'b<non-zero addr> |        none      | NEQ N    | Ra1 + Ra2 + 18L      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1101|0|  11'b000000000000    |     16'b<data>   | NEQ ,D   | Ra1 + Rc1 + 18L      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1101|1|x|x0|8'b<non-zero ptr>|        none      | NEQ /P   | Ra1 + Ra2 + 18L      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1101|1|x|01|8'b<non-zero ptr>|        none      | NEQ /P+  | Ra1 + M + 34L        |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1101|1|x|11|8'b<non-zero ptr>|        none      | NEQ /P-  | Ra1 + M + 34L        |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1101|1|x|xx|8'b00000000      |x|   15'b<addr>   | NEQ .W   | Ra1 + Ra2 + Rc1 + 18L|
+----+-+-+--+-----------------+-+----------------+----------+----------------------+


**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--| 1 | * | x | * |\--|
+---+---+---+---+---+---+---+

* C is always set to 1
* Z is set if the result is all-zeroes, otherwise cleared
* S is set if the MSB of the result is a '1', otherwise cleared
* V is undefined after this operation

'''
from .F100_Opcode import *

class OpcodeF13(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "NEQ":13}, CPU=CPU )
        self.F = 13

    def execute(self):
        cycle_count = 0

        self.execstats[self.CPU.IR.name] += 1

        (self.CPU.OR, operand_address, cycle_count) = self.get_operand()
        result = self.CPU.ACC ^ self.CPU.OR
        self.CPU.ACC  = result

        self.CPU.CR.C = 0
        self.CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        cycle_count += 0
        return cycle_count
