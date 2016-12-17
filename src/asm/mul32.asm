#define USE_SELFMODCODE 1           ; comment this to avoid self-modifying code !

;; Initialise Machine Here
        .equ  LSP     0x0000        ; Link Stack Pointer
        .equ  USP     0x0001        ; User Stack Pointer
        .equ  DATAPTR 0x0002        ; another pointer
        .equ  RESULTPTR 0x0003      ; pointer to results area
        .equ  TESTCTR 0x0004        ; first_item in data area is number of tests
        .equ  LPCTR   0x0005        ; generic loop var for top level of program
        .equ  CARRY   0x04          ; carry is bit 4 of the CR
        .equ  MULTI   0x05          ; multi-word flag is bit 5 of CR
        .equ  ZERO    0x01          ; zero bit in CR
        .equ  SIGN    0x03          ; sign bit in CR

        .equ  LINK_STACK  0x4001    ; initial value for link stack (must be ODD)
        .equ  USER_STACK  0x4100    ; initial value for user stack
        .equ  RESULT_AREA 0x5000    ; all results to get copied here
        .org 0x200

MULT_DATA:                          ; define some data to be used in the arithmetic
        #include "mul32.inc"



INIT:   .org 0x800                  ; 0x800 standard start address
        LDA ,LINK_STACK             ; initialize link stack pointer
        STO .LSP
        LDA ,USER_STACK             ; initialize user stack pointer
        STO .USP
        LDA ,RESULT_AREA-1          ; data pointer will be pre-incremented before use so subtract 1
        STO .RESULTPTR
        LDA ,MULT_DATA-1            ; data pointer will be pre-incremented before use so subtract 1
        STO .DATAPTR
        LDA /DATAPTR+                ; first item is number of tests (pairs of operands)
        SET CARRY CR
        SUB ,0
        STO .TESTCTR                ; store negative test count
NEXTTEST:
        LDA ,-0x4
        STO .LPCTR
RLOOP0:
        LDA /DATAPTR+
        STO /USP+
        STO /RESULTPTR+
        ICZ .LPCTR RLOOP0

        CAL .MUL32

        LDA ,-0x4
        STO .LPCTR
        ; 4 word result comes out in reverse order from stack so move stack pointer and read out with incrementing
        CLR MULTI CR
        LDA ,0x4
        SBS .USP
RLOOP1:
        LDA /USP+
        STO /RESULTPTR+
        ICZ .LPCTR RLOOP1
        ; reclaim the stack again now that the results are written out ..
        LDA ,0x4
        SBS .USP
        ICZ .TESTCTR NEXTTEST
        HALT  ,0x123

#include "mathlib.asm"
