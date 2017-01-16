
class IR_class {
public:
  unsigned int IR:16;
  unsigned int  F: 4;
  unsigned int  I: 1;
  unsigned int  T: 2;
  unsigned int  R: 2;
  unsigned int  S: 2;
  unsigned int  J: 2;
  unsigned int  B: 4;
  unsigned int  P: 8;
  unsigned int  N: 11;

  void unpack(int opcode);
};

