#!/usr/bin/env python
## ============================================================================
## F100Emu.py - Emulator for the Ferranti F100-L CPU
##
## COPYRIGHT 2016 Richard Evans, Ed Spittles
##
## This file is part of f100l - an set of utilities for programming and
## emulation of the Ferranti F100-L CPU and peripheral components.
##
## f100l is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## f100l is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##
## See  <http://www.gnu.org/licenses/> for a copy of the GNU Lesser General
## Public License
##
## ============================================================================
'''
USAGE:

  F100Emu is a very simple emulator for the Ferranti F100-L CPU.

REQUIRED SWITCHES ::

  -f --filename  <filename>      specify the assembled object file

  -g --format    <bin|ihex|hex>  set the file format for the assembled code


OPTIONAL SWITCHES ::

  -a --adsel      <0|1>          specify the state of the AdSel pin
                                 - defaults to 1 if not specified

  -e --endianness <little|big>   set endianness of byte oriented input file
                                 - default is little-endian

  -n --nolisting                 suppress the listing to stdout while the
                                 program runs

  -t --traceon                   print all memory transactions to stdout

  -h --help                      print this help message

EXAMPLES ::

  python3.5 F100Emu.py -f test.hex -g hex

'''

banner =\
'''
# -------------------------------------------------------------------------------------------
#    _____________  ____        __       ______                __      __
#   / ____<  / __ \/ __ \      / /      / ____/___ ___  __  __/ /___ _/ /_____  _____
#  / /_   / / / / / / / /_____/ /      / __/ / __ `__ \/ / / / / __ `/ __/ __ \/ ___/
# / __/  / / /_/ / /_/ /_____/ /___   / /___/ / / / / / /_/ / / /_/ / /_/ /_/ / /
#/_/    /_/\____/\____/     /_____/  /_____/_/ /_/ /_/\__,_/_/\__,_/\__/\____/_/
#
#
# F 1 0 0 - L * E M U L A T O R (c) 2016 Revaldinho & BigEd
# -------------------------------------------------------------------------------------------'''

from F100_Opcodes.F100_Opcode import F100HaltException
from F100CPU import F100CPU
from hex2bin import Hex2Bin
import getopt
import time
import sys

def usage():
    print( __doc__ )
    sys.exit(0)

def print_header():
    print(banner)
    print("#                                   Condition Reg.")
    print("# PC   : Memory         : Acc. OR.  F M C S V Z I  : Instruction ")
    print("# -------------------------------------------------------------------------------------------")

class F100Emu:
    def __init__ (self, ramsize=32768, adsel=1, traceon=False):
        self.CPU = F100CPU(adsel=adsel, memory_read=self.memory_read, memory_write=self.memory_write)
        self.RAM = [0xDEAD]*ramsize
        self.MEMTOP = ramsize-1
        self.traceon = traceon
        self.read_count = 0
        self.write_count = 0
        self.instr_count = 0

    def load_memory(self, filename, file_format):
        # Initialise the hex2bin object with a 64Kbyte address space
        h = Hex2Bin(0x10000)
        h.read_file(filename, file_format, 0, 0x10000)
        # Now convert into the local RAM
        for i in range(0, 64*1024,2):
            local_addr = i >> 1
            if endianness == "little":
                (byte_lo,valid) = h.read_byte(i)
                i+=1
                (byte_hi,valid) = h.read_byte(i)
                i+=1
            else:
                (byte_hi,valid) = h.read_byte(i)
                i+=1
                (byte_lo,valid) = h.read_byte(i)
                i+=1
            self.RAM[local_addr] = ((byte_hi << 8) | byte_lo ) & 0xFFFF


    def memory_read(self, address):
        if self.traceon == True:
            print ("READ 0x%04X 0x%04X" % ( address & 0xFFFF, self.RAM[address] & 0xFFFF))

        self.read_count += 1
        if 0 <= address <= self.MEMTOP:
            return self.RAM[address]
        else:
            raise UserWarning("Memory out of range error for address 0x%04X" % address )

    def memory_write(self, address, data):
        if self.traceon == True:
            print ("STORE 0x%04X 0x%04X" % ( address & 0xFFFF, data & 0xFFFF))
        self.write_count += 1

        if 0 <= address <= self.MEMTOP:
            self.RAM[address] = (data & 0xFFFF)
        else:
            raise UserWarning("Memory out of range error for address 0x%04X" % address )

    def print_machine_state(self):
        CPU = self.CPU
        PC = CPU.PC
        CR = CPU.CR
        IR = CPU.IR
        IR.update(self.RAM[PC])
        if ( IR.F not in CPU.opcode_table):
            raise UserWarning("Cannot execute Opcode with function field 0x%X" % IR.F )
        else:
            IR.name = CPU.opcode_table[IR.F].disassemble()

        print("  %04X : %04X %04X %04X : %04X %04X %d %d %d %d %d %d %d  : %s" % \
        (PC & 0xFFFF,self.RAM[PC] & 0xFFFF ,self.RAM[PC+1] & 0xFFFF, self.RAM[PC+2] & 0xFFFF,\
         CPU.ACC & 0xFFFF ,CPU.OR & 0xFFFF ,CR.F,CR.M,CR.C,CR.S,CR.V,CR.Z,CR.I, IR.name ))


if __name__ == "__main__" :
    filename = ""
    file_format = ""
    adsel = 1
    endianness = "little"
    traceon = False
    listingon = True
    try:
        opts, args = getopt.getopt( sys.argv[1:], "a:e:f:g:hnt", ["adsel=","endianness=", "filename=","format=","help","nolisting","traceon"])
    except getopt.GetoptError as  err:
        print(err)
        usage()

    for opt, arg in opts:
        if opt in ( "-f", "--filename" ) :
            filename = arg
        if opt in ( "-a", "--adsel" ) :
            adsel = int(arg)
        if opt in ( "-e", "--endianness" ) :
            endianness = arg
        if opt in ( "-g", "--format" ) :
            if (arg in ("hex", "bin", "ihex")):
                file_format = arg
            else:
                usage()
        if opt in ("-n", "--nolisting") :
            listingon = False
        if opt in ("-t", "--traceon") :
            traceon = True
        elif opt in ("-h", "--help" ) :
            usage()
    if filename=="" or file_format=="":
        usage()

    emu = F100Emu(adsel=adsel, traceon=traceon)
    emu.load_memory(filename, file_format)
    emu.CPU.reset()

    print_header()
    st = time.time()
    while True:
        if listingon:
            emu.print_machine_state()
        try:
            emu.CPU.single_step()
        except F100HaltException as e:
            print(e)
            break
        emu.instr_count += 1
    et = time.time()

    print("# -------------------------------------------------------------------------------------------")
    print("# Program execution Statistics")
    print("# -------------------------------------------------------------------------------------------")
    print("#          Instruction count: %7d" % emu.instr_count)
#    print("#          Logic cycle count: %7d" % emu.cycle_count)
    print("#      Total Memory accesses: %7d" % (emu.read_count + emu.write_count) )
    print("#               memory reads: %7d" % emu.read_count )
    print("#              memory writes: %7d" % emu.write_count )
    print("# -------------------------------------------------------------------------------------------")
    print("# Emulator Performance Statistics")
    print("# -------------------------------------------------------------------------------------------")
    print("# Run time                  : %10.2f s" % (et - st))
    print("# Instructions per second   : %10.2f MIPS" % (emu.instr_count/(1000000 * (et-st))))
    print("# -------------------------------------------------------------------------------------------")
