from F100_Opcodes.F100_Opcode import F100HaltException
from F100CPU import F100CPU


def print_header():
    print("                                  Condition Reg.")
    print("PC   : Memory         : Acc. OR.  I Z V S C M F  : Instruction ")
    print("-------------------------------------------------------------------")



class F100L_System:
    def __init__ (self, ramsize=32768):
        self.CPU = F100CPU(1, self.memory_read, self.memory_write)
        self.RAM = [0xDEAD]*ramsize
        self.MEMTOP = ramsize-1

    def memory_read(self, address):
        if 0 <= address <= self.MEMTOP:
            return self.RAM[address]
        else:
            raise UserWarning("Memory out of range error for address 0x%04X" % address )

    def memory_write(self, address, data):
        if 0 <= address <= self.MEMTOP:
            self.RAM[address] = data & 0xFFFF
        else:
            raise UserWarning("Memory out of range error for address 0x%04X" % address )

    def single_step(self):
        return self.CPU.single_step()

    def print_machine_state(self):
        CPU = self.CPU
        PC = self.CPU.PC
        CR = self.CPU.CR
        print("%04X : %04X %04X %04X : %04X %04X %d %d %d %d %d %d %d  :" % \
        (PC,self.RAM[PC],self.RAM[PC+1], self.RAM[PC+2],CPU.ACC,CPU.OR,CR.I,CR.Z,CPU.CR.V,CR.S,CR.C,CR.M,CR.F ))


if __name__ == "__main__" :
    emu = F100L_System()

    ## Poke sequence into RAM
    ##while emu.single_step() != None:

    emu.RAM[0] = 0x0101

    a = 2048
    for w in [
            0xC000,0x0000,#   AND ,0	 ; zero accumulator
            0xD000,0xFFFF,#   NEQ ,0xFFFF ; invert it
            0xD000,0xFF00,#   NEQ ,0xFF00 ; reset top bits
            0xF000,       #   JMP ,0x1234 ; aka a NOP
            0xB000,0x8000,#   CMP ,0x8000 ; compare with 0x8000
            0x0523,       #   HALT ,0x123
            0xF800,0x0800,#   JMP ,0x0800 ; loop back to start
            ]:
        emu.RAM[a] = w
        a += 1

    emu.CPU.reset()

    # simple dummy loop - don't execute uninitialised RAM yet...
    i = 0
    print_header()
    while emu.memory_read(emu.CPU.PC) != 0xDEAD:
        emu.print_machine_state()
        try:
            emu.CPU.single_step()
        except F100HaltException as e:
            print(e)
            break
        i += 1
        if i> 100:
            break
