#include "CC_class.h"
void CC_class::unpack(int val) {
  I = (val >> 0) & 0x01;
  Z = (val >> 1) & 0x01;
  V = (val >> 2) & 0x01;
  S = (val >> 3) & 0x01;
  C = (val >> 4) & 0x01;
  M = (val >> 5) & 0x01;
  F = (val >> 6) & 0x01;
}
int CC_class::pack() {
  return( F<<6 | M <<5 | C<<4 | S<<3 | V<<2 | Z<<1 | I );
}
void CC_class::reset() {
    unpack(0);
}


