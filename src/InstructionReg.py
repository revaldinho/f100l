class InstructionReg:

    def __init__ (self ):
        self.update(0)

    def reset(self):
        self.update(0)
        
    def update(self, new_value):
        self.content = new_value
        self.F = (self.content & 0xF000) >> 12
        self.I = (self.content & 0x0800) >> 11
        self.T = (self.content & 0x0C00) >> 10
        self.R = (self.content & 0x0300) >>  8
        self.S = (self.content & 0x00C0) >>  6
        self.J = (self.content & 0x0030) >>  4
        self.B = (self.content & 0x000F)
        self.P = (self.content & 0x00FF)
        self.N = (self.content & 0x07FF)
        
    def tostring(self):
        list = []
        for m in [attr for attr in dir(self) ]:
            if not callable(getattr(self,m)) and  not m.startswith("__") :
                list.append( "%s= 0x%04x, " % (m, getattr(self,m)))
        return ''.join(list)
              
                    
if __name__ == "__main__" :
    IR = InstructionReg()
    print IR.tostring()
    IR.update(0x4901)
    print IR.tostring()
    IR.update(0x5538)
    print IR.tostring()        
