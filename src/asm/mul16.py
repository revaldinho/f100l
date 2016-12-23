#!/usr/bin/env/python3

import random

# test data must be pairs of operands
test_data = []
result_area = 0x5000

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
    print_hex16(address,a)
    address+=1
    print_hex16(address,b)
    address+=1
    result = (a * b )
    print_hex16(address,(result>>16) & 0xFFFF)
    address+=1
    print_hex16(address,result)
    address+=1
