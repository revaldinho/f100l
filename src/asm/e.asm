.equ  	CARRY           0x04    ; carry is bit 4 of the CR
.equ  	MULTI      	0x05    ; multi-word flag is bit 5 of CR
.equ  	ZERO       	0x01    ; zero bit in CR
.equ  	SIGN       	0x03    ; sign bit in CR

.equ    LSP         	0       ; link stack pointer location
.equ    USP         	1       ; user stack pointer location
.equ    LINK_STACK  	0x7C01  ; initial value for link stack (must be ODD)
.equ    USER_STACK  	0x7800  ; initial value for user stack
        
.equ    R0              10      ; register space
.equ    R1              R0+1 
.equ    R2              R0+2 
.equ    R3              R0+3 
.equ    R4              R0+4 
.equ    R5              R0+5 
.equ    R6              R0+6 
.equ    R7              R0+7 
.equ    R8              R0+8 
.equ    R9              R0+9 
.equ    R10             R0+10
.equ    R11             R0+11
.equ    R12             R0+12
.equ    R13             R0+13
.equ    R14             R0+14
.equ    R15             R0+15
        

.equ  DIGITS  256
.equ  COLS    DIGITS+2
.equ  OSWRADDR 0x7FFF

INIT:   .org 0x800                  ; 0x800 standard start address
        LDA ,LINK_STACK             ; initialize link stack pointer
        STO .LSP
        LDA ,USER_STACK             ; initialize user stack pointer
        STO .USP
        ;; R0 = loopctr
        ;; R1 = pointer to remainders
        ;; R2 = q
        ;; R3 = n
        ;; R4 = i (use -i to allow ICZ in inner loop)
        ;; R5 = j (use -j to allow ICZ in inner loop)
        ;; R6 = stdoutbuffer
        ;; R10 = scratch
        ;; R11 = scratch
        ;; R12 = scratch
        ;; R13 = scratch
        ;; R14 = parameter reg
        ;; R15 = parameter reg
        ;; Zero remainder array
        LDA     ,OUTPUT_ARR-1
        STO     R6
        LDA     ,2
        CAL    .OSWRDIG
        LDA     ,46            ; char = '.'
        CAL    .OSWRCHR

        LDA     ,COLS
        SUB     ,0
        STO     R0
        LDA     ,(REMAIN_ARR-1) ; ptr pre-incremented before use
        STO     R1
LOOP:
        LDA     ,1
        STO     /R1+            ; init values to 1 
        ICZ     R0 LOOP
        LDA     ,0              ; except first which is 0
        STO     .REMAIN_ARR     

        LDA     ,DIGITS-1       ; j counter
        SUB     ,0              ; negate it
        STO     R5
OUTER:
        LDA     ,0
        STO     R2
        LDA     ,COLS
        STO     R4
        LDA     ,REMAIN_ARR
        ADD     R4
        STO     R1             ; initialize pointer to remainder array
        ;; compute -i to allow use of ICZ
        LDA     ,COLS
        SUB     ,0
        STO     R4
INNER:
        LDA     /R1             ; get remainder[i]
        STO     R10            ; save it
        SLL     3 A             ; multiply by 8
        ADD     R10            ; add the orignal number twice
        ADD     R10            ; .. to end up with remainder[i]*10
        ADD     R2             ; add Q
        STO     R3             ; save in N
        STO     R14            ; N= numerator for div call
        LDA     R4
        SUB     ,1              ; get negative R4 and then add 1
        STO     R15            ; (i+1)=denominateor for div call
        CAL     .UDIV16
        LDA     R14            ; get quotient
        STO     R2
        LDA     R15            ; get remainder
        STO     /R1-            ; save in remainder array and point to next (post dec)
        ICZ     R4 INNER
        LDA     R2
        CAL     .OSWRDIG
        ICZ     R5  OUTER
        HALT

OSWRDIG:
        ;; Entry A=char to write
        ADD     ,48             ; make ASCII
OSWRCHR:
        STO     .OSWRADDR       ; write to magic memory
        STO     /R6+            ; store in buffer also for easy diff vs behavioural
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
;       if N==0 :
;           return(0,0)
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
         LDA ,0x0000
         STO UD16_Q
         STO UD16_R
         NEQ UD16_N            ; exit early if N==0
         JBS ZERO CR UD16_EXIT
         LDA ,-16
         STO UD16_LCTR
         CLR  MULTI CR
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
        
.ORG 0x2000
REMAIN_ARR:

.ORG 0x4000
OUTPUT_ARR:

