'''
RTN, RTC - Return from Subroutine
=================================

These instructions perform a return from subroutine operation.

**RTN** restores bits 0-5 of the Condition Register from the word pointed to by the link stack pointer
(location 0). The link stack pointer is then decremented to point to the return address, and this
is placed into the program counter. The link stack pointer is then decremented again to finish
the instruction pointing to the last valid stack entry.

**RTC** operates in a similar manner but discards the Condition Register entry from the stack.

NOTE: on entry the link stack pointer must always be an odd number.

**Function**

::

   RTN     CR[5:0] <- (LSP)[5:0] ; LSP <- LSP-1 ; PC <- (LSP) ; LSP <- LSP - 1
   RTC     PC <- (LSP-1) ; LSP <- LSP - 2

* Where LSP = Link Stack Pointer which is always held in location 0 in memory

**Instruction Encoding**

+----+-+-+--+-----------------+----------+----------------------+
|        Opcode Word          | Function | Cycle count          |
+----+-+-+--+-----------------+          |                      |
|    | | N                    |          |                      |
|    | +-+--+-----------------+          |                      |
| F  |I| | R| P               |          |                      |
+----+-+-+--+-----------------+----------+----------------------+
|0011|0| 11'bxxxxxxxxxxx      | RTN      | TBC                  |
+----+-+-+--+-----------------+----------+----------------------+
|0011|1| 11'bxxxxxxxxxxx      | RTC      | TBC                  |
+----+-+-+--+-----------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+-----------------+
| F | M | C | S | V | Z | I |  Instruction    |
+---+---+---+---+---+---+---+-----------------+
|\--| * | * | * | * | * | * |  RTN            |
+---+---+---+---+---+---+---+-----------------+
|\--|\--|\--|\--|\--|\--|\--|  RTC            |
+---+---+---+---+---+---+---+-----------------+

* Bit 6, the Fail flag entry, is not overwritten by either of these instructions.
'''

from .F100_Opcode import *

class OpcodeF3(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "RTN":3, "RTC":3}, CPU=CPU )
        self.F = 3

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        if len(operands) > 0:
            warnings.append("Warning: Instruction %s takes no operands, so operand field%s will be ignored" % (opcode_token, '' if len(operands)< 2 else 's'))

        if opcode_token == "RTN":
            self.I = 0
        elif opcode_token == "RTC":
            self.I = 1

        # NB - lower 11 bits are all dont care but assembled will always define them to be zero
        self.N = 0

        return( self.bitassemble(), warnings)

    def disassemble(self, IR):
        if IR.I == 0:
            return "RTN"
        else:
            return "RTC"

    def execute(self):
        cycle_count = 0
        self.execstats[self.disassemble(self.CPU.IR)] += 1

        # Note that the PC has already been incremented during the instruction fetch
        stack_pointer = self.CPU.memory_read(0)
        self.CPU.PC = self.CPU.memory_read(stack_pointer-1) & 0x7FFF

        if self.CPU.IR.I == 0:
            # Restore only bits 0-5 from the stack
            condition = self.CPU.memory_read(stack_pointer) & 0x3F
            current_cr = self.CPU.CR.toint() & 0x0040
            self.CPU.CR.fromint(current_cr | condition)
        self.CPU.memory_write(0, stack_pointer-2)

        return cycle_count
