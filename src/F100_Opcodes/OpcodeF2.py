'''
CAL - Call Subroutine
=====================

Jump to subroutine location provided by operand, storing return address in the link stack

**Function**

::

   CAL N   (LSP+1) <- PC+1; (LSP+2) <- CR ; PC <- (N); LSP <- LSP+ 2
   CAL ,D  (LSP+1) <- PC+1; (LSP+2) <- CR ; PC <- PC+1; LSP<- LSP + 2
   CAL /P  (LSP+1) <- PC+1; (LSP+2) <- CR ; PC <- (P); LSP<- LSP+2
   CAL .W  (LSP+1) <- PC+2; (LSP+2) <- CR ; PC <- W; LSP<- LSP+2

Where LSP is link stack pointer held in memory location 0.

NOTE: on entry the link stack pointer must always be an odd number.

CAL ,D is a special case where only the link is stored in the link stack and the 'D' operand is
treated as the next instruction. In this form the assembler discards the provided operand.

**Instruction Encoding**

+----+-+-+--+-----------------+-+----------+----------+-----------+
|    Opcode Word              |Operand Word| Function |Cycle count|
+----+-+-+--+-----------------+            |          |           |
|    | | N                    |            |          |           |
|    | +-+--+-----------------+            |          |           |
| F  |I| |R | P               |            |          |           |
+----+-+-+--+-----------------+-+----------+----------+-----------+
|0010|0|  11'b<non-zero addr> |    none    | CAL N    | TBC       |
+----+-+-+--+-----------------+-+----------+----------+-----------+
|0010|0|  11'b000000000000    |    none    | CAL ,D   | TBC       |
+----+-+-+--+-----------------+-+----------+----------+-----------+
|0010|1|x|xx|8'b<non-zero ptr>|    none    | CAL /P   | TBC       |
+----+-+-+--+-----------------+-+----------+----------+-----------+
|0010|1|x|xx|8'b00000000      |x|15'b<addr>| CAL .W   | TBC       |
+----+-+-+--+-----------------+-+----------+----------+-----------+


**Condition Register**

+-----+-----+-----+-----+-----+-----+-----+
|  F  |  M  |  C  |  S  |  V  |  Z  |  I  |
+-----+-----+-----+-----+-----+-----+-----+
|``-``|``0``|``-``|``-``|``-``|``-``|``-``|
+-----+-----+-----+-----+-----+-----+-----+

* M is always cleared by this operation

'''

from .F100_Opcode import *

class OpcodeF2(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "CAL":2 }, CPU=CPU )
        self.F = 2

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        if addr_mode in (ADM_POINTER_INDIRECT_POSTDEC, ADM_POINTER_INDIRECT_PREINC):
            raise UserWarning("Error: Illegal address mode for this operation - pre increment/post decrement not supported")

        (code, warnings) = super().assemble(opcode_token, operands, symbol_table, suppress_errors)

        if addr_mode == ADM_IMMEDIATE:
            # In immediate mode the operand is discarded and execution will pass to the next instruction word
            code = code[:-1]

        return (code, warnings)


    def exec(self):
        raise UserWarning("Execution for Opcode F2 (CAL) not yet implemented")
