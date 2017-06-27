#!/usr/bin/env/python3

import random, math

test_data = []
result_area = 0x5000

random.seed(0x12345)
for i in range(0,100):
    test_data.append(random.randint(0,0x3FFFFFFF))

def sqrt32 (a):
    root  = 0
    rem   = a
    if a >0:
        count = 16
        while count != 0:
            subtrahend = root * 2 ** (count * 2 ) + 1 * 2 **((count-1) * 2)
            root = root << 1
            if rem >= subtrahend:
                rem = rem - subtrahend
                root += 1
            count -= 1

    return ( root, rem )

def isqrt( num) :
    res = 0
    bit = 1 << 14; ## The second-to-top bit is set: 1 << 30 for 32 bits
    ## "bit" starts at the highest power of four <= the argument.
    while (bit > num):
        bit >>= 2
    while (bit != 0):
        if (num >= res + bit) :
            num -= res + bit
            res = (res >> 1) + bit
        else :
            res >>= 1
        bit >>= 2
    return (res, num)



def print_hex32( addr, data):
    print ("0x%04X : 0x%04X" % (addr, (data>>16)&0xFFFF))
    addr += 1
    print ("0x%04X : 0x%04X" % (addr, (data)&0xFFFF))

# write out data for the assembler test code
with open("sqrt.inc","w") as f:
  f.write("  .word 0x%04X\n" % len(test_data))
  for a in test_data:
    f.write("  .word 0x%04X, 0x%04X\n" % ( (a>>16)& 0xFFFF, a & 0xFFFF))

# compute the golden results

address = result_area

for a in test_data:

    chk_quo = int(math.sqrt(a))
    chk_rem = a - chk_quo * chk_quo
    print_hex32(address,a)
    address+=2
#    (result,rem) = isqrt(a)
    (result,rem) = sqrt32(a)
    print_hex32(address,result & 0xFFFFFFFF)
    address+=2
    print_hex32(address,rem & 0xFFFFFFFF)
    address+=2
#    if chk_quo != result or chk_rem != rem:
#        print( "FAIL: %08x" % int(math.sqrt(a)))
#    else:
#        print("PASS")
