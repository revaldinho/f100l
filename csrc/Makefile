
default: f100emu

all: f100emu

f100.o : f100.c f100.h
	cc -c f100.c -O2 -o f100.o

f100emu : f100emu.c f100.o
	cc f100emu.c f100.o -o f100emu

clean:
	rm -f f100 *~ f100emu *.o
