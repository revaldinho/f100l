'''
STO - Store Accumulator to Memory
---------------------------------

Store the value in the accumulator to the specified memory location

**Function**

::

   STO N      (N) <- A
   STO ,D     (PC+1) <- A
   STO /P     (P) <- A
   STO /P+    P <- P + 1 ; (P) <- A
   STO /P-    (P) <- A ;  P <- P - 1 ;
   STO .W     (W) <- A

**Instruction Encoding**


+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|        Opcode Word          |  Operand Word    | Function | Cycle count          |
+----+-+-+--+-----------------+                  |          |                      |
|    | | N                    |                  |          |                      |
|    | +-+--+-----------------+                  |          |                      |
| F  |I| | R| P               |                  |          |                      |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|0|  11'b<non-zero addr> |        none      | STO N    | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|0|  11'b000000000000    |     16`b<data>   | STO ,D   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|x0|8`b<non-zero ptr>|        none      | STO /P   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|01|8`b<non-zero ptr>|        none      | STO /P+  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|11|8`b<non-zero ptr>|        none      | STO /P-  | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+
|0100|1|x|xx|8`b00000000      |x|   15`b<addr>   | STO .W   | TBC                  |
+----+-+-+--+-----------------+-+----------------+----------+----------------------+

**Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--| * | 0 | * |\--|
+---+---+---+---+---+---+---+

* Z is set if the accumulator value is all-zeroes, otherwise cleared
* S is set if the MSB of the accumulator is a '1', otherwise cleared
* V is always cleared

'''

from .F100_Opcode import *

class OpcodeF4(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "STO":4}, CPU=CPU)
        self.F = 4

    def exec(self):
        cycle_count = 0

        IR = self.CPU.IR
        CR = self.CPU.CR

        operand = None
        operand_address = None
        if ( IR.F != self.F):
            raise UserWarning("Cannot execute opcode %04X using opcode class %s" % (opcode, self.__name__) )
        elif IR.I==0 and IR.N==0:
            self.addr_mode == ADM_IMMEDIATE
            operand_address = self.CPU.PC
        elif IR.I==0:
            self.addr_mode == ADM_DIRECT
            operand_address = IR.N
        elif IR.I==1 and IR.P==0:
            self.addr_mode == ADM_IMMEDIATE_INDIRECT
            operand_address = self.CPU.memory_fetch()
        elif IR.I==1:
            self.addr_mode == ADM_POINTER_INDIRECT
            pointer_val = self.CPU.memory_read(IR.P)
            if IR.R==1:
                pointer_val += 1
                self.addr_mode == ADM_POINTER_INDIRECT_PREINC
            operand_address = pointer_val
            if IR.R==3:
                self.addr_mode == ADM_POINTER_INDIRECT_POSTDEC
                pointer_val -= 1
            # Update the pointer location whether or not it has changed value
            self.CPU.memory_write(IR.P, pointer_val)

        self.CPU.memory_write(operand_address, self.CPU.ACC)
        self.CPU.CR.Z = 1 if (self.CPU.ACC & 0xFFFF) == 0 else 0
        self.CPU.CR.S = 1 if (self.CPU.ACC & 0x8000) != 0 else 0
        self.CPU.CR.V = 0
        return cycle_count
