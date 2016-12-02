'''
OpcodeF0
========

This class is used only for the Emulator. The main switchboard selects
between different instruction classes but class F=0 has several different
sub-classes. All calls for F=0 are sent here and then this class sorts out
the final destination based on additional fields in the opcode word.

'''
from .F100_Opcode import *
from .OpcodeF0_Bit import *
from .OpcodeF0_Halt import *
from .OpcodeF0_Jump import *
from .OpcodeF0_Shift import *


class OpcodeF0(F100_Opcode) :
    def __init__ (self, CPU=None):

        self.obit = OpcodeF0_Bit(CPU=CPU)
        self.ohalt = OpcodeF0_Halt(CPU=CPU)
        self.ojump = OpcodeF0_Jump(CPU=CPU)
        self.oshift = OpcodeF0_Shift(CPU=CPU)

        self.opcode_fn = self.obit.opcode_fn
        self.opcode_fn.update(self.ohalt.opcode_fn)
        self.opcode_fn.update(self.ojump.opcode_fn)
        self.opcode_fn.update(self.oshift.opcode_fn)

        super().__init__(self.opcode_fn, CPU=CPU )
        self.F = 0

    def disassemble(self):
        IR = self.CPU.IR
        if IR.T == 1:
            opcode_fn = self.ohalt.opcode_fn
        elif IR.S == 2:
            opcode_fn = self.ojump.opcode_fn
        elif IR.S == 3:
            opcode_fn = self.obit.opcode_fn
        else:
            opcode_fn = self.oshift.opcode_fn
        return ', '.join(list(opcode_fn.keys()))

    def exec(self):
        # No real function here, just need to determine where to send the exec task
        IR = self.CPU.IR
        if IR.T == 1:
            execfn = self.ohalt.exec
        elif IR.S == 2:
            execfn = self.ojump.exec
        elif IR.S == 3:
            execfn = self.obit.exec
        else:
            execfn = self.oshift.exec
        return execfn()
