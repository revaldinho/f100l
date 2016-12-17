#define USE_SELFMODCODE 1           ; comment this to avoid self-modifying code !

;; Initialise Machine Here
        .equ  LSP     0x0000        ; Link Stack Pointer
        .equ  USP     0x0001        ; User Stack Pointer
        .equ  DATAPTR 0x0002        ; another pointer
        .equ  CARRY   0x04          ; carry is bit 4 of the CR
        .equ  MULTI   0x05          ; multi-word flag is bit 5 of CR
        .equ  ZERO    0x01          ; zero bit in CR
        .equ  SIGN    0x03          ; sign bit in CR

        .equ  LINK_STACK 0x4001     ; initial value for link stack (must be ODD)
        .equ  USER_STACK 0x4100     ; initial value for user stack

        .org 0x200
MULT_DATA:                          ; define some data to be used in the arithmetic
        .word 0x0123, 0x0456
        .word 0x0789, 0x0ABC

INIT:   .org 0x800                  ; 0x800 standard start address
        LDA ,LINK_STACK             ; initialize link stack pointer
        STO .LSP
        LDA ,USER_STACK             ; initialize user stack pointer
        STO .USP

        JMP  .RUN_SQRT
        LDA  ,MULT_DATA-1           ; data pointer will be pre-incremented before use so subtract 1
        STO  DATAPTR
        LDA  /DATAPTR+
        STO  /USP+
        LDA  /DATAPTR+
        STO  /USP+
        CAL  .MUL16D                ; multiply 0x123 x 0x456 = 0x0004EDC2 and leave result on user stack

        LDA  /DATAPTR+
        STO  /USP+
        LDA  /DATAPTR+
        STO  /USP+
        CAL  .MUL16D                ; multiply 0x789 x 0xABC = 0x0050E29C and leave result on user stack
        CAL  .MUL32                 ;
        LDA /USP-                   ; see the result in accumulator in the trace ...
        LDA /USP-                   ; see the result in accumulator in the trace ...
        LDA /USP-                   ; see the result in accumulator in the trace ...
        LDA /USP-                   ; see the result in accumulator in the trace ...

        HALT  ,0x123
  RUN_SQRT:
        LDA ,0x4FFF
        STO /USP+
        LDA ,0xFFFF
        STO /USP+
        CAL .SQRT32
        LDA /USP-
        LDA /USP-
        LDA /USP-
        LDA /USP-

        HALT ,0x123


#include "mathlib.asm"
