;; Initialise Machine Here
	.equ  LSP     0x0000     	; Link Stack Pointer
	.equ  USP     0x0001     	; User Stack Pointer
	.equ  DATAPTR 0x0002     	; another pointer
	.equ  CARRY   0x04		; carry is bit 4 of the CR
	.equ  MULTI   0x05      	; multi-word flag is bit 4 of CR
	
	.equ  LINK_STACK 0x4001  	; initial value for link stack (must be ODD)
	.equ  USER_STACK 0x4100  	; initial value for user stack
	
	.org 0x200
MULT_DATA:				; define some data to be used in the arithmetic
        .word 0x0123, 0x0456
	.word 0x0789, 0x0ABC

INIT: 	.org 0x800			; 0x800 standard start address
	LDA ,LINK_STACK			; initialize link stack pointer
	STO .LSP
      	LDA ,USER_STACK			; initialize user stack pointer
      	STO .USP
        LDA  ,MULT_DATA-1       	; data pointer will be pre-incremented before use so subtract 1
        STO  DATAPTR
        LDA  /DATAPTR+
        STO  /USP+
        LDA  /DATAPTR+
        STO  /USP+
        CAL  .MUL16D             	; multiply 0x123 x 0x456 = 0x0004EDC2 and leave result on user stack

	LDA  /DATAPTR+
        STO  /USP+
        LDA  /DATAPTR+
        STO  /USP+
        CAL  .MUL16D             	; multiply 0x789 x 0xABC = 0x0050E29C and leave result on user stack

	CAL  .ADD32             	; add the two multiply results together .. and hopefully end up with 0x0055D05E on the stack
        LDA /USP-             		; see the result in accumulator in the trace ...
        LDA /USP-             		; see the result in accumulator in the trace ...

        HALT ,0x123

        ;; ------------------------------------------------------
        ;; ADD32 - add two 32b numbers and return 32b result
        ;;
        ;; Entry:
        ;;   USP   -> Operand B lo word
        ;;   USP-1 -> Operand B hi word
        ;;   USP-2 -> Operand A lo word
        ;;   USP-3 -> Operand A hi word
        ;; Exit:
        ;;   USP   -> result lo word
        ;;   USP-1 -> result hi word
        ;;
        ;; Local var. space: 2 words
        ;; ------------------------------------------------------
ADD32:
        LDA /USP-
        STO .A32_bb_lo        		; pop B lo and store
        LDA /USP-
        STO .A32_bb_hi         		; pop B hi and store
        LDA /USP-              		; pop A lo into ACC
        SET MULTI CR
        CLR CARRY CR
        ADS .A32_bb_lo          	; bb_lo = A_lo + B_lo
        LDA /USP-               	; pop A hi into ACC
        ADD .A32_bb_hi          	; ACC = A_hi + B_hi + C
        STO /USP+               	; push high result word
        LDA .A32_bb_lo
        STO /USP+               	; push low  result word
        RTN

A32_LVAR:
        .word 0x0000, 0x0000
        .equ A32_bb_lo  A32_LVAR
        .equ A32_bb_hi  A32_LVAR+1

        ;; ------------------------------------------------------
        ;; MUL16 - multiply two 16b numbers and return 32b result
        ;;
        ;; Entry:
        ;;   USP   -> Operand A
        ;;   USP-1 -> Operand B
        ;; Exit:
        ;;   USP   -> result lo word
        ;;   USP-1 -> result hi word
        ;;
        ;; Local var. space: 6 words
        ;; ------------------------------------------------------
MUL16D:
        LDA ,-15
        STO .M16_count

        LDA /USP-
        STO .M16_bb_lo
        LDA /USP-
        STO .M16_aa
        LDA ,0x0000
        STO .M16_bb_hi
        STO .M16_res_lo
        STO .M16_res_hi
        SET MULTI CR

M16_LOOP:
        JBC 0 M16_aa M16_SKIPADD
        CLR CARRY CR
        LDA .M16_bb_lo
        ADS .M16_res_lo
        LDA .M16_bb_hi
        ADS .M16_res_hi

M16_SKIPADD:
        CLR MULTI CR
        SRA 1 M16_aa
        SET MULTI CR
        LDA .M16_bb_lo
        SRA.D 16 A
        LDA .M16_bb_hi
        SLL.D 1 A
        STO .M16_bb_hi
        SLL.D 16 A
        STO .M16_bb_lo
        ICZ .M16_count M16_LOOP
        LDA .M16_res_hi
        STO /USP+
        LDA .M16_res_lo
        STO /USP+
        RTN

M16_LVAR:
        .word 0x0000, 0x0000, 0x0000, 0x0000
        .word 0x0000, 0x0000

        .equ M16_aa     M16_LVAR
        .equ M16_bb_lo  M16_LVAR+1
        .equ M16_bb_hi  M16_LVAR+2
        .equ M16_res_lo M16_LVAR+3
        .equ M16_res_hi M16_LVAR+4
        .equ M16_count  M16_LVAR+5
