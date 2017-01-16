

class CC_class {
public:
  unsigned int I:1 ;
  unsigned int Z:1 ;
  unsigned int V:1 ;
  unsigned int S:1 ;
  unsigned int C:1 ;
  unsigned int M:1 ;
  unsigned int F:1 ;

  void unpack(int val);
  int pack();
  void reset();
};

