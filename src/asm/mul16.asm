.org 0x200

MULT_DATA:                          ; define some data to be used in the arithmetic
#include "mul16.inc"

#include "init.asm"

        LDA ,RESULT_AREA-1          ; data pointer will be pre-incremented before use so subtract 1
        STO .RESULTPTR
        LDA ,MULT_DATA-1            ; data pointer will be pre-incremented before use so subtract 1
        STO .DATAPTR
        LDA /DATAPTR+                ; first item is number of tests (pairs of operands)
        SET CARRY CR
        SUB ,0
        STO .TESTCTR                ; store negative test count
NEXTTEST:
        LDA ,-0x2
        STO .LPCTR
RLOOP0:
        LDA /DATAPTR+
        STO /USP+
        STO /RESULTPTR+
        ICZ .LPCTR RLOOP0
        CAL .MUL16
        LDA ,-0x2
        STO .LPCTR
        ; 2 word result comes out in reverse order from stack so move stack pointer and read out with incrementing
        CLR MULTI CR
        LDA ,0x2
        SBS .USP
RLOOP1:
        LDA /USP+
        STO /RESULTPTR+
        ICZ .LPCTR RLOOP1
        ; reclaim the stack again now that the results are written out ..
        LDA ,0x2
        SBS .USP
        ICZ .TESTCTR NEXTTEST
        HALT  ,0x123

#include "mathlib.asm"
