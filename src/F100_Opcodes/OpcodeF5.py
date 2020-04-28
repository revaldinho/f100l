'''
ADS - Add (With Carry), Store to Memory
=======================================

Perform addition of the accumulator and an operand with the result being stored in
the operand's original location.

When the multi-length 'M' flag is set, the carry bit from a previous operation is
included in the addition.

**Function**

When 'M' is clear

::

   ADS N      (N) <- (N) + A
   ADS ,D     (PC+1) <- D + A
   ADS /P     (P) <- (P) + A
   ADS /P+    P <- P + 1 ; (P) <- (P) + A
   ADS /P-    (P) <- (P) + A ;  P <- P - 1
   ADS .W     (W) <- (W) + A

When 'M' is set

::

   ADS N      (N) <- (N) + A + C
   ADS ,D     (PC+1) <- D + A + C
   ADS /P     (P) <- (P) + A + C
   ADS /P+    P <- P + 1 ; (P) <- (P) - A + C
   ADS /P-    (P) <- (P) + A + C ;  P <- P - 1
   ADS .W     (W) <- (W) + A + C


In the immediate mode operation, data 'D' is taken from the location (PC+1), ie the word immediately
after the opcode, and the the result is returned to that location.

The result of the addition passes through the Operand Register as it is written back to memory.

The accumulator is left unchanged by the result of the ADS operation.

**Instruction Encoding**


+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|        Opcode Word          |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | | N                    |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0101|0|  11'b<non-zero addr> |        none      | ADS N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0101|0|  11'b000000000000    |     16'b<data>   | ADS ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0101|1|x|x0|8'b<non-zero ptr>|        none      | ADS /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0101|1|x|01|8'b<non-zero ptr>|        none      | ADS /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0101|1|x|11|8'b<non-zero ptr>|        none      | ADS /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0101|1|x|xx|8'b00000000      |x|   15'b<addr>   | ADS .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--| * | * | * | * |\--|
+---+---+---+---+---+---+---+

* C is set if the operation results in a carry out, otherwise cleared
* Z is set if the result is all-zeroes, otherwise cleared
* S is set if the MSB of the result is a '1', otherwise cleared
* V is set if the addition of two numbers with the same sign results in a value with the opposite sign

'''
from .F100_Opcode import *


class OpcodeF5(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "ADS":5}, CPU=CPU)
        self.F = 5

    def execute(self):
        cycle_count = 0
        CPU = self.CPU

        self.execstats[self.disassemble(CPU.IR)] += 1

        (CPU.OR, operand_address, cycles) = self.get_operand()
        result = (CPU.OR + CPU.ACC) & 0x1FFFF
        if (CPU.CR.M==1) :
            result = (result + CPU.CR.C) &0x1FFFF

        CPU.memory_write(operand_address, result)

        if ((CPU.ACC & 0x8000) == (CPU.OR & 0x8000)) and ((result & 0x8000) != (CPU.ACC & 0x8000)):
            CPU.CR.V = 1
        else:
            CPU.CR.V = 0
        CPU.CR.C = 1 if (result & 0x010000) > 0 else 0
        CPU.CR.Z = 1 if (result & 0xFFFF) == 0 else 0
        CPU.CR.S = 1 if (result & 0x8000) != 0 else 0
        CPU.OR = result
        
        return cycle_count
