
'''
SJM - Switch Jump
=================

The contents of the accumulator are added to the contents of the program counter (which has
already been incremented to point to the next instruction). If the value of the accumulator
is zero then the program will continue execution in sequence.

Note that the MSB of the result is always discarded, so that the program counter value will
never exceed the 15b address range of the machine.

**Function**

::

   SJM    PC <- PC + 1 + A

**Instruction Encoding**

+----+-----------------------------+----------+----------------------+
|      Opcode Word                 | Function | Cycle count          |
+----+-----------------------------+          |                      |
|  F |                             |          |                      |
+----+-----------------------------+----------+----------------------+
|0001|    12'bxxxxxxxxxxxx         | SJM      | TBC                  |
+----+-----------------------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--|\--|\--|\--|\--|
+---+---+---+---+---+---+---+

* The Condition Register is unaffected by the addition in this instruction.

'''

from .F100_Opcode import *

class OpcodeF1(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "SJM":1}, CPU=CPU )
        self.F = 1

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        if len(operands) > 0:
            warnings.append("Warning: Instruction %s takes no operands, so operand field%s will be ignored" % (opcode_token, '' if len(operands)< 2 else 's'))

        # NB - lower 12 bits are all dont care but assembled will always define them to be zero
        self.I = 0
        self.N = 0

        return( self.bitassemble(), warnings)

    def execute(self):
        cycle_count = 0
        # Note that the PC has already been incremented during the instruction fetch
        self.CPU.PC = (self.CPU.PC + self.CPU.ACC ) & 0x7FFF

        return cycle_count
