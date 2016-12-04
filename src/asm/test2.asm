
  ; initialise LSP here
  .org 0
  .word     0x1001 ; must make the LSP an odd number

	
	.org 0x800

	.equ LOOPCTR 0x010 ;
	AND ,0x0000  		; zero accumulator
	NEQ ,0x00FF             ; invert half of it
	SUB ,0x0001
	ADD ,0x0001
	ADD ,0x0001

	LDA ,-5
	STO .LOOPCTR
LOOP:	SUB ,0x0001             ; subtract 1
	  CAL .SUBROUT1
    ICZ LOOPCTR LOOP
HALT ,0x123

SUBROUT1:
	       NEQ ,0x00FF
				 RTN
