#include <iostream>
#include <stdio.h>
#include <string>
#include <unistd.h>
#include <fstream>
#include <string>
#include <cstdlib>

#include "CC_class.h"
#include "IR_class.h"

#define ENDIANNESS 0
#define MEM_SIZE 32*1024

using namespace std;


class F100_class {
public:
  unsigned int mem [MEM_SIZE];
  unsigned int accessed [MEM_SIZE];
  unsigned int ACC;
  unsigned int PC;
  unsigned int OR;
  unsigned int adsel;
  unsigned int traceon;
  string instr_disassembly;
  CC_class CC;
  IR_class IR;
private:
  unsigned int lsp;
  unsigned int condition;


public:
  F100_class(int as, int tron=0);
  int mem_read(int address);
  void mem_write(int address, int data);
  void interrupt(int channel=0);
  void reset();
  int single_step();
private:
  int get_operand(unsigned int *operand_adr, unsigned int noread=0, unsigned int nopointerarith=0);

};
