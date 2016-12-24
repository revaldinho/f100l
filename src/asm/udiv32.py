#!/usr/bin/env/python3

import random

# test data must be pairs of operands
test_data = []
result_area = 0x5000

random.seed(0x12345)
for i in range(0,200):
    test_data.append(random.randint(0,0x7FFFFFFF))

test_data[0] = 0x009
test_data[1] = 0x001
test_data[2] = 0x004
test_data[3] = 0x002
test_data[4] = 0x001
test_data[5] = 0x004


def print_hex16( addr, data):
    print ("0x%04X : 0x%04X" % (addr, data&0xFFFF))

def print_hex32( addr, data):
    print ("0x%04X : 0x%04X" % (addr, (data>>16)&0xFFFF))
    addr += 1
    print ("0x%04X : 0x%04X" % (addr, (data)&0xFFFF))

def bit(N, n):
    mask = 1 << n
    if N & mask > 0 :
        return 1
    else:
        return 0

def bitset(N, n):
    mask = 1 << n
    return N | mask

def udiv32(N,D):
    if N==0 :
        return(0,0)
    Q = 0
    R = 0
    for i in range (31, -1, -1):
        #print("Q: 0x%08X" % Q)
        #print("R: 0x%08X" % R)
        #print("D: 0x%08X" % D)
        #print("N: 0x%08X" % N)

        Q = ( Q<< 1) & 0xFFFFFFFF
        R = ( R<< 1) & 0xFFFFFFFF
        if bit (N,31) :
            R = bitset(R,0)
        if R >= D:
            R = R - D
            Q = bitset(Q,0)
        N  = ( N<<1) & 0xFFFFFFFF
        #print("Q: 0x%08X" % Q)
        #print("R: 0x%08X" % R)
        #print("D: 0x%08X" % D)
        #print("N: 0x%08X" % N)
    return (Q,R)

# write out data for the assembler test code
with open("udiv32.inc","w") as f:
  f.write("  .word 0x%04X\n" % (len(test_data)>>1) )
  for a in test_data:
    f.write("  .word 0x%04X, 0x%04X\n" % ( (a>>16)& 0xFFFF, a & 0xFFFF))

# compute the golden results

address = result_area

for idx in range(0, len(test_data),2):
    a = test_data[idx]
    b = test_data[idx+1]

    print_hex32(address,a)
    address+=2
    print_hex32(address,b)
    address+=2
    # Test the 32 bit multiply Instruction
    (quotient,remainder) = udiv32(b,a)
    print_hex32(address,remainder)
    address+=2
    print_hex32(address,quotient)
    address+=2
