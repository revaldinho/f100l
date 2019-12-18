#define ISHEXCH(c) (c>= '0' && c<='9') || ( toupper(c) <= 'F' && toupper(c)>='A')
#define ATOH(c)   ((c>='0' && c<='9') ? toupper(c)-'0': toupper(c)-'A'+10)
#define HEXPAIRTOD(c,c1) (16*ATOH(c)+ATOH(c1))
#define INTTOPRINT(c) (( (c)>31 && (c)<128) ? (c): '.')
#define COMPUTE_ZERO(r)   cpu.Z = (((r&0x0FFFF) ==0)?1:0)
#define COMPUTE_CARRY(r)  cpu.C = (((r&0x10000) !=0)?1:0)
#define COMPUTE_BORROW(r) cpu.C = (((r&0x10000) !=0)?0:1)
#define COMPUTE_SIGN(r)   cpu.S = (((r&0x08000) !=0)?1:0)
#define COMPUTE_OVERFLOW(r,a,b) cpu.V = (((a & 0x8000)==(b & 0x8000)) && (r & 0x8000) != (a & 0x8000)) 
#define SET_CARRY         cpu.C = 1
#define CLEAR_CARRY       cpu.C = 0
#define CLEAR_OVERFLOW    cpu.V = 0
#define CLEAR_MULTI       cpu.M = 0
#define UNPACK_FLAGS(f)   cpu.I=(f&1);cpu.Z=(f>>1)&1;cpu.V=(f>>2)&1;cpu.S=(f>>3)&1;cpu.C=(f>>4)&1;cpu.M=(f>>5)&1;cpu.F=(f>>6)&1
#define PACK_FLAGS        ((cpu.F<<6)|(cpu.M<<5)|(cpu.C<<4)|(cpu.S<<3)|(cpu.V<<2)|(cpu.Z<<1)|(cpu.I))
#define TRUNC16(m)        (m & 0xFFFF) 
#define TRUNC15(m)        (m & 0x7FFF) 
#define INC_ADDR(m,n)     (m = TRUNC15(m+n))
#define FETCH15(m, o, pc) o=TRUNC15(read_mem(m, pc)); INC_ADDR(pc,1)
#define HALT(ir)          (ir.F==0 && ir.T==1)
#define LSP               0


#define OP_F0      0x0
#define OP_SJM     0x1
#define OP_CAL     0x2
#define OP_RTN_RTC 0x3
#define OP_STO     0x4
#define OP_ADS     0x5
#define OP_SBS     0x6
#define OP_ICZ     0x7
#define OP_LDA     0x8
#define OP_ADD     0x9
#define OP_SUB     0xA
#define OP_CMP     0xB
#define OP_AND     0xC
#define OP_NEQ     0xD
#define OP_F14     0xE
#define OP_JMP     0xF

static char *mnemonic[] = {
  "F0",
  "SJM",
  "CAL",
  "RTN_RTC",
  "STO",
  "ADS",
  "SBS",
  "ICZ",
  "LDA",
  "ADD",
  "SUB",
  "CMP",
  "AND",
  "NEQ",
  "F14",
  "JMP",
};

typedef struct {
  uint16_t WORD;
  uint8_t  B, F, I, J, P, R, S, T;
  uint16_t N;
} instr_t;

typedef struct {
  uint16_t *mem ;
  uint16_t acc;
  uint16_t or;
  uint16_t pc;
  bool I;
  bool Z;
  bool V;
  bool S;
  bool C;
  bool M;
  bool F;
  instr_t ir;
} cpu_t;


extern cpu_t f100_init();
extern void  f100_reset(bool adsel);
extern void  f100_trace(bool header);
extern int   f100_exec(int max_instr, bool trace_on);

extern uint16_t read_mem( uint16_t mem[], uint16_t addr );
extern void write_mem( uint16_t mem[], uint16_t addr, uint16_t data );
