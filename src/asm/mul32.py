#!/usr/bin/env/python3

import random

# test data must be pairs of operands
test_data = []
result_area = 0x5000

random.seed(0x12345)
for i in range(0,200):
    test_data.append(random.randint(0,0x7FFFFFFF))


def print_hex32( addr, data):
    print ("0x%04X : 0x%04X" % (addr, (data>>16)&0xFFFF))
    addr += 1
    print ("0x%04X : 0x%04X" % (addr, (data)&0xFFFF))


# write out data for the assembler test code
with open("mul32.inc","w") as f:
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
    result = (a * b )
    print_hex32(address,(result>>32) & 0xFFFFFFFF)
    address+=2
    print_hex32(address,result)
    address+=2
