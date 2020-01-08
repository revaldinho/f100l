#!/usr/bin/env/python3

import random

# test data must be pairs of operands
test_data = []
result_area = 0x5000
memory = [0]*0x10000


def INTTOPRINT(c):
    if (c>31 and c<128):
        return c
    else:
        return '.'

def hex16dump( data, dlen, filename=None):
    GRPSZ = 16
    astr = list()
    dstr = list()

    max = dlen + ((dlen + GRPSZ - dlen%GRPSZ) if (dlen%GRPSZ>0) else 0)
    if ( filename != None ) :
        f = open(filename,"w")
    else:
        f =sys.stdout
    for i in range (0, max):
        j=i%GRPSZ;
        dstr.append("%04X" % data[i] ) 
        astr.append("%c%c" % (INTTOPRINT((data[i]>>8)&0xFF),INTTOPRINT(data[i]&0xFF)))
        if (j==GRPSZ-1) :
            f.write( "%04X: %s %s%c" % ( i-j, ' '.join(dstr), ''.join(astr), '\n' if (i>0) else '\0'))
            astr = list()
            dstr = list()            



random.seed(0x12345)
for i in range(0,200):
    test_data.append(random.randint(0,0x00007FFF))


def print_hex16( addr, data):
    print ("0x%04X : 0x%04X" % (addr, data&0xFFFF))


# write out data for the assembler test code
with open("mul16.inc","w") as f:
  f.write("  .word 0x%04X\n" % (len(test_data)>>1) )
  for a in test_data:
    f.write("  .word 0x%04X\n" % ( a & 0xFFFF))

# compute the golden results

address = result_area

for idx in range(0, len(test_data),2):
    a = test_data[idx]
    b = test_data[idx+1]
    memory[address]=a & 0xFFFF
    address+=1
    memory[address]=b & 0xFFFF
    address+=1
    result = (a * b )
    memory[address]=(result>>16) & 0xFFFF
    address+=1
    memory[address]=result & 0xFFFF
    address+=1

hex16dump(memory,32768,"mul16.hexl")    
