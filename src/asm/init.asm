;; Initialise Machine Here
	.equ  LSP     0x0000        ; Link Stack Pointer
	.equ  USP     0x0001        ; User Stack Pointer
	.equ  R0      0x0002        ; 16 Local variable pointers
	.equ  R1      R0 + 1
	.equ  R2      R0 + 2
	.equ  R3      R0 + 3
	.equ  R4      R0 + 4
	.equ  R5      R0 + 5
	.equ  R6      R0 + 6
	.equ  R7      R0 + 7
	.equ  R8      R0 + 8
	.equ  R9      R0 + 9
	.equ  R10     R0 + 10
	.equ  R11     R0 + 11
	.equ  R12     R0 + 12
	.equ  R13     R0 + 13
	.equ  R14     R0 + 14
	.equ  R15     R0 + 15
	.equ  R16     R0 + 16
	.equ  R17     R0 + 17
	.equ  R18     R0 + 18
	.equ  R19     R0 + 19
	.equ  R20     R0 + 20
	        
	.equ  TMPVAR  50
	.equ  DATAPTR 51      ; another pointer
	.equ  RESULTPTR 52       ; pointer to results area
	.equ  TESTCTR 53        ; first_item in data area is number of tests
	.equ  LPCTR   54        ; generic loop var for top level of program
	
	.equ  CARRY   0x04          ; carry is bit 4 of the CR
	.equ  MULTI   0x05          ; multi-word flag is bit 5 of CR
	.equ  ZERO    0x01          ; zero bit in CR
	.equ  SIGN    0x03          ; sign bit in CR
	
	.equ  LINK_STACK  0x3601    ; initial value for link stack (must be ODD)
	.equ  USER_STACK  0x3800    ; initial value for user stack
	.equ  RESULT_AREA 0x5000    ; all results to get copied here246:

INIT:   .org 0x800                  ; 0x800 standard start address
        LDA ,LINK_STACK             ; initialize link stack pointer
        STO .LSP
        LDA ,USER_STACK             ; initialize user stack pointer
        STO .USP
