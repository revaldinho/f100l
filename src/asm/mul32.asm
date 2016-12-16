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

        CAL  .ADD32                 ; add the two multiply results together .. and hopefully end up with 0x0055D05E on the stack
        LDA /USP-                   ; see the result in accumulator in the trace ...
        LDA /USP-                   ; see the result in accumulator in the trace ...

        HALT  ,0x123
  RUN_SQRT:
        LDA ,0x1000
        STO /USP+
        LDA ,0x0000
        STO /USP+
        CAL .SQRT32
        LDA /USP-
        LDA /USP-
        LDA /USP-
        LDA /USP-

        HALT ,0x123

        ;; ------------------------------------------------------
        ;; SQRT32 - Find square root of an integer number less than 2**30
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
        ;;
        ;;   for a in (89,102,256,512, 15000, 28000, 32768, 65536, 128456, 1073676289, 1073741824):
        ;;     print a, sqrt32(a)
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
        SUB ,0                      ; negate
        STO .S32_LOOPCTR            ; save in loop counter as neg val for use with ICZ later
        SET MULTI CR
        LDA .S32_M1_LO
S32_INNER:                          ; m1 = m1 << S32_LOOPCTR
        SRA.D 16 A
        LDA .S32_M1_HI
        SLA.D 1 A
        STO .S32_M1_HI
        SLA.D 16 A
        STO .S32_M1_LO
        ICZ .S32_LOOPCTR S32_INNER

        LDA .S32_ROOT_LO
        STO /USP+
        LDA .S32_M1_LO
        STO /USP+
        CAL .MUL16D
        LDA /USP-
        STO .S32_SUB_LO
        LDA /USP-
        STO .S32_SUB_HI

        SET MULTI CR
        LDA .S32_M1_LO            ; m1 = m1 >> 2
        SRA.D 16 A
        LDA .S32_M1_HI
        SRA.D 2 A
        STO .S32_M1_HI
        SLA.D 16 A
        STO .S32_M1_LO
        CLR CARRY CR              ;  subtrahend = subtrahend + m1
        ADS .S32_SUB_LO
        LDA .S32_M1_HI
        ADS .S32_SUB_HI
        LDA .S32_ROOT_LO          ; root = root << 1
        SRA.D 16 A
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
