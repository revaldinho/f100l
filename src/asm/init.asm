
;;#undefine LOCALVARSTACKS
#define USE_SELFMODCODE 1


;; Initialise Machine Here
.equ  LSP     0x0000        ; Link Stack Pointer
.equ  USP     0x0001        ; User Stack Pointer
.equ  LVP0    0x0002        ; 16 Local variable pointers
.equ  LVP1    0x0003
.equ  LVP2    0x0004
.equ  LVP3    0x0005
.equ  LVP4    0x0006
.equ  LVP5    0x0007
.equ  LVP6    0x0008
.equ  LVP7    0x0009
.equ  LVP8    0x000A
.equ  LVP9    0x000B
.equ  LVPA    0x000C
.equ  LVPB    0x000D
.equ  LVPC    0x000E
.equ  LVPD    0x000F
.equ  LVPE    0x0010
.equ  LVPF    0x0011
.equ  TMPVAR  0x0012
.equ  DATAPTR 0x0013         ; another pointer
.equ  RESULTPTR 0x0014       ; pointer to results area
.equ  TESTCTR 0x00015        ; first_item in data area is number of tests
.equ  LPCTR   0x00016        ; generic loop var for top level of program

.equ  CARRY   0x04          ; carry is bit 4 of the CR
.equ  MULTI   0x05          ; multi-word flag is bit 5 of CR
.equ  ZERO    0x01          ; zero bit in CR
.equ  SIGN    0x03          ; sign bit in CR

.equ  LINK_STACK  0x3601    ; initial value for link stack (must be ODD)
.equ  USER_STACK  0x3800    ; initial value for user stack
.equ  LOCAL_VARS  0x4000    ; local vars will be allocated here, 0x100 per pointer, 0x1000 in total
.equ  RESULT_AREA 0x5000    ; all results to get copied here246:

INIT:   .org 0x800                  ; 0x800 standard start address
        LDA ,LINK_STACK             ; initialize link stack pointer
        STO .LSP
        LDA ,USER_STACK             ; initialize user stack pointer
        STO .USP
        LDA ,0x0001                 ; first of the local variable stacks is pointer 2 but will get pre-incremented
        STO .TMPVAR
        LDA ,-15                     ; 16 stacks to initialise
        STO .TESTCTR
        LDA ,LOCAL_VARS             ; initialise local variable stacks
INIT_LOCALVARS:
        STO /TMPVAR+
        ADD ,0x100									; each local variable stack can be 0x100 deep
        ICZ .TESTCTR INIT_LOCALVARS
