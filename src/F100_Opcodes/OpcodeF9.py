'''
ADD - Add (With Carry)
======================

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


+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|          Opcode Word        |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | | N                    |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1001|0|  11'b<non-zero addr> |        none      | ADD N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1001|0|  11'b000000000000    |     16`b<data>   | ADD ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1001|1|x|x0|8'b<non-zero ptr>|        none      | ADD /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1001|1|x|01|8'b<non-zero ptr>|        none      | ADD /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1001|1|x|11|8'b<non-zero ptr>|        none      | ADD /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1001|1|x|xx|8'b00000000      |x|   15'b<addr>   | ADD .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+

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

class OpcodeF9(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "ADD":9}, CPU=CPU)
        self.F = 9

    def execute(self):
        cycle_count = 0

        CPU = self.CPU
        self.execstats[CPU.IR.name] += 1

        (CPU.OR, operand_address, cycle_count) = self.get_operand()

        result = (CPU.OR + CPU.ACC) & 0xFFFFFF

        if (CPU.CR.M==1) :
            result = (result + CPU.CR.C) & 0xFFFFFF
        if ((CPU.ACC & 0x8000) == (CPU.OR & 0x8000)) and ((result & 0x8000) != (CPU.ACC & 0x8000)):
            CPU.CR.V = 1
        else:
            CPU.CR.V = 0

        CPU.ACC = result & 0xFFFF

        CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        CPU.CR.S = 1 if (result & 0x8000) != 0 else 0

        return cycle_count
