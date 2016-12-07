
      ; initialise Machine Here

      .equ  LSP     0x0000     ; Link Stack Pointer
      .equ  USP     0x0001     ; User Stack Pointer
      .equ  LOOPCTR 0x0010

      .equ  LINK_STACK 0x4001  ; initial value for link stack (must be ODD)
      .equ  USER_STACK 0x4100  ; initial value for user stack


INIT: .org 0x800
      LDA ,LINK_STACK
      STO .LSP
      LDA ,USER_STACK
      STO .USP


PROG_START:
    	AND ,0x0000  		; zero accumulator
    	NEQ ,0x00FF             ; invert half of it
    	SUB ,0x0001
    	ADD ,0x0001
    	ADD ,0x0001
    	LDA ,-5
    	STO .LOOPCTR


LOOP:	JBS 0 A OVERHERE
NEXT: SUB ,0x0002             ; subtract A from 2
NEXT2: JBC 0 A OVERHERE2
  	CAL .SUBROUT1
	SRA 4 A
	SRL 4 A
	SRA 4 A
	SRL 4 A
	SLA 2 A
	SLL 2 A
	SLE 10 A
      ICZ LOOPCTR LOOP
      HALT ,0x123

OVERHERE:
      JSC 0 A LOOP
OVERHERE2:
      JCS 0 A NEXT2

SUBROUT1:
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
      RTN
