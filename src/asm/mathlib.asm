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

         .equ UD32_Q_LO R10
         .equ UD32_Q_HI R11
         .equ UD32_R_LO R12
         .equ UD32_R_HI R13
         .equ UD32_N_LO R14
         .equ UD32_N_HI R15
         .equ UD32_D_LO R16
         .equ UD32_D_HI R17
         .equ UD32_LCTR R18

UDIV32:
         LDA /USP-
         STO UD32_N_LO
         LDA /USP-
         STO UD32_N_HI
         LDA /USP-
         STO UD32_D_LO
         LDA /USP-
         STO UD32_D_HI

         LDA ,0x0000
         STO UD32_Q_HI
         STO UD32_Q_LO
         STO UD32_R_HI
         STO UD32_R_LO

         LDA ,-32
         STO UD32_LCTR
         SET MULTI CR

UD32_LOOP:
         LDA UD32_Q_HI
         SLA.D 1 UD32_Q_LO
         STO UD32_Q_HI

         LDA UD32_R_HI
         SLA.D 1 UD32_R_LO
         STO UD32_R_HI

         JBC 15 UD32_N_HI UD32_SKIP
         SET 0 UD32_R_LO

UD32_SKIP:
         SET CARRY CR
         LDA UD32_D_LO
         CMP UD32_R_LO
         LDA UD32_D_HI
         CMP UD32_R_HI
         JBS SIGN CR UD32_SKIP2        ; JUMP if R < D

         SET CARRY CR
         LDA UD32_D_LO
         SBS UD32_R_LO
         LDA UD32_D_HI
         SBS UD32_R_HI
         SET 0 UD32_Q_LO

UD32_SKIP2:
         LDA UD32_N_HI
         SLA.D 1 UD32_N_LO
         STO UD32_N_HI

         ICZ UD32_LCTR UD32_LOOP

UD32_EXIT:
         LDA UD32_R_HI
         STO /USP+
         LDA UD32_R_LO
         STO /USP+
         LDA UD32_Q_HI
         STO /USP+
         LDA UD32_Q_LO
         STO /USP+
         RTN


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

        .equ S32_ROOT_LO   R0
        .equ S32_ROOT_HI   R1
        .equ S32_REM_LO    R2
        .equ S32_REM_HI    R3
        .equ S32_SUB_LO    R4
        .equ S32_SUB_HI    R5
        .equ S32_COUNT     R6
        .equ S32_LOOPCTR   R7
        .equ S32_M1_LO     R8
        .equ S32_M1_HI     R9

SQRT32:
        LDA ,0x0000
        STO S32_ROOT_LO
        STO S32_ROOT_HI
        LDA /USP-
        STO S32_REM_LO
        LDA /USP-
        STO S32_REM_HI
        JBS ZERO CR S32_EXIT
        JBS SIGN CR S32_EXIT

        LDA ,-15
        STO S32_COUNT
S32_OUTER:
        CLR MULTI CR
        LDA ,0x01
        STO S32_M1_LO
        LDA ,0x0000
        STO S32_M1_HI
        LDA S32_COUNT              ; negate S32_COUNT
        SUB ,0
        SLA 1 A                     ; loop_ctr = (count << 1)
        SUB ,0                      ; negate
        STO S32_LOOPCTR            ; save in loop counter as neg val for use with ICZ later
        SET MULTI CR
S32_INNER:                          ; m1 = m1 << S32_LOOPCTR
        LDA S32_M1_HI
        SLA.D 1 S32_M1_LO
        STO S32_M1_HI
        ICZ S32_LOOPCTR S32_INNER
        LDA S32_M1_HI
        STO /USP+
        LDA S32_M1_LO
        STO /USP+
        LDA S32_ROOT_HI
        STO /USP+
        LDA S32_ROOT_LO
        STO /USP+
        CAL .MUL32
        LDA /USP-
        STO S32_SUB_LO
        LDA /USP-
        STO S32_SUB_HI
        LDA /USP-                 ; throw away the two high words on the stack
        LDA /USP-

        SET MULTI CR
        LDA S32_M1_HI; m1 = m1 >> 2
        SRA.D 2 S32_M1_LO
        STO S32_M1_HI
        CLR CARRY CR              ;  subtrahend = subtrahend + m1
        LDA S32_M1_LO
        ADS S32_SUB_LO
        LDA S32_M1_HI
        ADS S32_SUB_HI
        LDA S32_ROOT_HI ; root = root << 1
        SLA.D 1 S32_ROOT_LO
        STO S32_ROOT_HI
                     ; now compare 32b subtrahend with rem
        SET CARRY CR
        LDA S32_SUB_LO
        CMP S32_REM_LO
        LDA S32_SUB_HI
        CMP S32_REM_HI
        JBC CARRY CR S32_NEXT
S32_ADJUST:
        ; CARRY bit already set here so no need to set explicitly for SBS
        LDA S32_SUB_LO
        SBS S32_REM_LO
        LDA S32_SUB_HI
        SBS S32_REM_HI
        CLR CARRY CR
        LDA ,0x1
        ADS S32_ROOT_LO
        LDA ,0x0
        ADS S32_ROOT_HI
S32_NEXT:
        ICZ S32_COUNT S32_OUTER

S32_EXIT:
        LDA S32_ROOT_HI
        STO /USP+
        LDA S32_ROOT_LO
        STO /USP+
        LDA S32_REM_HI
        STO /USP+
        LDA S32_REM_LO
        STO /USP+
        RTN

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
        .equ A32_bb_lo  R10
        .equ A32_bb_hi  R11

ADD32:
        LDA /USP-
        STO A32_bb_lo            ; pop B lo and store
        LDA /USP-
        STO A32_bb_hi             ; pop B hi and store
        LDA /USP-                  ; pop A lo into ACC
        SET MULTI CR
        CLR CARRY CR
        ADS A32_bb_lo            ; bb_lo = A_lo + B_lo
        LDA /USP-                 ; pop A hi into ACC
        ADD A32_bb_hi            ; ACC = A_hi + B_hi + C
        STO /USP+                 ; push high result word
        LDA A32_bb_lo
        STO /USP+                 ; push low  result word
        RTN

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
        ;; ------------------------------------------------------
        .equ M32_bb_00  R10
        .equ M32_bb_01  R11
        .equ M32_bb_02  R12
        .equ M32_bb_03  R13
        .equ M32_res_00 R14
        .equ M32_res_01 R15
        .equ M32_res_02 R16
        .equ M32_res_03 R17
        .equ M32_count  R18
        .equ M32_aa_lo  R19
        .equ M32_aa_hi  R20


MUL32:
        LDA ,-31
        STO M32_count

        LDA /USP-
        STO M32_aa_lo
        LDA /USP-
        STO M32_aa_hi
        LDA /USP-
        STO M32_bb_00
        LDA /USP-
        STO M32_bb_01
        LDA ,0x0000
        STO M32_res_00
        STO M32_res_01
        STO M32_res_02
        STO M32_res_03
        STO M32_bb_02
        STO M32_bb_03
        SET MULTI CR

M32_LOOP:
        JBC 0 M32_aa_lo M32_SKIPADD
        CLR CARRY CR
        LDA M32_bb_00
        ADS M32_res_00
        LDA M32_bb_01
        ADS M32_res_01
        LDA M32_bb_02
        ADS M32_res_02
        LDA M32_bb_03
        ADS M32_res_03

M32_SKIPADD:

        LDA M32_aa_hi
        SRA.D 1 M32_aa_lo
        STO M32_aa_hi
        ; Now shift the 64bit bb variable
        LDA M32_bb_03
        SLL.D 1 M32_bb_02
        STO M32_bb_03
        ; check the MSB of word 01 and if set need to add 1 into word O2, ie it is shifted into the next word
        JBC 15 M32_bb_01 M32_SKIPADJ
        CLR CARRY CR
        LDA ,0x1
        ADS M32_bb_02
M32_SKIPADJ:
        LDA M32_bb_01
        SLL.D 1 M32_bb_00
        STO M32_bb_01
        ICZ M32_count M32_LOOP
        LDA M32_res_03
        STO /USP+
        LDA M32_res_02
        STO /USP+
        LDA M32_res_01
        STO /USP+
        LDA M32_res_00
        STO /USP+
        RTN


        ;; ------------------------------------------------------
        ;; MUL16 - multiply two 16b numbers and return 32b result
        ;;
        ;; Version uses local variables
        ;;
        ;; Entry:
        ;;   USP   -> Operand A
        ;;   USP-1 -> Operand B
        ;; Exit:
        ;;   USP   -> result lo word
        ;;   USP-1 -> result hi word
        ;;
        ;; Use registers R10-R15
        ;; ------------------------------------------------------

        .equ M16L_aa     R10
        .equ M16L_bb_lo  R11
        .equ M16L_bb_hi  R12
        .equ M16L_res_lo R13
        .equ M16L_res_hi R14
        .equ M16L_count  R15
        
MUL16:
        LDA ,-15
        STO .M16L_count

        LDA /USP-
        STO M16L_bb_lo
        LDA /USP-
        STO M16L_aa
        LDA ,0x0000
        STO M16L_bb_hi
        STO M16L_res_lo
        STO M16L_res_hi
        SET MULTI CR

M16L_LOOP:
        JBC 0 M16L_aa M16L_SKIPADD
        CLR CARRY CR
        LDA M16L_bb_lo
        ADS M16L_res_lo
        LDA M16L_bb_hi
        ADS M16L_res_hi
        LDA M16L_res_hi    
M16L_SKIPADD:
        CLR MULTI CR
        SRA 1 M16L_aa
        SET MULTI CR
        LDA .M16L_bb_hi
        SLL.D 1 M16L_bb_lo
        STO M16L_bb_hi
        ICZ M16L_count M16L_LOOP
        LDA M16L_res_hi
        STO /USP+
        LDA M16L_res_lo
        STO /USP+
        RTN

