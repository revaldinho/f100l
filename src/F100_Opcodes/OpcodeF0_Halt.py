'''
HALT - Stop Processor Execution
===============================

This instruction stops the CPU and prevents the F100-L from executing any further instructions.

Once stopped the CPU can only be restarted by driving the RUN* pin high (the 'STOP' state) and then
low again.

The least significant 10 bits of the Opcode are ignored by the processor but can be used by the
programmer to provide a halt number. The assembler allows the HALT instruction to appear either
with or without an operand and in the latter case the 10 LSBs will be encoded into the opcode.

::

   HALT       Stop processor execution
   HALT ,D    Stop processor execution

**Instruction Encoding**

+----+--+----------------------------+----------+----------------------+
|        Opcode Word                 | Function | Cycle count          |
+----+--+----------------------------+          |                      |
| F  | T|    Halt Number             |          |                      |
+----+--+----------------------------+----------+----------------------+
|0000|01|    10'b<Halt Number>       | HALT     | TBC                  |
+----+--+----------------------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--|\--|\--|\--|\--|
+---+---+---+---+---+---+---+

  * The condition register is unaffected by this instruction
'''

from .F100_Opcode import *

class OpcodeF0_Halt(F100_Opcode) :
    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "HALT":0 }, CPU=CPU )
        self.F = 0

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        halt_number = 0
        if len(operands) == 1:
            (addr_mode, first_operand ) = self.get_address_mode(operands[0])
            if addr_mode != ADM_IMMEDIATE:
                raise UserWarning("Error: HALT instruction supports only immediate addressing for specifying a halt number")
            (halt_number, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
            if w != None:
                warnings.append(w)
            validate_operand(halt_number, 0, 0x03FF, 10)

        self.N = halt_number & 0x3FF
        self.T = 1

        return( self.bitassemble(), warnings)

    def disassemble(self, IR):
        if IR.T == 1:
            return "HALT"
        else:
            return "EXT"

    def exec(self):
        cycle_count = 0
        if self.CPU.IR.T >1 :
            raise UserException("External Function operation in F=0 class not yet implemented")
        else:
            halt_number = self.CPU.IR.content & 0x03FF
            raise F100HaltException("CPU Halted with halt number 0x%04X" % halt_number )

        return cycle_count
