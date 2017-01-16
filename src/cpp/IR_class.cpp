#include "IR_class.h"

void IR_class::unpack( int opcode) {
  IR = opcode ;
  F = (opcode>>12)& 0x000F;
  I = (opcode>>11)& 0x0001;
  T = (opcode>>10)& 0x0003;
  R = (opcode>> 8)& 0x0003;
  S = (opcode>> 6)& 0x0003;
  J = (opcode>> 4)& 0x0003;
  B = opcode      & 0x000F;
  P = opcode      & 0x00FF;
  N = opcode      & 0x07FF;
}

