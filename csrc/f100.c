#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#define COMPUTE_ZERO(r)   cpu.Z = ((r & 0x0FFFF) ==0) ? 1:0 
#define COMPUTE_CARRY(r)  cpu.C = ((r & 0x10000) !=0) ? 1:0 
#define COMPUTE_BORROW(r) cpu.C = ((r & 0x10000) !=0) ? 0:1
#define COMPUTE_SIGN(r)   cpu.S = ((r & 0x08000) !=0) ? 1:0 
#define COMPUTE_OVERFLOW(r,a,b) cpu.V = (((a & 0x8000)==(b & 0x8000)) && (r & 0x8000) != (a & 0x8000)) 
#define SET_CARRY         cpu.C = 1
#define CLEAR_CARRY       cpu.C = 0
#define CLEAR_OVERFLOW    cpu.V = 0
#define CLEAR_MULTI       cpu.M = 0
#define UNPACK_FLAGS(f)   cpu.I=(f&1);cpu.Z=(f>>1)&1;cpu.V=(f>>2)&1;cpu.S=(f>>3)&1;cpu.C=(f>>4)&1;cpu.M=(f>>5)&1;cpu.F=(f>>6)&1
#define PACK_FLAGS        ((cpu.F<<6)|(cpu.M<<5)|(cpu.C<<4)|(cpu.S<<3)|(cpu.V<<2)|(cpu.Z<1)|cpu.I)
#define TRUNC16(m)        (m & 0xFFFF) 
#define TRUNC15(m)        (m & 0x7FFF) 
#define INC_ADDR(m,n)     (m = TRUNC15(m+n))
#define HALT              (instr.F==0 && instr.T==1)
#define LSP               0

#define OP_F0      0x0
#define OP_SJM     0x1
#define OP_CAL     0x2
#define OP_RTN_RTC 0x3
#define OP_STO     0x4
#define OP_ADS     0x5
#define OP_SBS     0x6
#define OP_F7      0x7
#define OP_LDA     0x8
#define OP_ADD     0x9
#define OP_SUB     0xA
#define OP_CMP     0xB
#define OP_AND     0xC
#define OP_NEQ     0xD
#define OP_F14     0xE
#define OP_JMP     0xF

typedef struct {
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
} cpu_t;

typedef struct {
  uint16_t WORD;
  uint8_t  B, F, I, J, P, R, S, T;
  uint16_t N;
} instr_t;


// Global Variables
uint16_t mem[32768];
instr_t  instr;
cpu_t    cpu;
uint16_t operand_address, target;
bool     tron;

// Memory access routines (will be external and provided by emulation environment)
uint16_t read_mem( uint16_t addr )  {
  uint16_t data = mem[addr];
  if (tron) printf("  MEM READ : addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);    
  return data;
}
void write_mem( uint16_t addr, uint16_t data ) {
  if (tron) printf("  MEM WRITE: addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);      
  mem[addr] = data;
}


// CPU Functions
void decode( uint16_t word) {
  instr.WORD = word;
  instr.F = (word>>12) & 0x000F ;
  instr.I = (word>>11) & 0x0001 ;
  instr.T = (word>>10) & 0x0003 ;
  instr.R = (word>> 8) & 0x0003 ;
  instr.S = (word>> 6) & 0x0003 ;
  instr.J = (word>> 4) & 0x0003 ;
  instr.B = word       & 0x000F ;
  instr.P = word       & 0x00FF ;
  instr.N = word       & 0x07FF ;
}

void trace(bool header) {
  if (header) {
    printf("%4s : %4s : %4s %4s : %7s\n", "PC", "OP", "ACC", "OR", "FMCSVZI");   
  } else { 
    printf("%04X : %04X : %04X %04X : %x%x%x%d%d%d%d\n", cpu.pc, instr.WORD, cpu.acc, cpu.or,  \
           cpu.F, cpu.M, cpu.C, cpu.S, cpu.V, cpu.Z, cpu.I);
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
    decode(read_mem(cpu.pc));
    if ( tron ) trace (false);
    INC_ADDR(cpu.pc,1);

    // Fetch additional Operands if required
    if ( instr.F==OP_F0 && instr.T==1) {
      // HALT
      break;    
    } else if ( instr.F==1) {
      // SJM - ignore all addressing bits
    } else if ( instr.F!=0 && instr.I==0 && instr.N!=0) {
      // immediate data (single word)
      operand_address = instr.N; 
    } else if ( instr.F!=0 && instr.I==0 && instr.P!=0) {
      // Pointer indirect (single word)
      pointer = TRUNC15(read_mem(instr.P));
      if ( instr.R==1 ) INC_ADDR(pointer,1);
      operand_address = read_mem(pointer);
      if ( instr.R==3 ) INC_ADDR(pointer,-1);
      write_mem(instr.P, pointer);
    } else if ( instr.F!=0 && instr.I==0 && instr.N==0) {
      // immediate data address mode (double word)
      operand_address = cpu.pc; 
      INC_ADDR(cpu.pc,1);
    } else if (instr.F!=0 && instr.I==1 && instr.P==0) {
      // Immediate Indirect address (double word)
      operand_address = TRUNC15(read_mem(cpu.pc));
      INC_ADDR(cpu.pc,1);
    } else if (instr.F==0 && instr.T==0 && (instr.R==3||instr.S==2)) {
      // Shifts, bit manipulation and jumps
      operand_address = TRUNC15(read_mem(cpu.pc));
      INC_ADDR(cpu.pc,1);
      if (instr.S==2 && instr.R==3) {
        // Jumps (triple word)
        operand1_address = TRUNC15(read_mem(cpu.pc));
        INC_ADDR(cpu.pc,1);
      }
    }

    // Execute instruction
    switch ( instr.F ) {
    case OP_F0:
      if (instr.T==0 && instr.S<2) { // Shifts
        int i;
        if ( cpu.M==0 ) { // Single Length
          if (instr.R==1) operand = (cpu.or = PACK_FLAGS);
          else if (instr.R==3) operand = (cpu.or = read_mem(operand_address));
          else operand = cpu.acc;
          // S=Direction, J=0,1:Arith, 2:Logical, 3:Rotate, B=Num Places
          for (i=0, result=operand; i< instr.B; i++) {
            if (instr.S) result = (result<< 1 ) | (instr.J==3) ? ((result>>15)&1): 0;
            else result = (result >> 1)  | (instr.J<2) ? (result & 0x8000): (instr.J==3)?(result&1)<<15 : 0;
          }
          COMPUTE_OVERFLOW(result,operand,operand);
          COMPUTE_SIGN(result);          
          if (instr.R==1) {
            // Overwrite flags with the shifted value
            cpu.or = TRUNC16(result);
            UNPACK_FLAGS(cpu.or);
          } else if (instr.R==3) {
            cpu.or = TRUNC16(result);
            write_mem(operand_address, cpu.or);
          } else cpu.acc = TRUNC16(result);
        } else { // Double Length
          uint32_t double_operand;
          uint64_t quad_result;
          if (instr.R==1) cpu.or = PACK_FLAGS;
          else if (instr.R==3) cpu.or = read_mem(operand_address);
          double_operand = (cpu.acc<<16) | cpu.or;
          // S=Direction, J=0,1:Arith, 2:Logical, B=Num Places
          for (i=0, quad_result= (uint64_t) double_operand; i< (((instr.J&1)<<4) + instr.B); i++) {
            if (instr.S) quad_result = quad_result << 1 ;
            else quad_result = (quad_result >> 1)  | (instr.J<2) ? (quad_result & 0x80000000): 0;
          }
          COMPUTE_OVERFLOW((quad_result>>16), cpu.acc, cpu.acc);
          COMPUTE_SIGN(quad_result>>16); 
          cpu.acc = TRUNC16((quad_result>>16));
          cpu.or = TRUNC16(quad_result);
          if (instr.R==1) {
            // Overwrite flags with the shifted value, low word (in OR)
            UNPACK_FLAGS(cpu.or);
          } else if (instr.R==3) {
            write_mem(operand_address, cpu.or);
          } 
        }
      } else if ( instr.T==0 && instr.S>1) { //  Bit conditional jumps and Bit manipulation
        uint16_t bmask;
        uint16_t jump_address;
        if (instr.R==3) {
          operand = (cpu.or=read_mem(operand_address));
          jump_address = operand1_address;
        } else {
          operand=cpu.acc;
          jump_address=operand_address;
        }
        bmask = (1<<instr.B);
        if ( instr.S==2 ) { // Jumps only
          if ( instr.J==0 || instr.J==2) { // Jump on bit clear
            cpu.pc = (!(operand & bmask))? jump_address: cpu.pc;
          } else { // Jump on bit set
            cpu.pc = ((operand & bmask))? jump_address: cpu.pc;
          }
        }
        if (instr.J>1) { // Set or clear bit
          result = ( instr.J==2) ? operand | bmask : operand & ~bmask;
          if (instr.R==3) write_mem(operand_address, TRUNC16(result)) ; else cpu.acc=result;
        }
      }
      break;      
    case OP_SJM: 
      INC_ADDR( cpu.pc, cpu.acc ) ;
      break;      
    case OP_CAL:
      // Special case for immed. addr - push imm data addr onto stack and set it to be PC also
      stack_pointer = read_mem(LSP);
      if ( instr.I==0 && instr.N==0) cpu.pc = TRUNC15(operand_address);
      write_mem( TRUNC15(stack_pointer+1), cpu.pc);
      write_mem( TRUNC15(stack_pointer+2), PACK_FLAGS);
      write_mem( LSP, TRUNC15(stack_pointer+2));
      cpu.pc = TRUNC15(operand_address);
      CLEAR_MULTI ;
      break;
    case OP_JMP:
      cpu.pc = TRUNC15(operand_address);
      break;
    case OP_RTN_RTC:
      stack_pointer = read_mem(LSP);
      cpu.pc = TRUNC15(read_mem(stack_pointer-1));
      // restore bits 0-5 from stack, retain others
      if (instr.I == 0) {
        uint16_t flags, new_flags;
        flags = PACK_FLAGS;
        new_flags = read_mem(read_mem(stack_pointer));
        flags = (new_flags & 0x3F) | (flags & 0x60) ;
        UNPACK_FLAGS(flags);
      }
      write_mem( LSP, TRUNC15(stack_pointer-2));
      break;
    case OP_LDA:
    case OP_STO:
      if ( instr.F==OP_LDA) cpu.acc = read_mem(operand_address); 
      else write_mem( operand_address, cpu.acc);
      COMPUTE_ZERO(cpu.acc) ;
      COMPUTE_SIGN(cpu.acc) ; 
      CLEAR_OVERFLOW ;
      break;
    case OP_SBS:
    case OP_SUB:
    case OP_CMP:    
      cpu.or = read_mem(operand_address);
      result = cpu.or - cpu.acc;       
      if (cpu.M) result += cpu.C-1;
      COMPUTE_BORROW(result) ;
      COMPUTE_OVERFLOW(result, cpu.acc, cpu.or) ;
      COMPUTE_SIGN(result) ;
      COMPUTE_ZERO(result) ; 
      if (instr.F==OP_SBS) write_mem(operand_address, TRUNC16(result));
      else if (instr.F==OP_SUB) cpu.acc=TRUNC16(result);
      break;
    case OP_ADS: 
    case OP_ADD: 
      cpu.or = read_mem(operand_address);
      result = cpu.acc + cpu.or + (cpu.M&cpu.C);
      COMPUTE_CARRY(result) ;
      COMPUTE_OVERFLOW(result, cpu.acc, cpu.or) ;
      COMPUTE_SIGN(result) ;
      COMPUTE_ZERO(result) ; 
      if (instr.F==OP_ADS) write_mem(operand_address, TRUNC16(result));
      else if (instr.F==OP_ADD) cpu.acc=TRUNC16(result);
      break;
    case OP_AND:
    case OP_NEQ:
      cpu.or = read_mem(operand_address);
      cpu.acc = (instr.F==OP_AND)? cpu.acc&cpu.or : cpu.acc^cpu.or;
      COMPUTE_ZERO(cpu.acc) ;
      COMPUTE_SIGN(cpu.acc) ;
      SET_CARRY ;
    default: break;
    }
  }
  if (HALT) return (int) instr.WORD; else return 0;  
}



int main(int argc, char *argv[] ) {
  trace( true );
  reset(true);

  uint16_t i;
  uint16_t program[] = {
   0x8000, 0x3601, //  LDA ,LINK_STACK             ; initialize link stack pointer
   0x4800, 0x0000, //  STO .LSP
   0x8000, 0x3800, //  LDA ,USER_STACK             ; initialize user stack pointer
   0x4800, 0x0001, //  STO .USP
   0x8000, 0x0001, //  LDA ,0x0001                 ; first of the local variable stacks is pointer 2 but will get pre-incremented
   0x4800, 0x0012, //  STO .TMPVAR
   0x8000, 0xFFF1, //  LDA ,-15                     ; 16 stacks to initialise
   0x4800, 0x0015, //  STO .TESTCTR
   0x8000, 0x4000, //  LDA ,LOCAL_VARS             ; initialise local variable stacks
  };

  for (i=0; i< 18 ; i++ ) mem[2048+i] = program[i];
  exec (12, true);
  
}


