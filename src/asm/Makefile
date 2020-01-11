# If no env var is set then default to python3
# e.g. use setenv PYEXE pypy3 to get pypy before calling Make
PYEXE ?= python3


.SUFFIXES: .cpp .hex
.cpp.hex:; ../F100Asm.py -f $< -o $@ -g hex |  tee $*.lst

.SUFFIXES: .hex .dump
.hex.dump:; ../F100Emu.py -f $< -g hex -d $*.dump |  tee $*.log

.SUFFIXES: .asm .cpp
.asm.cpp:; cpp -E $< | grep -v '^#'>  $@

testdata.inc: testgen.py
	${PYEXE} testgen.py

all: test2.hex mul32.hex mul16.hex sqrt.hex udiv32.hex test2.hex mul16.dump mul32.dump sqrt.dump udiv32.dump

udiv32.hex: udiv32.asm testdata.inc mathlib.asm
mul16.hex: mul16.asm   testdata.inc mathlib.asm
mul32.hex: mul32.asm   testdata.inc mathlib.asm
sqrt.hex: sqrt.asm     testdata.inc mathlib.asm
test2.hex: test2.asm

golden: sqrt.py
	pypy3 sqrt.py 

clean:
	rm *hex *lst *~ *cpp *inc *golden *rslt *dump *log
