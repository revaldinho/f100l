VPATH=.:../asm

.SUFFIXES: .hex .crslt
.hex.crslt:; ./F100Emu -f $< -m $*.dump -p 0x5000 -q 0x6000 >& $*.log ; diff -s $*.dump ../asm/$*.golden > $@

F100Emu: F100CPU.cpp F100Emu.cpp
	g++ -O F100Emu.cpp -o F100Emu

all : F100Emu tests

crslt: mul16.hex mul32.hex sqrt.hex udiv32.hex

tests: mul16.crslt mul32.crslt sqrt.crslt udiv32.crslt
	cat *crslt

clean:
		rm -rf F100Emu
