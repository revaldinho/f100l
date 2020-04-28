#!/bin/bash

# Create binary files from intel hex
for i in 1 2 3 4 5 6
do
    objcopy --input-target=ihex --output-target=binary rom$i.ihex rom$i.bin
done

# Compile interleae program
gcc interleave.c -o interleave

# Interleave pairs of files
./interleave rom1.bin rom4.bin > pair14.bin
./interleave rom2.bin rom5.bin > pair25.bin
./interleave rom3.bin rom6.bin > pair36.bin

# Concatenate into a single binary
cat pair36.bin pair25.bin pair14.bin > cch_board.bin

# Disassemble using the disassembler from PiTubeDirect built using:
#    cd PiTubeDirect/src/f100
#    gcc -DSTANDALONE f100_debug.c -o f100dis
#
# The original ROMs are driven by an inverted address bus, so
# the -x 7ff option undoes this by inversion A10..A0
f100dis -a 800 -x 7ff -d data.map cch_board.bin > cch_board.asm

# Delete working files
rm -f rom[1-6].bin
rm -f pair14.bin
rm -f pair25.bin
rm -f pair36.bin
rm -f interleave
