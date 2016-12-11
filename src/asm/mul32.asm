	  			; initialise Machine Here

	.equ  LSP     0x0000     ; Link Stack Pointer
	.equ  USP     0x0001     ; User Stack Pointer
	.equ  LOOPCTR 0x0010
	.equ  CARRY   0x04	; carry is bit 4 of the CR
	.equ  MULTI   0x05      ; multi-word flag is bit 4 of CR

	.equ  LINK_STACK 0x4001  ; initial value for link stack (must be ODD)
	.equ  USER_STACK 0x4100  ; initial value for user stack


	.org 0x200

bb_lo:	.word 0x0000
bb_hi:	.word 0x0000   	
rst_lo:	.word 0x0000
rst_hi:	.word 0x0000   	
aa_lo:	.word 0x0000
counter: .word 0x0000

	
INIT: .org 0x800
      LDA ,LINK_STACK
      STO .LSP
      LDA ,USER_STACK
      STO .USP


	

PROG_START:
	LDA ,0x0201
	STO /USP+
	LDA ,0x1999
	STO /USP+
	CAL .MULTIPLY16D
	halt


MULTIPLY16D:
       LDA /USP-
       sto  .aa_lo
       LDA /USP-
       sto .bb_lo
       lda ,0x0000
       sto .bb_hi
       
       lda ,-15
       sto .counter   
       SET MULTI CR

M16D_NEXTBIT:

       JBC 0 aa_lo M16D_SKIPADD
       CLR CARRY CR
       LDA .bb_lo
       ADS .rst_lo
       LDA .bb_hi
       ADS .rst_hi

M16D_SKIPADD:
	; adjust operands now
       CLR MULTI CR	
       SRA 1 aa_lo
       SET MULTI CR
       LDA .bb_lo
       SRA.D 16 A    ; get bb_lo into OR
       LDA .bb_hi     
       SLA.D  1 A     ; do shift of low and high together
       STO .bb_hi
       SLA.D 16 A     ; get shifted low part
       STO .bb_lo

       icz  .counter M16D_NEXTBIT

       ; finish with result in rst_lo, rst_hi
       lda .rst_lo
       STO /USP+
       lda .rst_hi
       STO /USP+
       rtn
