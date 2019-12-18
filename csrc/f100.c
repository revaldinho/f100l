#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <unistd.h>

#include "f100.h"

#define BUFSZ 16
#define GRPSZ  8
#define F100MEMSZ 65536

// Global Variables
static bool     verbose = false;
static bool     tron;
static cpu_t    cpu;
static uint16_t operand_address, target;

// CPU Functions
cpu_t f100_init() {  
  cpu.mem = (uint16_t *) malloc(F100MEMSZ * sizeof(uint16_t));
  return cpu;
}

static uint16_t read_mem( uint16_t addr )  {
  uint16_t data = cpu.mem[addr];
  if (false) printf("  MEM READ : addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);    
  return data;
}

static void write_mem( uint16_t addr, uint16_t data ) {
  if (false) printf("  MEM WRITE: addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);      
  cpu.mem[addr] = data;
}

static void decode( uint16_t word) {
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
 
void f100_trace(bool header) {
  if (header) {
    printf("%4s : %4s : %4s %4s : %7s %s\n", "PC", "OP", "ACC", "OR", "FMCSVZI", ":  LSP (LSP-2)(LSP-1)(LSP-0): Instruction");   
  } else {
    char *mnem = mnemonic[cpu.ir.F];
    printf("%04X : %04X : %04X %04X : %x%x%x%d%d%d%d : %04X  %04X   %04X   %04X  : %s\n", cpu.pc, cpu.ir.WORD, cpu.acc, cpu.or,  \
           cpu.F, cpu.M, cpu.C, cpu.S, cpu.V, cpu.Z, cpu.I, cpu.mem[LSP], cpu.mem[TRUNC15(cpu.mem[LSP]-2)], cpu.mem[TRUNC15(cpu.mem[LSP]-1)], cpu.mem[TRUNC15(cpu.mem[LSP])], mnem);
  }
}

void f100_reset(bool adSel ) {
  cpu.pc = (adSel) ? 2048 : 16384 ;
}

int f100_exec(int max_instr, bool trace_on) {
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
    if ( tron ) f100_trace (false);
    INC_ADDR(cpu.pc,1);

    // Fetch additional Operands if required
    if ( cpu.ir.F==OP_F0 && cpu.ir.T==1) { // HALT
      break; 
    } else if ( cpu.ir.F==1) {  // SJM - ignore all addressing bits
    } else if ( cpu.ir.F!=0 && cpu.ir.I==0 && cpu.ir.N!=0) { // Direct data (single word)
      operand_address = cpu.ir.N;
    } else if ( cpu.ir.F!=0 && cpu.ir.I==0 && cpu.ir.N==0) { // Immediate data (double word)
      operand_address = cpu.pc; 
      INC_ADDR(cpu.pc,1);        
    } else if ( cpu.ir.F!=0 && cpu.ir.I==1 && cpu.ir.P!=0) { // Pointer indirect (single word)
      pointer = TRUNC15(read_mem(cpu.ir.P));
      if ( cpu.ir.R==1 ) INC_ADDR(pointer,1);
      operand_address = read_mem( pointer);
      if ( cpu.ir.R==3 ) INC_ADDR(pointer,-1);
      write_mem(cpu.ir.P, pointer);      
    } else if (cpu.ir.F!=0 && cpu.ir.I==1 && cpu.ir.P==0) { // Immediate Indirect address (double word)
      FETCH15(cpu.mem, operand_address, cpu.pc);
    } else if (cpu.ir.F==0 && cpu.ir.T==0 && (cpu.ir.R==3||cpu.ir.S==2)) { // Shifts, bit manipulation and jumps
      FETCH15(cpu.mem, operand_address, cpu.pc);
      if (cpu.ir.S==2 && cpu.ir.R==3) { // Jumps (triple word) 
        FETCH15(cpu.mem, operand1_address, cpu.pc);
      }
    }
    if (cpu.ir.F==OP_ICZ) { // ICZ takes an additional operand
      FETCH15(cpu.mem, operand1_address, cpu.pc);
    }                    
    

    // F100_Execute instruction
    switch ( cpu.ir.F ) {
    case OP_F0:
      if (cpu.ir.T==0 && cpu.ir.S<2) { // Shifts
        int i;
        if ( cpu.M==0 ) { // Single Length
          if (cpu.ir.R==1) operand = (cpu.or = PACK_FLAGS);
          else if (cpu.ir.R==3) operand = (cpu.or = read_mem(operand_address));
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
            write_mem(operand_address, cpu.or);
          } else cpu.acc = TRUNC16(result);
        } else { // Double Length
          uint32_t double_operand;
          uint64_t quad_result;
          if (cpu.ir.R==1) cpu.or = PACK_FLAGS;
          else if (cpu.ir.R==3) cpu.or = read_mem(operand_address);
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
            write_mem(operand_address, cpu.or);
          } 
        }
      } else if ( cpu.ir.T==0 && cpu.ir.S>1) { //  Bit conditional jumps and Bit manipulation
        uint16_t bmask;
        uint16_t jump_address;
        if (cpu.ir.R==3) {
          operand = (cpu.or=read_mem(operand_address));
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
            write_mem(operand_address, TRUNC16(result));
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
      stack_pointer = read_mem( LSP);
      if ( cpu.ir.I==0 && cpu.ir.N==0) cpu.pc = TRUNC15(operand_address);
      write_mem(TRUNC15(stack_pointer+1), cpu.pc);
      write_mem(TRUNC15(stack_pointer+2), PACK_FLAGS);
      write_mem(LSP, TRUNC15(stack_pointer+2));
      cpu.pc = TRUNC15(operand_address);
      CLEAR_MULTI ;
      break;
    case OP_ICZ:
      cpu.or = 1+read_mem(operand_address);
      write_mem(operand_address, cpu.or);
      if (cpu.or!=0) cpu.pc=operand1_address ;
      break;
    case OP_JMP:
      cpu.pc = TRUNC15(operand_address);
      break;
    case OP_RTN_RTC:
      stack_pointer = read_mem( LSP);
      cpu.pc = TRUNC15(read_mem( stack_pointer-1));
      // restore bits 0-5 from stack, retain others
      if (cpu.ir.I == 0) {
        uint16_t flags, new_flags;
        flags = PACK_FLAGS;
        new_flags = read_mem( stack_pointer);
        flags = (new_flags & 0x3F) | (flags & 0x60) ;
        UNPACK_FLAGS(flags);        
      }
      write_mem(LSP, TRUNC15(stack_pointer-2));
      break;
    case OP_LDA:
    case OP_STO:
      if ( cpu.ir.F==OP_LDA) cpu.acc = read_mem(operand_address); 
      else write_mem(operand_address, cpu.acc);
      COMPUTE_ZERO(cpu.acc) ;
      COMPUTE_SIGN(cpu.acc) ; 
      CLEAR_OVERFLOW ;
      break;
    case OP_SBS:
    case OP_SUB:
    case OP_CMP:    
      cpu.or = read_mem(operand_address);
      result = cpu.or - cpu.acc;       
      if (cpu.M || cpu.ir.F==OP_SBS) result += cpu.C-1;
      COMPUTE_BORROW(result) ;
      COMPUTE_OVERFLOW(result, cpu.acc, cpu.or) ;
      COMPUTE_SIGN(result) ;
      COMPUTE_ZERO(result) ; 
      if (cpu.ir.F==OP_SBS) write_mem(operand_address, TRUNC16(result));
      else if (cpu.ir.F==OP_SUB) cpu.acc=TRUNC16(result);
      break;
    case OP_ADS: 
    case OP_ADD: 
      cpu.or = read_mem(operand_address);
      result = cpu.acc + cpu.or;
      if (cpu.M || cpu.ir.F==OP_ADS) result += cpu.C;
      COMPUTE_CARRY(result) ;
      COMPUTE_OVERFLOW(result, cpu.acc, cpu.or) ;
      COMPUTE_SIGN(result) ;
      COMPUTE_ZERO(result) ; 
      if (cpu.ir.F==OP_ADS) write_mem(operand_address, TRUNC16(result));
      else if (cpu.ir.F==OP_ADD) cpu.acc=TRUNC16(result);
      break;
    case OP_AND:
    case OP_NEQ:
      cpu.or = read_mem(operand_address);
      cpu.acc = (cpu.ir.F==OP_AND)? cpu.acc&cpu.or : cpu.acc^cpu.or;
      COMPUTE_ZERO(cpu.acc) ;
      COMPUTE_SIGN(cpu.acc) ;
      SET_CARRY ;
    default: break;
    }
  }
  if (HALT(cpu.ir)) return (int) cpu.ir.WORD; else return 0;  
}
