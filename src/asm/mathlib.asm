; Define a Load Operand (LDOR) alias to be the CMP instruction - flags are trashed but acc is preserved
#define  LDOR  CMP

; ------------------------------------
; UDIV32
;
; Unsigned integer 32 bit division of two numbers
; returning quotient and remainder.
; ------------------------------------
; Entry: USP   -> Numerator (low word)
;        USP-1 -> Numerator (high word)
;        USP-2 -> Denominator   (low word)
;        USP-3 -> Denominator   (high word)
;
; Exit:  USP   -> Quotient (low word)
;        USP-1 -> Quotient (high word)
;        USP-2 -> Remainder (low word)
;        USP-3 -> Remainder (high word)
;
; Local var space: 9 words
; ------------------------------------
; Algorithm
; ------------------------------------
;   def div32(N,D):
;       if N==0 :
;           return(0,0)
;       Q = 0
;       R = 0
;       for i in range (-31, 1 ):
;           Q <<= 1
;           R <<= 1
;           if bit (N,31) :
;               R = bitset(R,0)
;           if R >= D:
;               R = R - D
;               Q = bitset(Q,0)
;           N <<= 1
;       return (Q,R)
; ------------------------------------

UDIV32:
         LDA /USP-
         STO .UD32_N_LO
         LDA /USP-
         STO .UD32_N_HI
         LDA /USP-
         STO .UD32_D_LO
         LDA /USP-
         STO .UD32_D_HI

         LDA ,0x0000
         STO .UD32_Q_HI
         STO .UD32_Q_LO
         STO .UD32_R_HI
         STO .UD32_R_LO

         LDA ,-32
         STO .UD32_LCTR
         SET MULTI CR

UD32_LOOP:
         LDOR .UD32_Q_LO
         LDA .UD32_Q_HI
         SLA.D 1 A
         STO .UD32_Q_HI
         SLA.D 16 A
         STO .UD32_Q_LO

         LDOR .UD32_R_LO
         LDA .UD32_R_HI
         SLA.D 1 A
         STO .UD32_R_HI
         SLA.D 16 A
         STO .UD32_R_LO

         JBC 15 UD32_N_HI UD32_SKIP
         SET 0 UD32_R_LO

UD32_SKIP:
         SET CARRY CR
         LDA .UD32_D_LO
         CMP .UD32_R_LO
         LDA .UD32_D_HI
         CMP .UD32_R_HI
         JBS SIGN CR UD32_SKIP2        ; JUMP if R < D

         SET CARRY CR
         LDA .UD32_D_LO
         SBS .UD32_R_LO
         LDA .UD32_D_HI
         SBS .UD32_R_HI
         SET 0 UD32_Q_LO

UD32_SKIP2:
         LDOR .UD32_N_LO
         LDA .UD32_N_HI
         SLA.D 1 A
         STO .UD32_N_HI
         SLA.D 16 A
         STO .UD32_N_LO

         ICZ .UD32_LCTR UD32_LOOP

UD32_EXIT:
         LDA .UD32_R_HI
         STO /USP+
         LDA .UD32_R_LO
         STO /USP+
         LDA .UD32_Q_HI
         STO /USP+
         LDA .UD32_Q_LO
         STO /USP+
         RTN

UD32_LVAR:
         .word 0x0000, 0x0000, 0x0000, 0x0000
         .word 0x0000, 0x0000, 0x0000, 0x0000
         .word 0x0000

         .equ UD32_Q_LO UD32_LVAR
         .equ UD32_Q_HI UD32_LVAR + 1
         .equ UD32_R_LO UD32_LVAR + 2
         .equ UD32_R_HI UD32_LVAR + 3
         .equ UD32_N_LO UD32_LVAR + 4
         .equ UD32_N_HI UD32_LVAR + 5
         .equ UD32_D_LO UD32_LVAR + 6
         .equ UD32_D_HI UD32_LVAR + 7
         .equ UD32_LCTR UD32_LVAR + 8

        ;; ------------------------------------------------------
        ;; SQRT32 - Find square root of an integer numbers up to
        ;;          ~ 2^30
        ;;
        ;; Entry:
        ;;   USP   -> Operand lo word
        ;;   USP-1 -> Operand hi word
        ;; Exit:
        ;;   USP   -> remainder lo word
        ;;   USP-1 -> remainder hi word
        ;;   USP-2 -> root lo word
        ;;   USP-3 -> root hi word
        ;;
        ;; Local var. space: 10 words
        ;; ------------------------------------------------------
        ;;
        ;; Algorithm in Python pseudo asm style
        ;; def sqrt32 (a):
        ;;   root  = 0
        ;;   rem   = a
        ;;   if a >0:
        ;;     count = 15
        ;;     while count != 0:
        ;;       # m1 = 1 <<(count << 1)
        ;;       m1 = 1
        ;;       loop_ctr = (count << 1)
        ;;       while loop_ctr != 0:
        ;;         m1 = m1 << 1
        ;;         loop_ctr -= 1
        ;;       subtrahend = root * m1
        ;;       m1 = m1 >> 2
        ;;       subtrahend = subtrahend + m1
        ;;       root = root << 1
        ;;       if rem >= subtrahend :
        ;;          rem = rem - subtrahend
        ;;          root += 1
        ;;       count -= 1
        ;;
        ;;   return ( root, rem )

SQRT32:
        LDA ,0x0000
        STO .S32_ROOT_LO
        STO .S32_ROOT_HI
        LDA /USP-
        STO .S32_REM_LO
        LDA /USP-
        STO .S32_REM_HI
        JBS ZERO CR S32_EXIT
        JBS SIGN CR S32_EXIT

        LDA ,-15

        STO .S32_COUNT
S32_OUTER:
        CLR MULTI CR
        LDA ,0x01
        STO .S32_M1_LO
        LDA ,0x0000
        STO .S32_M1_HI
        LDA .S32_COUNT              ; negate S32_COUNT
        SUB ,0
        SLA 1 A                     ; loop_ctr = (count << 1)
#ifdef USE_SELFMODCODE
        ADD .S32_SMC_TEMPLATE       ; add loop_ctr into bitfield of SHIFT instruction from template
        STO .S32_SMC_TARGET         ; install modified instruction in execution path
#else
        SUB ,0                      ; negate
        STO .S32_LOOPCTR            ; save in loop counter as neg val for use with ICZ later
#endif
        SET MULTI CR
        LDA .S32_M1_LO
S32_INNER:                          ; m1 = m1 << S32_LOOPCTR
        SRA.D 16 A
        LDA .S32_M1_HI
#ifdef USE_SELFMODCODE
S32_SMC_TARGET:
        SLA.D 0 A                   ; self-modifying code location - bitfield (5 lsbs will be modded!)
#else
        SLA.D 1 A
#endif
        STO .S32_M1_HI
        SLA.D 16 A
        STO .S32_M1_LO
#ifdef USE_SELFMODCODE
#else
        ICZ .S32_LOOPCTR S32_INNER
#endif
        LDA .S32_M1_HI
        STO /USP+
        LDA .S32_M1_LO
        STO /USP+
        LDA .S32_ROOT_HI
        STO /USP+
        LDA .S32_ROOT_LO
        STO /USP+
        CAL .MUL32
        LDA /USP-
        STO .S32_SUB_LO
        LDA /USP-
        STO .S32_SUB_HI
        LDA /USP-                 ; throw away the two high words on the stack
        LDA /USP-

        SET MULTI CR
        LDOR .S32_M1_LO            ; m1 = m1 >> 2
        LDA .S32_M1_HI
        SRA.D 2 A
        STO .S32_M1_HI
        SLA.D 16 A
        STO .S32_M1_LO
        CLR CARRY CR              ;  subtrahend = subtrahend + m1
        ADS .S32_SUB_LO
        LDA .S32_M1_HI
        ADS .S32_SUB_HI
        LDOR .S32_ROOT_LO          ; root = root << 1
        LDA .S32_ROOT_HI
        SLA.D 1 A
        STO .S32_ROOT_HI
        SLA.D 16 A
        STO .S32_ROOT_LO

                     ; now compare 32b subtrahend with rem
        SET CARRY CR
        LDA .S32_SUB_LO
        CMP .S32_REM_LO
        LDA .S32_SUB_HI
        CMP .S32_REM_HI
        JBC CARRY CR S32_NEXT
S32_ADJUST:
        ; CARRY bit already set here so no need to set explicitly for SBS
        LDA .S32_SUB_LO
        SBS .S32_REM_LO
        LDA .S32_SUB_HI
        SBS .S32_REM_HI
        CLR CARRY CR
        LDA ,0x1
        ADS .S32_ROOT_LO
        LDA ,0x0
        ADS .S32_ROOT_HI
S32_NEXT:
        ICZ .S32_COUNT S32_OUTER

S32_EXIT:
        LDA .S32_ROOT_HI
        STO /USP+
        LDA .S32_ROOT_LO
        STO /USP+
        LDA .S32_REM_HI
        STO /USP+
        LDA .S32_REM_LO
        STO /USP+
        RTN

S32_SMC_TEMPLATE:
        SLA.D 0 A     ; dummy shift by zero will have bit field incremented and used in code
S32_LVAR:
        .word 0x0000, 0x0000, 0x0000, 0x0000
        .word 0x0000, 0x0000, 0x0000, 0x0000
        .word 0x0000, 0x0000

        .equ S32_ROOT_LO   S32_LVAR
        .equ S32_ROOT_HI   S32_LVAR+1
        .equ S32_REM_LO    S32_LVAR+2
        .equ S32_REM_HI    S32_LVAR+3
        .equ S32_SUB_LO    S32_LVAR+4
        .equ S32_SUB_HI    S32_LVAR+5
        .equ S32_COUNT     S32_LVAR+6
        .equ S32_LOOPCTR   S32_LVAR+7
        .equ S32_M1_LO     S32_LVAR+8
        .equ S32_M1_HI     S32_LVAR+9




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
        STO .A32_bb_lo            ; pop B lo and store
        LDA /USP-
        STO .A32_bb_hi             ; pop B hi and store
        LDA /USP-                  ; pop A lo into ACC
        SET MULTI CR
        CLR CARRY CR
        ADS .A32_bb_lo            ; bb_lo = A_lo + B_lo
        LDA /USP-                 ; pop A hi into ACC
        ADD .A32_bb_hi            ; ACC = A_hi + B_hi + C
        STO /USP+                 ; push high result word
        LDA .A32_bb_lo
        STO /USP+                 ; push low  result word
        RTN

A32_LVAR:
        .word 0x0000, 0x0000
        .equ A32_bb_lo  A32_LVAR
        .equ A32_bb_hi  A32_LVAR+1


        ;; ------------------------------------------------------
        ;; MUL32 - multiply two 32b numbers and return 64b result
        ;;
        ;; Entry:
        ;;   USP   -> Operand A lo
        ;;   USP-1 -> Operand A hi
        ;;   USP-2 -> Operand B lo
        ;;   USP-3 -> Operand B hi
        ;; Exit:
        ;;   USP     -> result 00 (lo) word
        ;;   USP-1   -> result 01 word
        ;;   USP-2   -> result 02 word
        ;;   USP-3   -> result 03 (hi) word
        ;;
        ;; Local var. space: 12 words
        ;; ------------------------------------------------------
MUL32:
        LDA ,-31
        STO .M32_count

        LDA /USP-
        STO .M32_aa_lo
        LDA /USP-
        STO .M32_aa_hi
        LDA /USP-
        STO .M32_bb_00
        LDA /USP-
        STO .M32_bb_01
        LDA ,0x0000
        STO .M32_res_00
        STO .M32_res_01
        STO .M32_res_02
        STO .M32_res_03
        STO .M32_bb_02
        STO .M32_bb_03
        SET MULTI CR

M32_LOOP:
        JBC 0 M32_aa_lo M32_SKIPADD
        CLR CARRY CR
        LDA .M32_bb_00
        ADS .M32_res_00
        LDA .M32_bb_01
        ADS .M32_res_01
        LDA .M32_bb_02
        ADS .M32_res_02
        LDA .M32_bb_03
        ADS .M32_res_03

M32_SKIPADD:

        LDOR .M32_aa_lo
        LDA .M32_aa_hi
        SRA.D 1 A
        STO .M32_aa_hi
        SLA.D 16 A
        STO .M32_aa_lo
        ; Now shift the 64bit bb variable
        LDOR .M32_bb_02
        LDA .M32_bb_03
        SLL.D 1 A
        STO .M32_bb_03
        SLL.D 16 A
        STO .M32_bb_02
        ; check the MSB of word 01 and if set need to add 1 into word O2, ie it is shifted into the next word
        JBC 15 M32_bb_01 M32_SKIPADJ
        CLR CARRY CR
        LDA ,0x1
        ADS .M32_bb_02
M32_SKIPADJ:
        LDOR .M32_bb_00
        LDA .M32_bb_01
        SLL.D 1 A
        STO .M32_bb_01
        SLL.D 16 A
        STO .M32_bb_00
        ICZ .M32_count M32_LOOP
        LDA .M32_res_03
        STO /USP+
        LDA .M32_res_02
        STO /USP+
        LDA .M32_res_01
        STO /USP+
        LDA .M32_res_00
        STO /USP+
        RTN

M32_LVAR:
        .word 0x0000, 0x0000, 0x0000, 0x0000
        .word 0x0000, 0x0000, 0x0000, 0x0000
        .word 0x0000, 0x0000, 0x0000, 0x0000

        .equ M32_aa_lo  M32_LVAR
        .equ M32_aa_hi  M32_LVAR+1
        .equ M32_bb_00  M32_LVAR+2
        .equ M32_bb_01  M32_LVAR+3
        .equ M32_bb_02  M32_LVAR+4
        .equ M32_bb_03  M32_LVAR+5
        .equ M32_res_00 M32_LVAR+6
        .equ M32_res_01 M32_LVAR+7
        .equ M32_res_02 M32_LVAR+8
        .equ M32_res_03 M32_LVAR+9
        .equ M32_count  M32_LVAR+10



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
MUL16:
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
        LDOR .M16_bb_lo
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
