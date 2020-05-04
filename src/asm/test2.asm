
      ; initialise Machine Here

      .equ  LSP     0x0000     ; Link Stack Pointer
      .equ  USP     0x0001     ; User Stack Pointer
      .equ  LOOPCTR 0x0010

      .equ  LINK_STACK 0x4001  ; initial value for link stack (must be ODD)
      .equ  USER_STACK 0x4100  ; initial value for user stack

        .equ  R0      0x0002
        .equ  R1      0x0003
        .equ  R2      0x0004
        .equ  R3      0x0005        
        .equ  R4      0x0006
        
INIT: .org 0x800
      LDA ,LINK_STACK
      STO .LSP
      LDA ,USER_STACK
      STO .USP


PROG_START:
        SET     5 CR
        LDA     ,0x1234
        STO     R0
        LDA     ,0x8567
        SLL.D   5 R0
        LDA     ,0x1234
        STO     R0
        LDA     ,0x8567
        SLA.D   5 R0
        LDA     ,0x1234
        STO     R0
        LDA     ,0x8567
        SRL.D   5 R0
        LDA     ,0x1234
        STO     R0
        LDA     ,0x8567
        SRA.D   5 R0
        SLA.D   16 CR        
        AND ,0x0000  		; zero accumulator
    	NEQ ,0x00FF             ; invert half of it
    	SUB ,0x0001
    	ADD ,0x0001
    	ADD ,0x0001
    	LDA ,-5
        LDA ,0x0123
	SLE 10 A
        SRE 10 A
	NEQ ,0x00FF
	LDA ,0xFFFF
	CLR 0 A
	CLR 1 A
	CLR 2 A
	CLR 3 A
	SET 0 A
	SET 1 A
	SET 2 A
	SET 3 A
	SET 6 CR
	CLR 6 CR
	SET 5 CR
	CLR 5 CR
	SET 4 CR
	CLR 4 CR
        HALT ,0x123

        LDA     ,1
        SBS     R4
        LDA     /R4-
