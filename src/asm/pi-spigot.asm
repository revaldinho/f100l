;
; Program to generate Pi using the Spigot Algorithm from
;
; http://web.archive.org/web/20110716080608/http://www.mathpropress.com/stan/bibliography/spigot.pdf
;

.equ    CARRY           0x04    ; carry is bit 4 of the CR
.equ    MULTI           0x05    ; multi-word flag is bit 5 of CR
.equ    ZERO            0x01    ; zero bit in CR
.equ    SIGN            0x03    ; sign bit in CR
.equ    LSP             0       ; link stack pointer location
.equ    USP             1       ; user stack pointer location
.equ    LINK_STACK      0x7C01  ; initial value for link stack (must be ODD)
.equ    USER_STACK      0x7800  ; initial value for user stack
.equ    R0              10      ; loopctr
.equ    R1              R0+1    ; nines
.equ    R2              R0+2    ; output pointer
.equ    R3              R0+3    ; c
.equ    R4              R0+4    ; i (use -i to allow ICZ in inner loop)
.equ    R5              R0+5    ; Q
.equ    R6              R0+6    ; result
.equ    R7              R0+7    ; pointer to remainders
.equ    R8              R0+8    ; digit number
.equ    R9              R0+9    ; predigit
.equ    R10             R0+10   ; scratch
.equ    R11             R0+11   ; scratch
.equ    R12             R0+12   ; scratch
.equ    R13             R0+13   ; scratch
.equ    R14             R0+14   ; parameter reg
.equ    R15             R0+15   ; parameter reg
.equ    CONST0          R0+16   ; constant ZERO
.equ    CONST1          R0+17   ; constant ONE

.equ  DIGITS  64        
.equ  COLS    1+(DIGITS*10//3)

INIT:   .org 0x800              ; 0x800 standard start address
        LDA ,LINK_STACK         ; initialize link stack pointer
        STO .LSP
        LDA ,USER_STACK         ; initialize user stack pointer
        STO .USP
        CLR     MULTI CR
        LDA ,0                  ; initialize constant registers
        STO CONST0
        LDA ,1
        STO CONST1
start:
        LDA     ,MYPI-1         ; point to output buffer
        STO     R2
        ;; trivial banner       ; OK. Message
        LDA     ,0x4F
        CAL     .OSWRCHR
        LDA     ,0x6B
        CAL     .OSWRCHR
        LDA     ,0x20
        CAL     .OSWRCHR

        ; Initialise remainder array to 2
        LDA     ,REMAINDER-1
        STO     R1
        LDA     ,-COLS          ;  -cols negative counter for use with ICZ
        STO     R0
LOOP:
        LDA     ,2
        STO     /R1+            ; init remainder values to 2
        ICZ     R0 LOOP

        LDA     ,-DIGITS        ; Digit counter from -Digits to 0
        STO     R8
        LDA     CONST0             ; C = 0
        STO     R3
        STO     R9              ; init outer loop counter
        STO     R1              ; nines=0

L3:     LDA     ,COLS-1         ; i = COLS-1
        STO     R4
        ADD     ,REMAINDER      ; setup remainder pointer to end of data
        STO     R7
        LDA     CONST0            ; Q = 0
        STO     R5

L4:     LDA     /R7             ; Q += R[i]*10
        SLA     3 A
        ADD     /R7
        ADD     /R7
        ADS     R5
        SLA     1 R4            ; denom=(2*i)-1
        STO     R15
        LDA     CONST1
        SBS     R15
        LDA     R5              ; r[i] = q % denom ; q = q//denom
        STO     R14
        CAL     .UDIV16         ; returns R14=Quotient, R15=Remainder
        LDA     R14
        STO     R5              ; Q = quotient
        LDA     R15
        STO     /R7             ; r[i] = remainder
        LDA     CONST1
        SBS     R4              ; R4--
        CMP     CONST0
        JBS     ZERO CR L5
        LDA     /R7-            ; decrement pointer R7
        LDA     R5              ; Q *= i
        STO     R14
        LDA     R4
        STO     R15
        CAL     .MUL16
        LDA     R15
        STO     R5
        JMP     .L4

L5:     LDA     R5              ; result = C+Q//10
        STO     R14
        LDA     ,10
        STO     R15
        CAL     .UDIV16
        LDA     R14
        ADD     R3
        STO     R6
        LDA     R15             ; C=Q%10
        STO     R3

        LDA     R6              ; check if result=9
        CMP     ,9
        JBC     ZERO CR L5A
        LDA     CONST1              ; decrement 9s if yes (-ve counting)
        SBS     R1
        ICZ     R8 L3           ; loop again without printing digits

L5A:    LDA     R6              ; Check if result=10 (ie overflow)
        CMP     ,10
        JBC     ZERO CR L6
        LDA     CONST0            ; if yes, zero result
        STO     R6
        LDA     CONST1              ; and inc predigit
        ADS     R9
        CAL     .OSWRDIG        ; print predigit and all nines will be zeros now
        LDA     R1
        CMP     CONST0
        JBS     ZERO CR L7
L5B:    LDA     CONST0
        CAL     .OSWRDIG
        ICZ     R1 L5B

L6:     LDA     R8              ; If this isnt the first digit then print the existing pre-digit
        CMP     ,-DIGITS
        JBS     ZERO CR L7
        LDA     R9
        CAL     .OSWRDIG        ; print predigit and all nines
        LDA     R1
        CMP     CONST0
        JBS     ZERO CR L7
L6B:    LDA     ,9
        CAL     .OSWRDIG
        ICZ     R1 L6B

L7:     LDA     R6              ; predigit <- result
        STO     R9
L8:     ICZ     R8 L3
        ;; Print last digit
        LDA     R9
        CAL     .OSWRDIG
        HALT    ,0x0123
OSWRDIG:
        ;; Entry A=digit to write
        ADD     ,48             ; make ASCII
OSWRCHR:
        STO     /R2+
        RTN
; ------------------------------------
; UDIV16
;
; Unsigned integer 16 bit division of two numbers
; returning quotient and remainder.
; ------------------------------------
; Entry: R14 -> Numerator
;        R15 -> Denominator
;
; Exit:  R14 -> Quotient
;        R15 -> Remainder
;        R11-13 -> trashed
; ------------------------------------
; Algorithm
; ------------------------------------
;   def div16(N,D):
;       if N<D :
;           return(0,N)
;       Q = 0
;       R = 0
;       for i in range (-15, 1 ):
;           Q <<= 1
;           R <<= 1
;           if bit (N,15) :
;               R = bitset(R,0)
;           if R >= D:
;               R = R - D
;               Q = bitset(Q,0)
;           N <<= 1
;       return (Q,R)
; ------------------------------------

;; Local storage
.equ UD16_N    R14
.equ UD16_D    R15
.equ UD16_Q    R13
.equ UD16_R    R12
.equ UD16_LCTR R11

UDIV16:
         LDA CONST0
         STO UD16_Q
         STO UD16_R
UD16_L1:
         LDA ,-16
         STO UD16_LCTR
UD16_LOOP:
         SLA 1 UD16_Q
         STO UD16_Q
         SLA 1 UD16_R
         STO UD16_R
         JBC 15 UD16_N UD16_SKIP
         SET 0 UD16_R
UD16_SKIP:
         LDA UD16_D
         CMP UD16_R
         JBS SIGN CR UD16_SKIP2        ; JUMP if R < D
         LDA UD16_D
         SBS UD16_R
         SET 0 UD16_Q
UD16_SKIP2:
         SLA 1 UD16_N
         STO UD16_N
         ICZ UD16_LCTR UD16_LOOP
UD16_EXIT:
         LDA UD16_R
         STO R15
         LDA UD16_Q
         STO R14
         RTN

; ------------------------------------
; MUL16
;
; Multiply 2 16 bit numbers to yield a 16b result
; ------------------------------------
; Entry: R14 -> A
;        R15 -> B
;
; Exit:  R15    -> A*B
;        R11-14 -> trashed
; --------------------------------------------------------------
; Register Map
.equ    M16L_count      R11
.equ    M16L_aa         R13
.equ    M16L_bb         R14
.equ    M16L_res        R15

MUL16:
        LDA ,-15
        STO M16L_count
        LDA R15
        STO M16L_aa
        LDA CONST0
        STO M16L_res
M16L_LOOP:
        JBC 0 M16L_aa M16L_SKIPADD
        LDA M16L_bb
        ADS M16L_res
M16L_SKIPADD:
        SRA 1 M16L_aa
        STO M16L_aa
        SLL 1 M16L_bb
        STO M16L_bb
        ICZ M16L_count M16L_LOOP
        RTN

        .ORG 0x1000
MYPI:                              ; Space for pi digit storage

        .ORG 0x1500

REMAINDER:                         ; Array space for remainder
