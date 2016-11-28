'''
SLA,SLE,SLL,SRA,SRE,SRL - Shift and Rotation
============================================

These instructions perform single or multi-length shifts and rotations of a specified register or memory location.

Several different types of shift are available

* SLA - Shift Left Arithmetic

  * All bits are shifted left by the specified number of places, and the incoming LSBs are filled with '0'

* SRA - Shift Right Arithmetic

  * All bits are shifted right by the specified number of places, and the original sign bit is extended to fill the incoming MSBs

* SLL - Shift Left Logical

  * All bits are shifted left by the specified number of places, and the incoming LSBs are filled with '0'.
  * NB This is exactly the same data operation as SLA, but the flags are handled differently (see below)

* SRL - Shift Right Logical

  * All bits are shifted right by the specified number of places, and the incoming MSBs are filled with '0'

* SLE - Rotate Left (Shift Left End-around)

  * All bits are rotated left by the specified number of places, with the MSBs being recirculated into the LSB positions

* SRE - Rotate Right (Shift Right End-around)

  * All bits are shifted right by the specified number of places, with the LSBs being recirculated into the MSB positions

The data to be shifted can be one of

* the Accumulator (A),
* the Condition Register (CR), or
* a memory location (W)

The shifts will be either single length, if the 'M' flag is clear, or double length if 'M' is set.

Any shifts where the Condition Register itself is to be shifted will treat that register as a bit
pattern and all bits will be left in the shifted state at the end of the instruction.

Single Length Shifts
--------------------

When 'M' is clear the bottom 4 LSBs of the Opcode word determine the number of places, n,  to shift, ie 0<=n<=15.

In single length operation the data to be shifted can be one of

* the Accumulator (A),
* the Condition Register (CR), or
* a memory location (W)


**Function**

::

  SLL  B A      A <- A << B
  SLL  B CR     CR <- CR << B
  SLL  B W      (W) <- (W) << B
  SLA  B A      A <- A << B
  SLA  B CR     CR <- CR << B
  SLA  B W      (W) <- (W) << B
  SRL  B A      A <- A >>> B
  SRL  B CR     CR <- CR >>> B
  SRL  B W      (W) <- (W) >>> B
  SRA  B A      A <- A >> B
  SRA  B CR     CR <- CR >> B
  SRA  B W      (W) <- (W) >> B

**Instruction Encoding**

+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|         Opcode Word           | Operand         | Function                  | Cycle count          |
+----+--+--+--+--+--------------+                 |                           |                      |
| F  | T| R| S| J|   B          |                 |                           |                      |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|00|0x|4'b<shift num>|  none           | SRA B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|00|10|4'b<shift num>|  none           | SRL B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|00|0x|4'b<shift num>|  none           | SRA B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|00|10|4'b<shift num>|  none           | SRL B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|00|0x|4'b<shift num>|  none           | SRA B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|00|10|4'b<shift num>|  none           | SRL B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|0x|4'b<shift num>|  none           | SLA B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|10|4'b<shift num>|  none           | SLL B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|01|0x|4'b<shift num>|  none           | SLA B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|01|10|4'b<shift num>|  none           | SLL B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|0x|4'b<shift num>|  none           | SLA B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|10|4'b<shift num>|  none           | SLL B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+-------------------+
| F | M | C | S | V | Z | I |   Shift Type      |
+---+---+---+---+---+---+---+-------------------+
|\--|\--|\--| * | * | x |\--| Arithmetic Shifts |
+---+---+---+---+---+---+---+-------------------+
|\--|\--|\--| x | x | x |\--| Logical Shifts    |
+---+---+---+---+---+---+---+-------------------+

For arithmetic shift operations *not* specifying the Condition Register:

  * S is set if the MSB of the shifted data is '1', otherwise cleared
  * V is set if the MSB of the shifted data is different to its original state
  * C is preserved
  * Z is meaningless at the end of the instruction

For logical shift operations *not* specifying the Condition Register:

  * C is preserved
  * V, Z and S are meaningless



Single Length Rotations
-----------------------


**Function**

::

  SLE  B A      A <- _rotl(A,B)
  SLE  B CR     CR <- _rotl(CR,B)
  SLE  B W      (W) <- _rotl((W),B)
  SRE  B A      A <- _rotr(A,B)
  SRE  B CR     CR <- _rotr(CR,B)
  SRE  B W      (W) <- _rotr((W),B)


**Instruction Encoding**

+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|         Opcode Word           | Operand         | Function                  | Cycle count          |
+----+--+--+--+--+--------------+                 |                           |                      |
| F  | T| R| S| J|   B          |                 |                           |                      |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|00|11|4'b<shift num>|  none           | SRE B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|00|11|4'b<shift num>|  none           | SRE B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|00|11|4'b<shift num>|x| 15'b<addr>    | SRE B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|11|4'b<shift num>|  none           | SLE B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|01|11|4'b<shift num>|  none           | SLE B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|11|4'b<shift num>|x| 15'b<addr>    | SLE B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+


**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--| x | x | x |\--|
+---+---+---+---+---+---+---+

For operations *not* specifying the Condition register:

  * C is preserved
  * S, V and Z are meaningless at the end of the instruction



Double Length Shifts
--------------------

When 'M' is set, a double length operation is performed on a 32-bit word which is made up of the Accumulator
in the 16 MSBs and the internal Operand Register providing the lower 16 bits. The contents of the Operand
Register are dependent on the previous instruction.

In double length mode the number of bit positions to be shifted is taken from the 5 LSBs of the opcode word.
The lower 4 LSBs are the same bit as used in the single-length mode, but the 5th bit (the MSB) is taken from
one of the bit fields used to select between logical, arithmetic and rotate variations. Executing a shift
originally assembled as a single-length operation but with the M flag set to '1' can therefore have
unexpected results. For this reason the assembler provides a specific mnemonic for the double length
operations ending with a .D suffix. The programmer is responsible for ensuring that the M flag is in the
correct state before executing either a single or double length operation.

In double length mode, the rotate operations are undefined.

**Function**

::

  SLA.D B A  {A, OR} <- {A, OR} << B
  SLL.D B A  {A, OR} <- {A, OR} << B
  SRA.D B A  {A, OR} <- {A, OR} >> B
  SRL.D B A  {A, OR} <- {A, OR} >>> B

**Instruction Encoding**

+----+--+--+--+-+-+--------------+-+---------------+---------------------------+----------------------+
|         Opcode Word            | Operand         | Function                  | Cycle count          |
+----+--+--+--+-+-+--------------+                 |                           |                      |
| F  | T| R| S| J |   B          |                 |                           |                      |
+----+--+--+--+-+-+--------------+-+---------------+---------------------------+----------------------+
|0000|00|xx|00|0| 5'b<shift num> |  none           | SRA.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|xx|00|1| 5'b<shift num> |  none           | SRL.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|xx|01|0| 5'b<shift num> |  none           | SLA.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|xx|01|1| 5'b<shift num> |  none           | SLL.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+-------------------+
| F | M | C | S | V | Z | I |   Shift Type      |
+---+---+---+---+---+---+---+-------------------+
|\--|\--|\--| * | * | x |\--| Arithmetic Shifts |
+---+---+---+---+---+---+---+-------------------+
|\--|\--|\--| x | x | x |\--| Logical Shifts    |
+---+---+---+---+---+---+---+-------------------+

For arithmetic shift operations *not* specifying the Condition Register:

  * S is set if the MSB of the shifted data is '1', otherwise cleared
  * V is set if the MSB of the shifted data is different to its original state
  * C is preserved
  * Z is meaningless at the end of the instruction

For logical shift operations *not* specifying the Condition Register:

  * C is preserved
  * V, Z and S are meaningless

'''
from .F100_Opcode import *


class OpcodeF0_Shift(F100_Opcode) :


    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "SRE":0, "SLE":0, "SLA":0, "SRA":0, "SRL":0, "SLL":0, }, CPU=CPU )
        self.F = 0

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        # Shift can use one or two operands
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        warnings = []
        words = []

        if opcode_token.endswith(".D") :
            multilength = True
        else:
            multilength = False

        (first_operand_val, w ) = get_operand_value(first_operand, symbol_table, suppress_errors)

        if w != None:
            warnings.append(w)

        if multilength == True:
            if addr_mode != ADM_DIRECT or len(operands) != 2 or operands[1] != 'A' :
                raise UserWarning("Error: double length shift instruction can use only direct addressing with a 5 bit field operand and the accumulator as the operand")
            elif addr_mode != ADM_DIRECT or len(operands) != 2:
                raise UserWarning("Error: shift instruction can use only direct addressing with a 4 bit field operand and optional register or 15 bit second operand")


        self.T = 0
        self.J = 0
        if re.match("SRA",opcode_token):
            self.S = 0
            self.J = 0
        elif re.match("SRL",opcode_token):
            self.S = 0
            self.J = 2
        elif re.match("SLA",opcode_token):
            self.S = 1
            self.J = 0
        elif re.match("SLL",opcode_token):
            self.S = 1
            self.J = 2
        elif opcode_token == "SRE":
            self.S = 0
            self.J = 3
        elif opcode_token == "SLE":
            self.S = 1
            self.J = 3

        if multilength:
            # Make the 5 bit field fit into J and B
            validate_operand(first_operand_val, 0, 0x01F, 5)
            # B can hold a 5 bit number but will overlap with J when OR'd together
            self.B = first_operand_val
            # So zero the LSB in the J field.
            self.J = (self.J & 0x02)
        else:
            # 4 bit field fits B exactly
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

    def exec(self):
        raise UserWarning("Execution for Opcode F0 (SRE,SRA,SRL,SLE,SLA,SLL) not yet implemented")
