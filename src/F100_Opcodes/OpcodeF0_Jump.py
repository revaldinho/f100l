'''
JBC, JBS, JCS, JSC - Conditional Jump
=====================================

These instructions inspect a bit field in the first operand and if the expected condition is satisfied jump to the location specified in the second operand.

* JBC (Jump bit clear) will jump to the specified destination if the inspected bit is clear (0).

  * JCS extends this operation to set the specified bit after the jump has been made.

* JBS (Jump bit set) will jump to the specified destination if the inspected bit is set (1).

  * JSC extends this operation to clear the specified bit after the jump has been made.

Each instruction can specify the bit to be located in one of

* the Accumulator (A),
* the Condition Register (CR), or
* a memory location (W)

**Function**

::

   JBC B A  W1     if (A[B] == 0) PC <- W1
   JBC B CR W1     if (CR[B] == 0) PC <- W1
   JBC B W  W1     if ((W)[B] == 0) PC <- W1
   JBS B A  W1     if (A[B] == 1) PC <- W1
   JBS B CR W1     if (CR[B] == 1) PC <- W1
   JBS B W  W1     if ((W)[B] == 1) PC <- W1
   JCS B A  W1     if (A[B] == 0) PC <- W1 ; A[B] <- 1
   JCS B CR W1     if (CR[B] == 0) PC <- W1 ; CR[B] <- 1
   JCS B W  W1     if ((W)[B] == 0) PC <- W1 ; (W)[B] <- 1
   JSC B A  W1     if (A[B] == 1) PC <- W1 ; A[B] <- 0
   JSC B CR W1     if (CR[B] == 1) PC <- W1 ; CR[B] <- 0
   JSC B W  W1     if ((W)[B] == 1) PC <- W1 ; (W)[B] <- 0

**Instruction Encoding**

+----+-+--+-----+-----+--------+-+----------------+-+----------------+---------------------------+----------------------+
|       Opcode Word            | Operand          | Operand          | Function                  | Cycle count          |
+----+-+--+--+--+--------------+                  |                  |                           |                      |
| F  |T| R| S| J|   B          |                  |                  |                           |                      |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|x0|10|00|4'b<bit field>|x|15'b<address W1>|      none        | JBC B A  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|01|10|00|4'b<bit field>|x|15'b<address W1>|      none        | JBC B CR W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|11|10|00|4'b<bit field>|x|15'b<address W> |x|15'b<address W1>| JBC B W  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|x0|10|01|4'b<bit field>|x|15'b<address W1>|      none        | JBS B A  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|01|10|01|4'b<bit field>|x|15'b<address W1>|      none        | JBS B CR W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|11|10|01|4'b<bit field>|x|15'b<address W> |x|15'b<address W1>| JBS B W  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|x0|10|10|4'b<bit field>|x|15'b<address W1>|      none        | JCS B A  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|01|10|10|4'b<bit field>|x|15'b<address W1>|      none        | JCS B CR W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|11|10|10|4'b<bit field>|x|15'b<address W> |x|15'b<address W1>| JCS B W  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|x0|10|11|4'b<bit field>|x|15'b<address W1>|      none        | JSC B A  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|01|10|11|4'b<bit field>|x|15'b<address W1>|      none        | JSC B CR W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+
|0000|0|11|10|11|4'b<bit field>|x|15'b<address W> |x|15'b<address W1>| JSC B W  W1               | TBC                  |
+----+-+--+--+--+--------------+-+----------------+-+----------------+---------------------------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--|\--|\--|\--|\--|
+---+---+---+---+---+---+---+

* The condition bits are not evaluated during this instruction, but any bits explicitly set or cleared when using the condition register as the first operand will affect the relevant flag.

'''
from .F100_Opcode import *

class OpcodeF0_Jump(F100_Opcode) :
    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "JBC":0, "JBS":0, "JCS":0, "JSC":0 }, CPU=CPU )
        self.F = 0

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        warnings = []
        words = []

        (first_operand_val, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)

        if addr_mode != ADM_DIRECT or len(operands) != 3 :
            raise UserWarning("Error: %s instruction can use only direct addressing with a 4 bit operand, register or 15 bit second operand and a 15 bit jump address")

        self.T = 0
        self.S = 2

        validate_operand(first_operand_val, 0, 0x0F, 4)
        if opcode_token == "JBC":
            self.J = 0
        elif opcode_token == "JBS":
            self.J = 1
        elif opcode_token == "JCS":
            self.J = 2
        elif opcode_token == "JSC":
            self.J = 3

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

        (third_operand_val, w ) = get_operand_value(operands[2], symbol_table, suppress_errors)
        if w != None:
            warnings.append(w)
        validate_operand(third_operand_val, 0, 0x7FFF, 15)

        if self.W == None:
            self.W = third_operand_val
        else:
            self.W1 = third_operand_val

        return( self.bitassemble(), warnings)


    def disassemble(self, IR):
        mnemonics = list( ("JBC","JBS","JCS","JSC") )
        return mnemonics[IR.J]


    def execute(self):

        cycle_count = 0
        IR = self.CPU.IR

        self.execstats[self.disassemble(IR)] += 1

        bitmask = 0x01 << IR.B

        if IR.R == 3:
            W = self.CPU.memory_fetch()
            operand = self.CPU.memory_read(W)
            W1 = self.CPU.memory_fetch()
        else:
            if IR.R == 1:
                operand = self.CPU.CR.toint()
            else:
                operand = self.CPU.ACC
            W1 = self.CPU.memory_fetch()

        if IR.J == 0 or IR.J == 2: # JBC, JCS
            if operand & bitmask == 0:
                self.CPU.PC = W1
                if IR.J == 2:
                    if IR.R == 3:
                        self.CPU.memory_write(W, operand | bitmask)
                    elif IR.R == 1:
                        self.CPU.CR.fromint(operand | bitmask)
                    else:
                        self.CPU.ACC = operand | bitmask
        else: # JBS, JSC
            if operand & bitmask != 0:
                self.CPU.PC = W1
                if IR.J == 3:
                    if IR.R == 3:
                        self.CPU.memory_write(W, operand &  ~bitmask)
                    elif IR.R == 1:
                        self.CPU.CR.fromint(operand & ~bitmask)
                    else:
                        self.CPU.ACC = operand & ~bitmask

        return cycle_count
