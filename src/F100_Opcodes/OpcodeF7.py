
'''
ICZ - Increment and Jump if Non-Zero
====================================

Increment the contents of a counter or address and jump to a specified location if the result is non-zero

**Function**

::

   ICZ N   W1  (N) <- (N)+1 ; if (Z==0) PC <- W1
   ICZ ,D  W1  D <- D+1 ; if (Z==0) PC <- W1
   ICZ /P  W1  (P) <= (P)+1 ; if (Z==0) PC <- W1
   ICZ /P+ W1  P <- P+1 ; (P) <- (P)+1 ; if (Z==0) PC <- W1
   ICZ /P- W1  (P) <- (P)+1 ;  P <- P-1; ; if (Z==0) PC <- W1
   ICZ .W  W1  (W) <- (W)+1 ; if (Z==0) PC <- W1

**Instruction Encoding**

+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|        Opcode Word          |  Operand Word   | Second Operand   | Function  | Cycle count  |
+----+-+-+--+-----------------+                 |                  |           |              |
|    | | N                    |                 |                  |           |              |
|    | +-+--+-----------------+                 |                  |           |              |
| F  |I| | R| P               |                 |                  |           |              |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|0111|0|  11'b<non-zero addr> |x|15'b<jump addr>|        none      | ICZ N   W1| TBC          |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|0111|0|  11'b000000000000    |     16'b<data>  |x|15'b<jump addr> | ICZ ,D  W1| TBC          |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|0111|1|x|x0|8'b<non-zero ptr>|x|15'b<jump addr>|        none      | ICZ /P  W1| TBC          |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|0111|1|x|01|8'b<non-zero ptr>|x|15'b<jump addr>|        none      | ICZ /P+ W1| TBC          |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|0111|1|x|11|8'b<non-zero ptr>|x|15'b<jump addr>|        none      | ICZ /P- W1| TBC          |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+
|0111|1|x|xx|8'b00000000      |x|   15'b<addr>  |x|15'b<jump addr>x| ICZ .W  W1| TBC          |
+----+-+-+--+-----------------+-+---------------+-+----------------+-----------+--------------+


*Condition Register**

+---+---+---+---+---+---+---+
| F | M | C | S | V | Z | I |
+---+---+---+---+---+---+---+
|\--|\--|\--|\--|\--|\--|\--|
+---+---+---+---+---+---+---+

* The condition code register is unchanged after this operation

'''
from .F100_Opcode import *

class OpcodeF7(F100_Opcode) :

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "ICZ":7 }, CPU=CPU )
        self.F = 7

    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        warnings = []
        words = []

        if len(operands) != 2:
           raise UserWarning("Error: Instruction ICZ requires two operands, but %d provided" % len(operands))

        (addr_mode, first_operand ) = self.get_address_mode(operands[0])

        operand_values = []
        for o in (first_operand, operands[1]):
            (operand_val, w ) = get_operand_value(o, symbol_table, suppress_errors)
            if w != None:
                warnings.append(w)
            operand_values.append(operand_val)

        if opcode_token in self.opcode_fn:
            self.F = self.opcode_fn[opcode_token]
        else:
            raise UserWarning( "Error: Cannot deal with opcode %s" % opcode_token)

        # Cannot use direct mode with operand of 0 so silently transform to more suitable mode
        if addr_mode == ADM_DIRECT and operand_values[0] == 0:
            addr_mode = ADM_IMMEDIATE_INDIRECT
            warnings.append("Warning: Cannot use direct mode with operand of 0 so will assemble to immediate indirect instead")

        validate_operand( operand_values[1], 0, 0x7FFF, 15)
        # Set the various Opcode fields now based on addressing modes and instruction function
        if addr_mode == ADM_DIRECT:
            validate_operand( operand_values[0], 1, 0x07FF, 11)
            self.N = operand_values[0]
            self.W = operand_values[1]
            self.I = 0
        elif addr_mode == ADM_IMMEDIATE:
            validate_operand( operand_values[0], 0, 0xFFFF, 16)
            self.N = 0
            self.I = 0
            self.D = operand_values[0]
            self.W = operand_values[1]
        elif addr_mode in ( ADM_POINTER_INDIRECT, ADM_POINTER_INDIRECT_PREINC, ADM_POINTER_INDIRECT_POSTDEC):
            validate_operand( operand_values[0], 1, 0xFF, 8)
            self.P = operand_values[0]
            self.I = 1
            if addr_mode == ADM_POINTER_INDIRECT:
                self.R = 0
            elif addr_mode in (ADM_POINTER_INDIRECT_POSTDEC, ADM_POINTER_INDIRECT_PREINC):
                self.R = 1 if addr_mode == ADM_POINTER_INDIRECT_PREINC else 3
            self.W = operand_values[1]
        elif addr_mode == ADM_IMMEDIATE_INDIRECT:
            validate_operand( operand_values[0], 0, 0x7FFF, 15)
            self.P = 0
            self.I = 1
            self.W = operand_values[0]
            self.W1 = operand_values[1]

        return (self.bitassemble(), warnings)


    def execute(self):
        cycle_count = 0
        CPU = self.CPU
        IR = CPU.IR
        self.execstats[IR.name] += 1
        # Get the first operand - address or value of counter
        (CPU.OR, operand_address, cycle_count) = self.get_operand()
        # fetch the second operand
        jump_addr = CPU.memory_fetch()
        result = (CPU.OR + 1) & 0xFFFF
        # only the direct addressing case does not return the result to the operand source location
        if not(IR.I==0 and IR.N==0):
            CPU.memory_write(operand_address, result)
        if result != 0:
            CPU.PC = jump_addr
        CPU.ACC = result 

        return cycle_count
