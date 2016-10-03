def word_to_ascii_pair(word):
    hi_byte = (word>>8) & 0xFF
    lo_byte = word & 0xFF

    hi_char = chr(hi_byte) if (31<hi_byte<128) else '.'
    lo_char = chr(lo_byte) if (31<lo_byte<128) else '.'
    return hi_char + lo_char

class Memory:

    def __init__ (self, size, wordwidth ):
        self.data = [ord('.')] * size
        self.datamask = (2**wordwidth -1)

    def tostring(self):
        lines = []
        ascii = []
        hexes = []
        i = 0
        for d in self.data:
            hexes.append("%04x" % d)
            ascii.append(word_to_ascii_pair(d))
            i += 1
            if i % 16 == 0:
                lines.append( ("0x%04x: " % (i-16)) + ' '.join(hexes) + "  " + ''.join(ascii) )
                hexes = []
                ascii = []
        if i % 16 != 0:
            lines.append( ("0x%04x: " % (i- (i%16))) + ' '.join(hexes) + "  "+ ''.join(ascii) )
        return '\n'.join(lines)

        def poke(self, addr, dataword ) :
            self.data[addr] = dataword & self.datamask

        def peek(self, addr ) :
            return self.data[addr]

if __name__ == "__main__" :
    m = Memory(256, 16)
    print m.tostring()
