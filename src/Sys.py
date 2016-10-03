from F100L import F100L
from Memory import Memory


def mem_read(addr):
    if addr >= 2048:
        return ROM.data[addr-2048]
    elif addr < 2048:
        return RAM.data[addr]
    else:
        return None

def mem_write(addr, data):
    if addr > 1024:
        RAM.data[addr-1024] = data & 0xFFFF


ROM = Memory(2048,16)
RAM = Memory(2048,16)

cpu = F100L(mem_read, mem_write)

print cpu.tostring()
for i in range(0,10):
    cpu.single_step()
    print cpu.tostring()
