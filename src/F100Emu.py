#!/usr/bin/env python3
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

  -m  --memorydump <filename>    dump memory to file at end of run.

                                 Memory dump will by default write address and data for all
                                 memory locations written during program execution. Use the
                                 -p/-q switches to override this and instead dump a fixed
                                 block if required.


  -p  --memorystart <int>        start of memory dump range

  -q  --memoryend   <int>        end of memory dump range

  -s  --statistics               print extended statistics summary at end of run

  -h --help                      print this help message

EXAMPLES ::

  python3.5 F100Emu.py -f test.hex -g hex

'''

banner =\
'''# ---------------------------------------------------------------------------
# F 1 0 0 - L * E M U L A T O R (c) 2016, 2017, 2019 Revaldinho & BigEd
# ---------------------------------------------------------------------------'''

from F100_Opcodes.F100_Opcode import F100HaltException
from F100CPU import F100CPU
from hex2bin import Hex2Bin
import getopt
import time
import sys
import os.path

def usage():
    print( __doc__ )
    sys.exit(0)

def print_header():
    print(banner)
    print("# PC  :   OP :  ACC   OR : FMCSVZI :  LSP (LSP-2)(LSP-1)(LSP-0): Instruction")
    print("# ---------------------------------------------------------------------------")

def INTTOPRINT(c):
    if (c>31 and c<128):
        return c
    else:
        return '.'

def hex16dump( data, dlen, filename=None):
    GRPSZ = 16
    astr = list()
    dstr = list()

    max = dlen + ((dlen + GRPSZ - dlen%GRPSZ) if (dlen%GRPSZ>0) else 0)
    if ( filename != None ) :
        f = open(filename,"w")
    else:
        f =sys.stdout
    for i in range (0, max):
        j=i%GRPSZ;
        dstr.append("%04X" % data[i] )
        astr.append("%c%c" % (INTTOPRINT((data[i]>>8)&0xFF),INTTOPRINT(data[i]&0xFF)))
        if (j==GRPSZ-1) :
            f.write( "%04X: %s %s%c" % ( i-j, ' '.join(dstr), ''.join(astr), '\n' if (i>0) else '\0'))
            astr = list()
            dstr = list()

class F100Emu:
    def __init__ (self, adsel=1, traceon=False, memtraceon=False):
        self.CPU = F100CPU(adsel=adsel, traceon=traceon, memtraceon=memtraceon)
        self.traceon = traceon
        self.memtraceon = memtraceon
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
            self.CPU.memory_write(local_addr, ((byte_hi << 8) | byte_lo ) & 0xFFFF, nostats=True, notrace=True )



if __name__ == "__main__" :
    filename = ""
    file_format = ""
    adsel = 1
    endianness = "little"
    memtraceon = False
    traceon = False
    listingon = True
    memdumpon = False
    memdump_filename = ""
    memdump_lo = None
    memdump_hi = None
    statson = False
    try:
        opts, args = getopt.getopt( sys.argv[1:], "a:e:f:g:d:p:q:hmnst", ["adsel=","endianness=", \
                "filename=","format=","memorydump=","memorystart=", "memoryend=","help",\
                "memtraceon","nolisting","statistics","traceon"])
    except getopt.GetoptError as  err:
        print(err)
        usage()

    for opt, arg in opts:
        if opt in ( "-f", "--filename" ) :
            filename = arg
        if opt in ( "-d", "--memorydump" ) :
            memdump_filename = arg
            memdumpon = True
        if opt in ( "-a", "--adsel" ) :
            adsel = int(arg,0)
        if opt in ( "-p", "--memorystart" ) :
            memdump_lo = int(arg,0)
        if opt in ( "-q", "--memoryend" ) :
            memdump_hi = int(arg,0)
        if opt in ( "-e", "--endianness" ) :
            endianness = arg
        if opt in ( "-g", "--format" ) :
            if (arg in ("hex", "bin", "ihex")):
                file_format = arg
            else:
                usage()
        if opt in ("-n", "--nolisting") :
            listingon = False
        if opt in ("-s", "--statistics") :
            statson = True
        if opt in ("-t", "--traceon") :
            traceon = True
        if opt in ("-m", "--memtraceon") :
            memtraceon = True
        elif opt in ("-h", "--help" ) :
            usage()
    if filename=="" or file_format=="":
        usage()
    elif not os.path.exists(filename):
        print ("Cannot open file %s" % filename)
        sys.exit(0)

    emu = F100Emu(adsel=adsel, traceon=traceon, memtraceon=memtraceon)
    emu.load_memory(filename, file_format)
    emu.CPU.reset()

    print_header()
    st = time.time()
    while True:
        emu.instr_count += 1
        try:
            emu.CPU.single_step()
        except F100HaltException as e:
            print("HALT\n%s" %e)
            break
    et = time.time()

    if memdumpon:
        hex16dump( emu.CPU.RAM, 32768, memdump_filename)

    print("# -------------------------------------------------------------------------------------------")
    print("# Program Execution Statistics")
    print("# -------------------------------------------------------------------------------------------")
    print("#          Instruction Count: %7d" % emu.instr_count)
#    print("#          Logic cycle count: %7d" % emu.cycle_count)
    print("#      Total Memory Accesses: %7d" % (emu.CPU.read_count + emu.CPU.write_count) )
    print("#              Memory Writes: %7d" % emu.CPU.write_count )
    print("#               Memory Reads: %7d" % emu.CPU.read_count )    
    if statson:
        print ("# -------------------------------------------------------------------------------------------")
        print ("# Instruction Class Statistics")
        print ("# -------------------------------------------------------------------------------------------")
        print ("# Opcode             Execution")
        print ("# Class    Mnemonic  Count")
        print ("# -------+----------+----------------------------------------------------------------------------")
        for i in emu.CPU.opcode_table:
            for fn in sorted(emu.CPU.opcode_table[i].opcode_fn.keys()):
                print("# F =%2d  | %-8s | %12d" % ( i, fn, emu.CPU.opcode_table[i].execstats[fn]))
    print("# -------------------------------------------------------------------------------------------")
    print("# Emulator Performance Statistics")
    print("# -------------------------------------------------------------------------------------------")
    print("# Run time                  : %10.3f s" % (et - st))
    print("# Instructions per second   : %10.3f MIPS" % (emu.instr_count/(1000000 * (et-st))))
    print("# -------------------------------------------------------------------------------------------")
