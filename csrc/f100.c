
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <unistd.h>

#include "f100.h"

#define F100MEMSZ 65536

// Global Variables
static bool     verbose = false;
static bool     memtron;
static bool     tron;
static bool     regtron;
static cpu_t    cpu;

// CPU Functions
cpu_t *f100_init( bool trace_on, bool memtrace_on, bool regtrace_on) {
  cpu.mem = (uint16_t *) malloc(F100MEMSZ * sizeof(uint16_t));
  cpu.stats.mwrites = 0;
  cpu.stats.mreads = 0;
  cpu.stats.instrs = 0;
  memtron = memtrace_on;
  tron = trace_on;
  regtron = regtrace_on;
  return &cpu;
}

static uint16_t read_mem( uint16_t addr )  {
  uint16_t data = cpu.mem[addr];
  if (addr==0x7EF8) data=0x0040; // Always return status ready for tube register
  if (memtron) printf("LOAD  : addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);
  cpu.stats.mreads++;
  return data;
}

static void write_mem( uint16_t addr, uint16_t data ) {
  if (memtron) printf("STORE : addr=0x%04X (%6d) data=0x%04X (%6d)\n", addr, addr, data, data);
  cpu.stats.mwrites++;
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
    if (regtron) {
      printf("# %2s  : %4s : %4s %4s : %7s %s", "PC", "OP", "ACC", "OR", "FMCSVZI", ":  LSP  USP :");
      for (int i=0; i<16 ; i++ ) {
        printf("  r%02d", i);
      }
      puts(": Instruction");
      printf("# ---------------------------------------------------------------------------");
      puts("------------------------------------------------------------------------");
    } else { 
      printf("# %2s  : %4s : %4s %4s : %7s %s\n", "PC", "OP", "ACC", "OR", "FMCSVZI", ":  LSP (LSP-2)(LSP-1)(LSP-0): Instruction");
      puts("# ---------------------------------------------------------------------------");      
    }

  } else {
    char *mnem = mnemonic[cpu.ir.F];
      printf("%04X  : %04X : %04X %04X : %x%x%x%d%d%d%d : %04X %04X :", cpu.pc, cpu.ir.WORD, cpu.acc, cpu.or,\
             cpu.F, cpu.M, cpu.C, cpu.S, cpu.V, cpu.Z, cpu.I, cpu.mem[LSP], cpu.mem[1]);    
    if (regtron) {
      for ( int i=2;i<(2+16); i++) {
        printf(" %04X", cpu.mem[i]);
      }
      printf(": %s\n", mnem);
    } else {
      printf(" %04X  %04X   %04X   %04X  : %s\n", cpu.mem[LSP], cpu.mem[TRUNC15(cpu.mem[LSP]-2)], cpu.mem[TRUNC15(cpu.mem[LSP]-1)], cpu.mem[TRUNC15(cpu.mem[LSP])], mnem);
    }
  }
}

void f100_reset(bool adSel ) {
  cpu.stats.mwrites = 0;
  cpu.stats.mreads = 0;
  cpu.stats.instrs = 0;
  cpu.pc = (adSel) ? 2048 : 16384 ;
}

int32_t f100_exec(int max_instr ){
  uint32_t result;
  uint16_t stack_pointer;
  uint16_t pointer;
  uint16_t operand_address;
  uint16_t operand1_address;
  uint16_t operand;

  int32_t i;


  for ( i=0; (!max_instr)||(i<max_instr) ; i++ ) {
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
      operand_address = pointer;
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
        if (cpu.ir.R==1) cpu.or = PACK_FLAGS;
        else if (cpu.ir.R==3) cpu.or = read_mem(operand_address);
        if ( cpu.M==0 ) { // Single Length
          uint8_t  places = cpu.ir.B;
          if (cpu.ir.R==1 || cpu.ir.R==3) operand = cpu.or;
          else operand = cpu.acc;
          // S=Direction, J=0,1:Arith, 2:Logical, 3:Rotate, B=Num Places
          if (cpu.ir.S) {
            result = TRUNC16(operand<<places);
          } else if (cpu.ir.J<2) {
            result = TRUNC16((int16_t)operand>>places);
          } else {
            result = TRUNC16(operand>>places);
          }
          COMPUTE_SV(result,operand,operand);
          cpu.acc = TRUNC16(result);          
          if (cpu.ir.R==1) {
            // Overwrite flags with the shifted value
            UNPACK_FLAGS(cpu.acc);
          } 
        } else { // Double Length
          uint8_t  places = (((cpu.ir.J&1)<<4) + cpu.ir.B);
          // Assemble acc+OR into 32bit result register to start shifting
          result = (cpu.acc<<16) | cpu.or;
          // S=Direction, J=0,1:Arith, 2:Logical, B=Num Places
          if (cpu.ir.S) {
            result = (result << places) & 0xFFFFFFFF;
          } else if ( cpu.ir.J<2 ) {
            // Shift as a signed value to get arithmetic shift
            result =  ((int32_t) result>>places) & 0xFFFFFFFF;
          } else {
            result = result>>places;
          }
          COMPUTE_SV(TRUNC16(result>>16), cpu.acc, cpu.acc);
          cpu.acc = TRUNC16((result>>16));
          cpu.or = TRUNC16(result);
          if (cpu.ir.R==1) {
            // Overwrite flags with the shifted value, low word (in OR)
            UNPACK_FLAGS(cpu.or);
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
            cpu.pc = (operand & bmask)? jump_address: cpu.pc;
          }
        }
        if (cpu.ir.J>1) { // Set or clear bit
          result = ( cpu.ir.J==2) ? (operand | bmask) : (operand & ~bmask);
          if (cpu.ir.R==3) {
            cpu.or = TRUNC16(result);
            write_mem(operand_address, cpu.or);
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
      cpu.acc = 1+read_mem(operand_address);
      write_mem(operand_address, cpu.acc);
      if (cpu.acc!=0) cpu.pc=operand1_address ;
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
        new_flags = read_mem(stack_pointer);
        flags = (new_flags & 0x3F) | (flags & 0xC0) ;
        UNPACK_FLAGS(flags);
      }
      write_mem(LSP, TRUNC15(stack_pointer-2));
      break;
    case OP_LDA:
      cpu.acc = read_mem(operand_address);
      COMPUTE_SZ(cpu.acc) ;
      CLEAR_OVERFLOW ;
      break;
    case OP_STO:
      write_mem(operand_address, cpu.acc);
      COMPUTE_SZ(cpu.acc) ;
      CLEAR_OVERFLOW ;
      break;
    case OP_SBS:
    case OP_SUB:
    case OP_CMP:
      cpu.or = read_mem(operand_address);
      result = cpu.or - cpu.acc;
      if (cpu.M) result += cpu.C-1;
      COMPUTE_BORROW(result) ;
      COMPUTE_SVZ_SUB(result, cpu.or, cpu.acc) ;        
      if (cpu.ir.F==OP_SBS) write_mem(operand_address, TRUNC16(result));
      if (cpu.ir.F!=OP_CMP) cpu.acc=TRUNC16(result);
      break;
    case OP_ADS:
    case OP_ADD:
      cpu.or = read_mem(operand_address);
      result = cpu.acc + cpu.or;
      if (cpu.M) result += cpu.C;
      COMPUTE_CARRY(result) ;
      COMPUTE_SVZ_ADD(result, cpu.acc, cpu.or) ;
      cpu.acc=TRUNC16(result);      
      if (cpu.ir.F==OP_ADS) write_mem(operand_address, TRUNC16(result));
      break;
    case OP_AND:
      cpu.or = read_mem(operand_address);
      cpu.acc = cpu.acc&cpu.or;
      SET_CARRY ;
      COMPUTE_SZ(cpu.acc);
      break;
    case OP_NEQ:
      cpu.or = read_mem(operand_address);
      cpu.acc = cpu.acc^cpu.or;
      CLEAR_CARRY;
      COMPUTE_SZ(cpu.acc);
      break;  
   default: break;
    }
  }
  cpu.stats.instrs += i+1;
  if (HALT(cpu.ir)) printf("CPU Halted with halt number 0x%04X\n", cpu.ir.WORD & 0x03FF);
  return (i+1);
}
