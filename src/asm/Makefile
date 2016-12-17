

.SUFFIXES: .cpp .hex
.cpp.hex:; ../F100Asm.py -f $< -o $@ -g hex | tee $*.lst

.SUFFIXES: .asm .cpp
.asm.cpp:; cpp -E $< | grep -v '^#'>  $@

.SUFFIXES: .py .inc
.py.inc:; python3 $< | tee $*.golden

.SUFFIXES: .hex .rslt
.hex.rslt:; ../F100Emu.py -f $< -g hex -m $*.dump -p 0x5000 -q 0x6000 -n | tee $*.log ; diff -s $*.dump $*.golden > $@


all: test2.hex mul32.hex sqrt.hex tests

mul32.hex: mul32.asm mul32.inc
sqrt.hex: sqrt.asm sqrt.inc

tests: mul32.rslt sqrt.rslt
	cat *rslt



clean:
	rm *hex *lst *~ *cpp *inc *golden *rslt *dump
