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
    def __init__ (self, adsel=1, ramsize=32768, traceon=False, memtraceon=False ):
        self.MEMTOP = ramsize-1
        self.traceon = traceon
        self.memtraceon = memtraceon        
        self.CR = ConditionReg()
        self.IR = InstructionReg()
        self.OR = 0x0000
        self.adsel = adsel
        self.PC = 0x0000
        self.ACC= 0x0000
        self.RAM = [0xDEAD]*ramsize
        self.RAM_writeset = set()
        self.cycle_count = 0
        self.read_count = 0
        self.write_count = 0
        self.modify_write_count = 0
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
        self.reset()

    def print_machine_state(self):
        PC = self.PC
        CR = self.CR
        IR = self.IR
        LSP = self.memory_read(0,False,True)
        print("%04X  : %04X : %04X %04X : %d%d%d%d%d%d%d : %04X  %04X   %04X   %04X  : %s" % \
        ((PC-1) & 0xFFFF,\
         IR.content, \
         self.ACC & 0xFFFF ,self.OR & 0xFFFF, \
         CR.F,CR.M,CR.C,CR.S,CR.V,CR.Z,CR.I,\
         self.memory_read(0,False,True), \
         self.memory_read((LSP-2) % 0x7FFF,False,True), \
         self.memory_read((LSP-1) %0x7FFF,False,True), \
         self.memory_read((LSP % 0x7FFF),False,True), \
         self.IR.name) )

    def interrupt(self, channel=0):
        channel = channel & 0x3F
        lsp = self.CPU.memory_read(0)
        # save next PC (already incremented)
        self.memory_write(lsp+1, self.CPU.PC)
        self.memory_write(lsp+2, self.CPU.CR.toint())
        self.memory_write(0, lsp+2)
        # disable further interrupts
        self.CR.I = 1
        # compute new PC address
        base_addr = 2048 if self.adsel == 1 else 16384
        destination = base_addr + 2 * channel
        self.PC = destination & 0x7FFF

    def reset(self):
        self.cycle_count = 0
        self.instr_count = 0
        self.read_count = 0
        self.write_count = 0
        self.modify_write_count = 0
        self.RAM_writeset = set()
        self.CR.reset()
        self.PC = 2048 if self.adsel == 1 else 16384

    def memory_fetch(self):
        result = self.memory_read(self.PC)
        self.PC = ( self.PC + 1 )  & 0x7FFF
        return result

    def memory_read(self, address, nostats=False, notrace=False):
        a = address & 0xFFFF
        data = self.RAM[a] & 0xFFFF

        if self.memtraceon == True and not notrace:
            print ("LOAD  : addr=0x%04X (%6d) data=0x%04X (%6d)"%(a, a, data, data));

        if nostats== False:
            self.read_count += 1

        if 0 <= a <= self.MEMTOP:
            return data
        else:
            raise UserWarning("Memory out of range error for address 0x%04X" % a )

    def memory_write(self, address, data, modify=False, nostats=False, notrace=False):
        a = address & 0xFFFF
        if self.memtraceon == True and notrace==False:
            print ("STORE : addr=0x%04X (%6d) data=0x%04X (%6d)"%(a, a, data, data));

        if nostats == False:
            self.write_count += 1
            if modify:
                self.modify_write_count += 1
        if 0 <= a <= self.MEMTOP:
            self.RAM[a] = (data & 0xFFFF)
            self.RAM_writeset.add(a)
        else:
            raise UserWarning("Memory out of range error for address 0x%04X" % a )

    def single_step(self):
        self.IR.update(self.memory_fetch())
        if ( self.IR.F not in self.opcode_table):
            raise UserWarning("Cannot execute Opcode with function field 0x%X" % self.IR.F )
        else:
            if self.traceon:
                self.print_machine_state()
            self.opcode_table[self.IR.F].execute()

        return
