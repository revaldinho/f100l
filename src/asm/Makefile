# If no env var is set then default to python3
# e.g. use setenv PYEXE pypy3 to get pypy before calling Make
PYEXE ?= python3

.SUFFIXES: .cpp .hex
.cpp.hex:; ../F100Asm.py -f $< -o $@ -g hex |  tee $*.lst

.SUFFIXES: .asm .cpp
.asm.cpp:; cpp -E $< | grep -v '^#'>  $@

.SUFFIXES: .py .inc
.py.inc:; python3 $< | tee $*.golden

.SUFFIXES: .py .golden
.py.golden:; python3 $< | tee $*.golden

.SUFFIXES: .hex .rslt
.hex.rslt:; $(PYEXE) ../F100Emu.py  -f $< -g hex -m $*.dump -p 0x5000 -q 0x6000 >& $*.log ; diff -s $*.dump $*.golden > $@


all: test2.hex mul32.hex mul16.hex sqrt.hex udiv32.hex test2.hex tests

udiv32.hex: udiv32.asm udiv32.inc mathlib.asm
mul16.hex: mul16.asm mul16.inc mathlib.asm
mul32.hex: mul32.asm mul32.inc mathlib.asm
sqrt.hex: sqrt.asm sqrt.inc mathlib.asm
test2.hex: test2.asm

tests: mul16.rslt mul32.rslt sqrt.rslt udiv32.rslt
	cat *rslt



clean:
	rm *hex *lst *~ *cpp *inc *golden *rslt *dump *log
