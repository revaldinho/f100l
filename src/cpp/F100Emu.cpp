/* ============================================================================
 * F100Emu - Emulator for the Ferranti F100-L CPU
 *
 * COPYRIGHT 2017 Richard Evans, Ed Spittles
 *
 * This file is part of f100l - an set of utilities for programming and
 * emulation of the Ferranti F100-L CPU and peripheral components.
 *
 * f100l is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * f100l is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * See  <http://www.gnu.org/licenses/> for a copy of the GNU Lesser General
 * Public License
 *
 *  ===========================================================================*/
#include <iostream>
#include <stdio.h>
#include <string>
#include <unistd.h>
#include <fstream>
#include <string>
#include <cstdlib>

using namespace std;

#define ENDIANNESS 0
#define MEM_SIZE 32*1024

#include "F100CPU.cpp"

int glistingon = 1;
int gtraceon = 0;
int gmemdumpon = 0;
string gmemdump = string("");
int gmemdump_lo = 0;
int gmemdump_hi = (32*1024)-1;
string gbanner = "\n\
# -------------------------------------------------------------------------------------------\n\
#    _____________  ____        __       ______                __      __\n\
#   / ____<  / __ \\/ __ \\      / /      / ____/___ ___  __  __/ /___ _/ /_____  _____\n\
#  / /_   / / / / / / / /_____/ /      / __/ / __ `__ \\/ / / / / __ `/ __/ __ \\/ ___/\n\
# / __/  / / /_/ / /_/ /_____/ /___   / /___/ / / / / / /_/ / / /_/ / /_/ /_/ / /\n\
#/_/    /_/\\____/\\____/     /_____/  /_____/_/ /_/ /_/\\__,_/_/\\__,_/\\__/\\____/_/\n\
#\n\
#\n\
# F 1 0 0 - L * E M U L A T O R (c) 2016, 2017 Revaldinho & BigEd\n\
# -------------------------------------------------------------------------------------------\n";


void usage() {
  cout << "  USAGE:\n\n";
  cout << "    F100Emu is a very simple emulator for the Ferranti F100-L CPU.\n\n";
  cout << "  REQUIRED SWITCHES :\n\n";
  cout << "  -f <filename>   hex file for executable\n\n";
  cout << "  OPTIONAL SWITCHES :\n\n";
  cout << "  -a <1|0>        set state of AdSel pin on startup (default 1)\n";
  cout << "  -t              trace all memory accesses\n";
  cout << "  -m <filename>   dump memory to a file at the end of the run\n";
  cout << "  -p <number>     set lowest memory address for memory dump, defaults to 0\n";
  cout << "  -q <number>     set highest memory address for memory dump, defaults to 32K-1\n";
  cout << "  -n              suppress generation of listing file\n";
  cout << "  -h              show this help message\n";
  exit(1);
}

void write_memdump( string filename, unsigned int mem[], unsigned int accessed[]) {
  ofstream myfile (filename.c_str());
  for (int adr=gmemdump_lo ; adr <= gmemdump_hi; adr++) {
    char line[100];
    if (accessed[adr]) {
      sprintf(line, "0x%04X : 0x%04X\n" , adr, mem[adr]&0xFFFF);
      myfile << line;
    }
  }
  myfile.close();
}

void read_hex_file( string filename, unsigned int mem[], int is_big_endian=0 ) {
  // Read hex file arranged as bytes into memory array of 16bit words

  string line;
  int idx = 0;
  char *fields;
  int hex_values[2];
  int pair_idx = 0;

  ifstream myfile (filename.c_str());

  if (myfile.is_open()) {
    while ( getline (myfile,line) ) {
      char *cline = new char[line.length() +1 ] ;

      strcpy(cline, line.c_str());
      fields = strtok(cline," \n");

      while ( fields != NULL ) {
        sscanf(fields, "%2x", &hex_values[pair_idx]);
        fields = strtok(NULL," \n");

        pair_idx = (pair_idx+1) %2;
        if ( pair_idx == 0 ) {
          if (is_big_endian) {
            mem[idx++] = hex_values[0]*256 + hex_values[1];
          } else {
            mem[idx++] = hex_values[1]*256 + hex_values[0];
          }
        }
      }
    }
    myfile.close();
  }

  else cout << "Error: unable to open file " << filename << "\n";
}

void print_header() {
  cout << "#                                   Condition Reg.\n";
  cout << "# PC   : Memory         : Acc. OR.  F M C S V Z I  : Instruction\n";
  cout << "# -------------------------------------------------------------------------------------------\n";
}

void print_machine_state(F100_class emu) {

    char line [256];
    unsigned int PC = emu.PC;
    CC_class CR= emu.CC;
    IR_class IR = emu.IR;

    sprintf(line, "  %04X : %04X %04X %04X : %04X %04X %d %d %d %d %d %d %d  : ", \
      PC & 0xFFFF,emu.mem[PC] & 0xFFFF , emu.mem[PC+1] & 0xFFFF, emu.mem[PC+2] & 0xFFFF,\
      emu.ACC & 0xFFFF ,emu.OR & 0xFFFF ,CR.F,CR.M,CR.C,CR.S,CR.V,CR.Z,CR.I);
    cout << line ;
}


int run_emulation(string filename, int adsel) {
  unsigned int instr_count = 0;
  unsigned int breakval = 0;
  F100_class emu = F100_class::F100_class(adsel, gtraceon);

  read_hex_file (filename, emu.mem, 0 );

  cout << gbanner;
  emu.reset();
  print_header();
  while ( breakval == 0 ) {
    if ( glistingon) {
      print_machine_state(emu);
    }
    breakval = emu.single_step();
    if ( glistingon ) {
      cout  << emu.instr_disassembly << std::endl;
    }
    instr_count++;
  }
  printf ("Execution terminated with break instruction 0x%04X\n", breakval);
  //writeHexFile (filename, emu.mem, 0, 0);
  printf("# -------------------------------------------------------------------------------------------\n");
  printf("# Emulator Performance Statistics\n");
  printf("# -------------------------------------------------------------------------------------------\n");
  printf("# Instruction count         : %7d\n" , instr_count);
  //printf("# Run time                  : %10.2f s" % (et - st))
  //printf("# Instructions per second   : %10.2f MIPS" % (emu.instr_count/(1000000 * (et-st))))
  printf("# -------------------------------------------------------------------------------------------\n");

  if (gmemdumpon) {
    write_memdump(gmemdump, emu.mem, emu.accessed);
  }

  return 0;
}

int main (int argc, char **argv) {
  int index;
  int c;
  int adsel = 1;
  string filename = string("") ;

  opterr = 0;
  while ((c = getopt (argc, argv, "hnta:f:m:p:q:")) != -1)
    switch (c)
      {
      case 'f':
        filename = optarg;
        break;
      case 'n':
        glistingon=0;
        break;
      case 't':
        gtraceon=1;
        break;
      case 'm':
        gmemdumpon = 1;
        gmemdump = optarg;
        break;
      case 'a':
        adsel = ((int)strtol(optarg,NULL,0) >0)?1:0;
        break;
      case 'p':
        gmemdump_lo = (int)strtol(optarg,NULL,0);
        break;
      case 'q':
        gmemdump_hi = (int)strtol(optarg,NULL,0);
        break;
      case 'h':
        usage();
        break;
      default:
        abort ();
      }
  for (index = optind; index < argc; index++) {
    printf ("Non-option argument %s\n", argv[index]);
  }
  if (! std::ifstream(filename)){
    std::cout << "Error: File " << filename << " does not exist" << std::endl;
    return false;
  }

  run_emulation(filename, adsel);

  return 0;
}
