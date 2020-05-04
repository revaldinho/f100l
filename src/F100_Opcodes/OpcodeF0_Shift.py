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

All single-length shifting is done through the Operand Register and the result is copied into the
required destination at the end of the operation. When a memory location is specified as the source
that location is updated at the end of the shift via a read-modify-write operation. The Accumulator
is not modified when shifting the Condition Register or a memory location.

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
|0000|00|11|00|0x|4'b<shift num>|x| 15'b<addr>    | SRA B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|00|10|4'b<shift num>|x| 15'b<addr>    | SRL B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|0x|4'b<shift num>|  none           | SLA B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|10|4'b<shift num>|  none           | SLL B A                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|01|0x|4'b<shift num>|  none           | SLA B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|01|01|10|4'b<shift num>|  none           | SLL B CR                  | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|0x|4'b<shift num>|x| 15'b<addr>    | SLA B W                   | TBC                  |
+----+--+--+--+--+--------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|10|4'b<shift num>|x| 15'b<addr>    | SLL B W                   | TBC                  |
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
  * V is set if the MSB of the shifted data is permanently or temporarily different to its original state, ie for multiple place shifts the flag is set if any bit passing through the MSB position is different to the original sign even if the shift finishes with the sign bit apparently unchanged.
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
in the 16 MSBs and the internal Operand Register providing the lower 16 bits. The Operand Register is either 
pre-loaded by a previous instruction (R=0,2) or from a memory location (R=3). When R=3 the least significant
word of the result will be written back to the same memory location.

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

  SLA.D B W  {A, (W)} <- {A, (W)} << B
  SLL.D B W  {A, (W)} <- {A, (W)} << B
  SRA.D B W  {A, (W)} <- {A, (W)} >> B
  SRL.D B W  {A, (W)} <- {A, (W)} >>> B
  SLA.D B A  {A, OR} <- {A, OR} << B
  SLL.D B A  {A, OR} <- {A, OR} << B
  SRA.D B A  {A, OR} <- {A, OR} >> B
  SRL.D B A  {A, OR} <- {A, OR} >>> B
  SLA.D B CR  {A, CR} <- {A, CR} << B
  SLL.D B CR  {A, CR} <- {A, CR} << B
  SRA.D B CR  {A, CR} <- {A, CR} >> B
  SRL.D B CR  {A, CR} <- {A, CR} >>> B

**Instruction Encoding**

+----+--+--+--+-+-+--------------+-+---------------+---------------------------+----------------------+
|         Opcode Word            | Operand         | Function                  | Cycle count          |
+----+--+--+--+-+-+--------------+                 |                           |                      |
| F  | T| R| S| J |   B          |                 |                           |                      |
+----+--+--+--+-+-+--------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|00|0| 5'b<shift num> |  none           | SRA.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|00|1| 5'b<shift num> |  none           | SRL.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|0| 5'b<shift num> |  none           | SLA.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|x0|01|1| 5'b<shift num> |  none           | SLL.D B A                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|10|00|0| 5'b<shift num> |  none           | SRA.D B CR                | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|10|00|1| 5'b<shift num> |  none           | SRL.D B CR                | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|10|01|0| 5'b<shift num> |  none           | SLA.D B CR                | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|10|01|1| 5'b<shift num> |  none           | SLL.D B CR                | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|11|00|0| 5'b<shift num> |X| 15'b <addr>   | SRA.D B W                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|11|00|1| 5'b<shift num> |X| 15'b <addr>   | SRL.D B W                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|0| 5'b<shift num> |X| 15'b <addr>   | SLA.D B W                 | TBC                  |
+----+--+--+--+-+----------------+-+---------------+---------------------------+----------------------+
|0000|00|11|01|1| 5'b<shift num> |X| 15'b <addr>   | SLL.D B W                 | TBC                  |
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
  * V is set if the MSB of the shifted data is permanently or temporarily different to its original state, ie for multiple place shifts the flag is set if any bit passing through the MSB position is different to the original sign even if the shift finishes with the sign bit apparently unchanged.
  * C is preserved
  * Z is meaningless at the end of the instruction

For logical shift operations *not* specifying the Condition Register:

  * C is preserved
  * V, Z and S are meaningless

'''
from .F100_Opcode import *


def d_sra(a,o,num):
    # Double shift right arithmetic of 16b ACC + OR returning
    # two new 16 bit numbers
    operand = ((a<<16) | o ) >> num
    if a & 0x8000 :
        sign = 0xFFFFFFFF << (32-num)
        operand |= sign
    return (operand>>16 & 0xFFFF, operand & 0xFFFF)

def d_srl(a,o,num):
    # Double shift right logical of 16b ACC + OR returning
    # two new 16 bit numbers
    operand = (a<<16) | o
    operand = (operand >> num)
    return (operand>>16 & 0xFFFF, operand & 0xFFFF)

def d_sll(a,o,num):
    # Double shift left logical of 16b ACC + OR returning
    # two new 16 bit numbers
    overflow = 0
    operand = (a<<16) | o
    source = operand
    for i in range(0, num):
        operand = (operand << 1)
        if (operand & 0x80000000) != (source & 0x80000000):
            overflow = 1
    return (operand>>16 & 0xFFFF, operand & 0xFFFF, overflow)

def rotl(a,num):
    # Single 16b rotate left of 16b number by 0-15 places
    operand = a<<16 | a
    return ( operand >> (16-num) ) & 0xFFFF

def rotr(a,num):
    # Single 16b rotate right of 16b number by 0-15 places
    operand = a<<16 | a
    return ( operand >> num) & 0xFFFF

def sra( a, num):
    # Single shift right arithmetic of 16b number by 0-15 places
    operand = a | (0xFFFF0000 if a & 0x8000 else 0)
    return (operand >> num) & 0xFFFF

def srl( a, num):
    # Single shift right logical of 16b number by 0-15 places
    operand = a
    return (operand >> num) & 0xFFFF

def sll( a, num):
    # Single shift left arithmetic of 16b number by 0-15 places
    # return overflow set if any bit passing through the MSB is different to the original sign bit
    overflow = 0
    operand = a
    for i in range(0, num):
        operand = operand << 1
        if (operand & 0x8000) != (a & 0x8000):
            overflow = 1
    return (operand  & 0xFFFF, overflow)


class OpcodeF0_Shift(F100_Opcode) :


    def __init__ (self, CPU=None):
        super().__init__(opcode_fn = { "SRE":0, "SLE":0, "SLA":0, "SRA":0, "SRL":0, "SLL":0, "SLA.D":0, "SRA.D":0, "SRL.D":0, "SLL.D":0,}, CPU=CPU )
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
            if addr_mode != ADM_DIRECT or len(operands) != 2:
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


    def disassemble(self, IR):
        mnemonic = ""
        if self.CPU.CR.M == 0:
            if IR.S == 0 and IR.J <2:
                mnemonic = "SRA"
            elif IR.S == 0 and IR.J == 2:
                mnemonic = "SRL"
            elif IR.S == 0 and IR.J == 3:
                mnemonic = "SRE"
            elif IR.S == 1 and IR.J == 2:
                mnemonic = "SLL"
            elif IR.S == 1 and IR.J < 2:
                mnemonic = "SLA"
            elif IR.S == 1 and IR.J == 3:
                mnemonic = "SLE"
        else:
            if IR.S == 0 and IR.J <2:
                mnemonic = "SRA.D"
            elif IR.S == 0:
                mnemonic = "SRL.D"
            elif IR.J < 2:
                mnemonic = "SLA.D"
            else:
                mnemonic = "SLL.D"
        return mnemonic

    def execute(self):
        cycle_count = 0
        CPU = self.CPU
        CR = self.CPU.CR
        IR = self.CPU.IR
        IR.name = self.disassemble(self.CPU.IR)
        self.execstats[IR.name] += 1

        if CR.M == 0 :
            # Single length shifts and rotates
            if IR.R == 1:
                operand = CPU.OR = CR.toint()
            elif IR.R == 3:
                operand_addr = CPU.memory_fetch()
                operand = CPU.OR = CPU.memory_read(operand_addr)
            else:
                operand = CPU.OR = CPU.ACC

            if IR.S == 0 and IR.J <2:
                result = sra(operand, IR.B)
                CR.S = 1 if result & 0x8000 else 0
                CR.V = 1 if (result & 0x8000) != (operand & 0x8000) else 0
            elif IR.S == 0 and IR.J == 2:
                result = srl(operand, IR.B)
            elif IR.S == 0 and IR.J == 3:
                result = rotr(operand, IR.B)
            elif IR.S == 1 and IR.J != 3:
                (result, overflow) = sll(operand, IR.B)
            elif IR.S == 1 and IR.J == 3:
                result = rotl(operand, IR.B)

            # Always computer S and V even when meaningless
            CR.S = 1 if result & 0x8000 else 0
            CR.V = 1 if (result & 0x8000) != (operand & 0x8000) else 0

            if IR.R == 1:
                CR.fromint(result)
            elif IR.R ==3:
                CPU.OR = result
                CPU.memory_write(operand_addr, CPU.OR)
            else:
                CPU.ACC = result

        else:
            # Double length shifts use LSB of J field to extend shift number
            shift_dist = ( (IR.J << 4) | IR.B )  & 0x1F
            # Double length shifts
            if ( IR.R==3):
                operand_addr = CPU.memory_fetch()
                CPU.OR = CPU.memory_read(operand_addr)                    
            if IR.S == 0 and IR.J <2:
                (result, result1) = d_sra(CPU.ACC, CPU.OR, shift_dist)
            elif IR.S == 0:
                (result, result1) = d_srl(CPU.ACC, CPU.OR, shift_dist)
            else:
                (result, result1, overflow) = d_sll(CPU.ACC, CPU.OR, shift_dist)
            CR.S = 1 if result & 0x8000 else 0
            CR.V = 1 if (result & 0x8000) != (CPU.ACC & 0x8000) else 0

            CPU.ACC = result
            CPU.OR = result1
            if (IR.R==3):
                # Double length shifts write back the LSW into memory
                CPU.memory_write(operand_addr, CPU.OR)
            
        return cycle_count
