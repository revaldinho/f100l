'''
CLR, SET - Bit manipulation
===========================

Clear or set a single bit within the operand.

**Function**

::

   CLR B A   A[B] <- 0
   CLR B CR  CR[B] <- 0
   CLR B W   (W)[B] <- 0
   SET B A   A[B] <- 1
   SET B CR  CR[B] <- 1
   CLR B W   (W)[B] <- 1

**Instruction Encoding**

+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|         Opcode Word           | Operand         | Function                  | Cycle count          |
+----+--+--+--+--+--------------+                 |                           |                      |
| F  | T| R| S| J|   B          |                 |                           |                      |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|11|11|4'b<bit field>|  none           | CLR B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|11|11|4'b<bit field>|  none           | CLR B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|11|11|4'b<bit field>|x|15'b<address W>| CLR B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|11|10|4'b<bit field>|  none           | SET B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|11|10|4'b<bit field>|  none           | SET B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|11|10|4'b<bit field>|x|15'b<address W>| SET B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--|\--|\--|\--|\--|
+---+---+---+---+---+---+---+

* Note that any operation on the CR will set the selected bit, but otherwise the Condition Register is not
  affected by these instructions.
'''

from .F100_Opcode import *

class OpcodeF0_Bit(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "CLR":0, "SET":0 }, CPU=CPU )
        self.F = 0

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        # SET, CLR can use one or two operands
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        warnings = []
        words = []

        (first_operand_val, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)

        if addr_mode != ADM_DIRECT or len(operands) != 2:
            raise UserWarning("Error: %s instruction can use only direct addressing with a 4 bit operand and optional register or 15 bit second operand")

        self.T = 0
        self.S = 3
        self.J = 3 if opcode_token == "CLR" else 2

        validate_operand(first_operand_val, 0, 0x0F, 4)
        self.B = first_operand_val

        if operands[1] == "A":
            self.R = 0
        elif operands[1] == "CR":
            self.R = 1
        else:
            self.R = 3
            (second_operand_val, w ) = get_operand_value(operands[1], symbol_table, suppress_errors)
            if w != None:
                warnings.append(w)
            validate_operand(second_operand_val, 0, 0x7FFF, 15)
            self.W = second_operand_val

        return( self.bitassemble(), warnings)

    def disassemble(self, IR):
        if IR.J == 3:
            return "CLR"
        else:
            return "SET"

    def execute(self):
        cycle_count = 0

        IR = self.CPU.IR
        bitmask = 0x01 << IR.B
        IR.name = self.disassemble(self.CPU.IR)
        self.execstats[IR.name] += 1

        if IR.J == 3: # CLR
            if IR.R == 3:
                operand = self.CPU.memory_fetch()
                value = self.CPU.memory_read(operand) & ~bitmask
                self.CPU.memory_write(operand, value)
            elif IR.R == 1:
                self.CPU.CR.fromint(self.CPU.CR.toint() & ~bitmask)
            else:
                self.CPU.ACC = self.CPU.ACC & ~bitmask
        elif IR.J == 2:
            if IR.R == 3:
                operand = self.CPU.memory_fetch()
                value = self.CPU.memory_read(operand) | bitmask
                self.CPU.memory_write(operand, value)
            elif IR.R == 1:
                self.CPU.CR.fromint(self.CPU.CR.toint() | bitmask)
            else:
                self.CPU.ACC = self.CPU.ACC | bitmask
        else:
            raise UserWarning("Error illegal field J in BIT/CLR opcode")

        return cycle_count
