'''
JMP - Unconditional Jump
========================

Unconditional jump to the location provided by the operand.

**Function**

::

   JMP N      PC <- N
   JMP ,D     PC <- PC + 1
   JMP /P     PC <- (P)
   JMP /P+    P <- P+1 ; PC <- (P)
   JMP /P-    PC <- (P) ; P <- P - 1
   JMP .W     PC <- W

Note that the JMP,D form causes no branching and instruction proceeds to execute the next word (the
'D' effectively) as the next instruction. This instruction is effectively a NOP. The assembler
discards the literal provided when using this form so that the next assembled instruction will be
executed.

**Instruction Encoding**

+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|        Opcode Word          |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | | N                    |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| |R | P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1111|0|  11'b<non-zero addr> |        none      | JMP N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1111|0|  11'b000000000000    |        none      | JMP ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1111|1|x|x0|8'b<non-zero ptr>|        none      | JMP /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1111|1|x|01|8'b<non-zero ptr>|        none      | JMP /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1111|1|x|11|8'b<non-zero ptr>|        none      | JMP /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|1111|1|x|xx|8'b00000000      |x|   15'b<addr>   | JMP .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+


**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--|\--|\--|\--|\--|
+---+---+---+---+---+---+---+

* The condition register is not affected by this instruction
'''
from .F100_Opcode import *

class OpcodeF15(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "JMP":15}, CPU=CPU)
        self.F = 15



    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        (code, warnings) = super().assemble(opcode_token, operands, symbol_table, suppress_errors)

        if addr_mode == ADM_IMMEDIATE:
            # In immediate mode the operand is discarded and execution will pass to the next instruction word
            code = code[:-1]

        return (code, warnings)

    def execute(self):
        cycle_count = 0
        IR = self.CPU.IR
        self.execstats[IR.name] +=1
        (operand, operand_address, cycle_count) = self.get_operand(noread=True)
        self.CPU.PC = operand_address
        return cycle_count
