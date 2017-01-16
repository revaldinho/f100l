VPATH=.:../asm

.SUFFIXES: .hex .crslt
.hex.crslt:; ./F100Emu -n -f $< -m $*.dump -p 0x5000 -q 0x6000 >& $*.log ; diff -s $*.dump ../asm/$*.golden > $@

.SUFFIXES: .cpp .o
.c.o:; g++ -O $< -o $@

F100Emu: F100CPU.cpp F100Emu.cpp CC_class.cpp IR_class.cpp \
	F100CPU.h CC_class.h IR_class.h
	g++ -O F100Emu.cpp F100CPU.cpp CC_class.cpp IR_class.cpp -o F100Emu

all : F100Emu tests

crslt: F100Emu mul16.hex mul32.hex sqrt.hex udiv32.hex test2.crslt

tests: mul16.crslt mul32.crslt sqrt.crslt udiv32.crslt test2.crslt
	cat *crslt

clean:
	rm -rf F100Emu
	rm -rf *crslt
	rm -rf *dump
	rm -rf *.o
