=========================
The F100-L Microprocessor
=========================

The F100-L is a single-address, single accumulator, fixed 16-bit word length
microprocessor.

Memory Space
------------

Although all words are 16-bits wide, the program counter and addressing logic is
only capable of addressing a 15-bit space: the maximum addressable memory size
then is 64KBytes, arranged as 32K by 16-bit words.

In this 32K word space, the lower portion of the address range is treated differently
to the rest of the range. In particular the first 256 words of memory can be used as
pointers for Pointer Indirect Addressing modes,  with pre-increment and post-decrementing
available for the pointers themselves.

Locations 1-255 are available for user programs; location 0 is reserved
for use as the processor's link stack pointer since the CPU has no internal
stack pointer state of its own. The various jump to and return from subroutines
will always adjust the value of the stack pointer in location 0 appropriately.

Additionally when using any kind of indirection, the instruction word is able
to encode up to 11 bits of address in a single word opcode (Direct addressing). Therefore
it is preferred to use memory locations up to 0x07FF as data or additional pointers.

Memory above 0x0800 can be used for additional bulk data or program instruction code.

 +----------------+-----------------------------------------+
 | Memory Area    | Primary Usage                           |
 +----------------+-----------------------------------------+
 |    0x0000      | Link Stack Pointer                      |
 +----------------+-----------------------------------------+ 
 | 0x0001 - 0x00FF| Pointer area                            |
 +----------------+-----------------------------------------+
 | 0x0100 - 0x07FF| Directly addressed Data or Program Area |
 +----------------+-----------------------------------------+
 | 0x0800 - 0x7FFF| Data or Program Area                    | 
 +----------------+-----------------------------------------+

*Note: The user must always initialise the link stack pointer with an ODD value. The
return from stack operations assume that the top of the stack is odd and
access this location and the one immediately below by simply zeroing
the LSB when popping off the condition register and return address contents.*

Processor Start Up
------------------

When the processor is reset, program execution begins at one of two addresses
selected by the state of the AdSel pin (both of which are above the Direct
address mode area - see above).

 +------------------+-------------------------------+
 | AdSel Pin        | Program Counter Initial State |
 +------------------+-------------------------------+
 |     0            |  0x4000                       |
 +------------------+-------------------------------+
 | 1 \(or floating\)|  0x0800                       |
 +------------------+-------------------------------+ 


The Condition Register
----------------------

The Condition Register hold 7 flags (referred to as 'staticisers' in the F100-L
documentation).

+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
| Bit | Flag | Reset State | Name              |       Function                                                          |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  0  |   I  |  0          | Interrupt Disable | disables interrupts when set                                            |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  1  |   Z  |  X          | Zero              | indicates zero results                                                  |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  2  |   V  |  X          | Overflow          | indicates overflow in arithmetic and shift operations                   |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  3  |   N  |  X          | Negative sign     | indicates sign of results                                               |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  4  |   C  |  X          | Carry             | carry bit, set at the end of arithmetic and shift operations            |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  5  |   M  |  0          | Multi-Length      | enables use of the carry bit as input to arithmetic and shift operations|
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+
|  6  |   F  |  0          | Fail              | set if an external function , DMA or IO cycle does not complete         |
|     |      |             |                   | within an externally defined time.                                      |
+-----+------+-------------+-------------------+-------------------------------------------------------------------------+

 Once set the 'M' flag can only be reset by a CPU reset, interrupt or by using the CAL instruction.


Addressing Modes
----------------

The F100-L CPU supports 4 addressing modes and these are described below together
with the assembler syntax.

**Direct addressing**
  
The address of the operand data is encoded in an 11 bit field in the opcode word. In the 
assembler this mode is denoted by providing just a bare operand. e.g. 

  ::

    AND 0x444  ;  A <- A & (0x444)

If an operand is used which is larger than 11 bits, the assembler will emit a warning
and instead assemble the instruction using the Immediate Indirect Addressing mode below.
This will always achieve the correct behaviour, but the latter mode requires two instruction
words where Direct Addressing, with a smaller operand, needs only one.

**Immediate addressing**

The 16 bit operand data is placed in the word immediately following the opcode. In the 
assembler this mode is denoted by a comma (,) immediately before the operand e.g. 

  ::

    AND ,0x4444 ; A <- A & 0x4444

**Pointer addressing**

The address of the operand data is encoded in an 8 bit field in the opcode word. 
Optionally the value of this pointer can be pre-incremented or post-decremented. 
This mode is denoted in the assembler by a slash (/) immediately in front of the 
operand and optionally a plus (+) or minus (-) symbol following. e.g.

  :: 

    AND /0x44  ;  A <- A & (0x44)
    AND /0x44+ ;  (0x44) <- (0x44) + 1 ; A <- A & (0x44)
    AND /0x44- ;  A <- A & (0x44) ; (0x44) <- (0x44) -1

**Immediate indirect addressing**

The 15 bit address of the operand data is placed in the word immediately following
the opcode. This mode is denoted in the assembler by a dot (.) immediately in front
of the operand, e.g.

  ::

    AND .0x4444  ;  A <- A & (0x4444)







      
