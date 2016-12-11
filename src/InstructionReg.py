'''

Instruction Encoding
--------------------

All instruction encodings are defined as overlapping but mutually exclusive bit fields.

The bit fields are defined as follows

  +------+---------------+---------------+----------------------------------------------------------------+
  |Field |Number of bits | Bit positions | Comment                                                        |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  F   |      4        |  15..12       | Instruction class or function                                  |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  I   |      1        |      11       | Address Mode                                                   |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  T   |      2        |   11,10       | General field to qualify F=0 instructions                      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  R   |      2        |     9,8       | Register field or auto-index mode for indirect addressing      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  S   |      2        |     7,6       | General field to qualify F=0 instructions                      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  J   |      2        |     5,4       | General field to qualify F=0 instructions                      |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  N   |     11        |   10..0       | Memory address for direct addressing                           |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  P   |      8        |    7..0       | Memory address used as pointer for pointer indirect addressing |
  +------+---------------+---------------+----------------------------------------------------------------+
  |  B   |      4        |    3..0       | Shift number or bit significance                               |
  +------+---------------+---------------+----------------------------------------------------------------+

Where a don't care (x) bit is presented in the tables, the assembler will consistently use a '0'. The
emulator will ignore this field during decoding.
'''

import re

class InstructionReg:
    def __init__ (self ):
        self.update(0)

    def reset(self):
        self.update(0)

    def update(self, new_value):
        self.content = new_value
        self.name = ""
        self.F = (self.content>>12)& 0x000F
        self.I = (self.content>>11)& 0x0001
        self.T = (self.content>>10)& 0x0003
        self.R = (self.content>> 8)& 0x0003
        self.S = (self.content>> 6)& 0x0003
        self.J = (self.content>> 4)& 0x0003
        self.B = self.content      & 0x000F
        self.P = self.content      & 0x00FF
        self.N = self.content      & 0x07FF

    def tostring(self):
        list = [ "IR:  0x%04X   " % self.content]
        for m in [attr for attr in dir(self) ]:
            if not callable(getattr(self,m)) and  re.match("[A-Z]", m) :
                list.append( "%s=0x%04X, " % (m, getattr(self,m)))
        return ''.join(list)


if __name__ == "__main__" :
    IR = InstructionReg()
    print(IR.tostring())
    IR.update(0x4901)
    print(IR.tostring())
    IR.update(0x5538)
    print(IR.tostring())
