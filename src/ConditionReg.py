class ConditionReg:
    def __init__ (self):
        self.reset()

    def reset (self):
        '''
        Reset the condition register after a general CPU reset. Note that in
        the actual silicon only the I, M and F bits are reset to 0. The other bits are
        left undefined.
        '''
        self.V = 0
        self.Z = 0
        self.S = 0
        self.C = 0
        self.I = 0
        self.M = 0
        self.F = 0

    def fromint(self, val):
        '''
        Unpack an integer value into the individual flag components
        '''
        self.I = (val >> 0) & 0x01
        self.Z = (val >> 1) & 0x01
        self.V = (val >> 2) & 0x01
        self.S = (val >> 3) & 0x01
        self.C = (val >> 4) & 0x01
        self.M = (val >> 5) & 0x01
        self.F = (val >> 6) & 0x01

    def toint(self) :
        result = 0
        for f in [ self.F, self.M, self.C, self.S, self.V, self.Z, self.I ]:
            result = ( result << 1) | (f & 0x01)
        return result

    def tostring(self):
        list = ["CR:  0x%04x   " % self.toint()]
        for m in [attr for attr in dir(self) ]:
            if not callable(getattr(self,m)) and  not m.startswith("__"):
                list.append( "%s=%d, " % (m, getattr(self,m)))
        return ''.join(list)
