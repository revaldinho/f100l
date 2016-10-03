
I_FIELD = 0
Z_FIELD = 1
V_FIELD = 2
S_FIELD = 3
C_FIELD = 4
M_FIELD = 5
F_FIELD = 6

class ConditionReg:
    
    def __init__ (self):
        self.reset()
        
    def reset (self):
        self.V = 0
        self.Z = 0
        self.S = 0
        self.C = 0
        self.I = 0
        self.M = 0
        self.F = 0
        
    def update ( self, result, operands = [], field_list = [Z_FIELD,V_FIELD,S_FIELD,C_FIELD,M_FIELD,F_FIELD,I_FIELD] ) :

        ## Always take a 32bit result so we can see the 'carry' bit, but then truncate to 16bit
        ## for the other flag calculations
        result16 = result & 0xFFFF
        
        for f in field_list:
            if f == Z_FIELD:
                self.Z = 1 if result16 == 0x00 else 0
            elif f == S_FIELD:
                self.S = 1 if ( result16 & 0x8000 ) else 0
            elif f == V_FIELD:
                if operands != []:
                    result_sign = 1 if ( result16 & 0x8000 == 0x8000 ) else 0
                    operand_sign = [ 1 if op & 0x8000 else 0 for op in operands ]
                    self.V = 1 if (operand_sign[0]==operand_sign[1] and result_sign!=operand_sign[0] ) else 0
            elif f == C_FIELD:
                self.C = 1 if (result & 0x00010000 == 0x00010000) else 0

    def toint( self ) :
        result = 0
        for f in [ self.F, self.M, self.C, self.S, self.V, self.Z, self.I ]:
            result = ( result << 1) | (f & 0x01)
        return result
        
    def tostring(self):
        list = ["0x%04x " % self.toint()]
        for m in [attr for attr in dir(self) ]:
            if not callable(getattr(self,m)) and  not m.startswith("__") and not m.endswith("FIELD"):
                list.append( "%s=%2d, " % (m, getattr(self,m)))
        return ''.join(list)
                                                        
