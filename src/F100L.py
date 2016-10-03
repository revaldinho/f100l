from ConditionReg import ConditionReg
from InstructionReg import InstructionReg

MEM_CYCLES = 2


class F100L:

    def __init__ (self, mem_read, mem_write):
        self.CC = ConditionReg()
        self.IR = InstructionReg()
        self.reset()
        self.mem_read = mem_read
        self.mem_write = mem_write        

    def reset (self):
        self.IR.reset()
        self.CC.reset()
        self.PC = 0
        self.OR = 0
        self.cycles = 0
        self.ACC = 0

    def single_step(self):
        cycle_count = 0
        self.IR.update( self.mem_read(self.PC))
        self.PC += 1
        self.cycles += MEM_CYCLES
        
        if self.IR.I == 1:
            self.OR = self.mem_read(self.PC)
            self.PC += 1
            self.cycles += MEM_CYCLES
            
#        if self.IR.F == SRA:
#            result = (self.ACC >> 1) | (self.ACC & 0x8000)
#            self.CC.update(result)
#            self.ACC = result & 0xFFFF
#        elif self.IR.F == SRL:
#            pass
#        elif self.IR.F == SLA:
#            result = (self.ACC << 1)
#            self.CC.update(result)
#            self.ACC = result & 0xFFFF
#        elif self.IR.F == ADC:
#            self.ACC += self.OR + self.cc.C
#            pass
            
        return self.IR.content

    
    def tostring(self):
        result  = "AC:: " + "0x%04x\n" % self.ACC
        result += "IR:: " + self.IR.tostring() + "\n"
        result += "CC:: " + self.CC.tostring() + "\n"
        result += "PC:: 0x%04x\n" % self.PC
        return result
                                                    
