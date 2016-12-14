from F100_Opcodes.F100_Opcode import *
from F100_Opcodes.OpcodeF15 import *
from F100_Opcodes.OpcodeF13 import *
from F100_Opcodes.OpcodeF12 import *
from F100_Opcodes.OpcodeF11 import *
from F100_Opcodes.OpcodeF10 import *
from F100_Opcodes.OpcodeF9 import *
from F100_Opcodes.OpcodeF8 import *
from F100_Opcodes.OpcodeF7 import *
from F100_Opcodes.OpcodeF6 import *
from F100_Opcodes.OpcodeF5 import *
from F100_Opcodes.OpcodeF4 import *
from F100_Opcodes.OpcodeF3 import *
from F100_Opcodes.OpcodeF2 import *
from F100_Opcodes.OpcodeF1 import *
from F100_Opcodes.OpcodeF0 import *
from F100_Opcodes.OpcodeF0_Shift import *
from F100_Opcodes.OpcodeF0_Halt import *
from F100_Opcodes.OpcodeF0_Jump import *
from F100_Opcodes.OpcodeF0_Bit import *

from InstructionReg import InstructionReg
from ConditionReg import ConditionReg

class F100CPU:
    def __init__ (self, adsel=1, memory_read=None, memory_write=None):
        self.CR = ConditionReg()
        self.IR = InstructionReg()
        self.OR = 0x0000
        self.adsel = adsel
        self.PC = 0x0000
        self.ACC= 0x0000
        self.memory_write = memory_write
        self.memory_read = memory_read
        self.cycle_count = 0
        self.instr_count = 0
        ## instance all the opcode classes, passing each a reference to the CPU resources
        self.opcode_classes = [ opcode(CPU=self) for opcode in [OpcodeF0,
                                                                OpcodeF1, OpcodeF2, OpcodeF3, OpcodeF4,
                                                                OpcodeF5, OpcodeF6, OpcodeF7,
                                                                OpcodeF8, OpcodeF9, OpcodeF10,
                                                                OpcodeF11, OpcodeF12, OpcodeF13, OpcodeF15 ] ]
        self.opcode_table = dict()
        for o in self.opcode_classes:
            self.opcode_table[o.F] = o
        self.cycle_count = 0
        self.instr_count = 0
        self.reset()

    def reset(self):
        self.PC = 2048 if self.adsel == 1 else 16384

    def memory_fetch(self):
        result = self.memory_read(self.PC)
        self.PC = ( self.PC + 1 )  & 0x7FFF
        return result

    def single_step(self):
        self.IR.update(self.memory_fetch())
        if ( self.IR.F not in self.opcode_table):
            raise UserWarning("Cannot execute Opcode with function field 0x%X" % self.IR.F )
        else:
            self.opcode_table[self.IR.F].execute()
        return
