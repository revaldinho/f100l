'''
STO - Store Accumulator to Memory
---------------------------------

Store the value in the accumulator to the specified memory location

**Function**

::

   STO N      (N) <- A
   STO ,D     (PC+1) <- A
   STO /P     (P) <- A
   STO /P+    P <- P + 1 ; (P) <- A
   STO /P-    (P) <- A ;  P <- P - 1 ;
   STO .W     (W) <- A

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
|0100|0|  11'b<non-zero addr> |        none      | STO N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|0|  11'b000000000000    |     16`b<data>   | STO ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|x0|8`b<non-zero ptr>|        none      | STO /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|01|8`b<non-zero ptr>|        none      | STO /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|11|8`b<non-zero ptr>|        none      | STO /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|xx|8`b00000000      |x|   15`b<addr>   | STO .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--| * | 0 | * |\--|
+---+---+---+---+---+---+---+

* Z is set if the accumulator value is all-zeroes, otherwise cleared
* S is set if the MSB of the accumulator is a '1', otherwise cleared
* V is always cleared

'''

from .F100_Opcode import *

class OpcodeF4(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "STO":4}, CPU=CPU)
        self.F = 4

    def execute(self):
        cycle_count = 0

        CPU = self.CPU
        IR = self.CPU.IR
        CR = self.CPU.CR

        self.execstats[IR.name] += 1
        (operand, operand_address, cycle_count) = self.get_operand(noread=True)
        CPU.OR = CPU.ACC
        CPU.memory_write(operand_address, CPU.OR)
        CPU.CR.Z = 1 if (CPU.ACC & 0xFFFF) == 0 else 0
        CPU.CR.S = 1 if (CPU.ACC & 0x8000) != 0 else 0
        CPU.CR.V = 0
        return cycle_count
