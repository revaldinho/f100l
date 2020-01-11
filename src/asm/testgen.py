#!/usr/bin/env/python3

import random, math


test_data = []
result_area = 0x5000
memory = [0]*0x10000


def INTTOPRINT(c):
    if (c>31 and c<128):
        return c
    else:
        return '.'

def hex16dump( data, start, end, filename=None):
    GRPSZ = 16
    astr = list()
    dstr = list()

    start = start & ~( GRPSZ-1)

    end = (end + GRPSZ - (end%GRPSZ)) if (end%GRPSZ>0) else end

    if ( filename != None ) :
        f = open(filename,"w")
    else:
        f =sys.stdout
    for i in range (start, end):
        j=i%GRPSZ;
        dstr.append("%04X" % data[i] ) 
        astr.append("%c%c" % (INTTOPRINT((data[i]>>8)&0xFF),INTTOPRINT(data[i]&0xFF)))
        if (j==GRPSZ-1) :
            f.write( "%04X: %s %s%c" % ( i-j, ' '.join(dstr), ''.join(astr), '\n' if (i>0) else '\0'))
            astr = list()
            dstr = list()            

    
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

def gen_sqrt_ref() :    
    # compute the golden results
    memory = [0]*0x10000    
    address = result_area
    for a in test_data:
        chk_quo = int(math.sqrt(a))
        chk_rem = a - chk_quo * chk_quo
        memory[address] = (a>>16)&0xFFFF
        address += 1
        memory[address] = (a)&0xFFFF     
        address+=1
        (result,rem) = sqrt32(a)
        memory[address] = (result>>16)&0xFFFF
        address += 1
        memory[address] = (result)&0xFFFF
        address += 1    
        memory[address] = (rem>>16)&0xFFFF
        address += 1
        memory[address] = (rem)&0xFFFF
        address += 1
        
    hex16dump(memory, 0x0000, 0x7FFF, "sqrt.golden")    
    
def gen_mul16_ref() :
    memory = [0]*0x10000    
    address = result_area
    for idx in range(0, len(test_data)):
        a = (test_data[idx]>>16) & 0xFFFF
        b = (test_data[idx]) & 0xFFFF
        memory[address] = a
        address+=1
        memory[address] = b
        address+=1
        result = (a * b )
        memory[address]=(result>>16) & 0xFFFF
        address+=1
        memory[address]=result & 0xFFFF
        address+=1
    
    hex16dump(memory, 0x0000, 0x7FFF, "mul16.golden")        


def gen_mul32_ref() :
    memory = [0]*0x10000    
    address = result_area    
    for idx in range(0, len(test_data),2):
        a = test_data[idx]
        b = test_data[idx+1]
        memory[address] = (a>>16)&0xFFFF
        address += 1
        memory[address] = (a)&0xFFFF     
        address+=1
        memory[address] = (b>>16)&0xFFFF
        address += 1
        memory[address] = (b)&0xFFFF     
        address+=1
        # Test the 32 bit multiply Instruction
        result = (a * b )
        memory[address] = (result>>48)&0xFFFF
        address += 1
        memory[address] = (result>>32)&0xFFFF
        address += 1    
        memory[address] = (result>>16)&0xFFFF
        address += 1
        memory[address] = (result)&0xFFFF
        address += 1    

    hex16dump(memory, 0x0000, 0x7FFF, "mul32.golden")        

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

def gen_udiv32_ref() :
    memory = [0]*0x10000    
    address = result_area    
    for idx in range(0, len(test_data),2):
        a = test_data[idx]
        b = test_data[idx+1]
        memory[address] = (a>>16)&0xFFFF
        address += 1
        memory[address] = (a)&0xFFFF     
        address+=1
        memory[address] = (b>>16)&0xFFFF
        address += 1
        memory[address] = (b)&0xFFFF     
        address+=1
        (quotient,remainder) = udiv32(b,a)
        memory[address] = (remainder>>16)&0xFFFF
        address += 1
        memory[address] = (remainder)&0xFFFF
        address += 1    
        memory[address] = (quotient>>16)&0xFFFF
        address += 1
        memory[address] = (quotient)&0xFFFF
        address += 1    

    hex16dump(memory, 0x0000, 0x7FFF, "udiv32.golden")        

        
random.seed(0x12345)
for i in range(0,512):
    a = random.randint(0,0x3FFFFFFF)
    test_data.append(a)

# write out data for the assembler test code
with open("testdata.inc","w") as f:
    f.write("  .word 0x%04X\n" % len(test_data))
    for a in test_data:
        f.write("  .word 0x%04X, 0x%04X\n" % ( (a>>16)& 0xFFFF, a & 0xFFFF))

gen_sqrt_ref()
gen_mul16_ref()
gen_mul32_ref()
gen_udiv32_ref()


