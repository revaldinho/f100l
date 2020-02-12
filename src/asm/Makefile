# If no env var is set then default to python3
# e.g. use setenv PYEXE pypy3 to get pypy before calling Make
PYEXE ?= python3

ALLSRCS    ?= $(wildcard *.asm)
TESTSRCS   ?= $(shell ls -1 *asm | egrep -v '(mathlib|init)'  )
PDUMP      ?= $(patsubst %.asm,%.pdump,$(TESTSRCS))
CDUMP      ?= $(patsubst %.asm,%.cdump,$(TESTSRCS))
HEX        ?= $(patsubst %.asm,%.hex,$(TESTSRCS))

SRCS=mul32 mul16
VPATH=../../csrc

.SUFFIXES: .cpp .hex
.cpp.hex:; /usr/bin/time ${PYEXE} ../F100Asm.py -f $< -o $@ -g hex > $*.lst

.SUFFIXES: .hex .pdump	
.hex.pdump:; /usr/bin/time ${PYEXE} ../F100Emu.py -f $< -g hex -d $*.pdump -n > $*.plog

.SUFFIXES: .hex .cdump
.hex.cdump:; /usr/bin/time ../../csrc/f100emu -f $< -x -d $*.cdump > $*.clog

.SUFFIXES: .asm .cpp
.asm.cpp:; cpp -E -C $< | grep -v '^#'>  $@

testdata.inc: testgen.py
	${PYEXE} testgen.py

all: all_hex f100emu all_cdump all_pdump

f100emu: f100emu.c f100.c f100.h
	(cd ${VPATH} ; make ) 

all_cdump: all_hex f100emu ${CDUMP}
all_pdump: all_hex ${PDUMP} 
all_hex: testdata.inc init.asm mathlib.asm ${HEX}

clean:
	rm *hex *lst *~ *cpp *inc *golden *rslt *dump *log
