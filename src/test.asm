            ;;
            ;; test.asm 
            ;;
            ;; test assembly file including some intentional syntax/symbol errors
        

        .org 200 
mylabel: 
               .equ F1 23 ; some arbitrary constant 
               .equ F2 F1 * 2 

               INVALIDOC blh
               AND ,LABELWITHCODE
               AND ,labelwithcode
               AND 0
               AND .0
               AND ,0
               AND 0x0FE
               AND F1
               AND .0x0FE
               AND ,0x0FE
               AND /F1*2
               AND /0xF4+
               AND /0x1F-
               NEQ 0
               NEQ .0
               NEQ ,0
               NEQ 0x0FE
               NEQ F1
               NEQ .0x0FE
               NEQ ,0x0FE
               NEQ /F1*2
               NEQ /0x55+
               NEQ /0x55-
               CMP 0
               CMP .0
               CMP ,0
               CMP 0x0FE
               CMP F1
               CMP .0x0FE
               CMP .F1*2
               CMP ,0x0FE
               CMP /F1*2
               CMP /0x55+
               CMP /0x55-
               SUB 0
               SUB .0
               SUB ,0
               SUB 0x0FE
               SUB F1
               SUB .0x0FE
               SUB .F1*2
               SUB ,0x0FE
               SUB /F1*2
               SUB /0x55+
               SUB /0x55-
               LDA 0
               LDA .0
               LDA ,0
               LDA 0x0FE
               LDA F1
               LDA .0x0FE
               LDA .F1*2
               LDA ,0x0FE
               LDA /F1*2
               LDA /0x55+
               LDA /0x55-
               ICZ .0x0FE
               ICZ .F1*2 44
               ICZ ,0x0FE 33
               ICZ /F1*2 1
               ICZ /0x55+ 22
               ICZ /0x55- 33
               ADD 0
               ADD .0
               ADD ,0
               ADD 0x0FE
               ADD F1

               ADD .0x0FE
               ADD .F1*2
               RTN
               RTC

               SJM
               SJM 1 
               SJM 1 2 
               CAL ,0x0FE
               CAL /F1*2
               CAL /0x55+
               CAL /0x55-
               CAL /0x01-
               JMP mylabel
               SBS .89
               JMP mylabel 
               ; comment in   wierd spa c i n g  
               .word 0x99,10, F1, F1*2, HERE
               SBS 0x55
HERE: 
               ADS 0x88 
LABELWITHCODE: SBS 0x88 
               ADD 0x88 ; DIRECT
               STO ,0x88 ; IMMEDIATE
               STO /0x88 ; POINTER INDIRECT
               ADD /0x88+ ; POINTER INDIRECT PRE-INC
               ADD /0x88- ; POINTER INDIRECT POST-DEC
               ADD .0x88 ; IMMMEDIATE INDIRECT

               SET 0x02 A
               CLR 0x01 C
               SET 0x05 0x100
               SRL 0x01 
               SRE 0x01
               SRA 0x02 0x450

               JBC 0x02 A 0x400
               JSC 0x01 C 0x500
               JSC 0x05 0x100 0x100
               JCS 0x01 A 0x100
               JCS 0x01 C 0x200
               JSC 0x02 0x450 0x299
               
               HALT 


