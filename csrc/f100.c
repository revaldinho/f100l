#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <unistd.h>

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

#define BUFSZ 16
#define GRPSZ  8
#define F100MEMSZ 65536
bool verbose = false;

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



// Global Variables
cpu_t    cpu;
uint16_t operand_address, target;
bool     tron;

// Memory access routines (will be external and provided by emulation environment)
uint16_t read_mem( uint16_t mem[], uint16_t addr )  {
  uint16_t data = mem[addr];
  if (false) printf("  MEM READ : addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);    
  return data;
}
void write_mem( uint16_t mem[], uint16_t addr, uint16_t data ) {
  if (false) printf("  MEM WRITE: addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);      
  mem[addr] = data;
}


// CPU Functions
void decode( uint16_t word) {
  cpu.ir.WORD = word;
  cpu.ir.F = (word>>12) & 0x000F ;
  cpu.ir.I = (word>>11) & 0x0001 ;
  cpu.ir.T = (word>>10) & 0x0003 ;
  cpu.ir.R = (word>> 8) & 0x0003 ;
  cpu.ir.S = (word>> 6) & 0x0003 ;
  cpu.ir.J = (word>> 4) & 0x0003 ;
  cpu.ir.B = word       & 0x000F ;
  cpu.ir.P = word       & 0x00FF ;
  cpu.ir.N = word       & 0x07FF ;
}

void trace(uint16_t *mem, bool header) {
  if (header) {
    printf("%4s : %4s : %4s %4s : %7s %s\n", "PC", "OP", "ACC", "OR", "FMCSVZI", ":  LSP (LSP-2)(LSP-1)(LSP-0): Instruction");   
  } else {
    char *mnem = mnemonic[cpu.ir.F];
    printf("%04X : %04X : %04X %04X : %x%x%x%d%d%d%d : %04X  %04X   %04X   %04X  : %s\n", cpu.pc, cpu.ir.WORD, cpu.acc, cpu.or,  \
           cpu.F, cpu.M, cpu.C, cpu.S, cpu.V, cpu.Z, cpu.I, mem[LSP], mem[TRUNC15(mem[LSP]-2)], mem[TRUNC15(mem[LSP]-1)], mem[TRUNC15(mem[LSP])], mnem);
  }
}

void reset(bool adSel ) {
  cpu.pc = (adSel) ? 2048 : 16384 ;
}

int exec(int max_instr, bool trace_on) {
  uint32_t result;
  uint16_t stack_pointer;
  uint16_t pointer;
  uint16_t operand_address;
  uint16_t operand1_address;
  uint16_t operand;
  
  int i;

  tron = trace_on;
  for ( i=0; i<max_instr ; i++ ) {

    // Fetch and decode operand
    decode(read_mem(cpu.mem, cpu.pc));
    if ( tron ) trace (cpu.mem, false);
    INC_ADDR(cpu.pc,1);

    // Fetch additional Operands if required
    if ( cpu.ir.F==OP_F0 && cpu.ir.T==1) {
      // HALT
      break;    
    } else if ( cpu.ir.F==1) {
      // SJM - ignore all addressing bits
    } else if ( cpu.ir.F!=0 && cpu.ir.I==0) {
      if (cpu.ir.N!=0) {
        // immediate data (single word)
        operand_address = cpu.ir.N;
      } else {
        // immediate data address mode (double word)
        operand_address = cpu.pc; 
        INC_ADDR(cpu.pc,1);        
      }
      // ICZ can take an additional operand
      if (cpu.ir.F==OP_ICZ) {
        operand1_address = TRUNC15(read_mem(cpu.mem, cpu.pc));
        INC_ADDR(cpu.pc,1);
      }                    
    } else if ( cpu.ir.F!=0 && cpu.ir.I==1 && cpu.ir.P!=0) {
      // Pointer indirect (single word)
      pointer = TRUNC15(read_mem(cpu.mem, cpu.ir.P));
      if ( cpu.ir.R==1 ) INC_ADDR(pointer,1);
      operand_address = read_mem(cpu.mem, pointer);
      if ( cpu.ir.R==3 ) INC_ADDR(pointer,-1);
      write_mem(cpu.mem, cpu.ir.P, pointer);      
      if (cpu.ir.F==OP_ICZ) {
        operand1_address = TRUNC15(read_mem(cpu.mem, cpu.pc));
        INC_ADDR(cpu.pc,1);
      }
    } else if (cpu.ir.F!=0 && cpu.ir.I==1 && cpu.ir.P==0) {
      // Immediate Indirect address (double word)
      operand_address = TRUNC15(read_mem(cpu.mem, cpu.pc));
      INC_ADDR(cpu.pc,1);
      if (cpu.ir.F==OP_ICZ) {
        operand1_address = TRUNC15(read_mem(cpu.mem, cpu.pc));
        INC_ADDR(cpu.pc,1);
      }        
    } else if (cpu.ir.F==0 && cpu.ir.T==0 && (cpu.ir.R==3||cpu.ir.S==2)) {
      // Shifts, bit manipulation and jumps
      operand_address = TRUNC15(read_mem(cpu.mem, cpu.pc));
      INC_ADDR(cpu.pc,1);
      if (cpu.ir.S==2 && cpu.ir.R==3) {
        // Jumps (triple word) 
        operand1_address = TRUNC15(read_mem(cpu.mem, cpu.pc));
        INC_ADDR(cpu.pc,1);
      }
    }

    // Execute instruction
    switch ( cpu.ir.F ) {
    case OP_F0:
      if (cpu.ir.T==0 && cpu.ir.S<2) { // Shifts
        int i;
        if ( cpu.M==0 ) { // Single Length
          if (cpu.ir.R==1) operand = (cpu.or = PACK_FLAGS);
          else if (cpu.ir.R==3) operand = (cpu.or = read_mem(cpu.mem, operand_address));
          else operand = cpu.acc;
          // S=Direction, J=0,1:Arith, 2:Logical, 3:Rotate, B=Num Places
          for (i=0, result=operand; i< cpu.ir.B; i++) {
            if (cpu.ir.S) result = (result<< 1 ) | ((cpu.ir.J==3)?((result>>15)&1):0);
            else result = (result >> 1)  | ((cpu.ir.J<2) ? (result & 0x8000): (cpu.ir.J==3)?(result&1)<<15 : 0);
          }
          COMPUTE_OVERFLOW(result,operand,operand);
          COMPUTE_SIGN(result);          
          if (cpu.ir.R==1) {
            // Overwrite flags with the shifted value
            cpu.or = TRUNC16(result);
            UNPACK_FLAGS(cpu.or);
          } else if (cpu.ir.R==3) {
            cpu.or = TRUNC16(result);
            write_mem(cpu.mem, operand_address, cpu.or);
          } else cpu.acc = TRUNC16(result);
        } else { // Double Length
          uint32_t double_operand;
          uint64_t quad_result;
          if (cpu.ir.R==1) cpu.or = PACK_FLAGS;
          else if (cpu.ir.R==3) cpu.or = read_mem(cpu.mem, operand_address);
          double_operand = (cpu.acc<<16) | cpu.or;
          // S=Direction, J=0,1:Arith, 2:Logical, B=Num Places
          for (i=0, quad_result= (uint64_t) double_operand; i< (((cpu.ir.J&1)<<4) + cpu.ir.B); i++) {
            if (cpu.ir.S) quad_result = quad_result << 1 ;
            else quad_result = (quad_result >> 1)  | ((cpu.ir.J<2)?(quad_result&0x80000000):0);
          }
          COMPUTE_OVERFLOW((quad_result>>16), cpu.acc, cpu.acc);
          COMPUTE_SIGN(quad_result>>16); 
          cpu.acc = TRUNC16((quad_result>>16));
          cpu.or = TRUNC16(quad_result);
          if (cpu.ir.R==1) {
            // Overwrite flags with the shifted value, low word (in OR)
            UNPACK_FLAGS(cpu.or);
          } else if (cpu.ir.R==3) {
            write_mem(cpu.mem, operand_address, cpu.or);
          } 
        }
      } else if ( cpu.ir.T==0 && cpu.ir.S>1) { //  Bit conditional jumps and Bit manipulation
        uint16_t bmask;
        uint16_t jump_address;
        if (cpu.ir.R==3) {
          operand = (cpu.or=read_mem(cpu.mem, operand_address));
          jump_address = operand1_address;
        } else if (cpu.ir.R==1) {
          operand = PACK_FLAGS;
          jump_address = operand_address;          
        } else { 
          operand=cpu.acc;
          jump_address=operand_address;
        }
        bmask = (1<<cpu.ir.B);
        if ( cpu.ir.S==2 ) { // Jumps only
          if ( cpu.ir.J==0 || cpu.ir.J==2) { // Jump on bit clear
            cpu.pc = (!(operand & bmask))? jump_address: cpu.pc;
          } else { // Jump on bit set
            cpu.pc = ((operand & bmask))? jump_address: cpu.pc;
          }
        }
        if (cpu.ir.J>1) { // Set or clear bit
          result = ( cpu.ir.J==2) ? operand | bmask : operand & ~bmask;
          if (cpu.ir.R==3) {
            write_mem(cpu.mem, operand_address, TRUNC16(result));
          } else if ( cpu.ir.R==1) {
            UNPACK_FLAGS (result);
          } else {
            cpu.acc=result;
          }
        }
      }
      break;      
    case OP_SJM: 
      INC_ADDR( cpu.pc, cpu.acc ) ;
      break;      
    case OP_CAL:
      // Special case for immed. addr - push imm data addr onto stack and set it to be PC also
      stack_pointer = read_mem(cpu.mem, LSP);
      if ( cpu.ir.I==0 && cpu.ir.N==0) cpu.pc = TRUNC15(operand_address);
      write_mem(cpu.mem,  TRUNC15(stack_pointer+1), cpu.pc);
      write_mem(cpu.mem,  TRUNC15(stack_pointer+2), PACK_FLAGS);
      write_mem(cpu.mem,  LSP, TRUNC15(stack_pointer+2));
      cpu.pc = TRUNC15(operand_address);
      CLEAR_MULTI ;
      break;
    case OP_ICZ:
      cpu.or = 1+read_mem(cpu.mem, operand_address);
      write_mem(cpu.mem, operand_address, cpu.or);
      if (cpu.or!=0) cpu.pc=operand1_address ;
      break;
    case OP_JMP:
      cpu.pc = TRUNC15(operand_address);
      break;
    case OP_RTN_RTC:
      stack_pointer = read_mem(cpu.mem, LSP);
      cpu.pc = TRUNC15(read_mem(cpu.mem, stack_pointer-1));
      // restore bits 0-5 from stack, retain others
      if (cpu.ir.I == 0) {
        uint16_t flags, new_flags;
        flags = PACK_FLAGS;
        new_flags = read_mem(cpu.mem, stack_pointer);
        flags = (new_flags & 0x3F) | (flags & 0x60) ;
        UNPACK_FLAGS(flags);        
      }
      write_mem(cpu.mem,  LSP, TRUNC15(stack_pointer-2));
      break;
    case OP_LDA:
    case OP_STO:
      if ( cpu.ir.F==OP_LDA) cpu.acc = read_mem(cpu.mem, operand_address); 
      else write_mem(cpu.mem,  operand_address, cpu.acc);
      COMPUTE_ZERO(cpu.acc) ;
      COMPUTE_SIGN(cpu.acc) ; 
      CLEAR_OVERFLOW ;
      break;
    case OP_SBS:
    case OP_SUB:
    case OP_CMP:    
      cpu.or = read_mem(cpu.mem, operand_address);
      result = cpu.or - cpu.acc;       
      if (cpu.M || cpu.ir.F==OP_SBS) result += cpu.C-1;
      COMPUTE_BORROW(result) ;
      COMPUTE_OVERFLOW(result, cpu.acc, cpu.or) ;
      COMPUTE_SIGN(result) ;
      COMPUTE_ZERO(result) ; 
      if (cpu.ir.F==OP_SBS) write_mem(cpu.mem, operand_address, TRUNC16(result));
      else if (cpu.ir.F==OP_SUB) cpu.acc=TRUNC16(result);
      break;
    case OP_ADS: 
    case OP_ADD: 
      cpu.or = read_mem(cpu.mem, operand_address);
      result = cpu.acc + cpu.or;
      if (cpu.M || cpu.ir.F==OP_ADS) result += cpu.C;
      COMPUTE_CARRY(result) ;
      COMPUTE_OVERFLOW(result, cpu.acc, cpu.or) ;
      COMPUTE_SIGN(result) ;
      COMPUTE_ZERO(result) ; 
      if (cpu.ir.F==OP_ADS) write_mem(cpu.mem, operand_address, TRUNC16(result));
      else if (cpu.ir.F==OP_ADD) cpu.acc=TRUNC16(result);
      break;
    case OP_AND:
    case OP_NEQ:
      cpu.or = read_mem(cpu.mem, operand_address);
      cpu.acc = (cpu.ir.F==OP_AND)? cpu.acc&cpu.or : cpu.acc^cpu.or;
      COMPUTE_ZERO(cpu.acc) ;
      COMPUTE_SIGN(cpu.acc) ;
      SET_CARRY ;
    default: break;
    }
  }
  if (HALT(cpu.ir)) return (int) cpu.ir.WORD; else return 0;  
}

void hex16dump( uint16_t data[], int dlen) {
  int i, j, max;
  char *astr = (char * ) malloc (2*GRPSZ + 1);
  char *dstr = (char * ) malloc (5*GRPSZ + 1);
  astr[2*GRPSZ]='\0';
  dstr[5*GRPSZ]='\0';
  max = dlen + ((dlen%GRPSZ>0)?dlen + GRPSZ - dlen%GRPSZ: 0);
  for (i=0; i< max ; i++ ) {
    j=i%GRPSZ;
    sprintf( dstr+(j*5), "%04X ", data[i] ) ;  
      sprintf( astr+(j*2), "%c%c", INTTOPRINT((data[i]>>8)&0xFF),INTTOPRINT(data[i]&0xFF));
      if (j==GRPSZ-1) printf( "%04X: %s%s%c", i-j, dstr, astr, (i>0)?'\n':'\0');
  }
}

void read_hex_file( uint16_t *mem, char *filename, bool big_endian){
  char buf[BUFSZ];
  char hstr[BUFSZ+1];
  int n, hexn=0, i, j ;
  int first, second;
  if (big_endian) {
    first = 256;
    second = 1;
  } else {
    first = 1;
    second = 256;
  }
  
  FILE *f = fopen( filename, "rt") ;  
    while( (n=fread( buf, 1, BUFSZ, f))> 0) {
      for (i=0 ; i<n ; i++) if (ISHEXCH(buf[i])) hstr[hexn++]=buf[i];
      for (j=0; j<=hexn-4; j+=4) {
        *mem++=(HEXPAIRTOD(hstr[j],hstr[j+1])*first)+(HEXPAIRTOD(hstr[j+2],hstr[j+3])*second);
      }
      // Digits left over must be carried forward to the next line
      for (i=0; j<hexn; j++) hstr[i++] = hstr[j];
      hexn = i;
    }
    fclose(f);
}

void read_bin_file( uint16_t *mem, char *filename){
  char buf[BUFSZ+2];
  int n, j ; 
  FILE *f = fopen( filename, "rb") ;  
    while( (n=fread( buf, 1, BUFSZ-(BUFSZ%2), f))> 0) {
      for (j=0; j<=n-2; j+=2) *mem++=((buf[j]&0xFF)<<8) + (buf[j+1]&0xFF);
    }
    fclose(f);
}

void usage(){
  puts("Usage:\n   f100emu -f <filename> [-b][-v][-h]");
  puts("Options:\n   -f <filename>  program file name");
  puts("   -b       program file in binary format");
  puts("   -x       program file in hex format (default)");
  puts("   -v       verbose mode: turns on more debug messages");
  puts("   -h       print this summary");
  exit(0);
}


int main (int argc, char **argv ) {
  uint16_t *mem;
  int c;
  bool binaryNotHex=false;
  char *filename=NULL;
  opterr = 0;
  
  while ( (c=getopt(argc, argv,"bhvxf:")) != -1 ) {
    switch(c) {
    case 'f': filename = optarg; break;
    case 'v': verbose = true; break;
    case 'b': binaryNotHex = true; break;
    case 'x': binaryNotHex = false; break;
    default : usage(); break;
    }
  }    
  if ( filename==NULL) usage();
  else if ( access(filename,R_OK) == -1 ) {
    printf("Error - file %s cannot be opened for reading in read_hex_file\n", filename);
    exit(1);
  }
  
  cpu.mem = (uint16_t *) malloc(F100MEMSZ * sizeof(uint16_t));
  if (binaryNotHex) read_bin_file(cpu.mem, filename);
  else read_hex_file(cpu.mem, filename, false);

  if (verbose) hex16dump(cpu.mem+2048, 64);
  
  trace(cpu.mem, true);
  reset(true);
  exec (200, verbose);
  return (0);
}
