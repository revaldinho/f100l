0800 : f800 0820      : JMP  .0820
0802 : 0401           : HALT ,0001
0803 : 0000           : SRA   0 A
0804 : 0402           : HALT ,0002
0805 : 0000           : SRA   0 A
0806 : 0403           : HALT ,0003
0807 : 0000           : SRA   0 A
0808 : f800 0d1b      : JMP  .0d1b
080a : 0405           : HALT ,0005
080b : 0000           : SRA   0 A
080c : 0406           : HALT ,0006
080d : 0000           : SRA   0 A
080e : 0407           : HALT ,0007
080f : 0000           : SRA   0 A
0810 : f800 0870      : JMP  .0870
0812 : 0409           : HALT ,0009
0813 : 0000           : SRA   0 A
0814 : 040a           : HALT ,000a
0815 : 0000           : SRA   0 A
0816 : 040b           : HALT ,000b
0817 : 0000           : SRA   0 A
0818 : f800 1965      : JMP  .1965
081a : 040d           : HALT ,000d
081b : 0000           : SRA   0 A
081c : 040e           : HALT ,000e
081d : 0000           : SRA   0 A
081e : f800 228f      : JMP  .228f
0820 : 01e0           : SET   0 CR
0821 : 8000 f850      : LDA  ,f850
0823 : 4028           : STO   0028
0824 : 8000 004f      : LDA  ,004f
0826 : 4029           : STO   0029
0827 : 8000 3fff      : LDA  ,3fff
0829 : 402a           : STO   002a
082a : 8000 0000      : LDA  ,0000
082c : 4929           : STO  /0029+
082d : 492a           : STO  /002a+
082e : 7028 082c      : ICZ   0028 082c
0830 : 8000 083f      : LDA  ,083f
0832 : 4028           : STO   0028
0833 : 8000 0059      : LDA  ,0059
0835 : 4029           : STO   0029
0836 : 8000 ffe2      : LDA  ,ffe2
0838 : 402a           : STO   002a
0839 : 8928           : LDA  /0028+
083a : 4929           : STO  /0029+
083b : 702a 0839      : ICZ   002a 0839
083d : 01f0           : CLR   0 CR
083e : f800 26f0      : JMP  .26f0
0840 : 0000           : DATA
0841 : 0001           : DATA
0842 : 0002           : DATA
0843 : 0003           : DATA
0844 : 0004           : DATA
0845 : 0005           : DATA
0846 : 0006           : DATA
0847 : 0007           : DATA
0848 : 0008           : DATA
0849 : 0009           : DATA
084a : 000A           : DATA
084b : 000B           : DATA
084c : 000C           : DATA
084d : 000D           : DATA
084e : 000E           : DATA
084f : 000F           : DATA
0850 : 001F           : DATA
0851 : 003F           : DATA
0852 : 007F           : DATA
0853 : 00FF           : DATA
0854 : 01FF           : DATA
0855 : 03FF           : DATA
0856 : 07FF           : DATA
0857 : 0FFF           : DATA
0858 : 1FFF           : DATA
0859 : 3FFF           : DATA
085a : 7FFF           : DATA
085b : FFFF           : DATA
085c : 0077           : DATA
085d : 0078           : DATA
085e : f800 08de      : JMP  .08de
0860 : 8901           : LDA  /0001+
0861 : 411e           : STO   011e
0862 : c069           : AND   0069
0863 : 905b           : ADD   005b
0864 : 411e           : STO   011e
0865 : 805b           : LDA   005b
0866 : 411f           : STO   011f
0867 : 611e           : SBS   011e
0868 : 0191 086e      : JBS   1 CR 086e
086a : 0341 011f      : SLA   1 011f
086c : f800 0867      : JMP  .0867
086e : 811f           : LDA   011f
086f : 3800           : RTC
0870 : 4903           : STO  /0003+
0871 : 8001           : LDA   0001
0872 : 4903           : STO  /0003+
0873 : 8800 7fdd      : LDA  .7fdd
0875 : 4800 01e7      : STO  .01e7
0877 : 8000 d096      : LDA  ,d096
0879 : 4800 7fde      : STO  .7fde
087b : 8000 d095      : LDA  ,d095
087d : 4800 7fde      : STO  .7fde
087f : 8800 01e5      : LDA  .01e5
0881 : 0181 0887      : JBC   1 CR 0887
0883 : 2800 08e1      : CAL  .08e1
0885 : f800 08d9      : JMP  .08d9
0887 : 0389 01e7 08a0 : JBC   9 01e7 08a0
088a : 8000 01f0      : LDA  ,01f0
088c : 4001           : STO   0001
088d : 2800 0860      : CAL  .0860
088f : 4121           : STO   0121
0890 : a075           : SUB   0075
0891 : c800 01ee      : AND  .01ee
0893 : 9121           : ADD   0121
0894 : 4800 01ee      : STO  .01ee
0896 : 805a           : LDA   005a
0897 : 4800 01f1      : STO  .01f1
0899 : 4800 01e6      : STO  .01e6
089b : 805b           : LDA   005b
089c : 5800 0349      : ADS  .0349
089e : f800 08d9      : JMP  .08d9
08a0 : 0398 01e7 08b7 : JBS   8 01e7 08b7
08a3 : 8000 01f0      : LDA  ,01f0
08a5 : 4001           : STO   0001
08a6 : 2800 0860      : CAL  .0860
08a8 : 4121           : STO   0121
08a9 : a075           : SUB   0075
08aa : c800 01f0      : AND  .01f0
08ac : 9121           : ADD   0121
08ad : 4800 01f0      : STO  .01f0
08af : 805a           : LDA   005a
08b0 : 4800 01f1      : STO  .01f1
08b2 : 038c 01e7 08b7 : JBC   c 01e7 08b7
08b5 : 4800 01e6      : STO  .01e6
08b7 : 8800 01e6      : LDA  .01e6
08b9 : 0191 08bf      : JBS   1 CR 08bf
08bb : 2800 0987      : CAL  .0987
08bd : f800 08d9      : JMP  .08d9
08bf : 2800 0ab1      : CAL  .0ab1
08c1 : 8800 01ea      : LDA  .01ea
08c3 : 0191 08d9      : JBS   1 CR 08d9
08c5 : 8000 01f0      : LDA  ,01f0
08c7 : 4001           : STO   0001
08c8 : 2800 0860      : CAL  .0860
08ca : 4121           : STO   0121
08cb : a075           : SUB   0075
08cc : c800 01ef      : AND  .01ef
08ce : 9121           : ADD   0121
08cf : 4800 01ef      : STO  .01ef
08d1 : 805a           : LDA   005a
08d2 : 4800 01f1      : STO  .01f1
08d4 : 4800 01ea      : STO  .01ea
08d6 : 805b           : LDA   005b
08d7 : 5800 0349      : ADS  .0349
08d9 : 8b03           : LDA  /0003-
08da : 4001           : STO   0001
08db : 8b03           : LDA  /0003-
08dc : 3000           : RTN
08dd : 3800           : RTC
08de : 3000           : RTN
08df : f800 0984      : JMP  .0984
08e1 : 8800 01e7      : LDA  .01e7
08e3 : 0399 01e7 0983 : JBS   9 01e7 0983
08e6 : 008c 095d      : JBC   c A 095d
08e8 : c069           : AND   0069
08e9 : b05d           : CMP   005d
08ea : 0181 0983      : JBC   1 CR 0983
08ec : 806d           : LDA   006d
08ed : c800 01e7      : AND  .01e7
08ef : 0024           : SRL   4 A
08f0 : 4123           : STO   0123
08f1 : 0181 0905      : JBC   1 CR 0905
08f3 : 805a           : LDA   005a
08f4 : 4800 01f4      : STO  .01f4
08f6 : 805b           : LDA   005b
08f7 : a000 01f3      : SUB  ,01f3
08f9 : 4800 7fdf      : STO  .7fdf
08fb : 8000 d095      : LDA  ,d095
08fd : 4800 7fde      : STO  .7fde
08ff : 8000 0021      : LDA  ,0021
0901 : 4800 7fdd      : STO  .7fdd
0903 : f800 0983      : JMP  .0983
0905 : 8123           : LDA   0123
0906 : b05b           : CMP   005b
0907 : 0181 094b      : JBC   1 CR 094b
0909 : 8800 01e8      : LDA  .01e8
090b : 0191 0983      : JBS   1 CR 0983
090d : 806e           : LDA   006e
090e : c800 0273      : AND  .0273
0910 : 9000 0600      : ADD  ,0600
0912 : 4800 0273      : STO  .0273
0914 : c000 ff00      : AND  ,ff00
0916 : 4800 0273      : STO  .0273
0918 : 8081           : LDA   0081
0919 : 905b           : ADD   005b
091a : 0065           : SLL   5 A
091b : c000 07e0      : AND  ,07e0
091d : 4127           : STO   0127
091e : 8000 f81f      : LDA  ,f81f
0920 : c800 0274      : AND  .0274
0922 : 9127           : ADD   0127
0923 : 4800 0274      : STO  .0274
0925 : c000 ffe0      : AND  ,ffe0
0927 : 9060           : ADD   0060
0928 : 4800 0274      : STO  .0274
092a : 8081           : LDA   0081
092b : 4800 0275      : STO  .0275
092d : 8082           : LDA   0082
092e : 4800 0276      : STO  .0276
0930 : 805a           : LDA   005a
0931 : 4124           : STO   0124
0932 : 8124           : LDA   0124
0933 : b000 0011      : CMP  ,0011
0935 : 0193 093c      : JBS   3 CR 093c
0937 : 4124           : STO   0124
0938 : 905b           : ADD   005b
0939 : 4124           : STO   0124
093a : f800 0932      : JMP  .0932
093c : 805b           : LDA   005b
093d : a000 0273      : SUB  ,0273
093f : 4800 7fdf      : STO  .7fdf
0941 : 8000 d095      : LDA  ,d095
0943 : 4800 7fde      : STO  .7fde
0945 : 8000 0023      : LDA  ,0023
0947 : 4800 7fdd      : STO  .7fdd
0949 : f800 0983      : JMP  .0983
094b : 8800 01e9      : LDA  .01e9
094d : 0191 0983      : JBS   1 CR 0983
094f : 8123           : LDA   0123
0950 : b05d           : CMP   005d
0951 : 0181 0983      : JBC   1 CR 0983
0953 : 8075           : LDA   0075
0954 : 4800 01e5      : STO  .01e5
0956 : 805a           : LDA   005a
0957 : 4800 01f1      : STO  .01f1
0959 : 2800 0ab1      : CAL  .0ab1
095b : f800 0983      : JMP  .0983
095d : 8800 01f4      : LDA  .01f4
095f : 0191 0980      : JBS   1 CR 0980
0961 : c070           : AND   0070
0962 : b060           : CMP   0060
0963 : 0181 097b      : JBC   1 CR 097b
0965 : 805b           : LDA   005b
0966 : 5800 01e8      : ADS  .01e8
0968 : 8800 01f5      : LDA  .01f5
096a : 4081           : STO   0081
096b : 8800 01f6      : LDA  .01f6
096d : 4082           : STO   0082
096e : 8000 036a      : LDA  ,036a
0970 : 4049           : STO   0049
0971 : 8000 01f6      : LDA  ,01f6
0973 : 404a           : STO   004a
0974 : 8000 ffc0      : LDA  ,ffc0
0976 : 404e           : STO   004e
0977 : 894a           : LDA  /004a+
0978 : 4949           : STO  /0049+
0979 : 704e 0977      : ICZ   004e 0977
097b : 805a           : LDA   005a
097c : 4800 01f4      : STO  .01f4
097e : f800 0983      : JMP  .0983
0980 : 805b           : LDA   005b
0981 : 5800 01e9      : ADS  .01e9
0983 : 3800           : RTC
0984 : 3000           : RTN
0985 : f800 0aae      : JMP  .0aae
0987 : 8800 01f1      : LDA  .01f1
0989 : b05d           : CMP   005d
098a : 0181 0a49      : JBC   1 CR 0a49
098c : 0391 0112 09d6 : JBS   1 0112 09d6
098f : 8000 ff00      : LDA  ,ff00
0991 : c800 0273      : AND  .0273
0993 : 9000 00bf      : ADD  ,00bf
0995 : 4800 0273      : STO  .0273
0997 : c06e           : AND   006e
0998 : 9000 b600      : ADD  ,b600
099a : 4800 0273      : STO  .0273
099c : 8081           : LDA   0081
099d : 0065           : SLL   5 A
099e : c000 07e0      : AND  ,07e0
09a0 : 412c           : STO   012c
09a1 : 8000 f81f      : LDA  ,f81f
09a3 : c800 0274      : AND  .0274
09a5 : 912c           : ADD   012c
09a6 : 4800 0274      : STO  .0274
09a8 : c000 ffe0      : AND  ,ffe0
09aa : 905e           : ADD   005e
09ab : 4800 0274      : STO  .0274
09ad : 8000 0274      : LDA  ,0274
09af : 4049           : STO   0049
09b0 : 8000 068c      : LDA  ,068c
09b2 : 404a           : STO   004a
09b3 : 8000 ffd3      : LDA  ,ffd3
09b5 : 404e           : STO   004e
09b6 : 894a           : LDA  /004a+
09b7 : 4949           : STO  /0049+
09b8 : 704e 09b6      : ICZ   004e 09b6
09ba : 8000 06b9      : LDA  ,06b9
09bc : 404a           : STO   004a
09bd : 8000 ffd3      : LDA  ,ffd3
09bf : 404e           : STO   004e
09c0 : 894a           : LDA  /004a+
09c1 : 4949           : STO  /0049+
09c2 : 704e 09c0      : ICZ   004e 09c0
09c4 : 805b           : LDA   005b
09c5 : a000 0273      : SUB  ,0273
09c7 : 4800 7fdf      : STO  .7fdf
09c9 : 8000 d095      : LDA  ,d095
09cb : 4800 7fde      : STO  .7fde
09cd : 8000 0023      : LDA  ,0023
09cf : 4800 7fdd      : STO  .7fdd
09d1 : 805e           : LDA   005e
09d2 : 4800 01f1      : STO  .01f1
09d4 : f800 0aad      : JMP  .0aad
09d6 : 8000 ff00      : LDA  ,ff00
09d8 : c800 0273      : AND  .0273
09da : 906d           : ADD   006d
09db : 4800 0273      : STO  .0273
09dd : c06e           : AND   006e
09de : 9000 2200      : ADD  ,2200
09e0 : 4800 0273      : STO  .0273
09e2 : 8000 ffe0      : LDA  ,ffe0
09e4 : c800 0274      : AND  .0274
09e6 : 905d           : ADD   005d
09e7 : 4800 0274      : STO  .0274
09e9 : 8081           : LDA   0081
09ea : 0065           : SLL   5 A
09eb : c000 07e0      : AND  ,07e0
09ed : 412e           : STO   012e
09ee : 8000 f81f      : LDA  ,f81f
09f0 : c800 0274      : AND  .0274
09f2 : 912e           : ADD   012e
09f3 : 4800 0274      : STO  .0274
09f5 : 8081           : LDA   0081
09f6 : 412b           : STO   012b
09f7 : 905f           : ADD   005f
09f8 : 412c           : STO   012c
09f9 : 812b           : LDA   012b
09fa : 9000 0105      : ADD  ,0105
09fc : 4031           : STO   0031
09fd : 8831           : LDA  /0031
09fe : 4800 0275      : STO  .0275
0a00 : 812c           : LDA   012c
0a01 : 9000 0105      : ADD  ,0105
0a03 : 4032           : STO   0032
0a04 : 8832           : LDA  /0032
0a05 : 4800 0276      : STO  .0276
0a07 : 80cb           : LDA   00cb
0a08 : 4800 0277      : STO  .0277
0a0a : 80cc           : LDA   00cc
0a0b : 4800 0278      : STO  .0278
0a0d : 8800 077a      : LDA  .077a
0a0f : 4800 0279      : STO  .0279
0a11 : 8800 077b      : LDA  .077b
0a13 : 4800 027a      : STO  .027a
0a15 : 8062           : LDA   0062
0a16 : 4129           : STO   0129
0a17 : 805a           : LDA   005a
0a18 : 412a           : STO   012a
0a19 : 812a           : LDA   012a
0a1a : b063           : CMP   0063
0a1b : 0193 0a2b      : JBS   3 CR 0a2b
0a1d : 9000 00f0      : ADD  ,00f0
0a1f : 4031           : STO   0031
0a20 : 8129           : LDA   0129
0a21 : 9000 0273      : ADD  ,0273
0a23 : 4032           : STO   0032
0a24 : 8831           : LDA  /0031
0a25 : 4832           : STO  /0032
0a26 : 805b           : LDA   005b
0a27 : 5129           : ADS   0129
0a28 : 512a           : ADS   012a
0a29 : f800 0a19      : JMP  .0a19
0a2b : 805a           : LDA   005a
0a2c : 4129           : STO   0129
0a2d : 8129           : LDA   0129
0a2e : b000 0011      : CMP  ,0011
0a30 : 0193 0a37      : JBS   3 CR 0a37
0a32 : 4129           : STO   0129
0a33 : 905b           : ADD   005b
0a34 : 4129           : STO   0129
0a35 : f800 0a2d      : JMP  .0a2d
0a37 : 805b           : LDA   005b
0a38 : a000 0273      : SUB  ,0273
0a3a : 4800 7fdf      : STO  .7fdf
0a3c : 8000 d095      : LDA  ,d095
0a3e : 4800 7fde      : STO  .7fde
0a40 : 8000 0023      : LDA  ,0023
0a42 : 4800 7fdd      : STO  .7fdd
0a44 : 8060           : LDA   0060
0a45 : 4800 01f1      : STO  .01f1
0a47 : f800 0aad      : JMP  .0aad
0a49 : 8800 01f1      : LDA  .01f1
0a4b : b05e           : CMP   005e
0a4c : 0181 0aa8      : JBC   1 CR 0aa8
0a4e : 8000 ff00      : LDA  ,ff00
0a50 : c800 0273      : AND  .0273
0a52 : 4800 0273      : STO  .0273
0a54 : c06e           : AND   006e
0a55 : 9000 2200      : ADD  ,2200
0a57 : 4800 0273      : STO  .0273
0a59 : 8000 ffe0      : LDA  ,ffe0
0a5b : c800 0274      : AND  .0274
0a5d : 9061           : ADD   0061
0a5e : 4800 0274      : STO  .0274
0a60 : 8081           : LDA   0081
0a61 : 905b           : ADD   005b
0a62 : 0065           : SLL   5 A
0a63 : c000 07e0      : AND  ,07e0
0a65 : 412e           : STO   012e
0a66 : 8000 f81f      : LDA  ,f81f
0a68 : c800 0274      : AND  .0274
0a6a : 912e           : ADD   012e
0a6b : 4800 0274      : STO  .0274
0a6d : 8800 0344      : LDA  .0344
0a6f : 4800 0275      : STO  .0275
0a71 : 805d           : LDA   005d
0a72 : 4129           : STO   0129
0a73 : 805a           : LDA   005a
0a74 : 412a           : STO   012a
0a75 : 812a           : LDA   012a
0a76 : b060           : CMP   0060
0a77 : 0193 0a87      : JBS   3 CR 0a87
0a79 : 9000 033d      : ADD  ,033d
0a7b : 4031           : STO   0031
0a7c : 8129           : LDA   0129
0a7d : 9000 0273      : ADD  ,0273
0a7f : 4032           : STO   0032
0a80 : 8831           : LDA  /0031
0a81 : 4832           : STO  /0032
0a82 : 805b           : LDA   005b
0a83 : 5129           : ADS   0129
0a84 : 512a           : ADS   012a
0a85 : f800 0a75      : JMP  .0a75
0a87 : 805a           : LDA   005a
0a88 : 4800 033d      : STO  .033d
0a8a : 805a           : LDA   005a
0a8b : 412b           : STO   012b
0a8c : 812b           : LDA   012b
0a8d : b000 0011      : CMP  ,0011
0a8f : 0193 0a96      : JBS   3 CR 0a96
0a91 : 412b           : STO   012b
0a92 : 905b           : ADD   005b
0a93 : 412b           : STO   012b
0a94 : f800 0a8c      : JMP  .0a8c
0a96 : 805b           : LDA   005b
0a97 : a000 0273      : SUB  ,0273
0a99 : 4800 7fdf      : STO  .7fdf
0a9b : 8000 d095      : LDA  ,d095
0a9d : 4800 7fde      : STO  .7fde
0a9f : 8000 0023      : LDA  ,0023
0aa1 : 4800 7fdd      : STO  .7fdd
0aa3 : 805f           : LDA   005f
0aa4 : 4800 01f1      : STO  .01f1
0aa6 : f800 0aad      : JMP  .0aad
0aa8 : 805a           : LDA   005a
0aa9 : 4800 01f1      : STO  .01f1
0aab : 4800 01e6      : STO  .01e6
0aad : 3800           : RTC
0aae : 3000           : RTN
0aaf : f800 0d18      : JMP  .0d18
0ab1 : 8800 01e7      : LDA  .01e7
0ab3 : 038c 01e7 0b6f : JBC   c 01e7 0b6f
0ab6 : c06d           : AND   006d
0ab7 : 0024           : SRL   4 A
0ab8 : 4130           : STO   0130
0ab9 : 8069           : LDA   0069
0aba : c800 01e7      : AND  .01e7
0abc : b05d           : CMP   005d
0abd : 0181 0d17      : JBC   1 CR 0d17
0abf : 8130           : LDA   0130
0ac0 : b05d           : CMP   005d
0ac1 : 0181 0b27      : JBC   1 CR 0b27
0ac3 : 8075           : LDA   0075
0ac4 : 4800 01f2      : STO  .01f2
0ac6 : 4800 01ec      : STO  .01ec
0ac8 : 8064           : LDA   0064
0ac9 : 4800 7fee      : STO  .7fee
0acb : 0381 0112 0b05 : JBC   1 0112 0b05
0ace : 8113           : LDA   0113
0acf : 9062           : ADD   0062
0ad0 : 0066           : SLL   6 A
0ad1 : c000 03c0      : AND  ,03c0
0ad3 : 4133           : STO   0133
0ad4 : 8000 fc3f      : LDA  ,fc3f
0ad6 : c800 033d      : AND  .033d
0ad8 : 9133           : ADD   0133
0ad9 : 4800 033d      : STO  .033d
0adb : 8800 01ee      : LDA  .01ee
0add : 4800 033e      : STO  .033e
0adf : 8800 01ef      : LDA  .01ef
0ae1 : 4800 033f      : STO  .033f
0ae3 : 8800 01f0      : LDA  .01f0
0ae5 : 4800 0340      : STO  .0340
0ae7 : 805a           : LDA   005a
0ae8 : 4112           : STO   0112
0ae9 : 8113           : LDA   0113
0aea : 905b           : ADD   005b
0aeb : c061           : AND   0061
0aec : 4113           : STO   0113
0aed : c05d           : AND   005d
0aee : 0181 0b1e      : JBC   1 CR 0b1e
0af0 : 805a           : LDA   005a
0af1 : 4800 02f4      : STO  .02f4
0af3 : 805b           : LDA   005b
0af4 : a000 02f3      : SUB  ,02f3
0af6 : 4800 7fdf      : STO  .7fdf
0af8 : 8000 d095      : LDA  ,d095
0afa : 4800 7fde      : STO  .7fde
0afc : 8000 0021      : LDA  ,0021
0afe : 4800 7fdd      : STO  .7fdd
0b00 : 805b           : LDA   005b
0b01 : 4800 01f1      : STO  .01f1
0b03 : f800 0b1e      : JMP  .0b1e
0b05 : 8113           : LDA   0113
0b06 : 9062           : ADD   0062
0b07 : c069           : AND   0069
0b08 : 4132           : STO   0132
0b09 : 8000 fff0      : LDA  ,fff0
0b0b : c800 033d      : AND  .033d
0b0d : 9132           : ADD   0132
0b0e : 4800 033d      : STO  .033d
0b10 : 8800 01ee      : LDA  .01ee
0b12 : 4800 0341      : STO  .0341
0b14 : 8800 01ef      : LDA  .01ef
0b16 : 4800 0342      : STO  .0342
0b18 : 8800 01f0      : LDA  .01f0
0b1a : 4800 0343      : STO  .0343
0b1c : 805c           : LDA   005c
0b1d : 4112           : STO   0112
0b1e : 805a           : LDA   005a
0b1f : 4800 01ee      : STO  .01ee
0b21 : 4800 01ef      : STO  .01ef
0b23 : 4800 01f0      : STO  .01f0
0b25 : f800 0d17      : JMP  .0d17
0b27 : 8081           : LDA   0081
0b28 : 905e           : ADD   005e
0b29 : b130           : CMP   0130
0b2a : 0181 0b49      : JBC   1 CR 0b49
0b2c : 8800 01ec      : LDA  .01ec
0b2e : 0181 0b34      : JBC   1 CR 0b34
0b30 : 2800 0dca      : CAL  .0dca
0b32 : f800 0d17      : JMP  .0d17
0b34 : 8000 d085      : LDA  ,d085
0b36 : 4800 7fde      : STO  .7fde
0b38 : 805a           : LDA   005a
0b39 : 4800 01ec      : STO  .01ec
0b3b : 8075           : LDA   0075
0b3c : 4800 01e6      : STO  .01e6
0b3e : 805d           : LDA   005d
0b3f : 4800 01f1      : STO  .01f1
0b41 : 2800 0987      : CAL  .0987
0b43 : 8000 d095      : LDA  ,d095
0b45 : 4800 7fde      : STO  .7fde
0b47 : f800 0d17      : JMP  .0d17
0b49 : 805e           : LDA   005e
0b4a : b130           : CMP   0130
0b4b : 0193 0b68      : JBS   3 CR 0b68
0b4d : 8130           : LDA   0130
0b4e : b062           : CMP   0062
0b4f : 0193 0b68      : JBS   3 CR 0b68
0b51 : a000 fffd      : SUB  ,fffd
0b53 : a05a           : SUB   005a
0b54 : 4800 01f1      : STO  .01f1
0b56 : 8075           : LDA   0075
0b57 : 4800 01f4      : STO  .01f4
0b59 : 805b           : LDA   005b
0b5a : a000 01f3      : SUB  ,01f3
0b5c : 4800 7fdf      : STO  .7fdf
0b5e : 8000 d095      : LDA  ,d095
0b60 : 4800 7fde      : STO  .7fde
0b62 : 8000 0021      : LDA  ,0021
0b64 : 4800 7fdd      : STO  .7fdd
0b66 : f800 0d17      : JMP  .0d17
0b68 : 8130           : LDA   0130
0b69 : 0181 0d17      : JBC   1 CR 0d17
0b6b : f800 0820      : JMP  .0820
0b6d : f800 0d17      : JMP  .0d17
0b6f : 8800 01f1      : LDA  .01f1
0b71 : b05b           : CMP   005b
0b72 : 0181 0b8e      : JBC   1 CR 0b8e
0b74 : 8070           : LDA   0070
0b75 : c800 02f4      : AND  .02f4
0b77 : b05b           : CMP   005b
0b78 : 0181 0d14      : JBC   1 CR 0d14
0b7a : 805c           : LDA   005c
0b7b : 4800 01f1      : STO  .01f1
0b7d : 805a           : LDA   005a
0b7e : 4084           : STO   0084
0b7f : 805b           : LDA   005b
0b80 : a000 0083      : SUB  ,0083
0b82 : 4800 7fdf      : STO  .7fdf
0b84 : 8000 d095      : LDA  ,d095
0b86 : 4800 7fde      : STO  .7fde
0b88 : 8000 0021      : LDA  ,0021
0b8a : 4800 7fdd      : STO  .7fdd
0b8c : f800 0d17      : JMP  .0d17
0b8e : 8800 01f1      : LDA  .01f1
0b90 : b05c           : CMP   005c
0b91 : 0181 0c50      : JBC   1 CR 0c50
0b93 : 8070           : LDA   0070
0b94 : c084           : AND   0084
0b95 : b05c           : CMP   005c
0b96 : 0181 0d14      : JBC   1 CR 0d14
0b98 : 805a           : LDA   005a
0b99 : 4800 01f1      : STO  .01f1
0b9b : 8082           : LDA   0082
0b9c : 4131           : STO   0131
0b9d : 0191 0c2e      : JBS   1 CR 0c2e
0b9f : a05f           : SUB   005f
0ba0 : a05a           : SUB   005a
0ba1 : 4130           : STO   0130
0ba2 : 0c02           : EXT  ,0402
0ba3 : 0130           : DATA
0ba4 : 0061           : DATA
0ba5 : 0132           : DATA
0ba6 : 8132           : LDA   0132
0ba7 : 9000 00a3      : ADD  ,00a3
0ba9 : 4031           : STO   0031
0baa : 806d           : LDA   006d
0bab : c831           : AND  /0031
0bac : 4133           : STO   0133
0bad : 8131           : LDA   0131
0bae : 9000 0105      : ADD  ,0105
0bb0 : 4031           : STO   0031
0bb1 : 8000 ff00      : LDA  ,ff00
0bb3 : c831           : AND  /0031
0bb4 : 9133           : ADD   0133
0bb5 : 4831           : STO  /0031
0bb6 : 0c02           : EXT  ,0402
0bb7 : 0130           : DATA
0bb8 : 005D           : DATA
0bb9 : 0132           : DATA
0bba : 0c02           : EXT  ,0402
0bbb : 0130           : DATA
0bbc : 0061           : DATA
0bbd : 0133           : DATA
0bbe : 8133           : LDA   0133
0bbf : 9000 00a6      : ADD  ,00a6
0bc1 : 4032           : STO   0032
0bc2 : 806b           : LDA   006b
0bc3 : c832           : AND  /0032
0bc4 : 4134           : STO   0134
0bc5 : 8132           : LDA   0132
0bc6 : 9000 00e3      : ADD  ,00e3
0bc8 : 4032           : STO   0032
0bc9 : 8000 ffc0      : LDA  ,ffc0
0bcb : c832           : AND  /0032
0bcc : 9134           : ADD   0134
0bcd : 4832           : STO  /0032
0bce : 0c02           : EXT  ,0402
0bcf : 0130           : DATA
0bd0 : 005D           : DATA
0bd1 : 0132           : DATA
0bd2 : 0c02           : EXT  ,0402
0bd3 : 0130           : DATA
0bd4 : 0061           : DATA
0bd5 : 0133           : DATA
0bd6 : 8133           : LDA   0133
0bd7 : 9000 00a6      : ADD  ,00a6
0bd9 : 4032           : STO   0032
0bda : 8832           : LDA  /0032
0bdb : 0061           : SLL   1 A
0bdc : c000 1f80      : AND  ,1f80
0bde : 4135           : STO   0135
0bdf : 8132           : LDA   0132
0be0 : 9000 00e3      : ADD  ,00e3
0be2 : 4032           : STO   0032
0be3 : 8000 e07f      : LDA  ,e07f
0be5 : c832           : AND  /0032
0be6 : 9135           : ADD   0135
0be7 : 4832           : STO  /0032
0be8 : 0c02           : EXT  ,0402
0be9 : 0130           : DATA
0bea : 0061           : DATA
0beb : 0132           : DATA
0bec : 8132           : LDA   0132
0bed : 9000 00a6      : ADD  ,00a6
0bef : 4032           : STO   0032
0bf0 : 8832           : LDA  /0032
0bf1 : 008c 0c0b      : JBC   c A 0c0b
0bf3 : 0c02           : EXT  ,0402
0bf4 : 0130           : DATA
0bf5 : 005D           : DATA
0bf6 : 0132           : DATA
0bf7 : 8132           : LDA   0132
0bf8 : 9000 00e3      : ADD  ,00e3
0bfa : 4032           : STO   0032
0bfb : 8832           : LDA  /0032
0bfc : 00e6           : SET   6 A
0bfd : 4832           : STO  /0032
0bfe : 0c02           : EXT  ,0402
0bff : 0130           : DATA
0c00 : 005D           : DATA
0c01 : 0132           : DATA
0c02 : 8132           : LDA   0132
0c03 : 9000 00e1      : ADD  ,00e1
0c05 : 4032           : STO   0032
0c06 : 8071           : LDA   0071
0c07 : c832           : AND  /0032
0c08 : 9000 2000      : ADD  ,2000
0c0a : 4832           : STO  /0032
0c0b : 0c02           : EXT  ,0402
0c0c : 0130           : DATA
0c0d : 0061           : DATA
0c0e : 0132           : DATA
0c0f : 8132           : LDA   0132
0c10 : 9000 00a6      : ADD  ,00a6
0c12 : 4031           : STO   0031
0c13 : 8831           : LDA  /0031
0c14 : 008d 0c2e      : JBC   d A 0c2e
0c16 : 0c02           : EXT  ,0402
0c17 : 0130           : DATA
0c18 : 005D           : DATA
0c19 : 0132           : DATA
0c1a : 8132           : LDA   0132
0c1b : 9000 00e3      : ADD  ,00e3
0c1d : 4031           : STO   0031
0c1e : 8831           : LDA  /0031
0c1f : 00ed           : SET   d A
0c20 : 4831           : STO  /0031
0c21 : 0c02           : EXT  ,0402
0c22 : 0130           : DATA
0c23 : 005D           : DATA
0c24 : 0132           : DATA
0c25 : 8132           : LDA   0132
0c26 : 9000 00e1      : ADD  ,00e1
0c28 : 4031           : STO   0031
0c29 : 8071           : LDA   0071
0c2a : c831           : AND  /0031
0c2b : 9000 2000      : ADD  ,2000
0c2d : 4831           : STO  /0031
0c2e : 805a           : LDA   005a
0c2f : 4130           : STO   0130
0c30 : 8130           : LDA   0130
0c31 : b05d           : CMP   005d
0c32 : 0193 0d17      : JBS   3 CR 0d17
0c34 : 0c02           : EXT  ,0402
0c35 : 0130           : DATA
0c36 : 005D           : DATA
0c37 : 0132           : DATA
0c38 : 0c02           : EXT  ,0402
0c39 : 0130           : DATA
0c3a : 0061           : DATA
0c3b : 0133           : DATA
0c3c : 8133           : LDA   0133
0c3d : 9000 00a5      : ADD  ,00a5
0c3f : 4031           : STO   0031
0c40 : 806f           : LDA   006f
0c41 : c831           : AND  /0031
0c42 : 4134           : STO   0134
0c43 : 8132           : LDA   0132
0c44 : 9000 00e2      : ADD  ,00e2
0c46 : 4031           : STO   0031
0c47 : 8000 fc00      : LDA  ,fc00
0c49 : c831           : AND  /0031
0c4a : 9134           : ADD   0134
0c4b : 4831           : STO  /0031
0c4c : 805b           : LDA   005b
0c4d : 5130           : ADS   0130
0c4e : f800 0c30      : JMP  .0c30
0c50 : 8000 07e0      : LDA  ,07e0
0c52 : c800 01f4      : AND  .01f4
0c54 : 9000 00e0      : ADD  ,00e0
0c56 : 0005           : SRA   5 A
0c57 : b800 01f1      : CMP  .01f1
0c59 : 0181 0d14      : JBC   1 CR 0d14
0c5b : 806a           : LDA   006a
0c5c : c800 01f4      : AND  .01f4
0c5e : b05d           : CMP   005d
0c5f : 0181 0ca1      : JBC   1 CR 0ca1
0c61 : 8070           : LDA   0070
0c62 : c800 01f4      : AND  .01f4
0c64 : 0025           : SRL   5 A
0c65 : 4130           : STO   0130
0c66 : 905f           : ADD   005f
0c67 : 4131           : STO   0131
0c68 : 8130           : LDA   0130
0c69 : 9000 0105      : ADD  ,0105
0c6b : 4031           : STO   0031
0c6c : 8800 01f5      : LDA  .01f5
0c6e : 4831           : STO  /0031
0c6f : 8131           : LDA   0131
0c70 : 9000 0105      : ADD  ,0105
0c72 : 4032           : STO   0032
0c73 : 8800 01f6      : LDA  .01f6
0c75 : 4832           : STO  /0032
0c76 : 8130           : LDA   0130
0c77 : 9000 03bd      : ADD  ,03bd
0c79 : 4033           : STO   0033
0c7a : 8800 01f8      : LDA  .01f8
0c7c : 4833           : STO  /0033
0c7d : 8081           : LDA   0081
0c7e : 9062           : ADD   0062
0c7f : 4132           : STO   0132
0c80 : 9000 01f3      : ADD  ,01f3
0c82 : 4034           : STO   0034
0c83 : 806b           : LDA   006b
0c84 : c834           : AND  /0034
0c85 : 4133           : STO   0133
0c86 : 8130           : LDA   0130
0c87 : 9000 00fb      : ADD  ,00fb
0c89 : 4035           : STO   0035
0c8a : 8000 ffc0      : LDA  ,ffc0
0c8c : c835           : AND  /0035
0c8d : 9133           : ADD   0133
0c8e : 4835           : STO  /0035
0c8f : 8834           : LDA  /0034
0c90 : 0029           : SRL   9 A
0c91 : c06b           : AND   006b
0c92 : 4134           : STO   0134
0c93 : 8131           : LDA   0131
0c94 : 9000 00fb      : ADD  ,00fb
0c96 : 4036           : STO   0036
0c97 : 8000 ffc0      : LDA  ,ffc0
0c99 : c836           : AND  /0036
0c9a : 9134           : ADD   0134
0c9b : 4836           : STO  /0036
0c9c : 805a           : LDA   005a
0c9d : 4800 01f1      : STO  .01f1
0c9f : f800 0d17      : JMP  .0d17
0ca1 : 806a           : LDA   006a
0ca2 : c800 01f4      : AND  .01f4
0ca4 : b05e           : CMP   005e
0ca5 : 0181 0d14      : JBC   1 CR 0d14
0ca7 : 8070           : LDA   0070
0ca8 : c800 01f4      : AND  .01f4
0caa : 0025           : SRL   5 A
0cab : 4130           : STO   0130
0cac : 0c02           : EXT  ,0402
0cad : 0130           : DATA
0cae : 005F           : DATA
0caf : 0131           : DATA
0cb0 : 8131           : LDA   0131
0cb1 : 9000 0019      : ADD  ,0019
0cb3 : 4132           : STO   0132
0cb4 : 0c02           : EXT  ,0402
0cb5 : 0081           : DATA
0cb6 : 005F           : DATA
0cb7 : 0133           : DATA
0cb8 : 8133           : LDA   0133
0cb9 : 9000 0019      : ADD  ,0019
0cbb : 4134           : STO   0134
0cbc : 8000 01f4      : LDA  ,01f4
0cbe : 9800 0133      : ADD  .0133
0cc0 : 4049           : STO   0049
0cc1 : 8800 0131      : LDA  .0131
0cc3 : 9000 06fa      : ADD  ,06fa
0cc5 : 404a           : STO   004a
0cc6 : 8000 fffb      : LDA  ,fffb
0cc8 : 404e           : STO   004e
0cc9 : 8949           : LDA  /0049+
0cca : 494a           : STO  /004a+
0ccb : 704e 0cc9      : ICZ   004e 0cc9
0ccd : 8134           : LDA   0134
0cce : b000 002d      : CMP  ,002d
0cd0 : 0191 0ce3      : JBS   1 CR 0ce3
0cd2 : 8000 01f4      : LDA  ,01f4
0cd4 : 9800 0134      : ADD  .0134
0cd6 : 4049           : STO   0049
0cd7 : 8800 0131      : LDA  .0131
0cd9 : 9000 0727      : ADD  ,0727
0cdb : 404a           : STO   004a
0cdc : 8000 fffb      : LDA  ,fffb
0cde : 404e           : STO   004e
0cdf : 8949           : LDA  /0049+
0ce0 : 494a           : STO  /004a+
0ce1 : 704e 0cdf      : ICZ   004e 0cdf
0ce3 : 8132           : LDA   0132
0ce4 : b000 002d      : CMP  ,002d
0ce6 : 0191 0d0f      : JBS   1 CR 0d0f
0ce8 : 8000 0221      : LDA  ,0221
0cea : 9800 0133      : ADD  .0133
0cec : 4049           : STO   0049
0ced : 8800 0132      : LDA  .0132
0cef : 9000 06fa      : ADD  ,06fa
0cf1 : 404a           : STO   004a
0cf2 : 8000 fffb      : LDA  ,fffb
0cf4 : 404e           : STO   004e
0cf5 : 8949           : LDA  /0049+
0cf6 : 494a           : STO  /004a+
0cf7 : 704e 0cf5      : ICZ   004e 0cf5
0cf9 : 8134           : LDA   0134
0cfa : b000 002d      : CMP  ,002d
0cfc : 0191 0d0f      : JBS   1 CR 0d0f
0cfe : 8000 0221      : LDA  ,0221
0d00 : 9800 0134      : ADD  .0134
0d02 : 4049           : STO   0049
0d03 : 8800 0132      : LDA  .0132
0d05 : 9000 0727      : ADD  ,0727
0d07 : 404a           : STO   004a
0d08 : 8000 fffb      : LDA  ,fffb
0d0a : 404e           : STO   004e
0d0b : 8949           : LDA  /0049+
0d0c : 494a           : STO  /004a+
0d0d : 704e 0d0b      : ICZ   004e 0d0b
0d0f : 805a           : LDA   005a
0d10 : 4800 01f1      : STO  .01f1
0d12 : f800 0d17      : JMP  .0d17
0d14 : 8075           : LDA   0075
0d15 : 4800 01ea      : STO  .01ea
0d17 : 3800           : RTC
0d18 : 3000           : RTN
0d19 : f800 0d2b      : JMP  .0d2b
0d1b : 4903           : STO  /0003+
0d1c : 8001           : LDA   0001
0d1d : 4903           : STO  /0003+
0d1e : 805a           : LDA   005a
0d1f : 4800 7fee      : STO  .7fee
0d21 : 03e0 0112      : SET   0 0112
0d23 : 8075           : LDA   0075
0d24 : 4800 01f2      : STO  .01f2
0d26 : 8b03           : LDA  /0003-
0d27 : 4001           : STO   0001
0d28 : 8b03           : LDA  /0003-
0d29 : 3000           : RTN
0d2a : 3800           : RTC
0d2b : 3000           : RTN
0d2c : f800 0dc7      : JMP  .0dc7
0d2e : 0041           : SLA   1 A
0d2f : 1000           : SJM
0d30 : 0000           : SRA   0 A
0d31 : 0000           : SRA   0 A
0d32 : f800 0d4c      : JMP  .0d4c
0d34 : f800 0d52      : JMP  .0d52
0d36 : f800 0d56      : JMP  .0d56
0d38 : f800 0d80      : JMP  .0d80
0d3a : 8116           : LDA   0116
0d3b : 0191 0d42      : JBS   1 CR 0d42
0d3d : 805a           : LDA   005a
0d3e : 4116           : STO   0116
0d3f : 805b           : LDA   005b
0d40 : 5800 034a      : ADS  .034a
0d42 : 2800 23e9      : CAL  .23e9
0d44 : 2800 1b66      : CAL  .1b66
0d46 : 2800 224f      : CAL  .224f
0d48 : 8112           : LDA   0112
0d49 : 905b           : ADD   005b
0d4a : f800 0d2e      : JMP  .0d2e
0d4c : 2800 119f      : CAL  .119f
0d4e : 2800 18f0      : CAL  .18f0
0d50 : f800 0d82      : JMP  .0d82
0d52 : 2800 2082      : CAL  .2082
0d54 : f800 0d82      : JMP  .0d82
0d56 : f800 0d6c      : JMP  .0d6c
0d58 : 0041           : SLA   1 A
0d59 : 1000           : SJM
0d5a : 0000           : SRA   0 A
0d5b : 0000           : SRA   0 A
0d5c : f800 0d70      : JMP  .0d70
0d5e : f800 0d74      : JMP  .0d74
0d60 : f800 0d82      : JMP  .0d82
0d62 : f800 0d82      : JMP  .0d82
0d64 : f800 0d82      : JMP  .0d82
0d66 : f800 0d82      : JMP  .0d82
0d68 : f800 0d78      : JMP  .0d78
0d6a : f800 0d7c      : JMP  .0d7c
0d6c : 8113           : LDA   0113
0d6d : 905b           : ADD   005b
0d6e : f800 0d58      : JMP  .0d58
0d70 : 2800 1700      : CAL  .1700
0d72 : f800 0d82      : JMP  .0d82
0d74 : 2800 1827      : CAL  .1827
0d76 : f800 0d82      : JMP  .0d82
0d78 : 2800 2321      : CAL  .2321
0d7a : f800 0d82      : JMP  .0d82
0d7c : 2800 0dd8      : CAL  .0dd8
0d7e : f800 0d82      : JMP  .0d82
0d80 : 2800 1bed      : CAL  .1bed
0d82 : 805b           : LDA   005b
0d83 : 5114           : ADS   0114
0d84 : 8114           : LDA   0114
0d85 : b000 00a0      : CMP  ,00a0
0d87 : 0181 0dc6      : JBC   1 CR 0dc6
0d89 : 805a           : LDA   005a
0d8a : 4114           : STO   0114
0d8b : 4800 0344      : STO  .0344
0d8d : 8800 0345      : LDA  .0345
0d8f : b064           : CMP   0064
0d90 : 0183 0d94      : JBC   3 CR 0d94
0d92 : 03e1 0344      : SET   1 0344
0d94 : 8800 0346      : LDA  .0346
0d96 : b064           : CMP   0064
0d97 : 0183 0d9b      : JBC   3 CR 0d9b
0d99 : 03e2 0344      : SET   2 0344
0d9b : 8800 0347      : LDA  .0347
0d9d : b064           : CMP   0064
0d9e : 0183 0da2      : JBC   3 CR 0da2
0da0 : 03e3 0344      : SET   3 0344
0da2 : 8800 0348      : LDA  .0348
0da4 : b064           : CMP   0064
0da5 : 0183 0da9      : JBC   3 CR 0da9
0da7 : 03e4 0344      : SET   4 0344
0da9 : 8800 0349      : LDA  .0349
0dab : b064           : CMP   0064
0dac : 0183 0db0      : JBC   3 CR 0db0
0dae : 03e5 0344      : SET   5 0344
0db0 : 8800 034a      : LDA  .034a
0db2 : b064           : CMP   0064
0db3 : 0183 0db7      : JBC   3 CR 0db7
0db5 : 03e0 0344      : SET   0 0344
0db7 : 805b           : LDA   005b
0db8 : 4137           : STO   0137
0db9 : 8137           : LDA   0137
0dba : b060           : CMP   0060
0dbb : 0193 0dc6      : JBS   3 CR 0dc6
0dbd : 9000 0344      : ADD  ,0344
0dbf : 4026           : STO   0026
0dc0 : 805a           : LDA   005a
0dc1 : 4826           : STO  /0026
0dc2 : 805b           : LDA   005b
0dc3 : 5137           : ADS   0137
0dc4 : f800 0db9      : JMP  .0db9
0dc6 : 3800           : RTC
0dc7 : 3000           : RTN
0dc8 : f800 0dd5      : JMP  .0dd5
0dca : 8112           : LDA   0112
0dcb : 905c           : ADD   005c
0dcc : c05c           : AND   005c
0dcd : 4112           : STO   0112
0dce : 0181 0dd4      : JBC   1 CR 0dd4
0dd0 : 8113           : LDA   0113
0dd1 : 905b           : ADD   005b
0dd2 : c061           : AND   0061
0dd3 : 4113           : STO   0113
0dd4 : 3800           : RTC
0dd5 : 3000           : RTN
0dd6 : f800 116f      : JMP  .116f
0dd8 : 8081           : LDA   0081
0dd9 : 413a           : STO   013a
0dda : 0c02           : EXT  ,0402
0ddb : 013A           : DATA
0ddc : 005D           : DATA
0ddd : 0143           : DATA
0dde : 8143           : LDA   0143
0ddf : 9000 0085      : ADD  ,0085
0de1 : 4026           : STO   0026
0de2 : 8826           : LDA  /0026
0de3 : 008f 116e      : JBC   f A 116e
0de5 : 813a           : LDA   013a
0de6 : b05b           : CMP   005b
0de7 : 0191 0def      : JBS   1 CR 0def
0de9 : b05c           : CMP   005c
0dea : 0191 0def      : JBS   1 CR 0def
0dec : b05e           : CMP   005e
0ded : 0181 116e      : JBC   1 CR 116e
0def : 0380 00cb 115f : JBC   0 00cb 115f
0df2 : 0381 00cb 115f : JBC   1 00cb 115f
0df5 : 0392 00cb 115f : JBS   2 00cb 115f
0df8 : 0393 00cb 115f : JBS   3 00cb 115f
0dfb : 813a           : LDA   013a
0dfc : 9000 0105      : ADD  ,0105
0dfe : 4026           : STO   0026
0dff : 8826           : LDA  /0026
0e00 : 0087 115f      : JBC   7 A 115f
0e02 : 805a           : LDA   005a
0e03 : 413e           : STO   013e
0e04 : 813e           : LDA   013e
0e05 : b062           : CMP   0062
0e06 : 0193 0e1d      : JBS   3 CR 0e1d
0e08 : 9000 0362      : ADD  ,0362
0e0a : 4026           : STO   0026
0e0b : 805a           : LDA   005a
0e0c : 4826           : STO  /0026
0e0d : 813e           : LDA   013e
0e0e : 9000 0359      : ADD  ,0359
0e10 : 4027           : STO   0027
0e11 : 805a           : LDA   005a
0e12 : 4827           : STO  /0027
0e13 : 813e           : LDA   013e
0e14 : 9000 0350      : ADD  ,0350
0e16 : 4028           : STO   0028
0e17 : 805a           : LDA   005a
0e18 : 4828           : STO  /0028
0e19 : 805b           : LDA   005b
0e1a : 513e           : ADS   013e
0e1b : f800 0e04      : JMP  .0e04
0e1d : 805a           : LDA   005a
0e1e : 413e           : STO   013e
0e1f : 813e           : LDA   013e
0e20 : b05e           : CMP   005e
0e21 : 0193 0e2c      : JBS   3 CR 0e2c
0e23 : 9000 034b      : ADD  ,034b
0e25 : 4026           : STO   0026
0e26 : 805a           : LDA   005a
0e27 : 4826           : STO  /0026
0e28 : 805b           : LDA   005b
0e29 : 513e           : ADS   013e
0e2a : f800 0e1f      : JMP  .0e1f
0e2c : 805a           : LDA   005a
0e2d : 413b           : STO   013b
0e2e : 8067           : LDA   0067
0e2f : 413c           : STO   013c
0e30 : 805a           : LDA   005a
0e31 : 413e           : STO   013e
0e32 : 813e           : LDA   013e
0e33 : b062           : CMP   0062
0e34 : 0193 0e8c      : JBS   3 CR 0e8c
0e36 : b13a           : CMP   013a
0e37 : 0191 0e88      : JBS   1 CR 0e88
0e39 : 9000 00fb      : ADD  ,00fb
0e3b : 4026           : STO   0026
0e3c : 806b           : LDA   006b
0e3d : c826           : AND  /0026
0e3e : 4143           : STO   0143
0e3f : 813c           : LDA   013c
0e40 : b143           : CMP   0143
0e41 : 0183 0e6c      : JBC   3 CR 0e6c
0e43 : 8075           : LDA   0075
0e44 : 4143           : STO   0143
0e45 : 805b           : LDA   005b
0e46 : 5143           : ADS   0143
0e47 : 813b           : LDA   013b
0e48 : b143           : CMP   0143
0e49 : 0183 0e53      : JBC   3 CR 0e53
0e4b : 8143           : LDA   0143
0e4c : 9000 0362      : ADD  ,0362
0e4e : 4026           : STO   0026
0e4f : 805a           : LDA   005a
0e50 : 4826           : STO  /0026
0e51 : f800 0e45      : JMP  .0e45
0e53 : 03ef 0362      : SET   f 0362
0e55 : 813e           : LDA   013e
0e56 : 006a           : SLL   a A
0e57 : c000 7c00      : AND  ,7c00
0e59 : 4145           : STO   0145
0e5a : 8000 83ff      : LDA  ,83ff
0e5c : c800 0362      : AND  .0362
0e5e : 9145           : ADD   0145
0e5f : 4800 0362      : STO  .0362
0e61 : 805b           : LDA   005b
0e62 : 413b           : STO   013b
0e63 : 813e           : LDA   013e
0e64 : 9000 00fb      : ADD  ,00fb
0e66 : 4026           : STO   0026
0e67 : 806b           : LDA   006b
0e68 : c826           : AND  /0026
0e69 : 413c           : STO   013c
0e6a : f800 0e88      : JMP  .0e88
0e6c : 813e           : LDA   013e
0e6d : 9000 00fb      : ADD  ,00fb
0e6f : 4026           : STO   0026
0e70 : 806b           : LDA   006b
0e71 : c826           : AND  /0026
0e72 : b13c           : CMP   013c
0e73 : 0181 0e88      : JBC   1 CR 0e88
0e75 : 813b           : LDA   013b
0e76 : 9000 0362      : ADD  ,0362
0e78 : 4027           : STO   0027
0e79 : 8827           : LDA  /0027
0e7a : 00ef           : SET   f A
0e7b : 4827           : STO  /0027
0e7c : 813e           : LDA   013e
0e7d : 006a           : SLL   a A
0e7e : c000 7c00      : AND  ,7c00
0e80 : 4144           : STO   0144
0e81 : 8000 83ff      : LDA  ,83ff
0e83 : c827           : AND  /0027
0e84 : 9144           : ADD   0144
0e85 : 4827           : STO  /0027
0e86 : 805b           : LDA   005b
0e87 : 513b           : ADS   013b
0e88 : 805b           : LDA   005b
0e89 : 513e           : ADS   013e
0e8a : f800 0e32      : JMP  .0e32
0e8c : 813b           : LDA   013b
0e8d : b05a           : CMP   005a
0e8e : 0183 10c6      : JBC   3 CR 10c6
0e90 : 805a           : LDA   005a
0e91 : 4140           : STO   0140
0e92 : 4141           : STO   0141
0e93 : 4142           : STO   0142
0e94 : 8075           : LDA   0075
0e95 : 4143           : STO   0143
0e96 : 805b           : LDA   005b
0e97 : 5143           : ADS   0143
0e98 : 813b           : LDA   013b
0e99 : b143           : CMP   0143
0e9a : 0183 0f6f      : JBC   3 CR 0f6f
0e9c : 8143           : LDA   0143
0e9d : 9000 0362      : ADD  ,0362
0e9f : 4026           : STO   0026
0ea0 : 8074           : LDA   0074
0ea1 : c826           : AND  /0026
0ea2 : 002a           : SRL   a A
0ea3 : 413e           : STO   013e
0ea4 : 813a           : LDA   013a
0ea5 : b13e           : CMP   013e
0ea6 : 0183 0ec9      : JBC   3 CR 0ec9
0ea8 : 813e           : LDA   013e
0ea9 : 9000 1972      : ADD  ,1972
0eab : 4027           : STO   0027
0eac : 8827           : LDA  /0027
0ead : 913a           : ADD   013a
0eae : a13e           : SUB   013e
0eaf : a05a           : SUB   005a
0eb0 : a05b           : SUB   005b
0eb1 : a05a           : SUB   005a
0eb2 : 9000 02f5      : ADD  ,02f5
0eb4 : 4028           : STO   0028
0eb5 : 806f           : LDA   006f
0eb6 : c828           : AND  /0028
0eb7 : 4145           : STO   0145
0eb8 : 8000 fc00      : LDA  ,fc00
0eba : c800 034b      : AND  .034b
0ebc : 9145           : ADD   0145
0ebd : 4800 034b      : STO  .034b
0ebf : 0099 0ec5      : JBS   9 A 0ec5
0ec1 : 03e9 034b      : SET   9 034b
0ec3 : f800 0ee0      : JMP  .0ee0
0ec5 : 03f9 034b      : CLR   9 034b
0ec7 : f800 0ee0      : JMP  .0ee0
0ec9 : 813a           : LDA   013a
0eca : 9000 1972      : ADD  ,1972
0ecc : 4026           : STO   0026
0ecd : 8826           : LDA  /0026
0ece : 913e           : ADD   013e
0ecf : a13a           : SUB   013a
0ed0 : a05a           : SUB   005a
0ed1 : a05b           : SUB   005b
0ed2 : a05a           : SUB   005a
0ed3 : 9000 02f5      : ADD  ,02f5
0ed5 : 4027           : STO   0027
0ed6 : 806f           : LDA   006f
0ed7 : c827           : AND  /0027
0ed8 : 4145           : STO   0145
0ed9 : 8000 fc00      : LDA  ,fc00
0edb : c800 034b      : AND  .034b
0edd : 9145           : ADD   0145
0ede : 4800 034b      : STO  .034b
0ee0 : 806f           : LDA   006f
0ee1 : c800 034b      : AND  .034b
0ee3 : 4144           : STO   0144
0ee4 : 813e           : LDA   013e
0ee5 : 9000 0359      : ADD  ,0359
0ee7 : 4026           : STO   0026
0ee8 : 8000 fc00      : LDA  ,fc00
0eea : c826           : AND  /0026
0eeb : 9144           : ADD   0144
0eec : 4826           : STO  /0026
0eed : 806f           : LDA   006f
0eee : c0cc           : AND   00cc
0eef : 4144           : STO   0144
0ef0 : 8000 fc00      : LDA  ,fc00
0ef2 : c800 034d      : AND  .034d
0ef4 : 9144           : ADD   0144
0ef5 : 4800 034d      : STO  .034d
0ef7 : 8800 034b      : LDA  .034b
0ef9 : 0066           : SLL   6 A
0efa : 0006           : SRA   6 A
0efb : 4145           : STO   0145
0efc : 8800 034d      : LDA  .034d
0efe : 0066           : SLL   6 A
0eff : 0006           : SRA   6 A
0f00 : a145           : SUB   0145
0f01 : a05a           : SUB   005a
0f02 : c06f           : AND   006f
0f03 : 4146           : STO   0146
0f04 : 8000 fc00      : LDA  ,fc00
0f06 : c800 034e      : AND  .034e
0f08 : 9146           : ADD   0146
0f09 : 4800 034e      : STO  .034e
0f0b : c06f           : AND   006f
0f0c : 4144           : STO   0144
0f0d : 813e           : LDA   013e
0f0e : 9000 0362      : ADD  ,0362
0f10 : 4027           : STO   0027
0f11 : 8000 fc00      : LDA  ,fc00
0f13 : c827           : AND  /0027
0f14 : 9144           : ADD   0144
0f15 : 4827           : STO  /0027
0f16 : 8800 034e      : LDA  .034e
0f18 : 0046           : SLA   6 A
0f19 : 008f 0f29      : JBC   f A 0f29
0f1b : 8800 034e      : LDA  .034e
0f1d : 0066           : SLL   6 A
0f1e : 0006           : SRA   6 A
0f1f : a05a           : SUB   005a
0f20 : c06f           : AND   006f
0f21 : 4146           : STO   0146
0f22 : 8000 fc00      : LDA  ,fc00
0f24 : c800 034e      : AND  .034e
0f26 : 9146           : ADD   0146
0f27 : 4800 034e      : STO  .034e
0f29 : 8800 034e      : LDA  .034e
0f2b : 0046           : SLA   6 A
0f2c : 4144           : STO   0144
0f2d : 8000 0e40      : LDA  ,0e40
0f2f : b144           : CMP   0144
0f30 : 0183 0f42      : JBC   3 CR 0f42
0f32 : 806a           : LDA   006a
0f33 : c13e           : AND   013e
0f34 : 4144           : STO   0144
0f35 : 8140           : LDA   0140
0f36 : 9000 0350      : ADD  ,0350
0f38 : 4026           : STO   0026
0f39 : 8000 ffe0      : LDA  ,ffe0
0f3b : c826           : AND  /0026
0f3c : 9144           : ADD   0144
0f3d : 4826           : STO  /0026
0f3e : 805b           : LDA   005b
0f3f : 5140           : ADS   0140
0f40 : f800 0e96      : JMP  .0e96
0f42 : 8800 034e      : LDA  .034e
0f44 : 0046           : SLA   6 A
0f45 : 4144           : STO   0144
0f46 : 8000 1c80      : LDA  ,1c80
0f48 : b144           : CMP   0144
0f49 : 0183 0f5d      : JBC   3 CR 0f5d
0f4b : 813e           : LDA   013e
0f4c : 0065           : SLL   5 A
0f4d : c000 03e0      : AND  ,03e0
0f4f : 4145           : STO   0145
0f50 : 8141           : LDA   0141
0f51 : 9000 0350      : ADD  ,0350
0f53 : 4026           : STO   0026
0f54 : 8000 fc1f      : LDA  ,fc1f
0f56 : c826           : AND  /0026
0f57 : 9145           : ADD   0145
0f58 : 4826           : STO  /0026
0f59 : 805b           : LDA   005b
0f5a : 5141           : ADS   0141
0f5b : f800 0e96      : JMP  .0e96
0f5d : 813e           : LDA   013e
0f5e : 006a           : SLL   a A
0f5f : c000 7c00      : AND  ,7c00
0f61 : 4145           : STO   0145
0f62 : 8142           : LDA   0142
0f63 : 9000 0350      : ADD  ,0350
0f65 : 4026           : STO   0026
0f66 : 8000 83ff      : LDA  ,83ff
0f68 : c826           : AND  /0026
0f69 : 9145           : ADD   0145
0f6a : 4826           : STO  /0026
0f6b : 805b           : LDA   005b
0f6c : 5142           : ADS   0142
0f6d : f800 0e96      : JMP  .0e96
0f6f : 8075           : LDA   0075
0f70 : 4143           : STO   0143
0f71 : 8000 fc00      : LDA  ,fc00
0f73 : c800 034f      : AND  .034f
0f75 : 906e           : ADD   006e
0f76 : 4800 034f      : STO  .034f
0f78 : 8140           : LDA   0140
0f79 : b05a           : CMP   005a
0f7a : 0183 0fd2      : JBC   3 CR 0fd2
0f7c : 805b           : LDA   005b
0f7d : 5143           : ADS   0143
0f7e : 8140           : LDA   0140
0f7f : b143           : CMP   0143
0f80 : 0183 10c8      : JBC   3 CR 10c8
0f82 : 8143           : LDA   0143
0f83 : 9000 0350      : ADD  ,0350
0f85 : 4026           : STO   0026
0f86 : 806a           : LDA   006a
0f87 : c826           : AND  /0026
0f88 : 413e           : STO   013e
0f89 : 9000 0362      : ADD  ,0362
0f8b : 4027           : STO   0027
0f8c : 806f           : LDA   006f
0f8d : c827           : AND  /0027
0f8e : 4144           : STO   0144
0f8f : 8000 fc00      : LDA  ,fc00
0f91 : c800 034e      : AND  .034e
0f93 : 9144           : ADD   0144
0f94 : 4800 034e      : STO  .034e
0f96 : 0046           : SLA   6 A
0f97 : 008f 0fa7      : JBC   f A 0fa7
0f99 : 8800 034e      : LDA  .034e
0f9b : 0066           : SLL   6 A
0f9c : 0006           : SRA   6 A
0f9d : a05a           : SUB   005a
0f9e : c06f           : AND   006f
0f9f : 4146           : STO   0146
0fa0 : 8000 fc00      : LDA  ,fc00
0fa2 : c800 034e      : AND  .034e
0fa4 : 9146           : ADD   0146
0fa5 : 4800 034e      : STO  .034e
0fa7 : 8800 034f      : LDA  .034f
0fa9 : 0046           : SLA   6 A
0faa : 4144           : STO   0144
0fab : 8800 034e      : LDA  .034e
0fad : 0046           : SLA   6 A
0fae : 4145           : STO   0145
0faf : 8144           : LDA   0144
0fb0 : b145           : CMP   0145
0fb1 : 0183 0f7c      : JBC   3 CR 0f7c
0fb3 : 813e           : LDA   013e
0fb4 : 413f           : STO   013f
0fb5 : 806f           : LDA   006f
0fb6 : c800 034e      : AND  .034e
0fb8 : 4144           : STO   0144
0fb9 : 8000 fc00      : LDA  ,fc00
0fbb : c800 034f      : AND  .034f
0fbd : 9144           : ADD   0144
0fbe : 4800 034f      : STO  .034f
0fc0 : 813e           : LDA   013e
0fc1 : 9000 0359      : ADD  ,0359
0fc3 : 4026           : STO   0026
0fc4 : 806f           : LDA   006f
0fc5 : c826           : AND  /0026
0fc6 : 4144           : STO   0144
0fc7 : 8000 fc00      : LDA  ,fc00
0fc9 : c800 034c      : AND  .034c
0fcb : 9144           : ADD   0144
0fcc : 4800 034c      : STO  .034c
0fce : 805b           : LDA   005b
0fcf : 413d           : STO   013d
0fd0 : f800 0f7c      : JMP  .0f7c
0fd2 : 8141           : LDA   0141
0fd3 : b05a           : CMP   005a
0fd4 : 0183 104e      : JBC   3 CR 104e
0fd6 : 805b           : LDA   005b
0fd7 : 5143           : ADS   0143
0fd8 : 8141           : LDA   0141
0fd9 : b143           : CMP   0143
0fda : 0183 10c8      : JBC   3 CR 10c8
0fdc : 8143           : LDA   0143
0fdd : 9000 0350      : ADD  ,0350
0fdf : 4026           : STO   0026
0fe0 : 806f           : LDA   006f
0fe1 : c826           : AND  /0026
0fe2 : 0025           : SRL   5 A
0fe3 : 413e           : STO   013e
0fe4 : 9000 0362      : ADD  ,0362
0fe6 : 4027           : STO   0027
0fe7 : 806f           : LDA   006f
0fe8 : c827           : AND  /0027
0fe9 : 4144           : STO   0144
0fea : 8000 fc00      : LDA  ,fc00
0fec : c800 034e      : AND  .034e
0fee : 9144           : ADD   0144
0fef : 4800 034e      : STO  .034e
0ff1 : 0046           : SLA   6 A
0ff2 : 008f 1002      : JBC   f A 1002
0ff4 : 8800 034e      : LDA  .034e
0ff6 : 0066           : SLL   6 A
0ff7 : 0006           : SRA   6 A
0ff8 : a05a           : SUB   005a
0ff9 : c06f           : AND   006f
0ffa : 4146           : STO   0146
0ffb : 8000 fc00      : LDA  ,fc00
0ffd : c800 034e      : AND  .034e
0fff : 9146           : ADD   0146
1000 : 4800 034e      : STO  .034e
1002 : 8800 034e      : LDA  .034e
1004 : 0066           : SLL   6 A
1005 : 0006           : SRA   6 A
1006 : a000 0055      : SUB  ,0055
1008 : a05a           : SUB   005a
1009 : c06f           : AND   006f
100a : 4146           : STO   0146
100b : 8000 fc00      : LDA  ,fc00
100d : c800 034e      : AND  .034e
100f : 9146           : ADD   0146
1010 : 4800 034e      : STO  .034e
1012 : 0046           : SLA   6 A
1013 : 008f 1023      : JBC   f A 1023
1015 : 8800 034e      : LDA  .034e
1017 : 0066           : SLL   6 A
1018 : 0006           : SRA   6 A
1019 : a05a           : SUB   005a
101a : c06f           : AND   006f
101b : 4146           : STO   0146
101c : 8000 fc00      : LDA  ,fc00
101e : c800 034e      : AND  .034e
1020 : 9146           : ADD   0146
1021 : 4800 034e      : STO  .034e
1023 : 8800 034f      : LDA  .034f
1025 : 0046           : SLA   6 A
1026 : 4144           : STO   0144
1027 : 8800 034e      : LDA  .034e
1029 : 0046           : SLA   6 A
102a : 4145           : STO   0145
102b : 8144           : LDA   0144
102c : b145           : CMP   0145
102d : 0183 0fd6      : JBC   3 CR 0fd6
102f : 813e           : LDA   013e
1030 : 413f           : STO   013f
1031 : 806f           : LDA   006f
1032 : c800 034e      : AND  .034e
1034 : 4144           : STO   0144
1035 : 8000 fc00      : LDA  ,fc00
1037 : c800 034f      : AND  .034f
1039 : 9144           : ADD   0144
103a : 4800 034f      : STO  .034f
103c : 813e           : LDA   013e
103d : 9000 0359      : ADD  ,0359
103f : 4026           : STO   0026
1040 : 806f           : LDA   006f
1041 : c826           : AND  /0026
1042 : 4144           : STO   0144
1043 : 8000 fc00      : LDA  ,fc00
1045 : c800 034c      : AND  .034c
1047 : 9144           : ADD   0144
1048 : 4800 034c      : STO  .034c
104a : 805c           : LDA   005c
104b : 413d           : STO   013d
104c : f800 0fd6      : JMP  .0fd6
104e : 805b           : LDA   005b
104f : 5143           : ADS   0143
1050 : 8142           : LDA   0142
1051 : b143           : CMP   0143
1052 : 0183 10c8      : JBC   3 CR 10c8
1054 : 8143           : LDA   0143
1055 : 9000 0350      : ADD  ,0350
1057 : 4026           : STO   0026
1058 : 8074           : LDA   0074
1059 : c826           : AND  /0026
105a : 002a           : SRL   a A
105b : 413e           : STO   013e
105c : 9000 0362      : ADD  ,0362
105e : 4027           : STO   0027
105f : 806f           : LDA   006f
1060 : c827           : AND  /0027
1061 : 4144           : STO   0144
1062 : 8000 fc00      : LDA  ,fc00
1064 : c800 034e      : AND  .034e
1066 : 9144           : ADD   0144
1067 : 4800 034e      : STO  .034e
1069 : 0046           : SLA   6 A
106a : 008f 107a      : JBC   f A 107a
106c : 8800 034e      : LDA  .034e
106e : 0066           : SLL   6 A
106f : 0006           : SRA   6 A
1070 : a05a           : SUB   005a
1071 : c06f           : AND   006f
1072 : 4146           : STO   0146
1073 : 8000 fc00      : LDA  ,fc00
1075 : c800 034e      : AND  .034e
1077 : 9146           : ADD   0146
1078 : 4800 034e      : STO  .034e
107a : 8800 034e      : LDA  .034e
107c : 0066           : SLL   6 A
107d : 0006           : SRA   6 A
107e : a000 00aa      : SUB  ,00aa
1080 : a05a           : SUB   005a
1081 : c06f           : AND   006f
1082 : 4146           : STO   0146
1083 : 8000 fc00      : LDA  ,fc00
1085 : c800 034e      : AND  .034e
1087 : 9146           : ADD   0146
1088 : 4800 034e      : STO  .034e
108a : 0046           : SLA   6 A
108b : 008f 109b      : JBC   f A 109b
108d : 8800 034e      : LDA  .034e
108f : 0066           : SLL   6 A
1090 : 0006           : SRA   6 A
1091 : a05a           : SUB   005a
1092 : c06f           : AND   006f
1093 : 4146           : STO   0146
1094 : 8000 fc00      : LDA  ,fc00
1096 : c800 034e      : AND  .034e
1098 : 9146           : ADD   0146
1099 : 4800 034e      : STO  .034e
109b : 8800 034f      : LDA  .034f
109d : 0046           : SLA   6 A
109e : 4144           : STO   0144
109f : 8800 034e      : LDA  .034e
10a1 : 0046           : SLA   6 A
10a2 : 4145           : STO   0145
10a3 : 8144           : LDA   0144
10a4 : b145           : CMP   0145
10a5 : 0183 104e      : JBC   3 CR 104e
10a7 : 813e           : LDA   013e
10a8 : 413f           : STO   013f
10a9 : 806f           : LDA   006f
10aa : c800 034e      : AND  .034e
10ac : 4144           : STO   0144
10ad : 8000 fc00      : LDA  ,fc00
10af : c800 034f      : AND  .034f
10b1 : 9144           : ADD   0144
10b2 : 4800 034f      : STO  .034f
10b4 : 813e           : LDA   013e
10b5 : 9000 0359      : ADD  ,0359
10b7 : 4026           : STO   0026
10b8 : 806f           : LDA   006f
10b9 : c826           : AND  /0026
10ba : 4144           : STO   0144
10bb : 8000 fc00      : LDA  ,fc00
10bd : c800 034c      : AND  .034c
10bf : 9144           : ADD   0144
10c0 : 4800 034c      : STO  .034c
10c2 : 805d           : LDA   005d
10c3 : 413d           : STO   013d
10c4 : f800 104e      : JMP  .104e
10c6 : 805e           : LDA   005e
10c7 : 413d           : STO   013d
10c8 : f800 10d6      : JMP  .10d6
10ca : 0041           : SLA   1 A
10cb : 1000           : SJM
10cc : 0000           : SRA   0 A
10cd : 0000           : SRA   0 A
10ce : f800 113e      : JMP  .113e
10d0 : f800 10d9      : JMP  .10d9
10d2 : f800 1105      : JMP  .1105
10d4 : f800 1131      : JMP  .1131
10d6 : 813d           : LDA   013d
10d7 : f800 10ca      : JMP  .10ca
10d9 : 813f           : LDA   013f
10da : 9000 0362      : ADD  ,0362
10dc : 4026           : STO   0026
10dd : 8826           : LDA  /0026
10de : 0046           : SLA   6 A
10df : b05a           : CMP   005a
10e0 : 0183 10f3      : JBC   3 CR 10f3
10e2 : 8800 034c      : LDA  .034c
10e4 : 0066           : SLL   6 A
10e5 : 0006           : SRA   6 A
10e6 : 9000 0055      : ADD  ,0055
10e8 : c06f           : AND   006f
10e9 : 4145           : STO   0145
10ea : 8000 fc00      : LDA  ,fc00
10ec : c800 034c      : AND  .034c
10ee : 9145           : ADD   0145
10ef : 4800 034c      : STO  .034c
10f1 : f800 113e      : JMP  .113e
10f3 : 8800 034c      : LDA  .034c
10f5 : 0066           : SLL   6 A
10f6 : 0006           : SRA   6 A
10f7 : a000 0055      : SUB  ,0055
10f9 : a05a           : SUB   005a
10fa : c06f           : AND   006f
10fb : 4147           : STO   0147
10fc : 8000 fc00      : LDA  ,fc00
10fe : c800 034c      : AND  .034c
1100 : 9147           : ADD   0147
1101 : 4800 034c      : STO  .034c
1103 : f800 113e      : JMP  .113e
1105 : 813f           : LDA   013f
1106 : 9000 0362      : ADD  ,0362
1108 : 4026           : STO   0026
1109 : 8826           : LDA  /0026
110a : 0046           : SLA   6 A
110b : b05a           : CMP   005a
110c : 0183 111f      : JBC   3 CR 111f
110e : 8800 034c      : LDA  .034c
1110 : 0066           : SLL   6 A
1111 : 0006           : SRA   6 A
1112 : 9000 00aa      : ADD  ,00aa
1114 : c06f           : AND   006f
1115 : 4145           : STO   0145
1116 : 8000 fc00      : LDA  ,fc00
1118 : c800 034c      : AND  .034c
111a : 9145           : ADD   0145
111b : 4800 034c      : STO  .034c
111d : f800 113e      : JMP  .113e
111f : 8800 034c      : LDA  .034c
1121 : 0066           : SLL   6 A
1122 : 0006           : SRA   6 A
1123 : a000 00aa      : SUB  ,00aa
1125 : a05a           : SUB   005a
1126 : c06f           : AND   006f
1127 : 4147           : STO   0147
1128 : 8000 fc00      : LDA  ,fc00
112a : c800 034c      : AND  .034c
112c : 9147           : ADD   0147
112d : 4800 034c      : STO  .034c
112f : f800 113e      : JMP  .113e
1131 : 806f           : LDA   006f
1132 : c0cc           : AND   00cc
1133 : a05d           : SUB   005d
1134 : a05a           : SUB   005a
1135 : c06f           : AND   006f
1136 : 4144           : STO   0144
1137 : 8000 fc00      : LDA  ,fc00
1139 : c800 034c      : AND  .034c
113b : 9144           : ADD   0144
113c : 4800 034c      : STO  .034c
113e : 8800 034c      : LDA  .034c
1140 : 0066           : SLL   6 A
1141 : 0006           : SRA   6 A
1142 : 4144           : STO   0144
1143 : 806f           : LDA   006f
1144 : c10f           : AND   010f
1145 : 5144           : ADS   0144
1146 : 806f           : LDA   006f
1147 : c0cc           : AND   00cc
1148 : 6144           : SBS   0144
1149 : 806f           : LDA   006f
114a : c144           : AND   0144
114b : 4145           : STO   0145
114c : 8000 fc00      : LDA  ,fc00
114e : c10f           : AND   010f
114f : 9145           : ADD   0145
1150 : 410f           : STO   010f
1151 : 404c           : STO   004c
1152 : 805a           : LDA   005a
1153 : 4139           : STO   0139
1154 : 810f           : LDA   010f
1155 : 0066           : SLL   6 A
1156 : 4143           : STO   0143
1157 : 806b           : LDA   006b
1158 : c139           : AND   0139
1159 : 9143           : ADD   0143
115a : 4139           : STO   0139
115b : 4800 7fa0      : STO  .7fa0
115d : f800 116e      : JMP  .116e
115f : 0380 00cb 116e : JBC   0 00cb 116e
1162 : 813a           : LDA   013a
1163 : 9000 0105      : ADD  ,0105
1165 : 4026           : STO   0026
1166 : 8826           : LDA  /0026
1167 : 0087 116e      : JBC   7 A 116e
1169 : 0382 00cb 116e : JBC   2 00cb 116e
116c : 2800 1172      : CAL  .1172
116e : 3800           : RTC
116f : 3000           : RTN
1170 : f800 119c      : JMP  .119c
1172 : 8081           : LDA   0081
1173 : 4149           : STO   0149
1174 : 9000 00bc      : ADD  ,00bc
1176 : 4026           : STO   0026
1177 : 8826           : LDA  /0026
1178 : 008f 119b      : JBC   f A 119b
117a : 0066           : SLL   6 A
117b : 0006           : SRA   6 A
117c : 414c           : STO   014c
117d : 806f           : LDA   006f
117e : c10f           : AND   010f
117f : 514c           : ADS   014c
1180 : 806f           : LDA   006f
1181 : c0cc           : AND   00cc
1182 : 614c           : SBS   014c
1183 : 806f           : LDA   006f
1184 : c14c           : AND   014c
1185 : 414d           : STO   014d
1186 : 8000 fc00      : LDA  ,fc00
1188 : c10f           : AND   010f
1189 : 914d           : ADD   014d
118a : 410f           : STO   010f
118b : 404c           : STO   004c
118c : 805a           : LDA   005a
118d : 414a           : STO   014a
118e : 8149           : LDA   0149
118f : 9000 00bc      : ADD  ,00bc
1191 : 4026           : STO   0026
1192 : 8826           : LDA  /0026
1193 : 0066           : SLL   6 A
1194 : 414b           : STO   014b
1195 : 806b           : LDA   006b
1196 : c14a           : AND   014a
1197 : 914b           : ADD   014b
1198 : 414a           : STO   014a
1199 : 4800 7fa0      : STO  .7fa0
119b : 3800           : RTC
119c : 3000           : RTN
119d : f800 16fd      : JMP  .16fd
119f : 8081           : LDA   0081
11a0 : 4155           : STO   0155
11a1 : 805a           : LDA   005a
11a2 : 4152           : STO   0152
11a3 : 8152           : LDA   0152
11a4 : b05b           : CMP   005b
11a5 : 0193 163f      : JBS   3 CR 163f
11a7 : 9000 0081      : ADD  ,0081
11a9 : 4026           : STO   0026
11aa : 8826           : LDA  /0026
11ab : 415c           : STO   015c
11ac : 0c02           : EXT  ,0402
11ad : 015C           : DATA
11ae : 005D           : DATA
11af : 015F           : DATA
11b0 : 815f           : LDA   015f
11b1 : 9000 0085      : ADD  ,0085
11b3 : 4027           : STO   0027
11b4 : 8827           : LDA  /0027
11b5 : 008f 1614      : JBC   f A 1614
11b7 : 815c           : LDA   015c
11b8 : 9000 00c1      : ADD  ,00c1
11ba : 4027           : STO   0027
11bb : 8827           : LDA  /0027
11bc : 0094 1614      : JBS   4 A 1614
11be : 805a           : LDA   005a
11bf : 415a           : STO   015a
11c0 : 815a           : LDA   015a
11c1 : b062           : CMP   0062
11c2 : 0193 1636      : JBS   3 CR 1636
11c4 : 805a           : LDA   005a
11c5 : 4150           : STO   0150
11c6 : 414f           : STO   014f
11c7 : 4156           : STO   0156
11c8 : 815c           : LDA   015c
11c9 : b15a           : CMP   015a
11ca : 0191 15ed      : JBS   1 CR 15ed
11cc : 0c02           : EXT  ,0402
11cd : 015A           : DATA
11ce : 005D           : DATA
11cf : 015F           : DATA
11d0 : 815f           : LDA   015f
11d1 : 9000 0085      : ADD  ,0085
11d3 : 4026           : STO   0026
11d4 : 8826           : LDA  /0026
11d5 : 008f 15ed      : JBC   f A 15ed
11d7 : 0c02           : EXT  ,0402
11d8 : 015C           : DATA
11d9 : 005D           : DATA
11da : 015F           : DATA
11db : 0c02           : EXT  ,0402
11dc : 015A           : DATA
11dd : 005D           : DATA
11de : 0160           : DATA
11df : 8160           : LDA   0160
11e0 : 9000 0085      : ADD  ,0085
11e2 : 4026           : STO   0026
11e3 : 8000 7000      : LDA  ,7000
11e5 : c826           : AND  /0026
11e6 : 4161           : STO   0161
11e7 : 815f           : LDA   015f
11e8 : 9000 0085      : ADD  ,0085
11ea : 4026           : STO   0026
11eb : 8000 7000      : LDA  ,7000
11ed : c826           : AND  /0026
11ee : b161           : CMP   0161
11ef : 0181 15ed      : JBC   1 CR 15ed
11f1 : 8152           : LDA   0152
11f2 : 0181 11fd      : JBC   1 CR 11fd
11f4 : 815a           : LDA   015a
11f5 : 9000 00cd      : ADD  ,00cd
11f7 : 4026           : STO   0026
11f8 : 806f           : LDA   006f
11f9 : c826           : AND  /0026
11fa : 4153           : STO   0153
11fb : f800 1204      : JMP  .1204
11fd : 815a           : LDA   015a
11fe : 9000 00d7      : ADD  ,00d7
1200 : 4026           : STO   0026
1201 : 806f           : LDA   006f
1202 : c826           : AND  /0026
1203 : 4153           : STO   0153
1204 : 8153           : LDA   0153
1205 : b06f           : CMP   006f
1206 : 0191 15e9      : JBS   1 CR 15e9
1208 : 0044           : SLA   4 A
1209 : 905b           : ADD   005b
120a : 407a           : STO   007a
120b : 8000 007d      : LDA  ,007d
120d : 407b           : STO   007b
120e : 0c06           : EXT  ,0406
120f : 007A           : DATA
1210 : 007B           : DATA
1211 : 0078           : DATA
1212 : 8079           : LDA   0079
1213 : 4153           : STO   0153
1214 : a800 4160      : SUB  .4160
1216 : 415e           : STO   015e
1217 : 008f 121c      : JBC   f A 121c
1219 : 9000 00b0      : ADD  ,00b0
121b : 415e           : STO   015e
121c : 815e           : LDA   015e
121d : 0041           : SLA   1 A
121e : 9152           : ADD   0152
121f : 415d           : STO   015d
1220 : 9000 4000      : ADD  ,4000
1222 : 4026           : STO   0026
1223 : 8826           : LDA  /0026
1224 : 009f 122a      : JBS   f A 122a
1226 : 805a           : LDA   005a
1227 : 415b           : STO   015b
1228 : f800 1239      : JMP  .1239
122a : 815d           : LDA   015d
122b : 9000 4000      : ADD  ,4000
122d : 4026           : STO   0026
122e : 8826           : LDA  /0026
122f : 008a 1237      : JBC   a A 1237
1231 : 008e 1237      : JBC   e A 1237
1233 : 805a           : LDA   005a
1234 : 415b           : STO   015b
1235 : f800 1239      : JMP  .1239
1237 : 805b           : LDA   005b
1238 : 415b           : STO   015b
1239 : 815b           : LDA   015b
123a : 0181 1255      : JBC   1 CR 1255
123c : 8000 0050      : LDA  ,0050
123e : 615e           : SBS   015e
123f : 038f 015e 1245 : JBC   f 015e 1245
1242 : 8000 00b0      : LDA  ,00b0
1244 : 515e           : ADS   015e
1245 : 815e           : LDA   015e
1246 : 0041           : SLA   1 A
1247 : 9152           : ADD   0152
1248 : 415d           : STO   015d
1249 : 9000 4000      : ADD  ,4000
124b : 4026           : STO   0026
124c : 8826           : LDA  /0026
124d : 008f 1255      : JBC   f A 1255
124f : 008a 1255      : JBC   a A 1255
1251 : 008e 1255      : JBC   e A 1255
1253 : 805b           : LDA   005b
1254 : 415b           : STO   015b
1255 : 815b           : LDA   015b
1256 : 0191 15e5      : JBS   1 CR 15e5
1258 : 815a           : LDA   015a
1259 : 9000 0105      : ADD  ,0105
125b : 4026           : STO   0026
125c : 8000 1f00      : LDA  ,1f00
125e : c826           : AND  /0026
125f : 0191 15e5      : JBS   1 CR 15e5
1261 : 815a           : LDA   015a
1262 : 9000 00c1      : ADD  ,00c1
1264 : 4027           : STO   0027
1265 : 8827           : LDA  /0027
1266 : 0094 15e5      : JBS   4 A 15e5
1268 : 815d           : LDA   015d
1269 : 9000 4000      : ADD  ,4000
126b : 4028           : STO   0028
126c : 8828           : LDA  /0028
126d : 008b 1273      : JBC   b A 1273
126f : 805b           : LDA   005b
1270 : 414f           : STO   014f
1271 : f800 127c      : JMP  .127c
1273 : 815d           : LDA   015d
1274 : 9000 4000      : ADD  ,4000
1276 : 4026           : STO   0026
1277 : 8826           : LDA  /0026
1278 : 0099 127c      : JBS   9 A 127c
127a : 805b           : LDA   005b
127b : 4156           : STO   0156
127c : 815c           : LDA   015c
127d : b15a           : CMP   015a
127e : 0183 129b      : JBC   3 CR 129b
1280 : 815a           : LDA   015a
1281 : 9000 1972      : ADD  ,1972
1283 : 4026           : STO   0026
1284 : 8826           : LDA  /0026
1285 : 915c           : ADD   015c
1286 : a15a           : SUB   015a
1287 : a05a           : SUB   005a
1288 : a05b           : SUB   005b
1289 : a05a           : SUB   005a
128a : 4158           : STO   0158
128b : 9000 02f5      : ADD  ,02f5
128d : 4027           : STO   0027
128e : 806f           : LDA   006f
128f : c827           : AND  /0027
1290 : 4151           : STO   0151
1291 : 0089 1297      : JBC   9 A 1297
1293 : 03f9 0151      : CLR   9 0151
1295 : f800 12ac      : JMP  .12ac
1297 : 03e9 0151      : SET   9 0151
1299 : f800 12ac      : JMP  .12ac
129b : 815c           : LDA   015c
129c : 9000 1972      : ADD  ,1972
129e : 4026           : STO   0026
129f : 8826           : LDA  /0026
12a0 : 915a           : ADD   015a
12a1 : a15c           : SUB   015c
12a2 : a05a           : SUB   005a
12a3 : a05b           : SUB   005b
12a4 : a05a           : SUB   005a
12a5 : 4158           : STO   0158
12a6 : 9000 02f5      : ADD  ,02f5
12a8 : 4027           : STO   0027
12a9 : 806f           : LDA   006f
12aa : c827           : AND  /0027
12ab : 4151           : STO   0151
12ac : 8158           : LDA   0158
12ad : 9000 0319      : ADD  ,0319
12af : 4026           : STO   0026
12b0 : 8826           : LDA  /0026
12b1 : 4159           : STO   0159
12b2 : 806f           : LDA   006f
12b3 : c151           : AND   0151
12b4 : 415f           : STO   015f
12b5 : 8000 fc00      : LDA  ,fc00
12b7 : c800 03c2      : AND  .03c2
12b9 : 915f           : ADD   015f
12ba : 4800 03c2      : STO  .03c2
12bc : 0c02           : EXT  ,0402
12bd : 015C           : DATA
12be : 005D           : DATA
12bf : 015F           : DATA
12c0 : 815f           : LDA   015f
12c1 : 9000 0087      : ADD  ,0087
12c3 : 4027           : STO   0027
12c4 : 806f           : LDA   006f
12c5 : c827           : AND  /0027
12c6 : 4160           : STO   0160
12c7 : 8000 fc00      : LDA  ,fc00
12c9 : c800 03c3      : AND  .03c3
12cb : 9160           : ADD   0160
12cc : 4800 03c3      : STO  .03c3
12ce : 815d           : LDA   015d
12cf : 9000 4000      : ADD  ,4000
12d1 : 4027           : STO   0027
12d2 : 8061           : LDA   0061
12d3 : c827           : AND  /0027
12d4 : 4157           : STO   0157
12d5 : 8000 00f8      : LDA  ,00f8
12d7 : c827           : AND  /0027
12d8 : 0181 12de      : JBC   1 CR 12de
12da : 03e5 0150      : SET   5 0150
12dc : f800 135c      : JMP  .135c
12de : 815d           : LDA   015d
12df : 9000 4000      : ADD  ,4000
12e1 : 4026           : STO   0026
12e2 : 8826           : LDA  /0026
12e3 : 0087 1308      : JBC   7 A 1308
12e5 : 814f           : LDA   014f
12e6 : 0191 12f8      : JBS   1 CR 12f8
12e8 : 8157           : LDA   0157
12e9 : 0043           : SLA   3 A
12ea : 9000 0371      : ADD  ,0371
12ec : 4027           : STO   0027
12ed : 8827           : LDA  /0027
12ee : 415f           : STO   015f
12ef : 8157           : LDA   0157
12f0 : 0043           : SLA   3 A
12f1 : 9000 0372      : ADD  ,0372
12f3 : 4027           : STO   0027
12f4 : 8827           : LDA  /0027
12f5 : 4160           : STO   0160
12f6 : f800 1329      : JMP  .1329
12f8 : 8157           : LDA   0157
12f9 : 0043           : SLA   3 A
12fa : 9000 036d      : ADD  ,036d
12fc : 4026           : STO   0026
12fd : 8826           : LDA  /0026
12fe : 415f           : STO   015f
12ff : 8157           : LDA   0157
1300 : 0043           : SLA   3 A
1301 : 9000 036e      : ADD  ,036e
1303 : 4026           : STO   0026
1304 : 8826           : LDA  /0026
1305 : 4160           : STO   0160
1306 : f800 1329      : JMP  .1329
1308 : 814f           : LDA   014f
1309 : 0191 131b      : JBS   1 CR 131b
130b : 8157           : LDA   0157
130c : 0043           : SLA   3 A
130d : 9000 036f      : ADD  ,036f
130f : 4026           : STO   0026
1310 : 8826           : LDA  /0026
1311 : 415f           : STO   015f
1312 : 8157           : LDA   0157
1313 : 0043           : SLA   3 A
1314 : 9000 0370      : ADD  ,0370
1316 : 4026           : STO   0026
1317 : 8826           : LDA  /0026
1318 : 4160           : STO   0160
1319 : f800 1329      : JMP  .1329
131b : 8157           : LDA   0157
131c : 0043           : SLA   3 A
131d : 9000 036b      : ADD  ,036b
131f : 4026           : STO   0026
1320 : 8826           : LDA  /0026
1321 : 415f           : STO   015f
1322 : 8157           : LDA   0157
1323 : 0043           : SLA   3 A
1324 : 9000 036c      : ADD  ,036c
1326 : 4026           : STO   0026
1327 : 8826           : LDA  /0026
1328 : 4160           : STO   0160
1329 : 815f           : LDA   015f
132a : b159           : CMP   0159
132b : 0193 1331      : JBS   3 CR 1331
132d : 03e5 0150      : SET   5 0150
132f : f800 135c      : JMP  .135c
1331 : 8159           : LDA   0159
1332 : b160           : CMP   0160
1333 : 0193 1339      : JBS   3 CR 1339
1335 : 805a           : LDA   005a
1336 : 4150           : STO   0150
1337 : f800 135c      : JMP  .135c
1339 : 8160           : LDA   0160
133a : a159           : SUB   0159
133b : 4162           : STO   0162
133c : 8160           : LDA   0160
133d : a15f           : SUB   015f
133e : 4161           : STO   0161
133f : 805a           : LDA   005a
1340 : 4079           : STO   0079
1341 : 8162           : LDA   0162
1342 : 01e5           : SET   5 CR
1343 : 0305 0079      : SRA   5 0079
1345 : 01f5           : CLR   5 CR
1346 : 4078           : STO   0078
1347 : 0c05           : EXT  ,0405
1348 : 0078           : DATA
1349 : 0161           : DATA
134a : 0078           : DATA
134b : 8079           : LDA   0079
134c : 4163           : STO   0163
134d : 8000 7000      : LDA  ,7000
134f : 407a           : STO   007a
1350 : 0c01           : EXT  ,0401
1351 : 0163           : DATA
1352 : 007A           : DATA
1353 : 0078           : DATA
1354 : 8078           : LDA   0078
1355 : 01e5           : SET   5 CR
1356 : 0344 0079      : SLA   4 0079
1358 : 01f5           : CLR   5 CR
1359 : 4163           : STO   0163
135a : 002a           : SRL   a A
135b : 4150           : STO   0150
135c : 0c02           : EXT  ,0402
135d : 015C           : DATA
135e : 005D           : DATA
135f : 015F           : DATA
1360 : 0c02           : EXT  ,0402
1361 : 015A           : DATA
1362 : 005D           : DATA
1363 : 0160           : DATA
1364 : 8160           : LDA   0160
1365 : 9000 0085      : ADD  ,0085
1367 : 4026           : STO   0026
1368 : 8000 0e00      : LDA  ,0e00
136a : c826           : AND  /0026
136b : 4161           : STO   0161
136c : 815f           : LDA   015f
136d : 9000 0085      : ADD  ,0085
136f : 4026           : STO   0026
1370 : 8000 0e00      : LDA  ,0e00
1372 : c826           : AND  /0026
1373 : b161           : CMP   0161
1374 : 0191 13d0      : JBS   1 CR 13d0
1376 : 0c02           : EXT  ,0402
1377 : 015C           : DATA
1378 : 005D           : DATA
1379 : 0161           : DATA
137a : 0c02           : EXT  ,0402
137b : 015A           : DATA
137c : 005D           : DATA
137d : 0162           : DATA
137e : 8162           : LDA   0162
137f : 9000 0085      : ADD  ,0085
1381 : 4026           : STO   0026
1382 : 8000 0e00      : LDA  ,0e00
1384 : c826           : AND  /0026
1385 : 4163           : STO   0163
1386 : 8161           : LDA   0161
1387 : 9000 0085      : ADD  ,0085
1389 : 4026           : STO   0026
138a : 8000 0e00      : LDA  ,0e00
138c : c826           : AND  /0026
138d : b163           : CMP   0163
138e : 0183 13ac      : JBC   3 CR 13ac
1390 : 0c02           : EXT  ,0402
1391 : 015C           : DATA
1392 : 005D           : DATA
1393 : 0163           : DATA
1394 : 0c02           : EXT  ,0402
1395 : 015A           : DATA
1396 : 005D           : DATA
1397 : 0164           : DATA
1398 : 8164           : LDA   0164
1399 : 9000 0085      : ADD  ,0085
139b : 4026           : STO   0026
139c : 8071           : LDA   0071
139d : c826           : AND  /0026
139e : 0029           : SRL   9 A
139f : 4166           : STO   0166
13a0 : 8163           : LDA   0163
13a1 : 9000 0085      : ADD  ,0085
13a3 : 4026           : STO   0026
13a4 : 8071           : LDA   0071
13a5 : c826           : AND  /0026
13a6 : 0029           : SRL   9 A
13a7 : a166           : SUB   0166
13a8 : a05a           : SUB   005a
13a9 : 4154           : STO   0154
13aa : f800 13c6      : JMP  .13c6
13ac : 0c02           : EXT  ,0402
13ad : 015A           : DATA
13ae : 005D           : DATA
13af : 0166           : DATA
13b0 : 0c02           : EXT  ,0402
13b1 : 015C           : DATA
13b2 : 005D           : DATA
13b3 : 0167           : DATA
13b4 : 8167           : LDA   0167
13b5 : 9000 0085      : ADD  ,0085
13b7 : 4026           : STO   0026
13b8 : 8071           : LDA   0071
13b9 : c826           : AND  /0026
13ba : 0029           : SRL   9 A
13bb : 4169           : STO   0169
13bc : 8166           : LDA   0166
13bd : 9000 0085      : ADD  ,0085
13bf : 4026           : STO   0026
13c0 : 8071           : LDA   0071
13c1 : c826           : AND  /0026
13c2 : 0029           : SRL   9 A
13c3 : a169           : SUB   0169
13c4 : a05a           : SUB   005a
13c5 : 4154           : STO   0154
13c6 : 8154           : LDA   0154
13c7 : b05b           : CMP   005b
13c8 : 0183 13ce      : JBC   3 CR 13ce
13ca : 805c           : LDA   005c
13cb : 5150           : ADS   0150
13cc : f800 13d0      : JMP  .13d0
13ce : 805b           : LDA   005b
13cf : 5150           : ADS   0150
13d0 : 8068           : LDA   0068
13d1 : b150           : CMP   0150
13d2 : 0193 13d8      : JBS   3 CR 13d8
13d4 : 03e5 0150      : SET   5 0150
13d6 : f800 14cc      : JMP  .14cc
13d8 : 815d           : LDA   015d
13d9 : 9000 4000      : ADD  ,4000
13db : 4026           : STO   0026
13dc : 8826           : LDA  /0026
13dd : 0096 14cc      : JBS   6 A 14cc
13df : c000 0038      : AND  ,0038
13e1 : 0191 144a      : JBS   1 CR 144a
13e3 : 8800 03c3      : LDA  .03c3
13e5 : 0066           : SLL   6 A
13e6 : 0006           : SRA   6 A
13e7 : 4160           : STO   0160
13e8 : 8800 03c2      : LDA  .03c2
13ea : 0066           : SLL   6 A
13eb : 0006           : SRA   6 A
13ec : a160           : SUB   0160
13ed : a05a           : SUB   005a
13ee : c06f           : AND   006f
13ef : 4161           : STO   0161
13f0 : 8000 fc00      : LDA  ,fc00
13f2 : c800 03c4      : AND  .03c4
13f4 : 9161           : ADD   0161
13f5 : 4800 03c4      : STO  .03c4
13f7 : f800 1405      : JMP  .1405
13f9 : 0041           : SLA   1 A
13fa : 1000           : SJM
13fb : 0000           : SRA   0 A
13fc : 0000           : SRA   0 A
13fd : f800 140e      : JMP  .140e
13ff : f800 1422      : JMP  .1422
1401 : f800 14cc      : JMP  .14cc
1403 : f800 1436      : JMP  .1436
1405 : 815d           : LDA   015d
1406 : 9000 4000      : ADD  ,4000
1408 : 4026           : STO   0026
1409 : 806b           : LDA   006b
140a : c826           : AND  /0026
140b : 0023           : SRL   3 A
140c : f800 13f9      : JMP  .13f9
140e : 806f           : LDA   006f
140f : c800 03c4      : AND  .03c4
1411 : b000 00b9      : CMP  ,00b9
1413 : 0183 14cc      : JBC   3 CR 14cc
1415 : 806f           : LDA   006f
1416 : c800 03c4      : AND  .03c4
1418 : 415f           : STO   015f
1419 : 8000 0347      : LDA  ,0347
141b : b15f           : CMP   015f
141c : 0183 14cc      : JBC   3 CR 14cc
141e : 03e5 0150      : SET   5 0150
1420 : f800 14cc      : JMP  .14cc
1422 : 806f           : LDA   006f
1423 : c800 03c4      : AND  .03c4
1425 : b000 0363      : CMP  ,0363
1427 : 0193 1432      : JBS   3 CR 1432
1429 : 806f           : LDA   006f
142a : c800 03c4      : AND  .03c4
142c : 415f           : STO   015f
142d : 8000 01f1      : LDA  ,01f1
142f : b15f           : CMP   015f
1430 : 0183 14cc      : JBC   3 CR 14cc
1432 : 03e5 0150      : SET   5 0150
1434 : f800 14cc      : JMP  .14cc
1436 : 806f           : LDA   006f
1437 : c800 03c4      : AND  .03c4
1439 : 415f           : STO   015f
143a : 8000 009c      : LDA  ,009c
143c : b15f           : CMP   015f
143d : 0193 1446      : JBS   3 CR 1446
143f : 806f           : LDA   006f
1440 : c800 03c4      : AND  .03c4
1442 : b000 020e      : CMP  ,020e
1444 : 0183 14cc      : JBC   3 CR 14cc
1446 : 03e5 0150      : SET   5 0150
1448 : f800 14cc      : JMP  .14cc
144a : 815c           : LDA   015c
144b : b05b           : CMP   005b
144c : 0191 1458      : JBS   1 CR 1458
144e : b05c           : CMP   005c
144f : 0191 1458      : JBS   1 CR 1458
1451 : b05e           : CMP   005e
1452 : 0191 1458      : JBS   1 CR 1458
1454 : 805f           : LDA   005f
1455 : b15c           : CMP   015c
1456 : 0193 14ca      : JBS   3 CR 14ca
1458 : 815d           : LDA   015d
1459 : 9000 4000      : ADD  ,4000
145b : 4026           : STO   0026
145c : 8826           : LDA  /0026
145d : 0087 14c6      : JBC   7 A 14c6
145f : 0322 015e      : SRL   2 015e
1461 : 8152           : LDA   0152
1462 : 0181 1475      : JBC   1 CR 1475
1464 : 815e           : LDA   015e
1465 : 0041           : SLA   1 A
1466 : 9000 4161      : ADD  ,4161
1468 : 4027           : STO   0027
1469 : 806f           : LDA   006f
146a : c827           : AND  /0027
146b : 4160           : STO   0160
146c : 8000 fc00      : LDA  ,fc00
146e : c800 03c3      : AND  .03c3
1470 : 9160           : ADD   0160
1471 : 4800 03c3      : STO  .03c3
1473 : f800 1485      : JMP  .1485
1475 : 815e           : LDA   015e
1476 : 0041           : SLA   1 A
1477 : 905b           : ADD   005b
1478 : 9000 4161      : ADD  ,4161
147a : 4026           : STO   0026
147b : 806f           : LDA   006f
147c : c826           : AND  /0026
147d : 4161           : STO   0161
147e : 8000 fc00      : LDA  ,fc00
1480 : c800 03c3      : AND  .03c3
1482 : 9161           : ADD   0161
1483 : 4800 03c3      : STO  .03c3
1485 : 8800 03c3      : LDA  .03c3
1487 : 0066           : SLL   6 A
1488 : 0006           : SRA   6 A
1489 : 4160           : STO   0160
148a : 8800 03c2      : LDA  .03c2
148c : 0066           : SLL   6 A
148d : 0006           : SRA   6 A
148e : a160           : SUB   0160
148f : a05a           : SUB   005a
1490 : c06f           : AND   006f
1491 : 4161           : STO   0161
1492 : 8000 fc00      : LDA  ,fc00
1494 : c800 03c4      : AND  .03c4
1496 : 9161           : ADD   0161
1497 : 4800 03c4      : STO  .03c4
1499 : 0046           : SLA   6 A
149a : 008f 14aa      : JBC   f A 14aa
149c : 8800 03c4      : LDA  .03c4
149e : 0066           : SLL   6 A
149f : 0006           : SRA   6 A
14a0 : a05a           : SUB   005a
14a1 : c06f           : AND   006f
14a2 : 4161           : STO   0161
14a3 : 8000 fc00      : LDA  ,fc00
14a5 : c800 03c4      : AND  .03c4
14a7 : 9161           : ADD   0161
14a8 : 4800 03c4      : STO  .03c4
14aa : 8800 03c4      : LDA  .03c4
14ac : 0046           : SLA   6 A
14ad : b000 3fc0      : CMP  ,3fc0
14af : 0193 14c2      : JBS   3 CR 14c2
14b1 : 8800 03c4      : LDA  .03c4
14b3 : 0066           : SLL   6 A
14b4 : 0006           : SRA   6 A
14b5 : 9000 197b      : ADD  ,197b
14b7 : 4026           : STO   0026
14b8 : 8826           : LDA  /0026
14b9 : 5150           : ADS   0150
14ba : 8068           : LDA   0068
14bb : b150           : CMP   0150
14bc : 0193 14cc      : JBS   3 CR 14cc
14be : 03e5 0150      : SET   5 0150
14c0 : f800 14cc      : JMP  .14cc
14c2 : 03e5 0150      : SET   5 0150
14c4 : f800 14cc      : JMP  .14cc
14c6 : 03e5 0150      : SET   5 0150
14c8 : f800 14cc      : JMP  .14cc
14ca : 03e5 0150      : SET   5 0150
14cc : 0389 03c2 14d3 : JBC   9 03c2 14d3
14cf : 03f9 03c2      : CLR   9 03c2
14d1 : f800 14d5      : JMP  .14d5
14d3 : 03e9 03c2      : SET   9 03c2
14d5 : 0c02           : EXT  ,0402
14d6 : 015A           : DATA
14d7 : 005D           : DATA
14d8 : 015F           : DATA
14d9 : 815f           : LDA   015f
14da : 9000 0087      : ADD  ,0087
14dc : 4026           : STO   0026
14dd : 806f           : LDA   006f
14de : c826           : AND  /0026
14df : 4160           : STO   0160
14e0 : 8000 fc00      : LDA  ,fc00
14e2 : c800 03c3      : AND  .03c3
14e4 : 9160           : ADD   0160
14e5 : 4800 03c3      : STO  .03c3
14e7 : 8068           : LDA   0068
14e8 : b150           : CMP   0150
14e9 : 0183 15e1      : JBC   3 CR 15e1
14eb : 815a           : LDA   015a
14ec : 9000 0105      : ADD  ,0105
14ee : 4026           : STO   0026
14ef : 8826           : LDA  /0026
14f0 : 0096 15ef      : JBS   6 A 15ef
14f2 : c000 0038      : AND  ,0038
14f4 : 0191 155d      : JBS   1 CR 155d
14f6 : 8800 03c3      : LDA  .03c3
14f8 : 0066           : SLL   6 A
14f9 : 0006           : SRA   6 A
14fa : 4160           : STO   0160
14fb : 8800 03c2      : LDA  .03c2
14fd : 0066           : SLL   6 A
14fe : 0006           : SRA   6 A
14ff : a160           : SUB   0160
1500 : a05a           : SUB   005a
1501 : c06f           : AND   006f
1502 : 4161           : STO   0161
1503 : 8000 fc00      : LDA  ,fc00
1505 : c800 03c4      : AND  .03c4
1507 : 9161           : ADD   0161
1508 : 4800 03c4      : STO  .03c4
150a : f800 1518      : JMP  .1518
150c : 0041           : SLA   1 A
150d : 1000           : SJM
150e : 0000           : SRA   0 A
150f : 0000           : SRA   0 A
1510 : f800 1521      : JMP  .1521
1512 : f800 1535      : JMP  .1535
1514 : f800 15ef      : JMP  .15ef
1516 : f800 1549      : JMP  .1549
1518 : 815a           : LDA   015a
1519 : 9000 0105      : ADD  ,0105
151b : 4026           : STO   0026
151c : 806b           : LDA   006b
151d : c826           : AND  /0026
151e : 0023           : SRL   3 A
151f : f800 150c      : JMP  .150c
1521 : 806f           : LDA   006f
1522 : c800 03c4      : AND  .03c4
1524 : b000 00b9      : CMP  ,00b9
1526 : 0183 15ef      : JBC   3 CR 15ef
1528 : 806f           : LDA   006f
1529 : c800 03c4      : AND  .03c4
152b : 415f           : STO   015f
152c : 8000 0347      : LDA  ,0347
152e : b15f           : CMP   015f
152f : 0183 15ef      : JBC   3 CR 15ef
1531 : 03e5 0150      : SET   5 0150
1533 : f800 15ef      : JMP  .15ef
1535 : 806f           : LDA   006f
1536 : c800 03c4      : AND  .03c4
1538 : b000 0363      : CMP  ,0363
153a : 0193 1545      : JBS   3 CR 1545
153c : 806f           : LDA   006f
153d : c800 03c4      : AND  .03c4
153f : 415f           : STO   015f
1540 : 8000 01f1      : LDA  ,01f1
1542 : b15f           : CMP   015f
1543 : 0183 15ef      : JBC   3 CR 15ef
1545 : 03e5 0150      : SET   5 0150
1547 : f800 15ef      : JMP  .15ef
1549 : 806f           : LDA   006f
154a : c800 03c4      : AND  .03c4
154c : 415f           : STO   015f
154d : 8000 009c      : LDA  ,009c
154f : b15f           : CMP   015f
1550 : 0193 1559      : JBS   3 CR 1559
1552 : 806f           : LDA   006f
1553 : c800 03c4      : AND  .03c4
1555 : b000 020e      : CMP  ,020e
1557 : 0183 15ef      : JBC   3 CR 15ef
1559 : 03e5 0150      : SET   5 0150
155b : f800 15ef      : JMP  .15ef
155d : 815a           : LDA   015a
155e : b05b           : CMP   005b
155f : 0191 156b      : JBS   1 CR 156b
1561 : b05c           : CMP   005c
1562 : 0191 156b      : JBS   1 CR 156b
1564 : b05e           : CMP   005e
1565 : 0191 156b      : JBS   1 CR 156b
1567 : 805f           : LDA   005f
1568 : b15a           : CMP   015a
1569 : 0193 15dd      : JBS   3 CR 15dd
156b : 815a           : LDA   015a
156c : 9000 0105      : ADD  ,0105
156e : 4026           : STO   0026
156f : 8826           : LDA  /0026
1570 : 0087 15d9      : JBC   7 A 15d9
1572 : 805f           : LDA   005f
1573 : b15a           : CMP   015a
1574 : 0193 158a      : JBS   3 CR 158a
1576 : 0c02           : EXT  ,0402
1577 : 015A           : DATA
1578 : 005D           : DATA
1579 : 015F           : DATA
157a : 815f           : LDA   015f
157b : 9000 00d3      : ADD  ,00d3
157d : 4027           : STO   0027
157e : 806f           : LDA   006f
157f : c827           : AND  /0027
1580 : 4160           : STO   0160
1581 : 8000 fc00      : LDA  ,fc00
1583 : c800 03c3      : AND  .03c3
1585 : 9160           : ADD   0160
1586 : 4800 03c3      : STO  .03c3
1588 : f800 1598      : JMP  .1598
158a : 815a           : LDA   015a
158b : 9000 03bd      : ADD  ,03bd
158d : 4026           : STO   0026
158e : 806f           : LDA   006f
158f : c826           : AND  /0026
1590 : 4160           : STO   0160
1591 : 8000 fc00      : LDA  ,fc00
1593 : c800 03c3      : AND  .03c3
1595 : 9160           : ADD   0160
1596 : 4800 03c3      : STO  .03c3
1598 : 8800 03c3      : LDA  .03c3
159a : 0066           : SLL   6 A
159b : 0006           : SRA   6 A
159c : 4160           : STO   0160
159d : 8800 03c2      : LDA  .03c2
159f : 0066           : SLL   6 A
15a0 : 0006           : SRA   6 A
15a1 : a160           : SUB   0160
15a2 : a05a           : SUB   005a
15a3 : c06f           : AND   006f
15a4 : 4161           : STO   0161
15a5 : 8000 fc00      : LDA  ,fc00
15a7 : c800 03c4      : AND  .03c4
15a9 : 9161           : ADD   0161
15aa : 4800 03c4      : STO  .03c4
15ac : 0046           : SLA   6 A
15ad : 008f 15bd      : JBC   f A 15bd
15af : 8800 03c4      : LDA  .03c4
15b1 : 0066           : SLL   6 A
15b2 : 0006           : SRA   6 A
15b3 : a05a           : SUB   005a
15b4 : c06f           : AND   006f
15b5 : 4161           : STO   0161
15b6 : 8000 fc00      : LDA  ,fc00
15b8 : c800 03c4      : AND  .03c4
15ba : 9161           : ADD   0161
15bb : 4800 03c4      : STO  .03c4
15bd : 8800 03c4      : LDA  .03c4
15bf : 0046           : SLA   6 A
15c0 : b000 3fc0      : CMP  ,3fc0
15c2 : 0193 15d5      : JBS   3 CR 15d5
15c4 : 8800 03c4      : LDA  .03c4
15c6 : 0066           : SLL   6 A
15c7 : 0006           : SRA   6 A
15c8 : 9000 197b      : ADD  ,197b
15ca : 4026           : STO   0026
15cb : 8826           : LDA  /0026
15cc : 5150           : ADS   0150
15cd : 8068           : LDA   0068
15ce : b150           : CMP   0150
15cf : 0193 15ef      : JBS   3 CR 15ef
15d1 : 03e5 0150      : SET   5 0150
15d3 : f800 15ef      : JMP  .15ef
15d5 : 03e5 0150      : SET   5 0150
15d7 : f800 15ef      : JMP  .15ef
15d9 : 03e5 0150      : SET   5 0150
15db : f800 15ef      : JMP  .15ef
15dd : 03e5 0150      : SET   5 0150
15df : f800 15ef      : JMP  .15ef
15e1 : 03e5 0150      : SET   5 0150
15e3 : f800 15ef      : JMP  .15ef
15e5 : 03e5 0150      : SET   5 0150
15e7 : f800 15ef      : JMP  .15ef
15e9 : 03e5 0150      : SET   5 0150
15eb : f800 15ef      : JMP  .15ef
15ed : 03e5 0150      : SET   5 0150
15ef : 8156           : LDA   0156
15f0 : 0191 15f4      : JBS   1 CR 15f4
15f2 : 03e6 0150      : SET   6 0150
15f4 : 8152           : LDA   0152
15f5 : 0181 1605      : JBC   1 CR 1605
15f7 : 806c           : LDA   006c
15f8 : c150           : AND   0150
15f9 : 415f           : STO   015f
15fa : 815a           : LDA   015a
15fb : 9000 00f0      : ADD  ,00f0
15fd : 4026           : STO   0026
15fe : 8000 ff80      : LDA  ,ff80
1600 : c826           : AND  /0026
1601 : 915f           : ADD   015f
1602 : 4826           : STO  /0026
1603 : f800 1610      : JMP  .1610
1605 : 8150           : LDA   0150
1606 : 0069           : SLL   9 A
1607 : 415f           : STO   015f
1608 : 815a           : LDA   015a
1609 : 9000 00f0      : ADD  ,00f0
160b : 4026           : STO   0026
160c : 806e           : LDA   006e
160d : c826           : AND  /0026
160e : 915f           : ADD   015f
160f : 4826           : STO  /0026
1610 : 805b           : LDA   005b
1611 : 515a           : ADS   015a
1612 : f800 11c0      : JMP  .11c0
1614 : 805a           : LDA   005a
1615 : 415a           : STO   015a
1616 : 815a           : LDA   015a
1617 : b062           : CMP   0062
1618 : 0193 1636      : JBS   3 CR 1636
161a : 8152           : LDA   0152
161b : 0181 1629      : JBC   1 CR 1629
161d : 815a           : LDA   015a
161e : 9000 00f0      : ADD  ,00f0
1620 : 4026           : STO   0026
1621 : 8000 ff80      : LDA  ,ff80
1623 : c826           : AND  /0026
1624 : 9000 0020      : ADD  ,0020
1626 : 4826           : STO  /0026
1627 : f800 1632      : JMP  .1632
1629 : 815a           : LDA   015a
162a : 9000 00f0      : ADD  ,00f0
162c : 4026           : STO   0026
162d : 806e           : LDA   006e
162e : c826           : AND  /0026
162f : 9000 4000      : ADD  ,4000
1631 : 4826           : STO  /0026
1632 : 805b           : LDA   005b
1633 : 515a           : ADS   015a
1634 : f800 1616      : JMP  .1616
1636 : 8082           : LDA   0082
1637 : 0181 163b      : JBC   1 CR 163b
1639 : 805b           : LDA   005b
163a : 4152           : STO   0152
163b : 805b           : LDA   005b
163c : 5152           : ADS   0152
163d : f800 11a3      : JMP  .11a3
163f : 8081           : LDA   0081
1640 : 415f           : STO   015f
1641 : 905f           : ADD   005f
1642 : 4160           : STO   0160
1643 : 9000 00f0      : ADD  ,00f0
1645 : 4026           : STO   0026
1646 : 8826           : LDA  /0026
1647 : 006a           : SLL   a A
1648 : 4164           : STO   0164
1649 : 806f           : LDA   006f
164a : c800 03ab      : AND  .03ab
164c : 9164           : ADD   0164
164d : 4800 03ab      : STO  .03ab
164f : 8160           : LDA   0160
1650 : 9000 00cd      : ADD  ,00cd
1652 : 4027           : STO   0027
1653 : 806f           : LDA   006f
1654 : c827           : AND  /0027
1655 : 4164           : STO   0164
1656 : 8000 fc00      : LDA  ,fc00
1658 : c800 03ab      : AND  .03ab
165a : 9164           : ADD   0164
165b : 4800 03ab      : STO  .03ab
165d : 815f           : LDA   015f
165e : 9000 00f0      : ADD  ,00f0
1660 : 4028           : STO   0028
1661 : 8828           : LDA  /0028
1662 : 0061           : SLL   1 A
1663 : c000 fc00      : AND  ,fc00
1665 : 4165           : STO   0165
1666 : 806f           : LDA   006f
1667 : c800 03ac      : AND  .03ac
1669 : 9165           : ADD   0165
166a : 4800 03ac      : STO  .03ac
166c : 815f           : LDA   015f
166d : 9000 00d7      : ADD  ,00d7
166f : 4029           : STO   0029
1670 : 806f           : LDA   006f
1671 : c829           : AND  /0029
1672 : 4164           : STO   0164
1673 : 8000 fc00      : LDA  ,fc00
1675 : c800 03ac      : AND  .03ac
1677 : 9164           : ADD   0164
1678 : 4800 03ac      : STO  .03ac
167a : 805c           : LDA   005c
167b : 4158           : STO   0158
167c : 805a           : LDA   005a
167d : 4163           : STO   0163
167e : 8163           : LDA   0163
167f : b05e           : CMP   005e
1680 : 0193 16fc      : JBS   3 CR 16fc
1682 : b15f           : CMP   015f
1683 : 0191 16f8      : JBS   1 CR 16f8
1685 : 4161           : STO   0161
1686 : 905f           : ADD   005f
1687 : 4162           : STO   0162
1688 : 8161           : LDA   0161
1689 : 9000 00f0      : ADD  ,00f0
168b : 4026           : STO   0026
168c : 8826           : LDA  /0026
168d : 006a           : SLL   a A
168e : 4164           : STO   0164
168f : 8158           : LDA   0158
1690 : 9000 03ab      : ADD  ,03ab
1692 : 4027           : STO   0027
1693 : 806f           : LDA   006f
1694 : c827           : AND  /0027
1695 : 9164           : ADD   0164
1696 : 4827           : STO  /0027
1697 : 8161           : LDA   0161
1698 : 9000 00cd      : ADD  ,00cd
169a : 4028           : STO   0028
169b : 806f           : LDA   006f
169c : c828           : AND  /0028
169d : 4164           : STO   0164
169e : 8000 fc00      : LDA  ,fc00
16a0 : c827           : AND  /0027
16a1 : 9164           : ADD   0164
16a2 : 4827           : STO  /0027
16a3 : 805b           : LDA   005b
16a4 : 5158           : ADS   0158
16a5 : 8826           : LDA  /0026
16a6 : 0061           : SLL   1 A
16a7 : c000 fc00      : AND  ,fc00
16a9 : 4165           : STO   0165
16aa : 8158           : LDA   0158
16ab : 9000 03ab      : ADD  ,03ab
16ad : 4027           : STO   0027
16ae : 806f           : LDA   006f
16af : c827           : AND  /0027
16b0 : 9165           : ADD   0165
16b1 : 4827           : STO  /0027
16b2 : 8161           : LDA   0161
16b3 : 9000 00d7      : ADD  ,00d7
16b5 : 4029           : STO   0029
16b6 : 806f           : LDA   006f
16b7 : c829           : AND  /0029
16b8 : 4164           : STO   0164
16b9 : 8000 fc00      : LDA  ,fc00
16bb : c827           : AND  /0027
16bc : 9164           : ADD   0164
16bd : 4827           : STO  /0027
16be : 805b           : LDA   005b
16bf : 5158           : ADS   0158
16c0 : 8162           : LDA   0162
16c1 : 9000 00f0      : ADD  ,00f0
16c3 : 4027           : STO   0027
16c4 : 8827           : LDA  /0027
16c5 : 006a           : SLL   a A
16c6 : 4164           : STO   0164
16c7 : 8158           : LDA   0158
16c8 : 9000 03ab      : ADD  ,03ab
16ca : 402a           : STO   002a
16cb : 806f           : LDA   006f
16cc : c82a           : AND  /002a
16cd : 9164           : ADD   0164
16ce : 482a           : STO  /002a
16cf : 8162           : LDA   0162
16d0 : 9000 00cd      : ADD  ,00cd
16d2 : 402b           : STO   002b
16d3 : 806f           : LDA   006f
16d4 : c82b           : AND  /002b
16d5 : 4164           : STO   0164
16d6 : 8000 fc00      : LDA  ,fc00
16d8 : c82a           : AND  /002a
16d9 : 9164           : ADD   0164
16da : 482a           : STO  /002a
16db : 805b           : LDA   005b
16dc : 5158           : ADS   0158
16dd : 8827           : LDA  /0027
16de : 0061           : SLL   1 A
16df : c000 fc00      : AND  ,fc00
16e1 : 4165           : STO   0165
16e2 : 8158           : LDA   0158
16e3 : 9000 03ab      : ADD  ,03ab
16e5 : 402a           : STO   002a
16e6 : 806f           : LDA   006f
16e7 : c82a           : AND  /002a
16e8 : 9165           : ADD   0165
16e9 : 482a           : STO  /002a
16ea : 8162           : LDA   0162
16eb : 9000 00d7      : ADD  ,00d7
16ed : 402c           : STO   002c
16ee : 806f           : LDA   006f
16ef : c82c           : AND  /002c
16f0 : 4164           : STO   0164
16f1 : 8000 fc00      : LDA  ,fc00
16f3 : c82a           : AND  /002a
16f4 : 9164           : ADD   0164
16f5 : 482a           : STO  /002a
16f6 : 805b           : LDA   005b
16f7 : 5158           : ADS   0158
16f8 : 805b           : LDA   005b
16f9 : 5163           : ADS   0163
16fa : f800 167e      : JMP  .167e
16fc : 3800           : RTC
16fd : 3000           : RTN
16fe : f800 1824      : JMP  .1824
1700 : 805a           : LDA   005a
1701 : 416e           : STO   016e
1702 : 816e           : LDA   016e
1703 : b05b           : CMP   005b
1704 : 0193 1823      : JBS   3 CR 1823
1706 : 9000 0081      : ADD  ,0081
1708 : 4026           : STO   0026
1709 : 8826           : LDA  /0026
170a : 416c           : STO   016c
170b : 0c02           : EXT  ,0402
170c : 016C           : DATA
170d : 005D           : DATA
170e : 016F           : DATA
170f : 816f           : LDA   016f
1710 : 9000 0085      : ADD  ,0085
1712 : 4027           : STO   0027
1713 : 8827           : LDA  /0027
1714 : 008f 17fc      : JBC   f A 17fc
1716 : 805a           : LDA   005a
1717 : 416d           : STO   016d
1718 : 816d           : LDA   016d
1719 : b062           : CMP   0062
171a : 0193 181a      : JBS   3 CR 181a
171c : b16c           : CMP   016c
171d : 0191 17e0      : JBS   1 CR 17e0
171f : 0c02           : EXT  ,0402
1720 : 016D           : DATA
1721 : 005D           : DATA
1722 : 016F           : DATA
1723 : 816f           : LDA   016f
1724 : 9000 0085      : ADD  ,0085
1726 : 4026           : STO   0026
1727 : 8826           : LDA  /0026
1728 : 008f 17c6      : JBC   f A 17c6
172a : 0c02           : EXT  ,0402
172b : 016D           : DATA
172c : 005D           : DATA
172d : 016F           : DATA
172e : 0c02           : EXT  ,0402
172f : 016C           : DATA
1730 : 005D           : DATA
1731 : 0170           : DATA
1732 : 8170           : LDA   0170
1733 : 9000 0085      : ADD  ,0085
1735 : 4026           : STO   0026
1736 : 8000 7000      : LDA  ,7000
1738 : c826           : AND  /0026
1739 : 4171           : STO   0171
173a : 816f           : LDA   016f
173b : 9000 0085      : ADD  ,0085
173d : 4026           : STO   0026
173e : 8000 7000      : LDA  ,7000
1740 : c826           : AND  /0026
1741 : b171           : CMP   0171
1742 : 0181 17c6      : JBC   1 CR 17c6
1744 : 816c           : LDA   016c
1745 : b16d           : CMP   016d
1746 : 0183 175a      : JBC   3 CR 175a
1748 : 816d           : LDA   016d
1749 : 9000 1972      : ADD  ,1972
174b : 4026           : STO   0026
174c : 8826           : LDA  /0026
174d : 916c           : ADD   016c
174e : a16d           : SUB   016d
174f : a05a           : SUB   005a
1750 : a05b           : SUB   005b
1751 : a05a           : SUB   005a
1752 : 9000 0319      : ADD  ,0319
1754 : 4027           : STO   0027
1755 : 8827           : LDA  /0027
1756 : 4800 03c6      : STO  .03c6
1758 : f800 176a      : JMP  .176a
175a : 816c           : LDA   016c
175b : 9000 1972      : ADD  ,1972
175d : 4026           : STO   0026
175e : 8826           : LDA  /0026
175f : 916d           : ADD   016d
1760 : a16c           : SUB   016c
1761 : a05a           : SUB   005a
1762 : a05b           : SUB   005b
1763 : a05a           : SUB   005a
1764 : 9000 0319      : ADD  ,0319
1766 : 4027           : STO   0027
1767 : 8827           : LDA  /0027
1768 : 4800 03c6      : STO  .03c6
176a : 8800 03c6      : LDA  .03c6
176c : b000 6acc      : CMP  ,6acc
176e : 0193 178d      : JBS   3 CR 178d
1770 : 8000 004b      : LDA  ,004b
1772 : 4078           : STO   0078
1773 : 0c01           : EXT  ,0401
1774 : 03C6           : DATA
1775 : 0078           : DATA
1776 : 016F           : DATA
1777 : 816f           : LDA   016f
1778 : 01e5           : SET   5 CR
1779 : 030a 0170      : SRA   a 0170
177b : 01f5           : CLR   5 CR
177c : 416f           : STO   016f
177d : 0c05           : EXT  ,0405
177e : 016F           : DATA
177f : 005C           : DATA
1780 : 0079           : DATA
1781 : 806f           : LDA   006f
1782 : c07a           : AND   007a
1783 : 4170           : STO   0170
1784 : 8000 fc00      : LDA  ,fc00
1786 : c800 03c5      : AND  .03c5
1788 : 9170           : ADD   0170
1789 : 4800 03c5      : STO  .03c5
178b : f800 1794      : JMP  .1794
178d : 8000 fc00      : LDA  ,fc00
178f : c800 03c5      : AND  .03c5
1791 : 906f           : ADD   006f
1792 : 4800 03c5      : STO  .03c5
1794 : 806f           : LDA   006f
1795 : c800 03c5      : AND  .03c5
1797 : 416f           : STO   016f
1798 : 8000 03e8      : LDA  ,03e8
179a : b16f           : CMP   016f
179b : 0193 17a4      : JBS   3 CR 17a4
179d : 8000 fc00      : LDA  ,fc00
179f : c800 03c5      : AND  .03c5
17a1 : 906f           : ADD   006f
17a2 : 4800 03c5      : STO  .03c5
17a4 : 805f           : LDA   005f
17a5 : b16c           : CMP   016c
17a6 : 0183 17b7      : JBC   3 CR 17b7
17a8 : 806f           : LDA   006f
17a9 : c800 03c5      : AND  .03c5
17ab : 416f           : STO   016f
17ac : 816d           : LDA   016d
17ad : 9000 00cd      : ADD  ,00cd
17af : 4026           : STO   0026
17b0 : 8000 fc00      : LDA  ,fc00
17b2 : c826           : AND  /0026
17b3 : 916f           : ADD   016f
17b4 : 4826           : STO  /0026
17b5 : f800 17f8      : JMP  .17f8
17b7 : 806f           : LDA   006f
17b8 : c800 03c5      : AND  .03c5
17ba : 416f           : STO   016f
17bb : 816d           : LDA   016d
17bc : 9000 00d7      : ADD  ,00d7
17be : 4026           : STO   0026
17bf : 8000 fc00      : LDA  ,fc00
17c1 : c826           : AND  /0026
17c2 : 916f           : ADD   016f
17c3 : 4826           : STO  /0026
17c4 : f800 17f8      : JMP  .17f8
17c6 : 805f           : LDA   005f
17c7 : b16c           : CMP   016c
17c8 : 0183 17d5      : JBC   3 CR 17d5
17ca : 816d           : LDA   016d
17cb : 9000 00cd      : ADD  ,00cd
17cd : 4026           : STO   0026
17ce : 8000 fc00      : LDA  ,fc00
17d0 : c826           : AND  /0026
17d1 : 906f           : ADD   006f
17d2 : 4826           : STO  /0026
17d3 : f800 17f8      : JMP  .17f8
17d5 : 816d           : LDA   016d
17d6 : 9000 00d7      : ADD  ,00d7
17d8 : 4026           : STO   0026
17d9 : 8000 fc00      : LDA  ,fc00
17db : c826           : AND  /0026
17dc : 906f           : ADD   006f
17dd : 4826           : STO  /0026
17de : f800 17f8      : JMP  .17f8
17e0 : 805f           : LDA   005f
17e1 : b16c           : CMP   016c
17e2 : 0183 17ef      : JBC   3 CR 17ef
17e4 : 816c           : LDA   016c
17e5 : 9000 00cd      : ADD  ,00cd
17e7 : 4026           : STO   0026
17e8 : 4027           : STO   0027
17e9 : 8000 fc00      : LDA  ,fc00
17eb : c826           : AND  /0026
17ec : 4827           : STO  /0027
17ed : f800 17f8      : JMP  .17f8
17ef : 816c           : LDA   016c
17f0 : 9000 00d7      : ADD  ,00d7
17f2 : 4026           : STO   0026
17f3 : 4027           : STO   0027
17f4 : 8000 fc00      : LDA  ,fc00
17f6 : c826           : AND  /0026
17f7 : 4827           : STO  /0027
17f8 : 805b           : LDA   005b
17f9 : 516d           : ADS   016d
17fa : f800 1718      : JMP  .1718
17fc : 805f           : LDA   005f
17fd : b16c           : CMP   016c
17fe : 0183 1804      : JBC   3 CR 1804
1800 : 805a           : LDA   005a
1801 : 416f           : STO   016f
1802 : f800 1806      : JMP  .1806
1804 : 8064           : LDA   0064
1805 : 416f           : STO   016f
1806 : 805a           : LDA   005a
1807 : 4170           : STO   0170
1808 : 8170           : LDA   0170
1809 : b062           : CMP   0062
180a : 0193 181a      : JBS   3 CR 181a
180c : 816f           : LDA   016f
180d : 9000 00cd      : ADD  ,00cd
180f : 4026           : STO   0026
1810 : 8000 fc00      : LDA  ,fc00
1812 : c826           : AND  /0026
1813 : 906f           : ADD   006f
1814 : 4826           : STO  /0026
1815 : 805b           : LDA   005b
1816 : 516f           : ADS   016f
1817 : 5170           : ADS   0170
1818 : f800 1808      : JMP  .1808
181a : 8082           : LDA   0082
181b : 0181 181f      : JBC   1 CR 181f
181d : 805b           : LDA   005b
181e : 416e           : STO   016e
181f : 805b           : LDA   005b
1820 : 516e           : ADS   016e
1821 : f800 1702      : JMP  .1702
1823 : 3800           : RTC
1824 : 3000           : RTN
1825 : f800 18ed      : JMP  .18ed
1827 : 8075           : LDA   0075
1828 : 4175           : STO   0175
1829 : 805b           : LDA   005b
182a : 5175           : ADS   0175
182b : 805c           : LDA   005c
182c : b175           : CMP   0175
182d : 0183 18ec      : JBC   3 CR 18ec
182f : 8175           : LDA   0175
1830 : 9000 0081      : ADD  ,0081
1832 : 4026           : STO   0026
1833 : 8826           : LDA  /0026
1834 : 4173           : STO   0173
1835 : 0c02           : EXT  ,0402
1836 : 0173           : DATA
1837 : 005D           : DATA
1838 : 0176           : DATA
1839 : 8176           : LDA   0176
183a : 9000 0085      : ADD  ,0085
183c : 4027           : STO   0027
183d : 8827           : LDA  /0027
183e : 008f 18cc      : JBC   f A 18cc
1840 : 8173           : LDA   0173
1841 : 9000 00c1      : ADD  ,00c1
1843 : 4027           : STO   0027
1844 : 8827           : LDA  /0027
1845 : 0094 18cc      : JBS   4 A 18cc
1847 : c061           : AND   0061
1848 : 0181 18c1      : JBC   1 CR 18c1
184a : 0c02           : EXT  ,0402
184b : 0173           : DATA
184c : 005D           : DATA
184d : 0176           : DATA
184e : 8176           : LDA   0176
184f : 9000 0086      : ADD  ,0086
1851 : 4028           : STO   0028
1852 : 8000 1a00      : LDA  ,1a00
1854 : b828           : CMP  /0028
1855 : 0183 1864      : JBC   3 CR 1864
1857 : 0c02           : EXT  ,0402
1858 : 0173           : DATA
1859 : 005D           : DATA
185a : 0176           : DATA
185b : 8176           : LDA   0176
185c : 9000 0086      : ADD  ,0086
185e : 4028           : STO   0028
185f : 8828           : LDA  /0028
1860 : b000 e600      : CMP  ,e600
1862 : 0193 18a4      : JBS   3 CR 18a4
1864 : 0c02           : EXT  ,0402
1865 : 0173           : DATA
1866 : 005D           : DATA
1867 : 0176           : DATA
1868 : 8176           : LDA   0176
1869 : 9000 0086      : ADD  ,0086
186b : 4026           : STO   0026
186c : 8000 2400      : LDA  ,2400
186e : b826           : CMP  /0026
186f : 0183 187e      : JBC   3 CR 187e
1871 : 0c02           : EXT  ,0402
1872 : 0173           : DATA
1873 : 005D           : DATA
1874 : 0176           : DATA
1875 : 8176           : LDA   0176
1876 : 9000 0086      : ADD  ,0086
1878 : 4026           : STO   0026
1879 : 8826           : LDA  /0026
187a : b000 dc00      : CMP  ,dc00
187c : 0193 18a0      : JBS   3 CR 18a0
187e : 0c02           : EXT  ,0402
187f : 0173           : DATA
1880 : 005D           : DATA
1881 : 0176           : DATA
1882 : 8176           : LDA   0176
1883 : 9000 0086      : ADD  ,0086
1885 : 4026           : STO   0026
1886 : 8000 3200      : LDA  ,3200
1888 : b826           : CMP  /0026
1889 : 0183 1898      : JBC   3 CR 1898
188b : 0c02           : EXT  ,0402
188c : 0173           : DATA
188d : 005D           : DATA
188e : 0176           : DATA
188f : 8176           : LDA   0176
1890 : 9000 0086      : ADD  ,0086
1892 : 4026           : STO   0026
1893 : 8826           : LDA  /0026
1894 : b000 ce00      : CMP  ,ce00
1896 : 0193 189c      : JBS   3 CR 189c
1898 : 805d           : LDA   005d
1899 : 4174           : STO   0174
189a : f800 18a6      : JMP  .18a6
189c : 805c           : LDA   005c
189d : 4174           : STO   0174
189e : f800 18a6      : JMP  .18a6
18a0 : 805b           : LDA   005b
18a1 : 4174           : STO   0174
18a2 : f800 18a6      : JMP  .18a6
18a4 : 805a           : LDA   005a
18a5 : 4174           : STO   0174
18a6 : 0c02           : EXT  ,0402
18a7 : 0173           : DATA
18a8 : 005D           : DATA
18a9 : 0176           : DATA
18aa : 8176           : LDA   0176
18ab : 9000 0085      : ADD  ,0085
18ad : 4026           : STO   0026
18ae : 8000 01e0      : LDA  ,01e0
18b0 : c826           : AND  /0026
18b1 : 4177           : STO   0177
18b2 : 8000 0060      : LDA  ,0060
18b4 : b177           : CMP   0177
18b5 : 0193 18b9      : JBS   3 CR 18b9
18b7 : 805b           : LDA   005b
18b8 : 5174           : ADS   0174
18b9 : 805e           : LDA   005e
18ba : b174           : CMP   0174
18bb : 0193 18ce      : JBS   3 CR 18ce
18bd : 805d           : LDA   005d
18be : 4174           : STO   0174
18bf : f800 18ce      : JMP  .18ce
18c1 : 8173           : LDA   0173
18c2 : 9000 00c1      : ADD  ,00c1
18c4 : 4026           : STO   0026
18c5 : 8061           : LDA   0061
18c6 : c826           : AND  /0026
18c7 : a05b           : SUB   005b
18c8 : a05a           : SUB   005a
18c9 : 4174           : STO   0174
18ca : f800 18ce      : JMP  .18ce
18cc : 805a           : LDA   005a
18cd : 4174           : STO   0174
18ce : 805f           : LDA   005f
18cf : b173           : CMP   0173
18d0 : 0183 18dc      : JBC   3 CR 18dc
18d2 : 805d           : LDA   005d
18d3 : c174           : AND   0174
18d4 : 4176           : STO   0176
18d5 : 8000 fffc      : LDA  ,fffc
18d7 : c0fa           : AND   00fa
18d8 : 9176           : ADD   0176
18d9 : 40fa           : STO   00fa
18da : f800 18e5      : JMP  .18e5
18dc : 8174           : LDA   0174
18dd : 0062           : SLL   2 A
18de : c066           : AND   0066
18df : 4177           : STO   0177
18e0 : 8000 fff3      : LDA  ,fff3
18e2 : c0fa           : AND   00fa
18e3 : 9177           : ADD   0177
18e4 : 40fa           : STO   00fa
18e5 : 8082           : LDA   0082
18e6 : 0181 1829      : JBC   1 CR 1829
18e8 : 805b           : LDA   005b
18e9 : 4175           : STO   0175
18ea : f800 1829      : JMP  .1829
18ec : 3800           : RTC
18ed : 3000           : RTN
18ee : f800 1962      : JMP  .1962
18f0 : 805b           : LDA   005b
18f1 : 5800 4160      : ADS  .4160
18f3 : 8800 4160      : LDA  .4160
18f5 : b000 00af      : CMP  ,00af
18f7 : 0183 18fc      : JBC   3 CR 18fc
18f9 : 805a           : LDA   005a
18fa : 4800 4160      : STO  .4160
18fc : 8800 4160      : LDA  .4160
18fe : 0022           : SRL   2 A
18ff : 417a           : STO   017a
1900 : 8800 4160      : LDA  .4160
1902 : 0041           : SLA   1 A
1903 : 4179           : STO   0179
1904 : 9000 4000      : ADD  ,4000
1906 : 4026           : STO   0026
1907 : 8081           : LDA   0081
1908 : 9000 0105      : ADD  ,0105
190a : 4027           : STO   0027
190b : 8827           : LDA  /0027
190c : 4826           : STO  /0026
190d : 80cb           : LDA   00cb
190e : 0029           : SRL   9 A
190f : c05b           : AND   005b
1910 : 407e           : STO   007e
1911 : 8826           : LDA  /0026
1912 : 00fd           : CLR   d A
1913 : 4826           : STO  /0026
1914 : 807e           : LDA   007e
1915 : 004d           : SLA   d A
1916 : 5826           : ADS  /0026
1917 : 80cb           : LDA   00cb
1918 : 002c           : SRL   c A
1919 : c05b           : AND   005b
191a : 407e           : STO   007e
191b : 8826           : LDA  /0026
191c : 00fe           : CLR   e A
191d : 4826           : STO  /0026
191e : 807e           : LDA   007e
191f : 004e           : SLA   e A
1920 : 5826           : ADS  /0026
1921 : 8082           : LDA   0082
1922 : 0191 193d      : JBS   1 CR 193d
1924 : 805b           : LDA   005b
1925 : 5179           : ADS   0179
1926 : 8082           : LDA   0082
1927 : 9000 0105      : ADD  ,0105
1929 : 4026           : STO   0026
192a : 8179           : LDA   0179
192b : 9000 4000      : ADD  ,4000
192d : 4028           : STO   0028
192e : 8826           : LDA  /0026
192f : 4828           : STO  /0028
1930 : 8828           : LDA  /0028
1931 : 00ed           : SET   d A
1932 : 4828           : STO  /0028
1933 : 8826           : LDA  /0026
1934 : 002e           : SRL   e A
1935 : c05b           : AND   005b
1936 : 407e           : STO   007e
1937 : 8828           : LDA  /0028
1938 : 00fe           : CLR   e A
1939 : 4828           : STO  /0028
193a : 807e           : LDA   007e
193b : 004e           : SLA   e A
193c : 5828           : ADS  /0028
193d : 817a           : LDA   017a
193e : 0041           : SLA   1 A
193f : 4026           : STO   0026
1940 : 806f           : LDA   006f
1941 : c0cc           : AND   00cc
1942 : 417c           : STO   017c
1943 : 8000 4161      : LDA  ,4161
1945 : 5026           : ADS   0026
1946 : 8000 fc00      : LDA  ,fc00
1948 : c826           : AND  /0026
1949 : 917c           : ADD   017c
194a : 4826           : STO  /0026
194b : 817a           : LDA   017a
194c : 0041           : SLA   1 A
194d : 0c02           : EXT  ,0402
194e : 0081           : DATA
194f : 005D           : DATA
1950 : 017C           : DATA
1951 : 4026           : STO   0026
1952 : 817c           : LDA   017c
1953 : 9000 00e2      : ADD  ,00e2
1955 : 4027           : STO   0027
1956 : 806f           : LDA   006f
1957 : c827           : AND  /0027
1958 : 417d           : STO   017d
1959 : 8000 4162      : LDA  ,4162
195b : 5026           : ADS   0026
195c : 8000 fc00      : LDA  ,fc00
195e : c826           : AND  /0026
195f : 917d           : ADD   017d
1960 : 4826           : STO  /0026
1961 : 3800           : RTC
1962 : 3000           : RTN
1963 : f800 1971      : JMP  .1971
1965 : 4903           : STO  /0003+
1966 : 8001           : LDA   0001
1967 : 4903           : STO  /0003+
1968 : 8000 0000      : LDA  ,0000
196a : 4800 0116      : STO  .0116
196c : 8b03           : LDA  /0003-
196d : 4001           : STO   0001
196e : 8b03           : LDA  /0003-
196f : 3000           : RTN
1970 : 3800           : RTC
1971 : 3000           : RTN
1972 : 0000           : SRA   0 A
1973 : 0008           : SRA   8 A
1974 : 000f           : SRA   f A
1975 : 0015           : SRA   5 A
1976 : 001a           : SRA   a A
1977 : 001e           : SRA   e A
1978 : 0021           : SRL   1 A
1979 : 0023           : SRL   3 A
197a : 0000           : SRA   0 A
197b : 0000           : SRA   0 A
197c : 0000           : SRA   0 A
197d : 0000           : SRA   0 A
197e : 0000           : SRA   0 A
197f : 0000           : SRA   0 A
1980 : 0000           : SRA   0 A
1981 : 0000           : SRA   0 A
1982 : 0000           : SRA   0 A
1983 : 0000           : SRA   0 A
1984 : 0000           : SRA   0 A
1985 : 0000           : SRA   0 A
1986 : 0000           : SRA   0 A
1987 : 0000           : SRA   0 A
1988 : 0000           : SRA   0 A
1989 : 0000           : SRA   0 A
198a : 0000           : SRA   0 A
198b : 0000           : SRA   0 A
198c : 0001           : SRA   1 A
198d : 0001           : SRA   1 A
198e : 0001           : SRA   1 A
198f : 0001           : SRA   1 A
1990 : 0001           : SRA   1 A
1991 : 0001           : SRA   1 A
1992 : 0001           : SRA   1 A
1993 : 0001           : SRA   1 A
1994 : 0001           : SRA   1 A
1995 : 0001           : SRA   1 A
1996 : 0001           : SRA   1 A
1997 : 0001           : SRA   1 A
1998 : 0001           : SRA   1 A
1999 : 0002           : SRA   2 A
199a : 0002           : SRA   2 A
199b : 0002           : SRA   2 A
199c : 0002           : SRA   2 A
199d : 0002           : SRA   2 A
199e : 0002           : SRA   2 A
199f : 0002           : SRA   2 A
19a0 : 0002           : SRA   2 A
19a1 : 0003           : SRA   3 A
19a2 : 0003           : SRA   3 A
19a3 : 0003           : SRA   3 A
19a4 : 0003           : SRA   3 A
19a5 : 0003           : SRA   3 A
19a6 : 0003           : SRA   3 A
19a7 : 0003           : SRA   3 A
19a8 : 0004           : SRA   4 A
19a9 : 0004           : SRA   4 A
19aa : 0004           : SRA   4 A
19ab : 0004           : SRA   4 A
19ac : 0005           : SRA   5 A
19ad : 0005           : SRA   5 A
19ae : 0005           : SRA   5 A
19af : 0005           : SRA   5 A
19b0 : 0006           : SRA   6 A
19b1 : 0006           : SRA   6 A
19b2 : 0006           : SRA   6 A
19b3 : 0007           : SRA   7 A
19b4 : 0007           : SRA   7 A
19b5 : 0008           : SRA   8 A
19b6 : 0008           : SRA   8 A
19b7 : 0008           : SRA   8 A
19b8 : 0007           : SRA   7 A
19b9 : 0007           : SRA   7 A
19ba : 0007           : SRA   7 A
19bb : 0006           : SRA   6 A
19bc : 0006           : SRA   6 A
19bd : 0006           : SRA   6 A
19be : 0006           : SRA   6 A
19bf : 0006           : SRA   6 A
19c0 : 0005           : SRA   5 A
19c1 : 0005           : SRA   5 A
19c2 : 0005           : SRA   5 A
19c3 : 0005           : SRA   5 A
19c4 : 0005           : SRA   5 A
19c5 : 0005           : SRA   5 A
19c6 : 0005           : SRA   5 A
19c7 : 0005           : SRA   5 A
19c8 : 0005           : SRA   5 A
19c9 : 0005           : SRA   5 A
19ca : 0005           : SRA   5 A
19cb : 0004           : SRA   4 A
19cc : 0004           : SRA   4 A
19cd : 0004           : SRA   4 A
19ce : 0004           : SRA   4 A
19cf : 0004           : SRA   4 A
19d0 : 0004           : SRA   4 A
19d1 : 0004           : SRA   4 A
19d2 : 0004           : SRA   4 A
19d3 : 0004           : SRA   4 A
19d4 : 0004           : SRA   4 A
19d5 : 0004           : SRA   4 A
19d6 : 0004           : SRA   4 A
19d7 : 0004           : SRA   4 A
19d8 : 0004           : SRA   4 A
19d9 : 0004           : SRA   4 A
19da : 0004           : SRA   4 A
19db : 0004           : SRA   4 A
19dc : 0005           : SRA   5 A
19dd : 0005           : SRA   5 A
19de : 0005           : SRA   5 A
19df : 0005           : SRA   5 A
19e0 : 0005           : SRA   5 A
19e1 : 0005           : SRA   5 A
19e2 : 0005           : SRA   5 A
19e3 : 0005           : SRA   5 A
19e4 : 0005           : SRA   5 A
19e5 : 0006           : SRA   6 A
19e6 : 0006           : SRA   6 A
19e7 : 0006           : SRA   6 A
19e8 : 0006           : SRA   6 A
19e9 : 0006           : SRA   6 A
19ea : 0007           : SRA   7 A
19eb : 0007           : SRA   7 A
19ec : 0007           : SRA   7 A
19ed : 0008           : SRA   8 A
19ee : 0008           : SRA   8 A
19ef : 0008           : SRA   8 A
19f0 : 0008           : SRA   8 A
19f1 : 0009           : SRA   9 A
19f2 : 0009           : SRA   9 A
19f3 : 0009           : SRA   9 A
19f4 : 0009           : SRA   9 A
19f5 : 000a           : SRA   a A
19f6 : 000a           : SRA   a A
19f7 : 000a           : SRA   a A
19f8 : 000a           : SRA   a A
19f9 : 000a           : SRA   a A
19fa : 0009           : SRA   9 A
19fb : 0009           : SRA   9 A
19fc : 0008           : SRA   8 A
19fd : 0008           : SRA   8 A
19fe : 0008           : SRA   8 A
19ff : 0008           : SRA   8 A
1a00 : 0008           : SRA   8 A
1a01 : 0007           : SRA   7 A
1a02 : 0007           : SRA   7 A
1a03 : 0007           : SRA   7 A
1a04 : 0007           : SRA   7 A
1a05 : 0007           : SRA   7 A
1a06 : 0007           : SRA   7 A
1a07 : 0007           : SRA   7 A
1a08 : 0007           : SRA   7 A
1a09 : 0007           : SRA   7 A
1a0a : 0007           : SRA   7 A
1a0b : 0007           : SRA   7 A
1a0c : 0007           : SRA   7 A
1a0d : 0007           : SRA   7 A
1a0e : 0007           : SRA   7 A
1a0f : 0007           : SRA   7 A
1a10 : 0007           : SRA   7 A
1a11 : 0007           : SRA   7 A
1a12 : 0007           : SRA   7 A
1a13 : 0007           : SRA   7 A
1a14 : 0007           : SRA   7 A
1a15 : 0006           : SRA   6 A
1a16 : 0006           : SRA   6 A
1a17 : 0006           : SRA   6 A
1a18 : 0006           : SRA   6 A
1a19 : 0006           : SRA   6 A
1a1a : 0006           : SRA   6 A
1a1b : 0006           : SRA   6 A
1a1c : 0006           : SRA   6 A
1a1d : 0006           : SRA   6 A
1a1e : 0006           : SRA   6 A
1a1f : 0006           : SRA   6 A
1a20 : 0006           : SRA   6 A
1a21 : 0006           : SRA   6 A
1a22 : 0006           : SRA   6 A
1a23 : 0006           : SRA   6 A
1a24 : 0006           : SRA   6 A
1a25 : 0006           : SRA   6 A
1a26 : 0006           : SRA   6 A
1a27 : 0006           : SRA   6 A
1a28 : 0006           : SRA   6 A
1a29 : 0006           : SRA   6 A
1a2a : 0006           : SRA   6 A
1a2b : 0006           : SRA   6 A
1a2c : 0006           : SRA   6 A
1a2d : 0006           : SRA   6 A
1a2e : 0006           : SRA   6 A
1a2f : 0006           : SRA   6 A
1a30 : 0006           : SRA   6 A
1a31 : 0006           : SRA   6 A
1a32 : 0006           : SRA   6 A
1a33 : 0006           : SRA   6 A
1a34 : 0006           : SRA   6 A
1a35 : 0006           : SRA   6 A
1a36 : 0006           : SRA   6 A
1a37 : 0006           : SRA   6 A
1a38 : 0007           : SRA   7 A
1a39 : 0007           : SRA   7 A
1a3a : 0007           : SRA   7 A
1a3b : 0007           : SRA   7 A
1a3c : 0007           : SRA   7 A
1a3d : 0007           : SRA   7 A
1a3e : 0007           : SRA   7 A
1a3f : 0007           : SRA   7 A
1a40 : 0007           : SRA   7 A
1a41 : 0007           : SRA   7 A
1a42 : 0007           : SRA   7 A
1a43 : 0007           : SRA   7 A
1a44 : 0007           : SRA   7 A
1a45 : 0007           : SRA   7 A
1a46 : 0007           : SRA   7 A
1a47 : 0007           : SRA   7 A
1a48 : 0007           : SRA   7 A
1a49 : 0007           : SRA   7 A
1a4a : 0007           : SRA   7 A
1a4b : 0007           : SRA   7 A
1a4c : 0007           : SRA   7 A
1a4d : 0007           : SRA   7 A
1a4e : 0008           : SRA   8 A
1a4f : 0008           : SRA   8 A
1a50 : 0008           : SRA   8 A
1a51 : 0008           : SRA   8 A
1a52 : 0009           : SRA   9 A
1a53 : 0009           : SRA   9 A
1a54 : 0009           : SRA   9 A
1a55 : 0009           : SRA   9 A
1a56 : 000a           : SRA   a A
1a57 : 000a           : SRA   a A
1a58 : 000a           : SRA   a A
1a59 : 000a           : SRA   a A
1a5a : 000b           : SRA   b A
1a5b : 000b           : SRA   b A
1a5c : 000b           : SRA   b A
1a5d : 000b           : SRA   b A
1a5e : 000b           : SRA   b A
1a5f : 000b           : SRA   b A
1a60 : 000b           : SRA   b A
1a61 : 000c           : SRA   c A
1a62 : 000c           : SRA   c A
1a63 : 000c           : SRA   c A
1a64 : 000c           : SRA   c A
1a65 : 000d           : SRA   d A
1a66 : 000d           : SRA   d A
1a67 : 000d           : SRA   d A
1a68 : 000d           : SRA   d A
1a69 : 000d           : SRA   d A
1a6a : 000d           : SRA   d A
1a6b : 000d           : SRA   d A
1a6c : 000e           : SRA   e A
1a6d : 000e           : SRA   e A
1a6e : 000e           : SRA   e A
1a6f : 000e           : SRA   e A
1a70 : 000e           : SRA   e A
1a71 : 000e           : SRA   e A
1a72 : 000e           : SRA   e A
1a73 : 000f           : SRA   f A
1a74 : 000f           : SRA   f A
1a75 : 000f           : SRA   f A
1a76 : 000f           : SRA   f A
1a77 : 000f           : SRA   f A
1a78 : 000f           : SRA   f A
1a79 : 000f           : SRA   f A
1a7a : 000f           : SRA   f A
1a7b : f800 1b63      : JMP  .1b63
1a7d : 805a           : LDA   005a
1a7e : 4800 068a      : STO  .068a
1a80 : 0385 03c7 1a92 : JBC   5 03c7 1a92
1a83 : 806a           : LDA   006a
1a84 : c800 03c7      : AND  .03c7
1a86 : 4181           : STO   0181
1a87 : 8000 ffe0      : LDA  ,ffe0
1a89 : c800 068a      : AND  .068a
1a8b : 9181           : ADD   0181
1a8c : 4800 068a      : STO  .068a
1a8e : 805a           : LDA   005a
1a8f : 417f           : STO   017f
1a90 : f800 1aa0      : JMP  .1aa0
1a92 : 8800 03c7      : LDA  .03c7
1a94 : 0028           : SRL   8 A
1a95 : c06a           : AND   006a
1a96 : 4182           : STO   0182
1a97 : 8000 ffe0      : LDA  ,ffe0
1a99 : c800 068a      : AND  .068a
1a9b : 9182           : ADD   0182
1a9c : 4800 068a      : STO  .068a
1a9e : 805b           : LDA   005b
1a9f : 417f           : STO   017f
1aa0 : 817f           : LDA   017f
1aa1 : 9000 0081      : ADD  ,0081
1aa3 : 4041           : STO   0041
1aa4 : 8841           : LDA  /0041
1aa5 : 4180           : STO   0180
1aa6 : 9000 0105      : ADD  ,0105
1aa8 : 4042           : STO   0042
1aa9 : 8842           : LDA  /0042
1aaa : 009c 1aff      : JBS   c A 1aff
1aac : 8180           : LDA   0180
1aad : b05b           : CMP   005b
1aae : 0191 1ab7      : JBS   1 CR 1ab7
1ab0 : b05e           : CMP   005e
1ab1 : 0191 1ab7      : JBS   1 CR 1ab7
1ab3 : 805f           : LDA   005f
1ab4 : b180           : CMP   0180
1ab5 : 0193 1b0e      : JBS   3 CR 1b0e
1ab7 : 8180           : LDA   0180
1ab8 : 9000 0105      : ADD  ,0105
1aba : 4041           : STO   0041
1abb : 8841           : LDA  /0041
1abc : 008a 1b0e      : JBC   a A 1b0e
1abe : 8180           : LDA   0180
1abf : b05e           : CMP   005e
1ac0 : 0193 1ae2      : JBS   3 CR 1ae2
1ac2 : 0388 00cb 1b0e : JBC   8 00cb 1b0e
1ac5 : 038a 00cb 1b0e : JBC   a 00cb 1b0e
1ac8 : 0389 00cb 1b0e : JBC   9 00cb 1b0e
1acb : 038c 00cb 1ad8 : JBC   c 00cb 1ad8
1ace : 8000 ff1f      : LDA  ,ff1f
1ad0 : c800 068a      : AND  .068a
1ad2 : 9000 0060      : ADD  ,0060
1ad4 : 4800 068a      : STO  .068a
1ad6 : f800 1b0e      : JMP  .1b0e
1ad8 : 8000 ff1f      : LDA  ,ff1f
1ada : c800 068a      : AND  .068a
1adc : 9000 0040      : ADD  ,0040
1ade : 4800 068a      : STO  .068a
1ae0 : f800 1b0e      : JMP  .1b0e
1ae2 : 8180           : LDA   0180
1ae3 : 9000 0105      : ADD  ,0105
1ae5 : 4041           : STO   0041
1ae6 : 8841           : LDA  /0041
1ae7 : 008f 1b0e      : JBC   f A 1b0e
1ae9 : 008e 1af5      : JBC   e A 1af5
1aeb : 8000 ff1f      : LDA  ,ff1f
1aed : c800 068a      : AND  .068a
1aef : 9000 0060      : ADD  ,0060
1af1 : 4800 068a      : STO  .068a
1af3 : f800 1b0e      : JMP  .1b0e
1af5 : 8000 ff1f      : LDA  ,ff1f
1af7 : c800 068a      : AND  .068a
1af9 : 9000 0040      : ADD  ,0040
1afb : 4800 068a      : STO  .068a
1afd : f800 1b0e      : JMP  .1b0e
1aff : 8180           : LDA   0180
1b00 : 9000 0105      : ADD  ,0105
1b02 : 4041           : STO   0041
1b03 : 8841           : LDA  /0041
1b04 : 008f 1b0e      : JBC   f A 1b0e
1b06 : 8000 ff1f      : LDA  ,ff1f
1b08 : c800 068a      : AND  .068a
1b0a : 9000 0020      : ADD  ,0020
1b0c : 4800 068a      : STO  .068a
1b0e : 8000 00e0      : LDA  ,00e0
1b10 : c800 068a      : AND  .068a
1b12 : 0191 1b62      : JBS   1 CR 1b62
1b14 : 8000 00e0      : LDA  ,00e0
1b16 : c800 068a      : AND  .068a
1b18 : b000 0060      : CMP  ,0060
1b1a : 0181 1b41      : JBC   1 CR 1b41
1b1c : 8180           : LDA   0180
1b1d : b05e           : CMP   005e
1b1e : 0193 1b31      : JBS   3 CR 1b31
1b20 : 8800 068c      : LDA  .068c
1b22 : 4041           : STO   0041
1b23 : 806d           : LDA   006d
1b24 : c800 068a      : AND  .068a
1b26 : 4182           : STO   0182
1b27 : 8000 054a      : LDA  ,054a
1b29 : 5041           : ADS   0041
1b2a : 8000 ff00      : LDA  ,ff00
1b2c : c841           : AND  /0041
1b2d : 9182           : ADD   0182
1b2e : 4841           : STO  /0041
1b2f : f800 1b62      : JMP  .1b62
1b31 : 8800 068c      : LDA  .068c
1b33 : 4041           : STO   0041
1b34 : 8800 068a      : LDA  .068a
1b36 : 0068           : SLL   8 A
1b37 : 4183           : STO   0183
1b38 : 8000 054a      : LDA  ,054a
1b3a : 5041           : ADS   0041
1b3b : 806d           : LDA   006d
1b3c : c841           : AND  /0041
1b3d : 9183           : ADD   0183
1b3e : 4841           : STO  /0041
1b3f : f800 1b62      : JMP  .1b62
1b41 : 8180           : LDA   0180
1b42 : b05e           : CMP   005e
1b43 : 0193 1b55      : JBS   3 CR 1b55
1b45 : 806d           : LDA   006d
1b46 : c800 068a      : AND  .068a
1b48 : 4181           : STO   0181
1b49 : 8800 068b      : LDA  .068b
1b4b : 9000 03ca      : ADD  ,03ca
1b4d : 4041           : STO   0041
1b4e : 8000 ff00      : LDA  ,ff00
1b50 : c841           : AND  /0041
1b51 : 9181           : ADD   0181
1b52 : 4841           : STO  /0041
1b53 : f800 1b62      : JMP  .1b62
1b55 : 8800 068a      : LDA  .068a
1b57 : 0068           : SLL   8 A
1b58 : 4181           : STO   0181
1b59 : 8800 068b      : LDA  .068b
1b5b : 9000 03ca      : ADD  ,03ca
1b5d : 4041           : STO   0041
1b5e : 806d           : LDA   006d
1b5f : c841           : AND  /0041
1b60 : 9181           : ADD   0181
1b61 : 4841           : STO  /0041
1b62 : 3800           : RTC
1b63 : 3000           : RTN
1b64 : f800 1bea      : JMP  .1bea
1b66 : 8800 068c      : LDA  .068c
1b68 : 905b           : ADD   005b
1b69 : 4186           : STO   0186
1b6a : b000 013f      : CMP  ,013f
1b6c : 0183 1b70      : JBC   3 CR 1b70
1b6e : 805a           : LDA   005a
1b6f : 4186           : STO   0186
1b70 : 8081           : LDA   0081
1b71 : 4185           : STO   0185
1b72 : b05b           : CMP   005b
1b73 : 0191 1b78      : JBS   1 CR 1b78
1b75 : b05e           : CMP   005e
1b76 : 0181 1bb5      : JBC   1 CR 1bb5
1b78 : 8186           : LDA   0186
1b79 : 9000 054a      : ADD  ,054a
1b7b : 4026           : STO   0026
1b7c : 8000 00e0      : LDA  ,00e0
1b7e : c826           : AND  /0026
1b7f : b000 0060      : CMP  ,0060
1b81 : 0181 1b90      : JBC   1 CR 1b90
1b83 : 806d           : LDA   006d
1b84 : c826           : AND  /0026
1b85 : 4188           : STO   0188
1b86 : 8800 068b      : LDA  .068b
1b88 : 9000 03ca      : ADD  ,03ca
1b8a : 4027           : STO   0027
1b8b : 8000 ff00      : LDA  ,ff00
1b8d : c827           : AND  /0027
1b8e : 9188           : ADD   0188
1b8f : 4827           : STO  /0027
1b90 : 8185           : LDA   0185
1b91 : 9000 0105      : ADD  ,0105
1b93 : 4026           : STO   0026
1b94 : 8826           : LDA  /0026
1b95 : 008a 1bb3      : JBC   a A 1bb3
1b97 : 0388 00cb 1bb3 : JBC   8 00cb 1bb3
1b9a : 038a 00cb 1bb3 : JBC   a 00cb 1bb3
1b9d : 0399 00cb 1bb3 : JBS   9 00cb 1bb3
1ba0 : 8800 068b      : LDA  .068b
1ba2 : 9000 03ca      : ADD  ,03ca
1ba4 : 4027           : STO   0027
1ba5 : 4028           : STO   0028
1ba6 : 8000 ff00      : LDA  ,ff00
1ba8 : c827           : AND  /0027
1ba9 : 4828           : STO  /0028
1baa : c000 ff1f      : AND  ,ff1f
1bac : 9000 0080      : ADD  ,0080
1bae : 4827           : STO  /0027
1baf : 805b           : LDA   005b
1bb0 : 4110           : STO   0110
1bb1 : f800 1bb5      : JMP  .1bb5
1bb3 : 805a           : LDA   005a
1bb4 : 4110           : STO   0110
1bb5 : 8186           : LDA   0186
1bb6 : 9000 054a      : ADD  ,054a
1bb8 : 4026           : STO   0026
1bb9 : 8000 e000      : LDA  ,e000
1bbb : c826           : AND  /0026
1bbc : b000 6000      : CMP  ,6000
1bbe : 0181 1bcd      : JBC   1 CR 1bcd
1bc0 : 8000 ff00      : LDA  ,ff00
1bc2 : c826           : AND  /0026
1bc3 : 4188           : STO   0188
1bc4 : 8800 068b      : LDA  .068b
1bc6 : 9000 03ca      : ADD  ,03ca
1bc8 : 4027           : STO   0027
1bc9 : 806d           : LDA   006d
1bca : c827           : AND  /0027
1bcb : 9188           : ADD   0188
1bcc : 4827           : STO  /0027
1bcd : 8186           : LDA   0186
1bce : 9000 054a      : ADD  ,054a
1bd0 : 4026           : STO   0026
1bd1 : 805a           : LDA   005a
1bd2 : 4826           : STO  /0026
1bd3 : 8186           : LDA   0186
1bd4 : 4800 068c      : STO  .068c
1bd6 : 8800 068b      : LDA  .068b
1bd8 : 905b           : ADD   005b
1bd9 : 4187           : STO   0187
1bda : b000 017f      : CMP  ,017f
1bdc : 0183 1be0      : JBC   3 CR 1be0
1bde : 805a           : LDA   005a
1bdf : 4187           : STO   0187
1be0 : 8187           : LDA   0187
1be1 : 9000 03ca      : ADD  ,03ca
1be3 : 4026           : STO   0026
1be4 : 805a           : LDA   005a
1be5 : 4826           : STO  /0026
1be6 : 8187           : LDA   0187
1be7 : 4800 068b      : STO  .068b
1be9 : 3800           : RTC
1bea : 3000           : RTN
1beb : f800 1d9e      : JMP  .1d9e
1bed : 805a           : LDA   005a
1bee : 4192           : STO   0192
1bef : 8192           : LDA   0192
1bf0 : b05b           : CMP   005b
1bf1 : 0193 1d9d      : JBS   3 CR 1d9d
1bf3 : 9000 0081      : ADD  ,0081
1bf5 : 4026           : STO   0026
1bf6 : 8826           : LDA  /0026
1bf7 : 418d           : STO   018d
1bf8 : b05e           : CMP   005e
1bf9 : 0193 1c08      : JBS   3 CR 1c08
1bfb : 0c02           : EXT  ,0402
1bfc : 018D           : DATA
1bfd : 005F           : DATA
1bfe : 0195           : DATA
1bff : 8195           : LDA   0195
1c00 : 9000 06fb      : ADD  ,06fb
1c02 : 4027           : STO   0027
1c03 : 8000 0020      : LDA  ,0020
1c05 : 4827           : STO  /0027
1c06 : f800 1c13      : JMP  .1c13
1c08 : 0c02           : EXT  ,0402
1c09 : 018D           : DATA
1c0a : 005F           : DATA
1c0b : 0196           : DATA
1c0c : 8196           : LDA   0196
1c0d : 9000 0728      : ADD  ,0728
1c0f : 4026           : STO   0026
1c10 : 8000 0020      : LDA  ,0020
1c12 : 4826           : STO  /0026
1c13 : 805a           : LDA   005a
1c14 : 418c           : STO   018c
1c15 : 818c           : LDA   018c
1c16 : b062           : CMP   0062
1c17 : 0193 1d94      : JBS   3 CR 1d94
1c19 : 805a           : LDA   005a
1c1a : 4191           : STO   0191
1c1b : 818d           : LDA   018d
1c1c : b18c           : CMP   018c
1c1d : 0191 1d90      : JBS   1 CR 1d90
1c1f : b05e           : CMP   005e
1c20 : 0193 1c2b      : JBS   3 CR 1c2b
1c22 : 818c           : LDA   018c
1c23 : 9000 00f0      : ADD  ,00f0
1c25 : 4026           : STO   0026
1c26 : 806b           : LDA   006b
1c27 : c826           : AND  /0026
1c28 : 418b           : STO   018b
1c29 : f800 1c33      : JMP  .1c33
1c2b : 818c           : LDA   018c
1c2c : 9000 00f0      : ADD  ,00f0
1c2e : 4026           : STO   0026
1c2f : 8074           : LDA   0074
1c30 : c826           : AND  /0026
1c31 : 0029           : SRL   9 A
1c32 : 418b           : STO   018b
1c33 : 806b           : LDA   006b
1c34 : c18b           : AND   018b
1c35 : 4195           : STO   0195
1c36 : 8000 ffc0      : LDA  ,ffc0
1c38 : c191           : AND   0191
1c39 : 9195           : ADD   0195
1c3a : 4191           : STO   0191
1c3b : 0c02           : EXT  ,0402
1c3c : 0064           : DATA
1c3d : 0192           : DATA
1c3e : 0195           : DATA
1c3f : 8195           : LDA   0195
1c40 : 918c           : ADD   018c
1c41 : 418f           : STO   018f
1c42 : 0395 018b 1cfa : JBS   5 018b 1cfa
1c45 : 9000 06e7      : ADD  ,06e7
1c47 : 4026           : STO   0026
1c48 : 8826           : LDA  /0026
1c49 : 009c 1c70      : JBS   c A 1c70
1c4b : 818f           : LDA   018f
1c4c : 9000 00cd      : ADD  ,00cd
1c4e : 4027           : STO   0027
1c4f : 806f           : LDA   006f
1c50 : c827           : AND  /0027
1c51 : 0021           : SRL   1 A
1c52 : 418e           : STO   018e
1c53 : 8000 0018      : LDA  ,0018
1c55 : 4078           : STO   0078
1c56 : 0c02           : EXT  ,0402
1c57 : 018E           : DATA
1c58 : 0078           : DATA
1c59 : 0195           : DATA
1c5a : 8000 01f4      : LDA  ,01f4
1c5c : 5195           : ADS   0195
1c5d : 8000 03e8      : LDA  ,03e8
1c5f : 407b           : STO   007b
1c60 : 0c06           : EXT  ,0406
1c61 : 0195           : DATA
1c62 : 007B           : DATA
1c63 : 0079           : DATA
1c64 : 807a           : LDA   007a
1c65 : 518e           : ADS   018e
1c66 : 806f           : LDA   006f
1c67 : c18e           : AND   018e
1c68 : 4195           : STO   0195
1c69 : 8000 fc00      : LDA  ,fc00
1c6b : c826           : AND  /0026
1c6c : 9195           : ADD   0195
1c6d : 4826           : STO  /0026
1c6e : f800 1c77      : JMP  .1c77
1c70 : 818f           : LDA   018f
1c71 : 9000 06e7      : ADD  ,06e7
1c73 : 4026           : STO   0026
1c74 : 806f           : LDA   006f
1c75 : c826           : AND  /0026
1c76 : 418e           : STO   018e
1c77 : 8060           : LDA   0060
1c78 : b18e           : CMP   018e
1c79 : 0183 1c7f      : JBC   3 CR 1c7f
1c7b : 805e           : LDA   005e
1c7c : 418e           : STO   018e
1c7d : f800 1c81      : JMP  .1c81
1c7f : 805c           : LDA   005c
1c80 : 618e           : SBS   018e
1c81 : 818e           : LDA   018e
1c82 : b000 017c      : CMP  ,017c
1c84 : 0193 1cf8      : JBS   3 CR 1cf8
1c86 : b800 068b      : CMP  .068b
1c88 : 0183 1c91      : JBC   3 CR 1c91
1c8a : a000 0180      : SUB  ,0180
1c8c : 9800 068b      : ADD  .068b
1c8e : 418a           : STO   018a
1c8f : f800 1c95      : JMP  .1c95
1c91 : 818e           : LDA   018e
1c92 : a800 068b      : SUB  .068b
1c94 : 418a           : STO   018a
1c95 : 805a           : LDA   005a
1c96 : 4194           : STO   0194
1c97 : 818a           : LDA   018a
1c98 : 4190           : STO   0190
1c99 : 805a           : LDA   005a
1c9a : 4193           : STO   0193
1c9b : 805b           : LDA   005b
1c9c : 5193           : ADS   0193
1c9d : 8194           : LDA   0194
1c9e : 0181 1cc9      : JBC   1 CR 1cc9
1ca0 : 805f           : LDA   005f
1ca1 : b18d           : CMP   018d
1ca2 : 0183 1cae      : JBC   3 CR 1cae
1ca4 : 8190           : LDA   0190
1ca5 : 9000 03ca      : ADD  ,03ca
1ca7 : 4026           : STO   0026
1ca8 : 806d           : LDA   006d
1ca9 : c826           : AND  /0026
1caa : 0025           : SRL   5 A
1cab : 4194           : STO   0194
1cac : f800 1cb5      : JMP  .1cb5
1cae : 8190           : LDA   0190
1caf : 9000 03ca      : ADD  ,03ca
1cb1 : 4026           : STO   0026
1cb2 : 8826           : LDA  /0026
1cb3 : 002d           : SRL   d A
1cb4 : 4194           : STO   0194
1cb5 : 8194           : LDA   0194
1cb6 : 0181 1c9b      : JBC   1 CR 1c9b
1cb8 : 805b           : LDA   005b
1cb9 : 5190           : ADS   0190
1cba : 8190           : LDA   0190
1cbb : b000 017f      : CMP  ,017f
1cbd : 0183 1cc1      : JBC   3 CR 1cc1
1cbf : 805a           : LDA   005a
1cc0 : 4190           : STO   0190
1cc1 : 8193           : LDA   0193
1cc2 : b05e           : CMP   005e
1cc3 : 0181 1c9b      : JBC   1 CR 1c9b
1cc5 : 8075           : LDA   0075
1cc6 : 4194           : STO   0194
1cc7 : f800 1c9b      : JMP  .1c9b
1cc9 : 805c           : LDA   005c
1cca : b194           : CMP   0194
1ccb : 0193 1ce8      : JBS   3 CR 1ce8
1ccd : 818c           : LDA   018c
1cce : b05b           : CMP   005b
1ccf : 0191 1cd8      : JBS   1 CR 1cd8
1cd1 : b05e           : CMP   005e
1cd2 : 0191 1cd8      : JBS   1 CR 1cd8
1cd4 : 805f           : LDA   005f
1cd5 : b18c           : CMP   018c
1cd6 : 0193 1ce4      : JBS   3 CR 1ce4
1cd8 : 8194           : LDA   0194
1cd9 : 0066           : SLL   6 A
1cda : c000 01c0      : AND  ,01c0
1cdc : 4196           : STO   0196
1cdd : 8000 fe3f      : LDA  ,fe3f
1cdf : c191           : AND   0191
1ce0 : 9196           : ADD   0196
1ce1 : 4191           : STO   0191
1ce2 : f800 1cfa      : JMP  .1cfa
1ce4 : 03e5 0191      : SET   5 0191
1ce6 : f800 1cfa      : JMP  .1cfa
1ce8 : 8194           : LDA   0194
1ce9 : b05b           : CMP   005b
1cea : 0181 1cf4      : JBC   1 CR 1cf4
1cec : 8000 fe3f      : LDA  ,fe3f
1cee : c191           : AND   0191
1cef : 9000 0040      : ADD  ,0040
1cf1 : 4191           : STO   0191
1cf2 : f800 1cfa      : JMP  .1cfa
1cf4 : 03e5 0191      : SET   5 0191
1cf6 : f800 1cfa      : JMP  .1cfa
1cf8 : 03e5 0191      : SET   5 0191
1cfa : 0385 0191 1d06 : JBC   5 0191 1d06
1cfd : 818f           : LDA   018f
1cfe : 9000 06e7      : ADD  ,06e7
1d00 : 4026           : STO   0026
1d01 : 8826           : LDA  /0026
1d02 : 00fc           : CLR   c A
1d03 : 4826           : STO  /0026
1d04 : f800 1d0d      : JMP  .1d0d
1d06 : 818f           : LDA   018f
1d07 : 9000 06e7      : ADD  ,06e7
1d09 : 4026           : STO   0026
1d0a : 8826           : LDA  /0026
1d0b : 00ec           : SET   c A
1d0c : 4826           : STO  /0026
1d0d : 818c           : LDA   018c
1d0e : b081           : CMP   0081
1d0f : 0191 1d17      : JBS   1 CR 1d17
1d11 : b082           : CMP   0082
1d12 : 0181 1d2f      : JBC   1 CR 1d2f
1d14 : 8082           : LDA   0082
1d15 : 0191 1d2f      : JBS   1 CR 1d2f
1d17 : 8192           : LDA   0192
1d18 : b05b           : CMP   005b
1d19 : 0181 1d25      : JBC   1 CR 1d25
1d1b : 0c02           : EXT  ,0402
1d1c : 018D           : DATA
1d1d : 005F           : DATA
1d1e : 0197           : DATA
1d1f : 8000 06fb      : LDA  ,06fb
1d21 : 9197           : ADD   0197
1d22 : 4196           : STO   0196
1d23 : f800 1d44      : JMP  .1d44
1d25 : 0c02           : EXT  ,0402
1d26 : 018D           : DATA
1d27 : 005F           : DATA
1d28 : 0198           : DATA
1d29 : 8000 0728      : LDA  ,0728
1d2b : 9198           : ADD   0198
1d2c : 4196           : STO   0196
1d2d : f800 1d44      : JMP  .1d44
1d2f : 8192           : LDA   0192
1d30 : 0181 1d3c      : JBC   1 CR 1d3c
1d32 : 0c02           : EXT  ,0402
1d33 : 018C           : DATA
1d34 : 005F           : DATA
1d35 : 0197           : DATA
1d36 : 8000 068d      : LDA  ,068d
1d38 : 9197           : ADD   0197
1d39 : 4196           : STO   0196
1d3a : f800 1d44      : JMP  .1d44
1d3c : 0c02           : EXT  ,0402
1d3d : 018C           : DATA
1d3e : 005F           : DATA
1d3f : 0198           : DATA
1d40 : 8000 06ba      : LDA  ,06ba
1d42 : 9198           : ADD   0198
1d43 : 4196           : STO   0196
1d44 : 8196           : LDA   0196
1d45 : 4026           : STO   0026
1d46 : 8191           : LDA   0191
1d47 : 4826           : STO  /0026
1d48 : 805b           : LDA   005b
1d49 : 5196           : ADS   0196
1d4a : 0395 0191 1d90 : JBS   5 0191 1d90
1d4d : 8192           : LDA   0192
1d4e : 0181 1d70      : JBC   1 CR 1d70
1d50 : 805b           : LDA   005b
1d51 : 4195           : STO   0195
1d52 : 8195           : LDA   0195
1d53 : b05e           : CMP   005e
1d54 : 0193 1d90      : JBS   3 CR 1d90
1d56 : 8196           : LDA   0196
1d57 : 4026           : STO   0026
1d58 : 818a           : LDA   018a
1d59 : 9000 03ca      : ADD  ,03ca
1d5b : 4027           : STO   0027
1d5c : 806d           : LDA   006d
1d5d : c827           : AND  /0027
1d5e : 4826           : STO  /0026
1d5f : 805b           : LDA   005b
1d60 : 5196           : ADS   0196
1d61 : 818a           : LDA   018a
1d62 : b000 017f      : CMP  ,017f
1d64 : 0181 1d6a      : JBC   1 CR 1d6a
1d66 : 805a           : LDA   005a
1d67 : 418a           : STO   018a
1d68 : f800 1d6c      : JMP  .1d6c
1d6a : 805b           : LDA   005b
1d6b : 518a           : ADS   018a
1d6c : 805b           : LDA   005b
1d6d : 5195           : ADS   0195
1d6e : f800 1d52      : JMP  .1d52
1d70 : 805b           : LDA   005b
1d71 : 4195           : STO   0195
1d72 : 8195           : LDA   0195
1d73 : b05e           : CMP   005e
1d74 : 0193 1d90      : JBS   3 CR 1d90
1d76 : 8196           : LDA   0196
1d77 : 4026           : STO   0026
1d78 : 818a           : LDA   018a
1d79 : 9000 03ca      : ADD  ,03ca
1d7b : 4027           : STO   0027
1d7c : 8827           : LDA  /0027
1d7d : 0028           : SRL   8 A
1d7e : 4826           : STO  /0026
1d7f : 805b           : LDA   005b
1d80 : 5196           : ADS   0196
1d81 : 818a           : LDA   018a
1d82 : b000 017f      : CMP  ,017f
1d84 : 0181 1d8a      : JBC   1 CR 1d8a
1d86 : 805a           : LDA   005a
1d87 : 418a           : STO   018a
1d88 : f800 1d8c      : JMP  .1d8c
1d8a : 805b           : LDA   005b
1d8b : 518a           : ADS   018a
1d8c : 805b           : LDA   005b
1d8d : 5195           : ADS   0195
1d8e : f800 1d72      : JMP  .1d72
1d90 : 805b           : LDA   005b
1d91 : 518c           : ADS   018c
1d92 : f800 1c15      : JMP  .1c15
1d94 : 8082           : LDA   0082
1d95 : 0181 1d99      : JBC   1 CR 1d99
1d97 : 805b           : LDA   005b
1d98 : 4192           : STO   0192
1d99 : 805b           : LDA   005b
1d9a : 5192           : ADS   0192
1d9b : f800 1bef      : JMP  .1bef
1d9d : 3800           : RTC
1d9e : 3000           : RTN
1d9f : f800 20d1      : JMP  .20d1
1da1 : 8000 fffa      : LDA  ,fffa
1da3 : 4026           : STO   0026
1da4 : 8000 0198      : LDA  ,0198
1da6 : 4027           : STO   0027
1da7 : 8901           : LDA  /0001+
1da8 : 4927           : STO  /0027+
1da9 : 7026 1da7      : ICZ   0026 1da7
1dab : 805a           : LDA   005a
1dac : 4800 0755      : STO  .0755
1dae : 4800 0756      : STO  .0756
1db0 : 4800 0757      : STO  .0757
1db2 : 805a           : LDA   005a
1db3 : 419f           : STO   019f
1db4 : 819f           : LDA   019f
1db5 : b062           : CMP   0062
1db6 : 0193 1e67      : JBS   3 CR 1e67
1db8 : 0c02           : EXT  ,0402
1db9 : 019F           : DATA
1dba : 019A           : DATA
1dbb : 01A1           : DATA
1dbc : 81a1           : LDA   01a1
1dbd : 9199           : ADD   0199
1dbe : 4026           : STO   0026
1dbf : 8826           : LDA  /0026
1dc0 : 0095 1e63      : JBS   5 A 1e63
1dc2 : 806d           : LDA   006d
1dc3 : c800 0756      : AND  .0756
1dc5 : 0024           : SRL   4 A
1dc6 : 905b           : ADD   005b
1dc7 : 0064           : SLL   4 A
1dc8 : c000 00f0      : AND  ,00f0
1dca : 41a4           : STO   01a4
1dcb : 8000 ff0f      : LDA  ,ff0f
1dcd : c800 0756      : AND  .0756
1dcf : 91a4           : ADD   01a4
1dd0 : 4800 0756      : STO  .0756
1dd2 : 0c02           : EXT  ,0402
1dd3 : 019F           : DATA
1dd4 : 019A           : DATA
1dd5 : 01A1           : DATA
1dd6 : 81a1           : LDA   01a1
1dd7 : 9199           : ADD   0199
1dd8 : 4026           : STO   0026
1dd9 : 806b           : LDA   006b
1dda : c826           : AND  /0026
1ddb : 0181 1e22      : JBC   1 CR 1e22
1ddd : 819f           : LDA   019f
1dde : 0064           : SLL   4 A
1ddf : c000 00f0      : AND  ,00f0
1de1 : 41a3           : STO   01a3
1de2 : 8000 ff0f      : LDA  ,ff0f
1de4 : c800 0755      : AND  .0755
1de6 : 91a3           : ADD   01a3
1de7 : 4800 0755      : STO  .0755
1de9 : c069           : AND   0069
1dea : 905b           : ADD   005b
1deb : c069           : AND   0069
1dec : 41a2           : STO   01a2
1ded : 8000 fff0      : LDA  ,fff0
1def : c800 0755      : AND  .0755
1df1 : 91a2           : ADD   01a2
1df2 : 4800 0755      : STO  .0755
1df4 : 0c02           : EXT  ,0402
1df5 : 019F           : DATA
1df6 : 019A           : DATA
1df7 : 01A1           : DATA
1df8 : 81a1           : LDA   01a1
1df9 : 9199           : ADD   0199
1dfa : 4026           : STO   0026
1dfb : 8000 01c0      : LDA  ,01c0
1dfd : c826           : AND  /0026
1dfe : 41a2           : STO   01a2
1dff : 8000 0080      : LDA  ,0080
1e01 : b1a2           : CMP   01a2
1e02 : 0193 1e63      : JBS   3 CR 1e63
1e04 : 8071           : LDA   0071
1e05 : c800 0756      : AND  .0756
1e07 : 0028           : SRL   8 A
1e08 : 905b           : ADD   005b
1e09 : 0068           : SLL   8 A
1e0a : c000 0f00      : AND  ,0f00
1e0c : 41a5           : STO   01a5
1e0d : 8000 f0ff      : LDA  ,f0ff
1e0f : c800 0756      : AND  .0756
1e11 : 91a5           : ADD   01a5
1e12 : 4800 0756      : STO  .0756
1e14 : 8800 0755      : LDA  .0755
1e16 : 0068           : SLL   8 A
1e17 : c000 f000      : AND  ,f000
1e19 : 41a2           : STO   01a2
1e1a : 8071           : LDA   0071
1e1b : c800 0756      : AND  .0756
1e1d : 91a2           : ADD   01a2
1e1e : 4800 0756      : STO  .0756
1e20 : f800 1e63      : JMP  .1e63
1e22 : 819f           : LDA   019f
1e23 : 006c           : SLL   c A
1e24 : 41a1           : STO   01a1
1e25 : 8071           : LDA   0071
1e26 : c800 0755      : AND  .0755
1e28 : 91a1           : ADD   01a1
1e29 : 4800 0755      : STO  .0755
1e2b : c071           : AND   0071
1e2c : 0028           : SRL   8 A
1e2d : 905b           : ADD   005b
1e2e : 0068           : SLL   8 A
1e2f : c000 0f00      : AND  ,0f00
1e31 : 41a4           : STO   01a4
1e32 : 8000 f0ff      : LDA  ,f0ff
1e34 : c800 0755      : AND  .0755
1e36 : 91a4           : ADD   01a4
1e37 : 4800 0755      : STO  .0755
1e39 : 0c02           : EXT  ,0402
1e3a : 019F           : DATA
1e3b : 019A           : DATA
1e3c : 01A1           : DATA
1e3d : 81a1           : LDA   01a1
1e3e : 9199           : ADD   0199
1e3f : 4026           : STO   0026
1e40 : 8000 01c0      : LDA  ,01c0
1e42 : c826           : AND  /0026
1e43 : 41a2           : STO   01a2
1e44 : 8000 0080      : LDA  ,0080
1e46 : b1a2           : CMP   01a2
1e47 : 0193 1e63      : JBS   3 CR 1e63
1e49 : 8069           : LDA   0069
1e4a : c800 0757      : AND  .0757
1e4c : 905b           : ADD   005b
1e4d : c069           : AND   0069
1e4e : 41a3           : STO   01a3
1e4f : 8000 fff0      : LDA  ,fff0
1e51 : c800 0757      : AND  .0757
1e53 : 91a3           : ADD   01a3
1e54 : 4800 0757      : STO  .0757
1e56 : 8800 0755      : LDA  .0755
1e58 : 0028           : SRL   8 A
1e59 : c000 00f0      : AND  ,00f0
1e5b : 41a2           : STO   01a2
1e5c : 8000 ff0f      : LDA  ,ff0f
1e5e : c800 0757      : AND  .0757
1e60 : 91a2           : ADD   01a2
1e61 : 4800 0757      : STO  .0757
1e63 : 805b           : LDA   005b
1e64 : 519f           : ADS   019f
1e65 : f800 1db4      : JMP  .1db4
1e67 : 8071           : LDA   0071
1e68 : c800 0756      : AND  .0756
1e6a : 0028           : SRL   8 A
1e6b : 41a2           : STO   01a2
1e6c : 8069           : LDA   0069
1e6d : c800 0757      : AND  .0757
1e6f : 51a2           : ADS   01a2
1e70 : 8069           : LDA   0069
1e71 : c1a2           : AND   01a2
1e72 : 41a3           : STO   01a3
1e73 : 8000 fff0      : LDA  ,fff0
1e75 : c800 0756      : AND  .0756
1e77 : 91a3           : ADD   01a3
1e78 : 4800 0756      : STO  .0756
1e7a : 819d           : LDA   019d
1e7b : 4026           : STO   0026
1e7c : 8826           : LDA  /0026
1e7d : b05e           : CMP   005e
1e7e : 0193 1e9e      : JBS   3 CR 1e9e
1e80 : b05b           : CMP   005b
1e81 : 0191 1e86      : JBS   1 CR 1e86
1e83 : b05e           : CMP   005e
1e84 : 0181 1eb9      : JBC   1 CR 1eb9
1e86 : 0388 00cb 1eb9 : JBC   8 00cb 1eb9
1e89 : 039c 00cb 1e95 : JBS   c 00cb 1e95
1e8c : 8071           : LDA   0071
1e8d : c800 0757      : AND  .0757
1e8f : 9000 2000      : ADD  ,2000
1e91 : 4800 0757      : STO  .0757
1e93 : f800 1eb9      : JMP  .1eb9
1e95 : 8071           : LDA   0071
1e96 : c800 0757      : AND  .0757
1e98 : 9000 3000      : ADD  ,3000
1e9a : 4800 0757      : STO  .0757
1e9c : f800 1eb9      : JMP  .1eb9
1e9e : 819d           : LDA   019d
1e9f : 4026           : STO   0026
1ea0 : 8826           : LDA  /0026
1ea1 : 9000 0105      : ADD  ,0105
1ea3 : 4027           : STO   0027
1ea4 : 8827           : LDA  /0027
1ea5 : 008a 1eb9      : JBC   a A 1eb9
1ea7 : 009e 1eb2      : JBS   e A 1eb2
1ea9 : 8071           : LDA   0071
1eaa : c800 0757      : AND  .0757
1eac : 9000 2000      : ADD  ,2000
1eae : 4800 0757      : STO  .0757
1eb0 : f800 1eb9      : JMP  .1eb9
1eb2 : 8071           : LDA   0071
1eb3 : c800 0757      : AND  .0757
1eb5 : 9000 3000      : ADD  ,3000
1eb7 : 4800 0757      : STO  .0757
1eb9 : 8069           : LDA   0069
1eba : c800 0755      : AND  .0755
1ebc : b05a           : CMP   005a
1ebd : 0183 1f2f      : JBC   3 CR 1f2f
1ebf : 8800 0755      : LDA  .0755
1ec1 : 0064           : SLL   4 A
1ec2 : c000 0f00      : AND  ,0f00
1ec4 : 41a2           : STO   01a2
1ec5 : 8000 f0ff      : LDA  ,f0ff
1ec7 : c800 0757      : AND  .0757
1ec9 : 91a2           : ADD   01a2
1eca : 4800 0757      : STO  .0757
1ecc : 8069           : LDA   0069
1ecd : c800 0755      : AND  .0755
1ecf : b05b           : CMP   005b
1ed0 : 0181 1f29      : JBC   1 CR 1f29
1ed2 : 8000 0f00      : LDA  ,0f00
1ed4 : c800 0756      : AND  .0756
1ed6 : b000 0100      : CMP  ,0100
1ed8 : 0181 1f17      : JBC   1 CR 1f17
1eda : 8071           : LDA   0071
1edb : c800 0757      : AND  .0757
1edd : 0028           : SRL   8 A
1ede : 4078           : STO   0078
1edf : 0c02           : EXT  ,0402
1ee0 : 0078           : DATA
1ee1 : 019A           : DATA
1ee2 : 01A2           : DATA
1ee3 : 81a2           : LDA   01a2
1ee4 : 9199           : ADD   0199
1ee5 : 4026           : STO   0026
1ee6 : 8000 01c0      : LDA  ,01c0
1ee8 : c826           : AND  /0026
1ee9 : b000 0100      : CMP  ,0100
1eeb : 0181 1ef3      : JBC   1 CR 1ef3
1eed : 819e           : LDA   019e
1eee : 4026           : STO   0026
1eef : 805a           : LDA   005a
1ef0 : 4826           : STO  /0026
1ef1 : f800 2019      : JMP  .2019
1ef3 : 8071           : LDA   0071
1ef4 : c800 0757      : AND  .0757
1ef6 : 0028           : SRL   8 A
1ef7 : 4078           : STO   0078
1ef8 : 0c02           : EXT  ,0402
1ef9 : 0078           : DATA
1efa : 019A           : DATA
1efb : 01A4           : DATA
1efc : 8000 f000      : LDA  ,f000
1efe : c800 0757      : AND  .0757
1f00 : 41a5           : STO   01a5
1f01 : 81a4           : LDA   01a4
1f02 : 9199           : ADD   0199
1f03 : 4026           : STO   0026
1f04 : 8000 01c0      : LDA  ,01c0
1f06 : c826           : AND  /0026
1f07 : 0066           : SLL   6 A
1f08 : b1a5           : CMP   01a5
1f09 : 0181 1f11      : JBC   1 CR 1f11
1f0b : 819e           : LDA   019e
1f0c : 4026           : STO   0026
1f0d : 805a           : LDA   005a
1f0e : 4826           : STO  /0026
1f0f : f800 2019      : JMP  .2019
1f11 : 819e           : LDA   019e
1f12 : 4026           : STO   0026
1f13 : 805d           : LDA   005d
1f14 : 4826           : STO  /0026
1f15 : f800 2019      : JMP  .2019
1f17 : 8000 f000      : LDA  ,f000
1f19 : c800 0757      : AND  .0757
1f1b : 0181 1f23      : JBC   1 CR 1f23
1f1d : 819e           : LDA   019e
1f1e : 4026           : STO   0026
1f1f : 805a           : LDA   005a
1f20 : 4826           : STO  /0026
1f21 : f800 2019      : JMP  .2019
1f23 : 819e           : LDA   019e
1f24 : 4026           : STO   0026
1f25 : 805d           : LDA   005d
1f26 : 4826           : STO  /0026
1f27 : f800 2019      : JMP  .2019
1f29 : 819e           : LDA   019e
1f2a : 4026           : STO   0026
1f2b : 805d           : LDA   005d
1f2c : 4826           : STO  /0026
1f2d : f800 2019      : JMP  .2019
1f2f : 8000 0f00      : LDA  ,0f00
1f31 : c800 0755      : AND  .0755
1f33 : b05a           : CMP   005a
1f34 : 0183 2011      : JBC   3 CR 2011
1f36 : 8800 0755      : LDA  .0755
1f38 : 0024           : SRL   4 A
1f39 : c000 0f00      : AND  ,0f00
1f3b : 41a2           : STO   01a2
1f3c : 8000 f0ff      : LDA  ,f0ff
1f3e : c800 0757      : AND  .0757
1f40 : 91a2           : ADD   01a2
1f41 : 4800 0757      : STO  .0757
1f43 : 8000 0f00      : LDA  ,0f00
1f45 : c800 0755      : AND  .0755
1f47 : b000 0100      : CMP  ,0100
1f49 : 0181 200b      : JBC   1 CR 200b
1f4b : 819d           : LDA   019d
1f4c : 4026           : STO   0026
1f4d : 8826           : LDA  /0026
1f4e : b05e           : CMP   005e
1f4f : 0193 1f57      : JBS   3 CR 1f57
1f51 : 805d           : LDA   005d
1f52 : c0fa           : AND   00fa
1f53 : 905b           : ADD   005b
1f54 : 41a0           : STO   01a0
1f55 : f800 1f5c      : JMP  .1f5c
1f57 : 8069           : LDA   0069
1f58 : c0fa           : AND   00fa
1f59 : 0022           : SRL   2 A
1f5a : 905b           : ADD   005b
1f5b : 41a0           : STO   01a0
1f5c : 8069           : LDA   0069
1f5d : c800 0757      : AND  .0757
1f5f : b05b           : CMP   005b
1f60 : 0181 1fd8      : JBC   1 CR 1fd8
1f62 : 8071           : LDA   0071
1f63 : c800 0757      : AND  .0757
1f65 : 0028           : SRL   8 A
1f66 : 4078           : STO   0078
1f67 : 0c02           : EXT  ,0402
1f68 : 0078           : DATA
1f69 : 019A           : DATA
1f6a : 01A2           : DATA
1f6b : 81a2           : LDA   01a2
1f6c : 9199           : ADD   0199
1f6d : 4026           : STO   0026
1f6e : 8000 01c0      : LDA  ,01c0
1f70 : c826           : AND  /0026
1f71 : b000 0100      : CMP  ,0100
1f73 : 0181 1f7b      : JBC   1 CR 1f7b
1f75 : 819e           : LDA   019e
1f76 : 4026           : STO   0026
1f77 : 805a           : LDA   005a
1f78 : 4826           : STO  /0026
1f79 : f800 2019      : JMP  .2019
1f7b : 8071           : LDA   0071
1f7c : c800 0757      : AND  .0757
1f7e : 0028           : SRL   8 A
1f7f : 4078           : STO   0078
1f80 : 0c02           : EXT  ,0402
1f81 : 0078           : DATA
1f82 : 019A           : DATA
1f83 : 01A4           : DATA
1f84 : 8000 f000      : LDA  ,f000
1f86 : c800 0757      : AND  .0757
1f88 : 41a5           : STO   01a5
1f89 : 81a4           : LDA   01a4
1f8a : 9199           : ADD   0199
1f8b : 4026           : STO   0026
1f8c : 8000 01c0      : LDA  ,01c0
1f8e : c826           : AND  /0026
1f8f : 0066           : SLL   6 A
1f90 : b1a5           : CMP   01a5
1f91 : 0191 1f99      : JBS   1 CR 1f99
1f93 : 819e           : LDA   019e
1f94 : 4026           : STO   0026
1f95 : 805d           : LDA   005d
1f96 : 4826           : STO  /0026
1f97 : f800 2019      : JMP  .2019
1f99 : f800 1fa7      : JMP  .1fa7
1f9b : 0041           : SLA   1 A
1f9c : 1000           : SJM
1f9d : 0000           : SRA   0 A
1f9e : 0000           : SRA   0 A
1f9f : f800 1faa      : JMP  .1faa
1fa1 : f800 1faa      : JMP  .1faa
1fa3 : f800 1fb0      : JMP  .1fb0
1fa5 : f800 1fb6      : JMP  .1fb6
1fa7 : 81a0           : LDA   01a0
1fa8 : f800 1f9b      : JMP  .1f9b
1faa : 819e           : LDA   019e
1fab : 4026           : STO   0026
1fac : 805a           : LDA   005a
1fad : 4826           : STO  /0026
1fae : f800 1fba      : JMP  .1fba
1fb0 : 819e           : LDA   019e
1fb1 : 4026           : STO   0026
1fb2 : 805b           : LDA   005b
1fb3 : 4826           : STO  /0026
1fb4 : f800 1fba      : JMP  .1fba
1fb6 : 819e           : LDA   019e
1fb7 : 4026           : STO   0026
1fb8 : 805c           : LDA   005c
1fb9 : 4826           : STO  /0026
1fba : 8071           : LDA   0071
1fbb : c800 0757      : AND  .0757
1fbd : 0028           : SRL   8 A
1fbe : 4078           : STO   0078
1fbf : 0c02           : EXT  ,0402
1fc0 : 0078           : DATA
1fc1 : 019A           : DATA
1fc2 : 01A2           : DATA
1fc3 : 81a2           : LDA   01a2
1fc4 : 9199           : ADD   0199
1fc5 : 4026           : STO   0026
1fc6 : 8000 01c0      : LDA  ,01c0
1fc8 : c826           : AND  /0026
1fc9 : b000 00c0      : CMP  ,00c0
1fcb : 0181 2019      : JBC   1 CR 2019
1fcd : 819e           : LDA   019e
1fce : 4026           : STO   0026
1fcf : 8826           : LDA  /0026
1fd0 : b05a           : CMP   005a
1fd1 : 0183 2019      : JBC   3 CR 2019
1fd3 : a05b           : SUB   005b
1fd4 : a05a           : SUB   005a
1fd5 : 4826           : STO  /0026
1fd6 : f800 2019      : JMP  .2019
1fd8 : f800 1fe8      : JMP  .1fe8
1fda : 0041           : SLA   1 A
1fdb : 1000           : SJM
1fdc : 0000           : SRA   0 A
1fdd : 0000           : SRA   0 A
1fde : f800 1ff3      : JMP  .1ff3
1fe0 : f800 1ff9      : JMP  .1ff9
1fe2 : f800 1fff      : JMP  .1fff
1fe4 : f800 1fff      : JMP  .1fff
1fe6 : f800 2005      : JMP  .2005
1fe8 : 8000 f000      : LDA  ,f000
1fea : c800 0757      : AND  .0757
1fec : 0191 1ff0      : JBS   1 CR 1ff0
1fee : 805f           : LDA   005f
1fef : 41a0           : STO   01a0
1ff0 : 81a0           : LDA   01a0
1ff1 : f800 1fda      : JMP  .1fda
1ff3 : 819e           : LDA   019e
1ff4 : 4026           : STO   0026
1ff5 : 805a           : LDA   005a
1ff6 : 4826           : STO  /0026
1ff7 : f800 2019      : JMP  .2019
1ff9 : 819e           : LDA   019e
1ffa : 4026           : STO   0026
1ffb : 805b           : LDA   005b
1ffc : 4826           : STO  /0026
1ffd : f800 2019      : JMP  .2019
1fff : 819e           : LDA   019e
2000 : 4026           : STO   0026
2001 : 805c           : LDA   005c
2002 : 4826           : STO  /0026
2003 : f800 2019      : JMP  .2019
2005 : 819e           : LDA   019e
2006 : 4026           : STO   0026
2007 : 805d           : LDA   005d
2008 : 4826           : STO  /0026
2009 : f800 2019      : JMP  .2019
200b : 819e           : LDA   019e
200c : 4026           : STO   0026
200d : 805d           : LDA   005d
200e : 4826           : STO  /0026
200f : f800 2019      : JMP  .2019
2011 : 8000 f0ff      : LDA  ,f0ff
2013 : c800 0757      : AND  .0757
2015 : 9000 0f00      : ADD  ,0f00
2017 : 4800 0757      : STO  .0757
2019 : 8000 0f00      : LDA  ,0f00
201b : c800 0757      : AND  .0757
201d : b000 0f00      : CMP  ,0f00
201f : 0181 2036      : JBC   1 CR 2036
2021 : 819b           : LDA   019b
2022 : 4026           : STO   0026
2023 : 805b           : LDA   005b
2024 : 4826           : STO  /0026
2025 : 819b           : LDA   019b
2026 : 4026           : STO   0026
2027 : 8826           : LDA  /0026
2028 : b05e           : CMP   005e
2029 : 0193 2059      : JBS   3 CR 2059
202b : 919b           : ADD   019b
202c : 4027           : STO   0027
202d : 805a           : LDA   005a
202e : 4827           : STO  /0027
202f : 819b           : LDA   019b
2030 : 4026           : STO   0026
2031 : 4027           : STO   0027
2032 : 805b           : LDA   005b
2033 : 5826           : ADS  /0026
2034 : f800 2025      : JMP  .2025
2036 : 819b           : LDA   019b
2037 : 4026           : STO   0026
2038 : 805b           : LDA   005b
2039 : 4826           : STO  /0026
203a : 819b           : LDA   019b
203b : 4026           : STO   0026
203c : 8826           : LDA  /0026
203d : b05e           : CMP   005e
203e : 0193 2059      : JBS   3 CR 2059
2040 : 8071           : LDA   0071
2041 : c800 0757      : AND  .0757
2043 : 0028           : SRL   8 A
2044 : 4078           : STO   0078
2045 : 0c02           : EXT  ,0402
2046 : 0078           : DATA
2047 : 019A           : DATA
2048 : 01A2           : DATA
2049 : 8826           : LDA  /0026
204a : 51a2           : ADS   01a2
204b : 919b           : ADD   019b
204c : 4027           : STO   0027
204d : 81a2           : LDA   01a2
204e : 9199           : ADD   0199
204f : 4028           : STO   0028
2050 : 8828           : LDA  /0028
2051 : 4827           : STO  /0027
2052 : 819b           : LDA   019b
2053 : 4026           : STO   0026
2054 : 4027           : STO   0027
2055 : 805b           : LDA   005b
2056 : 5826           : ADS  /0026
2057 : f800 203a      : JMP  .203a
2059 : 819b           : LDA   019b
205a : 4026           : STO   0026
205b : 805b           : LDA   005b
205c : 4826           : STO  /0026
205d : 819d           : LDA   019d
205e : 4026           : STO   0026
205f : 8826           : LDA  /0026
2060 : b05b           : CMP   005b
2061 : 0191 2066      : JBS   1 CR 2066
2063 : b05e           : CMP   005e
2064 : 0181 2081      : JBC   1 CR 2081
2066 : 8000 0f00      : LDA  ,0f00
2068 : c800 0756      : AND  .0756
206a : b05a           : CMP   005a
206b : 0183 2073      : JBC   3 CR 2073
206d : 8800 0756      : LDA  .0756
206f : 0028           : SRL   8 A
2070 : 4117           : STO   0117
2071 : f800 2081      : JMP  .2081
2073 : 8069           : LDA   0069
2074 : c800 0757      : AND  .0757
2076 : b05a           : CMP   005a
2077 : 0183 207f      : JBC   3 CR 207f
2079 : 806d           : LDA   006d
207a : c800 0757      : AND  .0757
207c : 4117           : STO   0117
207d : f800 2081      : JMP  .2081
207f : 805a           : LDA   005a
2080 : 4117           : STO   0117
2081 : 3800           : RTC
2082 : 8000 06fb      : LDA  ,06fb
2084 : 41a9           : STO   01a9
2085 : 805f           : LDA   005f
2086 : 41aa           : STO   01aa
2087 : 8000 076c      : LDA  ,076c
2089 : 41ab           : STO   01ab
208a : 805f           : LDA   005f
208b : 41ac           : STO   01ac
208c : 8000 0081      : LDA  ,0081
208e : 41ad           : STO   01ad
208f : 8000 0776      : LDA  ,0776
2091 : 41ae           : STO   01ae
2092 : 8000 01a8      : LDA  ,01a8
2094 : 4001           : STO   0001
2095 : 2800 1da1      : CAL  .1da1
2097 : 8082           : LDA   0082
2098 : 0191 20b0      : JBS   1 CR 20b0
209a : 8000 0728      : LDA  ,0728
209c : 41a9           : STO   01a9
209d : 805f           : LDA   005f
209e : 41aa           : STO   01aa
209f : 8000 0771      : LDA  ,0771
20a1 : 41ab           : STO   01ab
20a2 : 805f           : LDA   005f
20a3 : 41ac           : STO   01ac
20a4 : 8000 0082      : LDA  ,0082
20a6 : 41ad           : STO   01ad
20a7 : 8000 0776      : LDA  ,0776
20a9 : 905b           : ADD   005b
20aa : 41ae           : STO   01ae
20ab : 8000 01a8      : LDA  ,01a8
20ad : 4001           : STO   0001
20ae : 2800 1da1      : CAL  .1da1
20b0 : 805a           : LDA   005a
20b1 : 41a8           : STO   01a8
20b2 : 81a8           : LDA   01a8
20b3 : b062           : CMP   0062
20b4 : 0193 20d0      : JBS   3 CR 20d0
20b6 : 0c02           : EXT  ,0402
20b7 : 01A8           : DATA
20b8 : 005F           : DATA
20b9 : 01A9           : DATA
20ba : 81a9           : LDA   01a9
20bb : 9000 06fb      : ADD  ,06fb
20bd : 4026           : STO   0026
20be : 8000 0020      : LDA  ,0020
20c0 : 4826           : STO  /0026
20c1 : 0c02           : EXT  ,0402
20c2 : 01A8           : DATA
20c3 : 005F           : DATA
20c4 : 01A9           : DATA
20c5 : 81a9           : LDA   01a9
20c6 : 9000 0728      : ADD  ,0728
20c8 : 4026           : STO   0026
20c9 : 8000 0020      : LDA  ,0020
20cb : 4826           : STO  /0026
20cc : 805b           : LDA   005b
20cd : 51a8           : ADS   01a8
20ce : f800 20b2      : JMP  .20b2
20d0 : 3800           : RTC
20d1 : 3000           : RTN
20d2 : f800 228c      : JMP  .228c
20d4 : 8000 fff8      : LDA  ,fff8
20d6 : 4026           : STO   0026
20d7 : 8000 01b0      : LDA  ,01b0
20d9 : 4027           : STO   0027
20da : 8901           : LDA  /0001+
20db : 4927           : STO  /0027+
20dc : 7026 20da      : ICZ   0026 20da
20de : 81b3           : LDA   01b3
20df : 9000 0081      : ADD  ,0081
20e1 : 4026           : STO   0026
20e2 : 8826           : LDA  /0026
20e3 : 41bb           : STO   01bb
20e4 : 9000 0105      : ADD  ,0105
20e6 : 4027           : STO   0027
20e7 : 8000 1f00      : LDA  ,1f00
20e9 : c827           : AND  /0027
20ea : 0181 20f3      : JBC   1 CR 20f3
20ec : 81b5           : LDA   01b5
20ed : 4028           : STO   0028
20ee : 8828           : LDA  /0028
20ef : 91b5           : ADD   01b5
20f0 : 4029           : STO   0029
20f1 : 805a           : LDA   005a
20f2 : 4829           : STO  /0029
20f3 : 81b7           : LDA   01b7
20f4 : 9062           : ADD   0062
20f5 : 4026           : STO   0026
20f6 : 8826           : LDA  /0026
20f7 : 91b7           : ADD   01b7
20f8 : 4027           : STO   0027
20f9 : 8827           : LDA  /0027
20fa : 0191 2106      : JBS   1 CR 2106
20fc : 805b           : LDA   005b
20fd : 6926           : SBS  /0026+
20fe : 81b7           : LDA   01b7
20ff : 9062           : ADD   0062
2100 : 4026           : STO   0026
2101 : 8826           : LDA  /0026
2102 : 91b7           : ADD   01b7
2103 : 4027           : STO   0027
2104 : 805a           : LDA   005a
2105 : 4827           : STO  /0027
2106 : 81b5           : LDA   01b5
2107 : 4026           : STO   0026
2108 : 8826           : LDA  /0026
2109 : 91b5           : ADD   01b5
210a : 4027           : STO   0027
210b : 8827           : LDA  /0027
210c : b05a           : CMP   005a
210d : 0183 2228      : JBC   3 CR 2228
210f : c000 00e0      : AND  ,00e0
2111 : b000 0080      : CMP  ,0080
2113 : 0181 2136      : JBC   1 CR 2136
2115 : 81bb           : LDA   01bb
2116 : b05b           : CMP   005b
2117 : 0191 211c      : JBS   1 CR 211c
2119 : b05e           : CMP   005e
211a : 0181 2130      : JBC   1 CR 2130
211c : 8110           : LDA   0110
211d : 0191 2123      : JBS   1 CR 2123
211f : 8075           : LDA   0075
2120 : 4111           : STO   0111
2121 : f800 2130      : JMP  .2130
2123 : 81bb           : LDA   01bb
2124 : 9000 0105      : ADD  ,0105
2126 : 4026           : STO   0026
2127 : 8826           : LDA  /0026
2128 : 008f 212e      : JBC   f A 212e
212a : 805a           : LDA   005a
212b : 4111           : STO   0111
212c : f800 2130      : JMP  .2130
212e : 8075           : LDA   0075
212f : 4111           : STO   0111
2130 : 81b1           : LDA   01b1
2131 : 4026           : STO   0026
2132 : 805a           : LDA   005a
2133 : 4826           : STO  /0026
2134 : f800 223c      : JMP  .223c
2136 : 805a           : LDA   005a
2137 : 4111           : STO   0111
2138 : 81b1           : LDA   01b1
2139 : 4026           : STO   0026
213a : 8826           : LDA  /0026
213b : b05c           : CMP   005c
213c : 0181 2142      : JBC   1 CR 2142
213e : 805a           : LDA   005a
213f : 4826           : STO  /0026
2140 : f800 223c      : JMP  .223c
2142 : 81b1           : LDA   01b1
2143 : 4026           : STO   0026
2144 : 4027           : STO   0027
2145 : 805b           : LDA   005b
2146 : 5826           : ADS  /0026
2147 : f800 2155      : JMP  .2155
2149 : 0041           : SLA   1 A
214a : 1000           : SJM
214b : 0000           : SRA   0 A
214c : 0000           : SRA   0 A
214d : f800 2159      : JMP  .2159
214f : f800 215d      : JMP  .215d
2151 : f800 217e      : JMP  .217e
2153 : f800 219b      : JMP  .219b
2155 : 81b4           : LDA   01b4
2156 : 905b           : ADD   005b
2157 : f800 2149      : JMP  .2149
2159 : 805a           : LDA   005a
215a : 41b9           : STO   01b9
215b : f800 219d      : JMP  .219d
215d : 8800 03c8      : LDA  .03c8
215f : 41bd           : STO   01bd
2160 : 8000 01bc      : LDA  ,01bc
2162 : 4001           : STO   0001
2163 : 2800 2305      : CAL  .2305
2165 : 4800 03c8      : STO  .03c8
2167 : 41bc           : STO   01bc
2168 : 8000 03fd      : LDA  ,03fd
216a : 407a           : STO   007a
216b : 0c06           : EXT  ,0406
216c : 01BC           : DATA
216d : 007A           : DATA
216e : 0078           : DATA
216f : 8079           : LDA   0079
2170 : 905b           : ADD   005b
2171 : 41ba           : STO   01ba
2172 : b000 0011      : CMP  ,0011
2174 : 0181 217a      : JBC   1 CR 217a
2176 : 8075           : LDA   0075
2177 : 41b9           : STO   01b9
2178 : f800 219d      : JMP  .219d
217a : 805a           : LDA   005a
217b : 41b9           : STO   01b9
217c : f800 219d      : JMP  .219d
217e : 8800 03c8      : LDA  .03c8
2180 : 41bd           : STO   01bd
2181 : 8000 01bc      : LDA  ,01bc
2183 : 4001           : STO   0001
2184 : 2800 2305      : CAL  .2305
2186 : 4800 03c8      : STO  .03c8
2188 : 41bc           : STO   01bc
2189 : 0c06           : EXT  ,0406
218a : 01BC           : DATA
218b : 0071           : DATA
218c : 0078           : DATA
218d : 8079           : LDA   0079
218e : 905b           : ADD   005b
218f : 41ba           : STO   01ba
2190 : b05e           : CMP   005e
2191 : 0181 2197      : JBC   1 CR 2197
2193 : 8075           : LDA   0075
2194 : 41b9           : STO   01b9
2195 : f800 219d      : JMP  .219d
2197 : 805a           : LDA   005a
2198 : 41b9           : STO   01b9
2199 : f800 219d      : JMP  .219d
219b : 8075           : LDA   0075
219c : 41b9           : STO   01b9
219d : 81b9           : LDA   01b9
219e : 0191 21d4      : JBS   1 CR 21d4
21a0 : 81b5           : LDA   01b5
21a1 : 4026           : STO   0026
21a2 : 8826           : LDA  /0026
21a3 : 91b5           : ADD   01b5
21a4 : 4027           : STO   0027
21a5 : 8000 00e0      : LDA  ,00e0
21a7 : c827           : AND  /0027
21a8 : 41bd           : STO   01bd
21a9 : 8000 0040      : LDA  ,0040
21ab : b1bd           : CMP   01bd
21ac : 0193 21b5      : JBS   3 CR 21b5
21ae : 8000 ffe0      : LDA  ,ffe0
21b0 : c827           : AND  /0027
21b1 : 905e           : ADD   005e
21b2 : 4827           : STO  /0027
21b3 : f800 21d4      : JMP  .21d4
21b5 : 8800 03c9      : LDA  .03c9
21b7 : 41bd           : STO   01bd
21b8 : 8000 01bc      : LDA  ,01bc
21ba : 4001           : STO   0001
21bb : 2800 2305      : CAL  .2305
21bd : 4800 03c9      : STO  .03c9
21bf : 41bc           : STO   01bc
21c0 : 8000 03fd      : LDA  ,03fd
21c2 : 407a           : STO   007a
21c3 : 0c06           : EXT  ,0406
21c4 : 01BC           : DATA
21c5 : 007A           : DATA
21c6 : 0078           : DATA
21c7 : 806a           : LDA   006a
21c8 : c079           : AND   0079
21c9 : 41be           : STO   01be
21ca : 81b5           : LDA   01b5
21cb : 4026           : STO   0026
21cc : 8826           : LDA  /0026
21cd : 91b5           : ADD   01b5
21ce : 4027           : STO   0027
21cf : 8000 ffe0      : LDA  ,ffe0
21d1 : c827           : AND  /0027
21d2 : 91be           : ADD   01be
21d3 : 4827           : STO  /0027
21d4 : 81b7           : LDA   01b7
21d5 : 9063           : ADD   0063
21d6 : 4026           : STO   0026
21d7 : 8826           : LDA  /0026
21d8 : b05f           : CMP   005f
21d9 : 0191 223c      : JBS   1 CR 223c
21db : 905b           : ADD   005b
21dc : 4826           : STO  /0026
21dd : 81b7           : LDA   01b7
21de : 9062           : ADD   0062
21df : 4026           : STO   0026
21e0 : 8826           : LDA  /0026
21e1 : 91b7           : ADD   01b7
21e2 : 4027           : STO   0027
21e3 : 8075           : LDA   0075
21e4 : 4827           : STO  /0027
21e5 : 81b3           : LDA   01b3
21e6 : 0181 2207      : JBC   1 CR 2207
21e8 : 81b5           : LDA   01b5
21e9 : 4026           : STO   0026
21ea : 8826           : LDA  /0026
21eb : 91b5           : ADD   01b5
21ec : 4027           : STO   0027
21ed : 806a           : LDA   006a
21ee : c827           : AND  /0027
21ef : 41bd           : STO   01bd
21f0 : 81b2           : LDA   01b2
21f1 : 4028           : STO   0028
21f2 : 8000 ffe0      : LDA  ,ffe0
21f4 : c828           : AND  /0028
21f5 : 91bd           : ADD   01bd
21f6 : 4828           : STO  /0028
21f7 : 81b5           : LDA   01b5
21f8 : 4026           : STO   0026
21f9 : 8826           : LDA  /0026
21fa : 91b5           : ADD   01b5
21fb : 4027           : STO   0027
21fc : 806d           : LDA   006d
21fd : c827           : AND  /0027
21fe : 0191 223c      : JBS   1 CR 223c
2200 : 81b2           : LDA   01b2
2201 : 4028           : STO   0028
2202 : 8828           : LDA  /0028
2203 : 00e5           : SET   5 A
2204 : 4828           : STO  /0028
2205 : f800 223c      : JMP  .223c
2207 : 81b5           : LDA   01b5
2208 : 4026           : STO   0026
2209 : 8826           : LDA  /0026
220a : 91b5           : ADD   01b5
220b : 4027           : STO   0027
220c : 8827           : LDA  /0027
220d : 0068           : SLL   8 A
220e : c000 1f00      : AND  ,1f00
2210 : 41be           : STO   01be
2211 : 81b2           : LDA   01b2
2212 : 4028           : STO   0028
2213 : 8000 e0ff      : LDA  ,e0ff
2215 : c828           : AND  /0028
2216 : 91be           : ADD   01be
2217 : 4828           : STO  /0028
2218 : 81b5           : LDA   01b5
2219 : 4026           : STO   0026
221a : 8826           : LDA  /0026
221b : 91b5           : ADD   01b5
221c : 4027           : STO   0027
221d : 806d           : LDA   006d
221e : c827           : AND  /0027
221f : 0191 223c      : JBS   1 CR 223c
2221 : 81b2           : LDA   01b2
2222 : 4028           : STO   0028
2223 : 8828           : LDA  /0028
2224 : 00ed           : SET   d A
2225 : 4828           : STO  /0028
2226 : f800 223c      : JMP  .223c
2228 : 81b1           : LDA   01b1
2229 : 4026           : STO   0026
222a : 805a           : LDA   005a
222b : 4826           : STO  /0026
222c : 81bb           : LDA   01bb
222d : b05b           : CMP   005b
222e : 0191 2233      : JBS   1 CR 2233
2230 : b05e           : CMP   005e
2231 : 0181 223c      : JBC   1 CR 223c
2233 : 8110           : LDA   0110
2234 : 0191 223a      : JBS   1 CR 223a
2236 : 8075           : LDA   0075
2237 : 4111           : STO   0111
2238 : f800 223c      : JMP  .223c
223a : 805a           : LDA   005a
223b : 4111           : STO   0111
223c : 81b5           : LDA   01b5
223d : 4026           : STO   0026
223e : 4027           : STO   0027
223f : 805b           : LDA   005b
2240 : 5826           : ADS  /0026
2241 : 81b7           : LDA   01b7
2242 : 9062           : ADD   0062
2243 : 4026           : STO   0026
2244 : 4027           : STO   0027
2245 : 805b           : LDA   005b
2246 : 5827           : ADS  /0027
2247 : 81b7           : LDA   01b7
2248 : 9062           : ADD   0062
2249 : 4026           : STO   0026
224a : 4027           : STO   0027
224b : 8061           : LDA   0061
224c : c826           : AND  /0026
224d : 4827           : STO  /0027
224e : 3800           : RTC
224f : 805a           : LDA   005a
2250 : 41b0           : STO   01b0
2251 : 8000 0778      : LDA  ,0778
2253 : 41c0           : STO   01c0
2254 : 8000 01b0      : LDA  ,01b0
2256 : 41c1           : STO   01c1
2257 : 805a           : LDA   005a
2258 : 41c2           : STO   01c2
2259 : 8800 0776      : LDA  .0776
225b : 41c3           : STO   01c3
225c : 8000 076c      : LDA  ,076c
225e : 41c4           : STO   01c4
225f : 805f           : LDA   005f
2260 : 41c5           : STO   01c5
2261 : 8000 0758      : LDA  ,0758
2263 : 41c6           : STO   01c6
2264 : 8064           : LDA   0064
2265 : 41c7           : STO   01c7
2266 : 8000 01bf      : LDA  ,01bf
2268 : 4001           : STO   0001
2269 : 2800 20d4      : CAL  .20d4
226b : 8082           : LDA   0082
226c : 0191 2288      : JBS   1 CR 2288
226e : 8000 0779      : LDA  ,0779
2270 : 41c0           : STO   01c0
2271 : 8000 01b0      : LDA  ,01b0
2273 : 41c1           : STO   01c1
2274 : 805b           : LDA   005b
2275 : 41c2           : STO   01c2
2276 : 8800 0777      : LDA  .0777
2278 : 41c3           : STO   01c3
2279 : 8000 0771      : LDA  ,0771
227b : 41c4           : STO   01c4
227c : 805f           : LDA   005f
227d : 41c5           : STO   01c5
227e : 8000 0762      : LDA  ,0762
2280 : 41c6           : STO   01c6
2281 : 8064           : LDA   0064
2282 : 41c7           : STO   01c7
2283 : 8000 01bf      : LDA  ,01bf
2285 : 4001           : STO   0001
2286 : 2800 20d4      : CAL  .20d4
2288 : 81b0           : LDA   01b0
2289 : 4800 7fc0      : STO  .7fc0
228b : 3800           : RTC
228c : 3000           : RTN
228d : f800 2304      : JMP  .2304
228f : 4903           : STO  /0003+
2290 : 8001           : LDA   0001
2291 : 4903           : STO  /0003+
2292 : 8800 7fc1      : LDA  .7fc1
2294 : 4800 01c8      : STO  .01c8
2296 : 009f 22d5      : JBS   f A 22d5
2298 : 039e 01c8 22dd : JBS   e 01c8 22dd
229b : 0397 01c8 22e8 : JBS   7 01c8 22e8
229e : 0396 01c8 22f0 : JBS   6 01c8 22f0
22a1 : 039d 01c8 22a7 : JBS   d 01c8 22a7
22a4 : 0385 01c8 22ff : JBC   5 01c8 22ff
22a7 : 8800 01c8      : LDA  .01c8
22a9 : 03a0 002f 22b1 : JCS   0 002f 22b1
22ac : 402e           : STO   002e
22ad : 03e1 002f      : SET   1 002f
22af : f800 22ff      : JMP  .22ff
22b1 : 03e0 002f      : SET   0 002f
22b3 : 4800 03c7      : STO  .03c7
22b5 : c000 2020      : AND  ,2020
22b7 : d000 2020      : NEQ  ,2020
22b9 : 0181 22c9      : JBC   1 CR 22c9
22bb : 8000 003f      : LDA  ,003f
22bd : c800 03c7      : AND  .03c7
22bf : 402e           : STO   002e
22c0 : 8000 3f00      : LDA  ,3f00
22c2 : c800 03c7      : AND  .03c7
22c4 : 4800 03c7      : STO  .03c7
22c6 : 8000 0003      : LDA  ,0003
22c8 : 402f           : STO   002f
22c9 : 01f0           : CLR   0 CR
22ca : 2800 1a7d      : CAL  .1a7d
22cc : 01e0           : SET   0 CR
22cd : 802e           : LDA   002e
22ce : 4800 03c7      : STO  .03c7
22d0 : 03b1 002f 22c9 : JSC   1 002f 22c9
22d3 : f800 22fb      : JMP  .22fb
22d5 : 8000 0001      : LDA  ,0001
22d7 : 5800 0348      : ADS  .0348
22d9 : 03fd 01c8      : CLR   d 01c8
22db : f800 229b      : JMP  .229b
22dd : 038d 01c8 229b : JBC   d 01c8 229b
22e0 : 03fd 01c8      : CLR   d 01c8
22e2 : 8000 0001      : LDA  ,0001
22e4 : 5800 0347      : ADS  .0347
22e6 : f800 229b      : JMP  .229b
22e8 : 8000 0001      : LDA  ,0001
22ea : 5800 0346      : ADS  .0346
22ec : 03f5 01c8      : CLR   5 01c8
22ee : f800 22a1      : JMP  .22a1
22f0 : 0385 01c8 22a1 : JBC   5 01c8 22a1
22f3 : 03f5 01c8      : CLR   5 01c8
22f5 : 8000 0001      : LDA  ,0001
22f7 : 5800 0345      : ADS  .0345
22f9 : f800 22a1      : JMP  .22a1
22fb : 8000 0000      : LDA  ,0000
22fd : 402f           : STO   002f
22fe : 01f0           : CLR   0 CR
22ff : 8b03           : LDA  /0003-
2300 : 4001           : STO   0001
2301 : 8b03           : LDA  /0003-
2302 : 3000           : RTN
2303 : 3800           : RTC
2304 : 3000           : RTN
2305 : 8901           : LDA  /0001+
2306 : 4118           : STO   0118
2307 : 8000 01fe      : LDA  ,01fe
2309 : 411d           : STO   011d
230a : 0c03           : EXT  ,0403
230b : 011D           : DATA
230c : 0118           : DATA
230d : 0119           : DATA
230e : 01f5           : CLR   5 CR
230f : 8000 3aa9      : LDA  ,3aa9
2311 : 511a           : ADS   011a
2312 : 01e5           : SET   5 CR
2313 : 8000 0000      : LDA  ,0000
2315 : 5119           : ADS   0119
2316 : 8000 7fed      : LDA  ,7fed
2318 : 411d           : STO   011d
2319 : 0c07           : EXT  ,0407
231a : 0119           : DATA
231b : 011D           : DATA
231c : 011B           : DATA
231d : 811b           : LDA   011b
231e : 3000           : RTN
231f : f800 23e6      : JMP  .23e6
2321 : 8081           : LDA   0081
2322 : 41cb           : STO   01cb
2323 : b05b           : CMP   005b
2324 : 0191 2329      : JBS   1 CR 2329
2326 : b05e           : CMP   005e
2327 : 0181 23e5      : JBC   1 CR 23e5
2329 : 8117           : LDA   0117
232a : 0191 23d6      : JBS   1 CR 23d6
232c : c06d           : AND   006d
232d : 0024           : SRL   4 A
232e : 41c9           : STO   01c9
232f : 81cb           : LDA   01cb
2330 : b1c9           : CMP   01c9
2331 : 0183 2351      : JBC   3 CR 2351
2333 : 81c9           : LDA   01c9
2334 : 9000 1972      : ADD  ,1972
2336 : 4026           : STO   0026
2337 : 8826           : LDA  /0026
2338 : 91cb           : ADD   01cb
2339 : a1c9           : SUB   01c9
233a : a05a           : SUB   005a
233b : a05b           : SUB   005b
233c : a05a           : SUB   005a
233d : 9000 02f5      : ADD  ,02f5
233f : 4027           : STO   0027
2340 : 8827           : LDA  /0027
2341 : 0066           : SLL   6 A
2342 : 41d3           : STO   01d3
2343 : 806b           : LDA   006b
2344 : c1cd           : AND   01cd
2345 : 91d3           : ADD   01d3
2346 : 41cd           : STO   01cd
2347 : 009f 234d      : JBS   f A 234d
2349 : 03ef 01cd      : SET   f 01cd
234b : f800 2365      : JMP  .2365
234d : 03ff 01cd      : CLR   f 01cd
234f : f800 2365      : JMP  .2365
2351 : 81cb           : LDA   01cb
2352 : 9000 1972      : ADD  ,1972
2354 : 4026           : STO   0026
2355 : 8826           : LDA  /0026
2356 : 91c9           : ADD   01c9
2357 : a1cb           : SUB   01cb
2358 : a05a           : SUB   005a
2359 : a05b           : SUB   005b
235a : a05a           : SUB   005a
235b : 9000 02f5      : ADD  ,02f5
235d : 4027           : STO   0027
235e : 8827           : LDA  /0027
235f : 0066           : SLL   6 A
2360 : 41d3           : STO   01d3
2361 : 806b           : LDA   006b
2362 : c1cd           : AND   01cd
2363 : 91d3           : ADD   01d3
2364 : 41cd           : STO   01cd
2365 : 0c02           : EXT  ,0402
2366 : 01CB           : DATA
2367 : 005D           : DATA
2368 : 01D2           : DATA
2369 : 81d2           : LDA   01d2
236a : 9000 0087      : ADD  ,0087
236c : 4026           : STO   0026
236d : 8826           : LDA  /0026
236e : 0066           : SLL   6 A
236f : 41d3           : STO   01d3
2370 : 806b           : LDA   006b
2371 : c1ce           : AND   01ce
2372 : 91d3           : ADD   01d3
2373 : 41ce           : STO   01ce
2374 : 0c02           : EXT  ,0402
2375 : 01C9           : DATA
2376 : 005D           : DATA
2377 : 01D2           : DATA
2378 : 81d2           : LDA   01d2
2379 : 9000 0087      : ADD  ,0087
237b : 4026           : STO   0026
237c : 8826           : LDA  /0026
237d : 0066           : SLL   6 A
237e : 41d3           : STO   01d3
237f : 806b           : LDA   006b
2380 : c1cc           : AND   01cc
2381 : 91d3           : ADD   01d3
2382 : 41cc           : STO   01cc
2383 : a1cd           : SUB   01cd
2384 : a05a           : SUB   005a
2385 : 41d0           : STO   01d0
2386 : 81cd           : LDA   01cd
2387 : a1ce           : SUB   01ce
2388 : 41d1           : STO   01d1
2389 : 0c02           : EXT  ,0402
238a : 01CB           : DATA
238b : 005D           : DATA
238c : 01D2           : DATA
238d : 8000 01d0      : LDA  ,01d0
238f : 4001           : STO   0001
2390 : 2800 2779      : CAL  .2779
2392 : 41d3           : STO   01d3
2393 : 81d2           : LDA   01d2
2394 : 9000 0086      : ADD  ,0086
2396 : 4026           : STO   0026
2397 : 0c08           : EXT  ,0408
2398 : 0026           : DATA
2399 : 01D3           : DATA
239a : 01D2           : DATA
239b : 0c02           : EXT  ,0402
239c : 01C9           : DATA
239d : 005D           : DATA
239e : 01D3           : DATA
239f : 8000 01cf      : LDA  ,01cf
23a1 : 4001           : STO   0001
23a2 : 2800 2779      : CAL  .2779
23a4 : 41d4           : STO   01d4
23a5 : 81d3           : LDA   01d3
23a6 : 9000 0086      : ADD  ,0086
23a8 : 4026           : STO   0026
23a9 : 0c08           : EXT  ,0408
23aa : 0026           : DATA
23ab : 01D4           : DATA
23ac : 01D3           : DATA
23ad : 81d3           : LDA   01d3
23ae : a1d2           : SUB   01d2
23af : 41cf           : STO   01cf
23b0 : 8000 47ae      : LDA  ,47ae
23b2 : 4078           : STO   0078
23b3 : 0c00           : EXT  ,0400
23b4 : 01CF           : DATA
23b5 : 0078           : DATA
23b6 : 01D2           : DATA
23b7 : 0302 01d2      : SRA   2 01d2
23b9 : 81d2           : LDA   01d2
23ba : 9000 0ecc      : ADD  ,0ecc
23bc : 41cf           : STO   01cf
23bd : 8069           : LDA   0069
23be : c117           : AND   0117
23bf : b05b           : CMP   005b
23c0 : 0183 23c5      : JBC   3 CR 23c5
23c2 : 8000 0400      : LDA  ,0400
23c4 : 51cf           : ADS   01cf
23c5 : 81cf           : LDA   01cf
23c6 : b000 1c00      : CMP  ,1c00
23c8 : 0183 23cf      : JBC   3 CR 23cf
23ca : 8000 1c00      : LDA  ,1c00
23cc : 41cf           : STO   01cf
23cd : f800 23d9      : JMP  .23d9
23cf : 038f 01cf 23d9 : JBC   f 01cf 23d9
23d2 : 805a           : LDA   005a
23d3 : 41cf           : STO   01cf
23d4 : f800 23d9      : JMP  .23d9
23d6 : 8000 0e00      : LDA  ,0e00
23d8 : 41cf           : STO   01cf
23d9 : 81cf           : LDA   01cf
23da : 0023           : SRL   3 A
23db : c000 03c0      : AND  ,03c0
23dd : 41d3           : STO   01d3
23de : 8000 fc3f      : LDA  ,fc3f
23e0 : c800 077a      : AND  .077a
23e2 : 91d3           : ADD   01d3
23e3 : 4800 077a      : STO  .077a
23e5 : 3800           : RTC
23e6 : 3000           : RTN
23e7 : f800 26ef      : JMP  .26ef
23e9 : 8081           : LDA   0081
23ea : 41d6           : STO   01d6
23eb : 8082           : LDA   0082
23ec : 41d8           : STO   01d8
23ed : 81d6           : LDA   01d6
23ee : 9000 0105      : ADD  ,0105
23f0 : 4026           : STO   0026
23f1 : 8800 7fe4      : LDA  .7fe4
23f3 : d075           : NEQ   0075
23f4 : 4826           : STO  /0026
23f5 : 8800 7fe0      : LDA  .7fe0
23f7 : d075           : NEQ   0075
23f8 : 40cb           : STO   00cb
23f9 : 8073           : LDA   0073
23fa : c800 077b      : AND  .077b
23fc : 0028           : SRL   8 A
23fd : 41d5           : STO   01d5
23fe : 806f           : LDA   006f
23ff : c800 077a      : AND  .077a
2401 : 0026           : SRL   6 A
2402 : 41d7           : STO   01d7
2403 : 805a           : LDA   005a
2404 : 4800 077a      : STO  .077a
2406 : 4800 077b      : STO  .077b
2408 : 81d7           : LDA   01d7
2409 : 0066           : SLL   6 A
240a : c000 03c0      : AND  ,03c0
240c : 41dc           : STO   01dc
240d : 8000 fc3f      : LDA  ,fc3f
240f : c800 077a      : AND  .077a
2411 : 91dc           : ADD   01dc
2412 : 4800 077a      : STO  .077a
2414 : 81d5           : LDA   01d5
2415 : 0068           : SLL   8 A
2416 : c000 3f00      : AND  ,3f00
2418 : 41dc           : STO   01dc
2419 : 8000 c0ff      : LDA  ,c0ff
241b : c800 077b      : AND  .077b
241d : 91dc           : ADD   01dc
241e : 4800 077b      : STO  .077b
2420 : 81d8           : LDA   01d8
2421 : 0191 2598      : JBS   1 CR 2598
2423 : 9000 0105      : ADD  ,0105
2425 : 4027           : STO   0027
2426 : 80cb           : LDA   00cb
2427 : 0024           : SRL   4 A
2428 : c05b           : AND   005b
2429 : 407e           : STO   007e
242a : 8827           : LDA  /0027
242b : 00fe           : CLR   e A
242c : 4827           : STO  /0027
242d : 807e           : LDA   007e
242e : 004e           : SLA   e A
242f : 5827           : ADS  /0027
2430 : 81d8           : LDA   01d8
2431 : 9000 0105      : ADD  ,0105
2433 : 4028           : STO   0028
2434 : 80cb           : LDA   00cb
2435 : 0025           : SRL   5 A
2436 : c05b           : AND   005b
2437 : 407e           : STO   007e
2438 : 8828           : LDA  /0028
2439 : 00fa           : CLR   a A
243a : 4828           : STO  /0028
243b : 807e           : LDA   007e
243c : 004a           : SLA   a A
243d : 5828           : ADS  /0028
243e : 81d8           : LDA   01d8
243f : 9000 0105      : ADD  ,0105
2441 : 4029           : STO   0029
2442 : 80cb           : LDA   00cb
2443 : 0026           : SRL   6 A
2444 : c05b           : AND   005b
2445 : 407e           : STO   007e
2446 : 8829           : LDA  /0029
2447 : 00fc           : CLR   c A
2448 : 4829           : STO  /0029
2449 : 807e           : LDA   007e
244a : 004c           : SLA   c A
244b : 5829           : ADS  /0029
244c : 81d8           : LDA   01d8
244d : 9000 0105      : ADD  ,0105
244f : 402a           : STO   002a
2450 : 80cb           : LDA   00cb
2451 : 0027           : SRL   7 A
2452 : c05b           : AND   005b
2453 : 407e           : STO   007e
2454 : 882a           : LDA  /002a
2455 : 00ff           : CLR   f A
2456 : 482a           : STO  /002a
2457 : 807e           : LDA   007e
2458 : 004f           : SLA   f A
2459 : 582a           : ADS  /002a
245a : 8000 0060      : LDA  ,0060
245c : c0cb           : AND   00cb
245d : 0181 2466      : JBC   1 CR 2466
245f : 81d8           : LDA   01d8
2460 : 9000 0105      : ADD  ,0105
2462 : 402b           : STO   002b
2463 : 882b           : LDA  /002b
2464 : 00e9           : SET   9 A
2465 : 482b           : STO  /002b
2466 : 8000 ff0f      : LDA  ,ff0f
2468 : c0cb           : AND   00cb
2469 : 40cb           : STO   00cb
246a : 805f           : LDA   005f
246b : 61d8           : SBS   01d8
246c : 0c02           : EXT  ,0402
246d : 01D8           : DATA
246e : 005D           : DATA
246f : 01DB           : DATA
2470 : 81db           : LDA   01db
2471 : 9000 00e1      : ADD  ,00e1
2473 : 4026           : STO   0026
2474 : 8826           : LDA  /0026
2475 : 002c           : SRL   c A
2476 : b05a           : CMP   005a
2477 : 0183 2546      : JBC   3 CR 2546
2479 : 0c02           : EXT  ,0402
247a : 01D8           : DATA
247b : 005D           : DATA
247c : 01DC           : DATA
247d : 81dc           : LDA   01dc
247e : 9000 00e1      : ADD  ,00e1
2480 : 4026           : STO   0026
2481 : 8000 f000      : LDA  ,f000
2483 : c826           : AND  /0026
2484 : b000 2000      : CMP  ,2000
2486 : 0181 24dd      : JBC   1 CR 24dd
2488 : 0c02           : EXT  ,0402
2489 : 01D8           : DATA
248a : 005D           : DATA
248b : 01DD           : DATA
248c : 0c02           : EXT  ,0402
248d : 01D8           : DATA
248e : 005D           : DATA
248f : 01DE           : DATA
2490 : 81de           : LDA   01de
2491 : 9000 00e1      : ADD  ,00e1
2493 : 4026           : STO   0026
2494 : 8826           : LDA  /0026
2495 : 002c           : SRL   c A
2496 : a05b           : SUB   005b
2497 : a05a           : SUB   005a
2498 : 006c           : SLL   c A
2499 : 41e0           : STO   01e0
249a : 81dd           : LDA   01dd
249b : 9000 00e1      : ADD  ,00e1
249d : 4026           : STO   0026
249e : 8071           : LDA   0071
249f : c826           : AND  /0026
24a0 : 91e0           : ADD   01e0
24a1 : 4826           : STO  /0026
24a2 : 0c02           : EXT  ,0402
24a3 : 01D8           : DATA
24a4 : 005D           : DATA
24a5 : 01DB           : DATA
24a6 : 81db           : LDA   01db
24a7 : 9000 00e3      : ADD  ,00e3
24a9 : 4026           : STO   0026
24aa : 8826           : LDA  /0026
24ab : 0086 24c5      : JBC   6 A 24c5
24ad : 0c02           : EXT  ,0402
24ae : 01D8           : DATA
24af : 005D           : DATA
24b0 : 01DB           : DATA
24b1 : 81db           : LDA   01db
24b2 : 9000 00e3      : ADD  ,00e3
24b4 : 4026           : STO   0026
24b5 : 8826           : LDA  /0026
24b6 : 0068           : SLL   8 A
24b7 : c000 3f00      : AND  ,3f00
24b9 : 41dd           : STO   01dd
24ba : 8000 c0ff      : LDA  ,c0ff
24bc : c800 077b      : AND  .077b
24be : 91dd           : ADD   01dd
24bf : 4800 077b      : STO  .077b
24c1 : 03ee 077b      : SET   e 077b
24c3 : f800 2598      : JMP  .2598
24c5 : 0c02           : EXT  ,0402
24c6 : 01D8           : DATA
24c7 : 005D           : DATA
24c8 : 01DB           : DATA
24c9 : 81db           : LDA   01db
24ca : 9000 00e3      : ADD  ,00e3
24cc : 4026           : STO   0026
24cd : 8826           : LDA  /0026
24ce : 0061           : SLL   1 A
24cf : c000 3f00      : AND  ,3f00
24d1 : 41dd           : STO   01dd
24d2 : 8000 c0ff      : LDA  ,c0ff
24d4 : c800 077b      : AND  .077b
24d6 : 91dd           : ADD   01dd
24d7 : 4800 077b      : STO  .077b
24d9 : 03ef 077b      : SET   f 077b
24db : f800 2598      : JMP  .2598
24dd : 0c02           : EXT  ,0402
24de : 01D8           : DATA
24df : 005D           : DATA
24e0 : 01DB           : DATA
24e1 : 81db           : LDA   01db
24e2 : 9000 00e1      : ADD  ,00e1
24e4 : 4026           : STO   0026
24e5 : 8000 f000      : LDA  ,f000
24e7 : c826           : AND  /0026
24e8 : b000 1000      : CMP  ,1000
24ea : 0181 252a      : JBC   1 CR 252a
24ec : 0c02           : EXT  ,0402
24ed : 01D8           : DATA
24ee : 005D           : DATA
24ef : 01DC           : DATA
24f0 : 81dc           : LDA   01dc
24f1 : 9000 00e1      : ADD  ,00e1
24f3 : 4026           : STO   0026
24f4 : 4027           : STO   0027
24f5 : 8071           : LDA   0071
24f6 : c826           : AND  /0026
24f7 : 4827           : STO  /0027
24f8 : 0c02           : EXT  ,0402
24f9 : 01D8           : DATA
24fa : 005D           : DATA
24fb : 01DB           : DATA
24fc : 81db           : LDA   01db
24fd : 9000 00e3      : ADD  ,00e3
24ff : 4027           : STO   0027
2500 : 8827           : LDA  /0027
2501 : 0086 2513      : JBC   6 A 2513
2503 : 0c02           : EXT  ,0402
2504 : 01D8           : DATA
2505 : 005D           : DATA
2506 : 01DB           : DATA
2507 : 81db           : LDA   01db
2508 : 9000 00e1      : ADD  ,00e1
250a : 4027           : STO   0027
250b : 8000 f003      : LDA  ,f003
250d : c827           : AND  /0027
250e : 9000 0b80      : ADD  ,0b80
2510 : 4827           : STO  /0027
2511 : f800 2521      : JMP  .2521
2513 : 0c02           : EXT  ,0402
2514 : 01D8           : DATA
2515 : 005D           : DATA
2516 : 01DC           : DATA
2517 : 81dc           : LDA   01dc
2518 : 9000 00e1      : ADD  ,00e1
251a : 4026           : STO   0026
251b : 8000 f003      : LDA  ,f003
251d : c826           : AND  /0026
251e : 9000 0680      : ADD  ,0680
2520 : 4826           : STO  /0026
2521 : 81d8           : LDA   01d8
2522 : 9000 010a      : ADD  ,010a
2524 : 4026           : STO   0026
2525 : 8826           : LDA  /0026
2526 : 00eb           : SET   b A
2527 : 4826           : STO  /0026
2528 : f800 2598      : JMP  .2598
252a : 0c02           : EXT  ,0402
252b : 01D8           : DATA
252c : 005D           : DATA
252d : 01DB           : DATA
252e : 0c02           : EXT  ,0402
252f : 01D8           : DATA
2530 : 005D           : DATA
2531 : 01DC           : DATA
2532 : 81dc           : LDA   01dc
2533 : 9000 00e1      : ADD  ,00e1
2535 : 4026           : STO   0026
2536 : 8826           : LDA  /0026
2537 : 002c           : SRL   c A
2538 : a05b           : SUB   005b
2539 : a05a           : SUB   005a
253a : 006c           : SLL   c A
253b : 41de           : STO   01de
253c : 81db           : LDA   01db
253d : 9000 00e1      : ADD  ,00e1
253f : 4026           : STO   0026
2540 : 8071           : LDA   0071
2541 : c826           : AND  /0026
2542 : 91de           : ADD   01de
2543 : 4826           : STO  /0026
2544 : f800 2598      : JMP  .2598
2546 : 0c02           : EXT  ,0402
2547 : 01D8           : DATA
2548 : 005D           : DATA
2549 : 01DB           : DATA
254a : 81db           : LDA   01db
254b : 9000 00e1      : ADD  ,00e1
254d : 4026           : STO   0026
254e : 8000 0ffc      : LDA  ,0ffc
2550 : c826           : AND  /0026
2551 : b05a           : CMP   005a
2552 : 0183 257b      : JBC   3 CR 257b
2554 : 0c02           : EXT  ,0402
2555 : 01D8           : DATA
2556 : 005D           : DATA
2557 : 01DC           : DATA
2558 : 0c02           : EXT  ,0402
2559 : 01D8           : DATA
255a : 005D           : DATA
255b : 01DD           : DATA
255c : 81dd           : LDA   01dd
255d : 9000 00e1      : ADD  ,00e1
255f : 4026           : STO   0026
2560 : 8071           : LDA   0071
2561 : c826           : AND  /0026
2562 : 0022           : SRL   2 A
2563 : a05b           : SUB   005b
2564 : a05a           : SUB   005a
2565 : 0062           : SLL   2 A
2566 : c000 0ffc      : AND  ,0ffc
2568 : 41e1           : STO   01e1
2569 : 81dc           : LDA   01dc
256a : 9000 00e1      : ADD  ,00e1
256c : 4026           : STO   0026
256d : 8000 f003      : LDA  ,f003
256f : c826           : AND  /0026
2570 : 91e1           : ADD   01e1
2571 : 4826           : STO  /0026
2572 : 81d8           : LDA   01d8
2573 : 9000 010a      : ADD  ,010a
2575 : 4026           : STO   0026
2576 : 8826           : LDA  /0026
2577 : 00eb           : SET   b A
2578 : 4826           : STO  /0026
2579 : f800 2598      : JMP  .2598
257b : 81d8           : LDA   01d8
257c : 9000 010a      : ADD  ,010a
257e : 4026           : STO   0026
257f : 8826           : LDA  /0026
2580 : 00fb           : CLR   b A
2581 : 4826           : STO  /0026
2582 : 0c02           : EXT  ,0402
2583 : 01D8           : DATA
2584 : 005D           : DATA
2585 : 01DB           : DATA
2586 : 81db           : LDA   01db
2587 : 9000 00e3      : ADD  ,00e3
2589 : 4027           : STO   0027
258a : 8827           : LDA  /0027
258b : 00f6           : CLR   6 A
258c : 4827           : STO  /0027
258d : 0c02           : EXT  ,0402
258e : 01D8           : DATA
258f : 005D           : DATA
2590 : 01DB           : DATA
2591 : 81db           : LDA   01db
2592 : 9000 00e3      : ADD  ,00e3
2594 : 4027           : STO   0027
2595 : 8827           : LDA  /0027
2596 : 00fd           : CLR   d A
2597 : 4827           : STO  /0027
2598 : 8081           : LDA   0081
2599 : b05b           : CMP   005b
259a : 0191 25a2      : JBS   1 CR 25a2
259c : b05c           : CMP   005c
259d : 0191 25a2      : JBS   1 CR 25a2
259f : b05e           : CMP   005e
25a0 : 0181 25ab      : JBC   1 CR 25ab
25a2 : 8800 7fa2      : LDA  .7fa2
25a4 : 0026           : SRL   6 A
25a5 : 41db           : STO   01db
25a6 : 8000 fc00      : LDA  ,fc00
25a8 : c0cc           : AND   00cc
25a9 : 91db           : ADD   01db
25aa : 40cc           : STO   00cc
25ab : 806f           : LDA   006f
25ac : c0cc           : AND   00cc
25ad : 41db           : STO   01db
25ae : 81d6           : LDA   01d6
25af : 9000 03bd      : ADD  ,03bd
25b1 : 4026           : STO   0026
25b2 : 8000 fc00      : LDA  ,fc00
25b4 : c826           : AND  /0026
25b5 : 91db           : ADD   01db
25b6 : 4826           : STO  /0026
25b7 : 81d6           : LDA   01d6
25b8 : 9000 0105      : ADD  ,0105
25ba : 4027           : STO   0027
25bb : 8061           : LDA   0061
25bc : c827           : AND  /0027
25bd : b060           : CMP   0060
25be : 0181 25d0      : JBC   1 CR 25d0
25c0 : 8000 0038      : LDA  ,0038
25c2 : c827           : AND  /0027
25c3 : 0191 25d0      : JBS   1 CR 25d0
25c5 : 8827           : LDA  /0027
25c6 : 008f 25d0      : JBC   f A 25d0
25c8 : c000 fff8      : AND  ,fff8
25ca : 905f           : ADD   005f
25cb : 4827           : STO  /0027
25cc : 03e6 077b      : SET   6 077b
25ce : f800 25d2      : JMP  .25d2
25d0 : 03e5 077b      : SET   5 077b
25d2 : 0396 077b 25dc : JBS   6 077b 25dc
25d5 : 8081           : LDA   0081
25d6 : 9000 00c1      : ADD  ,00c1
25d8 : 4026           : STO   0026
25d9 : 8826           : LDA  /0026
25da : 0084 25de      : JBC   4 A 25de
25dc : 03e4 077b      : SET   4 077b
25de : 03e7 077b      : SET   7 077b
25e0 : 81d6           : LDA   01d6
25e1 : 0191 25e6      : JBS   1 CR 25e6
25e3 : b05d           : CMP   005d
25e4 : 0181 25ef      : JBC   1 CR 25ef
25e6 : 81d6           : LDA   01d6
25e7 : 9000 0105      : ADD  ,0105
25e9 : 4026           : STO   0026
25ea : 8826           : LDA  /0026
25eb : 0087 25ef      : JBC   7 A 25ef
25ed : 03f7 077b      : CLR   7 077b
25ef : 80cb           : LDA   00cb
25f0 : 0021           : SRL   1 A
25f1 : c05b           : AND   005b
25f2 : 03f4 077a      : CLR   4 077a
25f4 : 0044           : SLA   4 A
25f5 : 5800 077a      : ADS  .077a
25f7 : 80cb           : LDA   00cb
25f8 : c05b           : AND   005b
25f9 : 03fa 077a      : CLR   a 077a
25fb : 004a           : SLA   a A
25fc : 5800 077a      : ADS  .077a
25fe : 806f           : LDA   006f
25ff : c0cc           : AND   00cc
2600 : 41db           : STO   01db
2601 : 8000 fc00      : LDA  ,fc00
2603 : c800 077c      : AND  .077c
2605 : 91db           : ADD   01db
2606 : 4800 077c      : STO  .077c
2608 : 0c02           : EXT  ,0402
2609 : 01D6           : DATA
260a : 005D           : DATA
260b : 01DB           : DATA
260c : 81db           : LDA   01db
260d : 9000 0087      : ADD  ,0087
260f : 4026           : STO   0026
2610 : 8826           : LDA  /0026
2611 : 0066           : SLL   6 A
2612 : 0006           : SRA   6 A
2613 : 41dd           : STO   01dd
2614 : 8800 077c      : LDA  .077c
2616 : 0066           : SLL   6 A
2617 : 0006           : SRA   6 A
2618 : a1dd           : SUB   01dd
2619 : a05a           : SUB   005a
261a : c06f           : AND   006f
261b : 41de           : STO   01de
261c : 8000 fc00      : LDA  ,fc00
261e : c800 077d      : AND  .077d
2620 : 91de           : ADD   01de
2621 : 4800 077d      : STO  .077d
2623 : 0046           : SLA   6 A
2624 : 008f 2634      : JBC   f A 2634
2626 : 8800 077d      : LDA  .077d
2628 : 0066           : SLL   6 A
2629 : 0006           : SRA   6 A
262a : a05a           : SUB   005a
262b : c06f           : AND   006f
262c : 41dd           : STO   01dd
262d : 8000 fc00      : LDA  ,fc00
262f : c800 077d      : AND  .077d
2631 : 91dd           : ADD   01dd
2632 : 4800 077d      : STO  .077d
2634 : 8800 077d      : LDA  .077d
2636 : 0046           : SLA   6 A
2637 : b000 0180      : CMP  ,0180
2639 : 0193 263d      : JBS   3 CR 263d
263b : 03e5 077a      : SET   5 077a
263d : 81d6           : LDA   01d6
263e : 9000 0105      : ADD  ,0105
2640 : 4026           : STO   0026
2641 : 8826           : LDA  /0026
2642 : 008a 2646      : JBC   a A 2646
2644 : 03ef 077a      : SET   f 077a
2646 : 038a 00cb 264b : JBC   a 00cb 264b
2649 : 03ee 077a      : SET   e 077a
264b : 8117           : LDA   0117
264c : 0191 2665      : JBS   1 CR 2665
264e : 03eb 077a      : SET   b 077a
2650 : 8800 0776      : LDA  .0776
2652 : b05d           : CMP   005d
2653 : 0181 2667      : JBC   1 CR 2667
2655 : 81d9           : LDA   01d9
2656 : 0181 265b      : JBC   1 CR 265b
2658 : 81da           : LDA   01da
2659 : d05b           : NEQ   005b
265a : 41da           : STO   01da
265b : 81d9           : LDA   01d9
265c : d05b           : NEQ   005b
265d : 41d9           : STO   01d9
265e : 81da           : LDA   01da
265f : 0191 2667      : JBS   1 CR 2667
2661 : 03ec 077a      : SET   c 077a
2663 : f800 2667      : JMP  .2667
2665 : 805a           : LDA   005a
2666 : 41da           : STO   01da
2667 : 8111           : LDA   0111
2668 : b075           : CMP   0075
2669 : 0181 266d      : JBC   1 CR 266d
266b : 03ed 077a      : SET   d 077a
266d : 805a           : LDA   005a
266e : 41d7           : STO   01d7
266f : c000 fff0      : AND  ,fff0
2671 : 9063           : ADD   0063
2672 : 41d7           : STO   01d7
2673 : 80fa           : LDA   00fa
2674 : 006b           : SLL   b A
2675 : c000 7800      : AND  ,7800
2677 : 41dc           : STO   01dc
2678 : 8000 87ff      : LDA  ,87ff
267a : c1d7           : AND   01d7
267b : 91dc           : ADD   01dc
267c : 41d7           : STO   01d7
267d : 03ef 01d7      : SET   f 01d7
267f : 805b           : LDA   005b
2680 : a000 03ab      : SUB  ,03ab
2682 : 4800 7fcf      : STO  .7fcf
2684 : 81d7           : LDA   01d7
2685 : 4800 7fce      : STO  .7fce
2687 : 8075           : LDA   0075
2688 : 4116           : STO   0116
2689 : d800 077a      : NEQ  .077a
268b : 4800 7fe0      : STO  .7fe0
268d : 8800 077b      : LDA  .077b
268f : d075           : NEQ   0075
2690 : 4800 7fe4      : STO  .7fe4
2692 : 8800 4160      : LDA  .4160
2694 : 0041           : SLA   1 A
2695 : 41d7           : STO   01d7
2696 : 8081           : LDA   0081
2697 : 9000 0105      : ADD  ,0105
2699 : 4026           : STO   0026
269a : 8826           : LDA  /0026
269b : 008f 26bf      : JBC   f A 26bf
269d : 009b 26a1      : JBS   b A 26a1
269f : 0089 26bf      : JBC   9 A 26bf
26a1 : 8081           : LDA   0081
26a2 : 9000 0105      : ADD  ,0105
26a4 : 4026           : STO   0026
26a5 : 81d7           : LDA   01d7
26a6 : 9000 4000      : ADD  ,4000
26a8 : 4027           : STO   0027
26a9 : 8826           : LDA  /0026
26aa : 4827           : STO  /0027
26ab : 80cb           : LDA   00cb
26ac : 0029           : SRL   9 A
26ad : c05b           : AND   005b
26ae : 407e           : STO   007e
26af : 8827           : LDA  /0027
26b0 : 00fd           : CLR   d A
26b1 : 4827           : STO  /0027
26b2 : 807e           : LDA   007e
26b3 : 004d           : SLA   d A
26b4 : 5827           : ADS  /0027
26b5 : 80cb           : LDA   00cb
26b6 : 002c           : SRL   c A
26b7 : c05b           : AND   005b
26b8 : 407e           : STO   007e
26b9 : 8827           : LDA  /0027
26ba : 00fe           : CLR   e A
26bb : 4827           : STO  /0027
26bc : 807e           : LDA   007e
26bd : 004e           : SLA   e A
26be : 5827           : ADS  /0027
26bf : 8082           : LDA   0082
26c0 : 0191 26ee      : JBS   1 CR 26ee
26c2 : 9000 0105      : ADD  ,0105
26c4 : 4026           : STO   0026
26c5 : 8826           : LDA  /0026
26c6 : 008f 26ee      : JBC   f A 26ee
26c8 : 009b 26cc      : JBS   b A 26cc
26ca : 0089 26ee      : JBC   9 A 26ee
26cc : 81d7           : LDA   01d7
26cd : 905b           : ADD   005b
26ce : 9000 4000      : ADD  ,4000
26d0 : 4026           : STO   0026
26d1 : 8082           : LDA   0082
26d2 : 9000 0105      : ADD  ,0105
26d4 : 4027           : STO   0027
26d5 : 8827           : LDA  /0027
26d6 : 4826           : STO  /0026
26d7 : 81d7           : LDA   01d7
26d8 : 905b           : ADD   005b
26d9 : 9000 4000      : ADD  ,4000
26db : 4026           : STO   0026
26dc : 8826           : LDA  /0026
26dd : 00ed           : SET   d A
26de : 4826           : STO  /0026
26df : 81d7           : LDA   01d7
26e0 : 905b           : ADD   005b
26e1 : 9000 4000      : ADD  ,4000
26e3 : 4026           : STO   0026
26e4 : 8827           : LDA  /0027
26e5 : 002e           : SRL   e A
26e6 : c05b           : AND   005b
26e7 : 407e           : STO   007e
26e8 : 8826           : LDA  /0026
26e9 : 00fe           : CLR   e A
26ea : 4826           : STO  /0026
26eb : 807e           : LDA   007e
26ec : 004e           : SLA   e A
26ed : 5826           : ADS  /0026
26ee : 3800           : RTC
26ef : 3000           : RTN
26f0 : 8000 4280      : LDA  ,4280
26f2 : 00e0           : SET   0 A
26f3 : 4800 0000      : STO  .0000
26f5 : 9000 0002      : ADD  ,0002
26f7 : 407f           : STO   007f
26f8 : 8000 41b8      : LDA  ,41b8
26fa : 4003           : STO   0003
26fb : 4080           : STO   0080
26fc : 2800 2706      : CAL  .2706
26fe : 8000 2703      : LDA  ,2703
2700 : 4001           : STO   0001
2701 : 2817           : CAL  /0017
2702 : f800 26f0      : JMP  .26f0
2704 : 0000           : SRA   0 A
2705 : 0000           : SRA   0 A
2706 : 805a           : LDA   005a
2707 : 41e3           : STO   01e3
2708 : 81e3           : LDA   01e3
2709 : b063           : CMP   0063
270a : 0193 271d      : JBS   3 CR 271d
270c : 9000 00f0      : ADD  ,00f0
270e : 4026           : STO   0026
270f : 8000 c060      : LDA  ,c060
2711 : 4826           : STO  /0026
2712 : 81e3           : LDA   01e3
2713 : 9000 00fb      : ADD  ,00fb
2715 : 4027           : STO   0027
2716 : 8000 0020      : LDA  ,0020
2718 : 4827           : STO  /0027
2719 : 805b           : LDA   005b
271a : 51e3           : ADS   01e3
271b : f800 2708      : JMP  .2708
271d : 805a           : LDA   005a
271e : 41e3           : STO   01e3
271f : 81e3           : LDA   01e3
2720 : b062           : CMP   0062
2721 : 0193 273d      : JBS   3 CR 273d
2723 : 0c02           : EXT  ,0402
2724 : 01E3           : DATA
2725 : 005F           : DATA
2726 : 01E4           : DATA
2727 : 81e4           : LDA   01e4
2728 : 9000 06fb      : ADD  ,06fb
272a : 4026           : STO   0026
272b : 8000 0020      : LDA  ,0020
272d : 4826           : STO  /0026
272e : 0c02           : EXT  ,0402
272f : 01E3           : DATA
2730 : 005F           : DATA
2731 : 01E4           : DATA
2732 : 81e4           : LDA   01e4
2733 : 9000 0728      : ADD  ,0728
2735 : 4026           : STO   0026
2736 : 8000 0020      : LDA  ,0020
2738 : 4826           : STO  /0026
2739 : 805b           : LDA   005b
273a : 51e3           : ADS   01e3
273b : f800 271f      : JMP  .271f
273d : 805a           : LDA   005a
273e : 41e3           : STO   01e3
273f : 81e3           : LDA   01e3
2740 : b000 0011      : CMP  ,0011
2742 : 0193 274e      : JBS   3 CR 274e
2744 : 9000 03ab      : ADD  ,03ab
2746 : 4026           : STO   0026
2747 : 8000 83ff      : LDA  ,83ff
2749 : 4826           : STO  /0026
274a : 805b           : LDA   005b
274b : 51e3           : ADS   01e3
274c : f800 273f      : JMP  .273f
274e : 8000 d095      : LDA  ,d095
2750 : 4800 7fde      : STO  .7fde
2752 : 8000 0025      : LDA  ,0025
2754 : 4800 7fdd      : STO  .7fdd
2756 : 805a           : LDA   005a
2757 : 402e           : STO   002e
2758 : 402f           : STO   002f
2759 : 8000 8000      : LDA  ,8000
275b : 4800 7fc2      : STO  .7fc2
275d : 8800 01e5      : LDA  .01e5
275f : 0191 275d      : JBS   1 CR 275d
2761 : 8081           : LDA   0081
2762 : b05b           : CMP   005b
2763 : 0191 276b      : JBS   1 CR 276b
2765 : b05c           : CMP   005c
2766 : 0191 276b      : JBS   1 CR 276b
2768 : b05e           : CMP   005e
2769 : 0181 276e      : JBC   1 CR 276e
276b : 805a           : LDA   005a
276c : 4800 7fa0      : STO  .7fa0
276e : 8800 01f2      : LDA  .01f2
2770 : 0191 276e      : JBS   1 CR 276e
2772 : 805a           : LDA   005a
2773 : 4800 01f2      : STO  .01f2
2775 : 2800 0d3a      : CAL  .0d3a
2777 : f800 276e      : JMP  .276e
2779 : 2800 284b      : CAL  .284b
277b : 0000           : SRA   0 A
277c : 0000           : SRA   0 A
277d : 8000 0000      : LDA  ,0000
277f : 4028           : STO   0028
2780 : 8901           : LDA  /0001+
2781 : 8b01           : LDA  /0001-
2782 : 01b5 2786      : JSC   5 CR 2786
2784 : 9000 4000      : ADD  ,4000
2786 : 008e 278a      : JBC   e A 278a
2788 : a000 8000      : SUB  ,8000
278a : 4026           : STO   0026
278b : 008e 2791      : JBC   e A 2791
278d : 8000 7fff      : LDA  ,7fff
278f : f800 27bf      : JMP  .27bf
2791 : 0061           : SLL   1 A
2792 : 0028           : SRL   8 A
2793 : a000 2849      : SUB  ,2849
2795 : 4027           : STO   0027
2796 : 8b27           : LDA  /0027-
2797 : a827           : SUB  /0027
2798 : 0380 0026 279c : JBC   0 0026 279c
279b : 5028           : ADS   0028
279c : 0061           : SLL   1 A
279d : 0381 0026 27a1 : JBC   1 0026 27a1
27a0 : 5028           : ADS   0028
27a1 : 0061           : SLL   1 A
27a2 : 0382 0026 27a6 : JBC   2 0026 27a6
27a5 : 5028           : ADS   0028
27a6 : 0061           : SLL   1 A
27a7 : 0383 0026 27ab : JBC   3 0026 27ab
27aa : 5028           : ADS   0028
27ab : 0061           : SLL   1 A
27ac : 0384 0026 27b0 : JBC   4 0026 27b0
27af : 5028           : ADS   0028
27b0 : 0061           : SLL   1 A
27b1 : 0385 0026 27b5 : JBC   5 0026 27b5
27b4 : 5028           : ADS   0028
27b5 : 0061           : SLL   1 A
27b6 : 0386 0026 27ba : JBC   6 0026 27ba
27b9 : 5028           : ADS   0028
27ba : 8000 0040      : LDA  ,0040
27bc : 9028           : ADD   0028
27bd : 0027           : SRL   7 A
27be : 9927           : ADD  /0027+
27bf : 038f 0026 27c4 : JBC   f 0026 27c4
27c2 : a000 0000      : SUB  ,0000
27c4 : 2800 2850      : CAL  .2850
27c6 : 0000           : SRA   0 A
27c7 : 0000           : SRA   0 A
27c8 : 3800           : RTC
27c9 : 7FFF           : DATA
27ca : 7FFE           : DATA
27cb : 7FF6           : DATA
27cc : 7FEA           : DATA
27cd : 7FD9           : DATA
27ce : 7FC2           : DATA
27cf : 7FA7           : DATA
27d0 : 7F87           : DATA
27d1 : 7F62           : DATA
27d2 : 7F38           : DATA
27d3 : 7F0A           : DATA
27d4 : 7ED6           : DATA
27d5 : 7E9D           : DATA
27d6 : 7E60           : DATA
27d7 : 7E1E           : DATA
27d8 : 7DD6           : DATA
27d9 : 7D8A           : DATA
27da : 7D3A           : DATA
27db : 7CE4           : DATA
27dc : 7C89           : DATA
27dd : 7C2A           : DATA
27de : 7BC6           : DATA
27df : 7B5D           : DATA
27e0 : 7AEF           : DATA
27e1 : 7A7D           : DATA
27e2 : 7A06           : DATA
27e3 : 798A           : DATA
27e4 : 790A           : DATA
27e5 : 7885           : DATA
27e6 : 77FB           : DATA
27e7 : 776C           : DATA
27e8 : 76D9           : DATA
27e9 : 7642           : DATA
27ea : 75A6           : DATA
27eb : 7505           : DATA
27ec : 7460           : DATA
27ed : 73B6           : DATA
27ee : 7308           : DATA
27ef : 7255           : DATA
27f0 : 719E           : DATA
27f1 : 70E3           : DATA
27f2 : 7023           : DATA
27f3 : 6F5F           : DATA
27f4 : 6E97           : DATA
27f5 : 6DCA           : DATA
27f6 : 6CF9           : DATA
27f7 : 6C24           : DATA
27f8 : 6B4B           : DATA
27f9 : 6A6E           : DATA
27fa : 698C           : DATA
27fb : 68A7           : DATA
27fc : 67BD           : DATA
27fd : 66D0           : DATA
27fe : 65DE           : DATA
27ff : 64E9           : DATA
2800 : 63EF           : DATA
2801 : 62F2           : DATA
2802 : 61F1           : DATA
2803 : 60EC           : DATA
2804 : 5FE4           : DATA
2805 : 5ED7           : DATA
2806 : 5DC8           : DATA
2807 : 5CB4           : DATA
2808 : 5B9D           : DATA
2809 : 5A82           : DATA
280a : 5964           : DATA
280b : 5843           : DATA
280c : 571E           : DATA
280d : 55F6           : DATA
280e : 54CA           : DATA
280f : 539B           : DATA
2810 : 5269           : DATA
2811 : 5134           : DATA
2812 : 4FFB           : DATA
2813 : 4EC0           : DATA
2814 : 4D81           : DATA
2815 : 4C40           : DATA
2816 : 4AFB           : DATA
2817 : 49B4           : DATA
2818 : 486A           : DATA
2819 : 471D           : DATA
281a : 45CD           : DATA
281b : 447B           : DATA
281c : 4326           : DATA
281d : 41CE           : DATA
281e : 4074           : DATA
281f : 3F17           : DATA
2820 : 3DB8           : DATA
2821 : 3C57           : DATA
2822 : 3AF3           : DATA
2823 : 398D           : DATA
2824 : 3825           : DATA
2825 : 36BA           : DATA
2826 : 354E           : DATA
2827 : 33DF           : DATA
2828 : 326E           : DATA
2829 : 30FC           : DATA
282a : 2F87           : DATA
282b : 2E11           : DATA
282c : 2C99           : DATA
282d : 2B1F           : DATA
282e : 29A4           : DATA
282f : 2827           : DATA
2830 : 26A8           : DATA
2831 : 2528           : DATA
2832 : 23A7           : DATA
2833 : 2224           : DATA
2834 : 209F           : DATA
2835 : 1F1A           : DATA
2836 : 1D93           : DATA
2837 : 1C0C           : DATA
2838 : 1A83           : DATA
2839 : 18F9           : DATA
283a : 176E           : DATA
283b : 15E2           : DATA
283c : 1455           : DATA
283d : 12C8           : DATA
283e : 113A           : DATA
283f : 0FAB           : DATA
2840 : 0E1C           : DATA
2841 : 0C8C           : DATA
2842 : 0AFB           : DATA
2843 : 096B           : DATA
2844 : 07D9           : DATA
2845 : 0648           : DATA
2846 : 04B6           : DATA
2847 : 0324           : DATA
2848 : 0192           : DATA
2849 : 0000           : DATA
284a : FFFF           : DATA
284b : 8000 286b      : LDA  ,286b
284d : 402c           : STO   002c
284e : f800 2854      : JMP  .2854
2850 : 402b           : STO   002b
2851 : 8000 2870      : LDA  ,2870
2853 : 402c           : STO   002c
2854 : 8800 0000      : LDA  .0000
2856 : 4026           : STO   0026
2857 : 8b26           : LDA  /0026-
2858 : 8826           : LDA  /0026
2859 : 4027           : STO   0027
285a : 03f0 002a      : CLR   0 002a
285c : 8827           : LDA  /0027
285d : 0191 2863      : JBS   1 CR 2863
285f : 4028           : STO   0028
2860 : 8927           : LDA  /0027+
2861 : 4029           : STO   0029
2862 : 282c           : CAL  /002c
2863 : 8927           : LDA  /0027+
2864 : 03a0 002a 285d : JCS   0 002a 285d
2867 : 8027           : LDA   0027
2868 : 4826           : STO  /0026
2869 : 802b           : LDA   002b
286a : 3800           : RTC
286b : 8929           : LDA  /0029+
286c : 4903           : STO  /0003+
286d : 7028 286b      : ICZ   0028 286b
286f : 3800           : RTC
2870 : 8b03           : LDA  /0003-
2871 : 4b29           : STO  /0029-
2872 : 7028 2870      : ICZ   0028 2870
2874 : 3800           : RTC
2875 : FFFF           : DATA
2876 : FFFF           : DATA
2877 : FFFF           : DATA
2878 : FFFF           : DATA
2879 : FFFF           : DATA
287a : FFFF           : DATA
287b : FFFF           : DATA
287c : FFFF           : DATA
287d : FFFF           : DATA
287e : FFFF           : DATA
287f : FFFF           : DATA
2880 : FFFF           : DATA
2881 : FFFF           : DATA
2882 : FFFF           : DATA
2883 : FFFF           : DATA
2884 : FFFF           : DATA
2885 : FFFF           : DATA
2886 : FFFF           : DATA
2887 : FFFF           : DATA
2888 : FFFF           : DATA
2889 : FFFF           : DATA
288a : FFFF           : DATA
288b : FFFF           : DATA
288c : FFFF           : DATA
288d : FFFF           : DATA
288e : FFFF           : DATA
288f : FFFF           : DATA
2890 : FFFF           : DATA
2891 : FFFF           : DATA
2892 : FFFF           : DATA
2893 : FFFF           : DATA
2894 : FFFF           : DATA
2895 : FFFF           : DATA
2896 : FFFF           : DATA
2897 : FFFF           : DATA
2898 : FFFF           : DATA
2899 : FFFF           : DATA
289a : FFFF           : DATA
289b : FFFF           : DATA
289c : FFFF           : DATA
289d : FFFF           : DATA
289e : FFFF           : DATA
289f : FFFF           : DATA
28a0 : FFFF           : DATA
28a1 : FFFF           : DATA
28a2 : FFFF           : DATA
28a3 : FFFF           : DATA
28a4 : FFFF           : DATA
28a5 : FFFF           : DATA
28a6 : FFFF           : DATA
28a7 : FFFF           : DATA
28a8 : FFFF           : DATA
28a9 : FFFF           : DATA
28aa : FFFF           : DATA
28ab : FFFF           : DATA
28ac : FFFF           : DATA
28ad : FFFF           : DATA
28ae : FFFF           : DATA
28af : FFFF           : DATA
28b0 : FFFF           : DATA
28b1 : FFFF           : DATA
28b2 : FFFF           : DATA
28b3 : FFFF           : DATA
28b4 : FFFF           : DATA
28b5 : FFFF           : DATA
28b6 : FFFF           : DATA
28b7 : FFFF           : DATA
28b8 : FFFF           : DATA
28b9 : FFFF           : DATA
28ba : FFFF           : DATA
28bb : FFFF           : DATA
28bc : FFFF           : DATA
28bd : FFFF           : DATA
28be : FFFF           : DATA
28bf : FFFF           : DATA
28c0 : FFFF           : DATA
28c1 : FFFF           : DATA
28c2 : FFFF           : DATA
28c3 : FFFF           : DATA
28c4 : FFFF           : DATA
28c5 : FFFF           : DATA
28c6 : FFFF           : DATA
28c7 : FFFF           : DATA
28c8 : FFFF           : DATA
28c9 : FFFF           : DATA
28ca : FFFF           : DATA
28cb : FFFF           : DATA
28cc : FFFF           : DATA
28cd : FFFF           : DATA
28ce : FFFF           : DATA
28cf : FFFF           : DATA
28d0 : FFFF           : DATA
28d1 : FFFF           : DATA
28d2 : FFFF           : DATA
28d3 : FFFF           : DATA
28d4 : FFFF           : DATA
28d5 : FFFF           : DATA
28d6 : FFFF           : DATA
28d7 : FFFF           : DATA
28d8 : FFFF           : DATA
28d9 : FFFF           : DATA
28da : FFFF           : DATA
28db : FFFF           : DATA
28dc : FFFF           : DATA
28dd : FFFF           : DATA
28de : FFFF           : DATA
28df : FFFF           : DATA
28e0 : FFFF           : DATA
28e1 : FFFF           : DATA
28e2 : FFFF           : DATA
28e3 : FFFF           : DATA
28e4 : FFFF           : DATA
28e5 : FFFF           : DATA
28e6 : FFFF           : DATA
28e7 : FFFF           : DATA
28e8 : FFFF           : DATA
28e9 : FFFF           : DATA
28ea : FFFF           : DATA
28eb : FFFF           : DATA
28ec : FFFF           : DATA
28ed : FFFF           : DATA
28ee : FFFF           : DATA
28ef : FFFF           : DATA
28f0 : FFFF           : DATA
28f1 : FFFF           : DATA
28f2 : FFFF           : DATA
28f3 : FFFF           : DATA
28f4 : FFFF           : DATA
28f5 : FFFF           : DATA
28f6 : FFFF           : DATA
28f7 : FFFF           : DATA
28f8 : FFFF           : DATA
28f9 : FFFF           : DATA
28fa : FFFF           : DATA
28fb : FFFF           : DATA
28fc : FFFF           : DATA
28fd : FFFF           : DATA
28fe : FFFF           : DATA
28ff : FFFF           : DATA
2900 : FFFF           : DATA
2901 : FFFF           : DATA
2902 : FFFF           : DATA
2903 : FFFF           : DATA
2904 : FFFF           : DATA
2905 : FFFF           : DATA
2906 : FFFF           : DATA
2907 : FFFF           : DATA
2908 : FFFF           : DATA
2909 : FFFF           : DATA
290a : FFFF           : DATA
290b : FFFF           : DATA
290c : FFFF           : DATA
290d : FFFF           : DATA
290e : FFFF           : DATA
290f : FFFF           : DATA
2910 : FFFF           : DATA
2911 : FFFF           : DATA
2912 : FFFF           : DATA
2913 : FFFF           : DATA
2914 : FFFF           : DATA
2915 : FFFF           : DATA
2916 : FFFF           : DATA
2917 : FFFF           : DATA
2918 : FFFF           : DATA
2919 : FFFF           : DATA
291a : FFFF           : DATA
291b : FFFF           : DATA
291c : FFFF           : DATA
291d : FFFF           : DATA
291e : FFFF           : DATA
291f : FFFF           : DATA
2920 : FFFF           : DATA
2921 : FFFF           : DATA
2922 : FFFF           : DATA
2923 : FFFF           : DATA
2924 : FFFF           : DATA
2925 : FFFF           : DATA
2926 : FFFF           : DATA
2927 : FFFF           : DATA
2928 : FFFF           : DATA
2929 : FFFF           : DATA
292a : FFFF           : DATA
292b : FFFF           : DATA
292c : FFFF           : DATA
292d : FFFF           : DATA
292e : FFFF           : DATA
292f : FFFF           : DATA
2930 : FFFF           : DATA
2931 : FFFF           : DATA
2932 : FFFF           : DATA
2933 : FFFF           : DATA
2934 : FFFF           : DATA
2935 : FFFF           : DATA
2936 : FFFF           : DATA
2937 : FFFF           : DATA
2938 : FFFF           : DATA
2939 : FFFF           : DATA
293a : FFFF           : DATA
293b : FFFF           : DATA
293c : FFFF           : DATA
293d : FFFF           : DATA
293e : FFFF           : DATA
293f : FFFF           : DATA
2940 : FFFF           : DATA
2941 : FFFF           : DATA
2942 : FFFF           : DATA
2943 : FFFF           : DATA
2944 : FFFF           : DATA
2945 : FFFF           : DATA
2946 : FFFF           : DATA
2947 : FFFF           : DATA
2948 : FFFF           : DATA
2949 : FFFF           : DATA
294a : FFFF           : DATA
294b : FFFF           : DATA
294c : FFFF           : DATA
294d : FFFF           : DATA
294e : FFFF           : DATA
294f : FFFF           : DATA
2950 : FFFF           : DATA
2951 : FFFF           : DATA
2952 : FFFF           : DATA
2953 : FFFF           : DATA
2954 : FFFF           : DATA
2955 : FFFF           : DATA
2956 : FFFF           : DATA
2957 : FFFF           : DATA
2958 : FFFF           : DATA
2959 : FFFF           : DATA
295a : FFFF           : DATA
295b : FFFF           : DATA
295c : FFFF           : DATA
295d : FFFF           : DATA
295e : FFFF           : DATA
295f : FFFF           : DATA
2960 : FFFF           : DATA
2961 : FFFF           : DATA
2962 : FFFF           : DATA
2963 : FFFF           : DATA
2964 : FFFF           : DATA
2965 : FFFF           : DATA
2966 : FFFF           : DATA
2967 : FFFF           : DATA
2968 : FFFF           : DATA
2969 : FFFF           : DATA
296a : FFFF           : DATA
296b : FFFF           : DATA
296c : FFFF           : DATA
296d : FFFF           : DATA
296e : FFFF           : DATA
296f : FFFF           : DATA
2970 : FFFF           : DATA
2971 : FFFF           : DATA
2972 : FFFF           : DATA
2973 : FFFF           : DATA
2974 : FFFF           : DATA
2975 : FFFF           : DATA
2976 : FFFF           : DATA
2977 : FFFF           : DATA
2978 : FFFF           : DATA
2979 : FFFF           : DATA
297a : FFFF           : DATA
297b : FFFF           : DATA
297c : FFFF           : DATA
297d : FFFF           : DATA
297e : FFFF           : DATA
297f : FFFF           : DATA
2980 : FFFF           : DATA
2981 : FFFF           : DATA
2982 : FFFF           : DATA
2983 : FFFF           : DATA
2984 : FFFF           : DATA
2985 : FFFF           : DATA
2986 : FFFF           : DATA
2987 : FFFF           : DATA
2988 : FFFF           : DATA
2989 : FFFF           : DATA
298a : FFFF           : DATA
298b : FFFF           : DATA
298c : FFFF           : DATA
298d : FFFF           : DATA
298e : FFFF           : DATA
298f : FFFF           : DATA
2990 : FFFF           : DATA
2991 : FFFF           : DATA
2992 : FFFF           : DATA
2993 : FFFF           : DATA
2994 : FFFF           : DATA
2995 : FFFF           : DATA
2996 : FFFF           : DATA
2997 : FFFF           : DATA
2998 : FFFF           : DATA
2999 : FFFF           : DATA
299a : FFFF           : DATA
299b : FFFF           : DATA
299c : FFFF           : DATA
299d : FFFF           : DATA
299e : FFFF           : DATA
299f : FFFF           : DATA
29a0 : FFFF           : DATA
29a1 : FFFF           : DATA
29a2 : FFFF           : DATA
29a3 : FFFF           : DATA
29a4 : FFFF           : DATA
29a5 : FFFF           : DATA
29a6 : FFFF           : DATA
29a7 : FFFF           : DATA
29a8 : FFFF           : DATA
29a9 : FFFF           : DATA
29aa : FFFF           : DATA
29ab : FFFF           : DATA
29ac : FFFF           : DATA
29ad : FFFF           : DATA
29ae : FFFF           : DATA
29af : FFFF           : DATA
29b0 : FFFF           : DATA
29b1 : FFFF           : DATA
29b2 : FFFF           : DATA
29b3 : FFFF           : DATA
29b4 : FFFF           : DATA
29b5 : FFFF           : DATA
29b6 : FFFF           : DATA
29b7 : FFFF           : DATA
29b8 : FFFF           : DATA
29b9 : FFFF           : DATA
29ba : FFFF           : DATA
29bb : FFFF           : DATA
29bc : FFFF           : DATA
29bd : FFFF           : DATA
29be : FFFF           : DATA
29bf : FFFF           : DATA
29c0 : FFFF           : DATA
29c1 : FFFF           : DATA
29c2 : FFFF           : DATA
29c3 : FFFF           : DATA
29c4 : FFFF           : DATA
29c5 : FFFF           : DATA
29c6 : FFFF           : DATA
29c7 : FFFF           : DATA
29c8 : FFFF           : DATA
29c9 : FFFF           : DATA
29ca : FFFF           : DATA
29cb : FFFF           : DATA
29cc : FFFF           : DATA
29cd : FFFF           : DATA
29ce : FFFF           : DATA
29cf : FFFF           : DATA
29d0 : FFFF           : DATA
29d1 : FFFF           : DATA
29d2 : FFFF           : DATA
29d3 : FFFF           : DATA
29d4 : FFFF           : DATA
29d5 : FFFF           : DATA
29d6 : FFFF           : DATA
29d7 : FFFF           : DATA
29d8 : FFFF           : DATA
29d9 : FFFF           : DATA
29da : FFFF           : DATA
29db : FFFF           : DATA
29dc : FFFF           : DATA
29dd : FFFF           : DATA
29de : FFFF           : DATA
29df : FFFF           : DATA
29e0 : FFFF           : DATA
29e1 : FFFF           : DATA
29e2 : FFFF           : DATA
29e3 : FFFF           : DATA
29e4 : FFFF           : DATA
29e5 : FFFF           : DATA
29e6 : FFFF           : DATA
29e7 : FFFF           : DATA
29e8 : FFFF           : DATA
29e9 : FFFF           : DATA
29ea : FFFF           : DATA
29eb : FFFF           : DATA
29ec : FFFF           : DATA
29ed : FFFF           : DATA
29ee : FFFF           : DATA
29ef : FFFF           : DATA
29f0 : FFFF           : DATA
29f1 : FFFF           : DATA
29f2 : FFFF           : DATA
29f3 : FFFF           : DATA
29f4 : FFFF           : DATA
29f5 : FFFF           : DATA
29f6 : FFFF           : DATA
29f7 : FFFF           : DATA
29f8 : FFFF           : DATA
29f9 : FFFF           : DATA
29fa : FFFF           : DATA
29fb : FFFF           : DATA
29fc : FFFF           : DATA
29fd : FFFF           : DATA
29fe : FFFF           : DATA
29ff : FFFF           : DATA
2a00 : FFFF           : DATA
2a01 : FFFF           : DATA
2a02 : FFFF           : DATA
2a03 : FFFF           : DATA
2a04 : FFFF           : DATA
2a05 : FFFF           : DATA
2a06 : FFFF           : DATA
2a07 : FFFF           : DATA
2a08 : FFFF           : DATA
2a09 : FFFF           : DATA
2a0a : FFFF           : DATA
2a0b : FFFF           : DATA
2a0c : FFFF           : DATA
2a0d : FFFF           : DATA
2a0e : FFFF           : DATA
2a0f : FFFF           : DATA
2a10 : FFFF           : DATA
2a11 : FFFF           : DATA
2a12 : FFFF           : DATA
2a13 : FFFF           : DATA
2a14 : FFFF           : DATA
2a15 : FFFF           : DATA
2a16 : FFFF           : DATA
2a17 : FFFF           : DATA
2a18 : FFFF           : DATA
2a19 : FFFF           : DATA
2a1a : FFFF           : DATA
2a1b : FFFF           : DATA
2a1c : FFFF           : DATA
2a1d : FFFF           : DATA
2a1e : FFFF           : DATA
2a1f : FFFF           : DATA
2a20 : FFFF           : DATA
2a21 : FFFF           : DATA
2a22 : FFFF           : DATA
2a23 : FFFF           : DATA
2a24 : FFFF           : DATA
2a25 : FFFF           : DATA
2a26 : FFFF           : DATA
2a27 : FFFF           : DATA
2a28 : FFFF           : DATA
2a29 : FFFF           : DATA
2a2a : FFFF           : DATA
2a2b : FFFF           : DATA
2a2c : FFFF           : DATA
2a2d : FFFF           : DATA
2a2e : FFFF           : DATA
2a2f : FFFF           : DATA
2a30 : FFFF           : DATA
2a31 : FFFF           : DATA
2a32 : FFFF           : DATA
2a33 : FFFF           : DATA
2a34 : FFFF           : DATA
2a35 : FFFF           : DATA
2a36 : FFFF           : DATA
2a37 : FFFF           : DATA
2a38 : FFFF           : DATA
2a39 : FFFF           : DATA
2a3a : FFFF           : DATA
2a3b : FFFF           : DATA
2a3c : FFFF           : DATA
2a3d : FFFF           : DATA
2a3e : FFFF           : DATA
2a3f : FFFF           : DATA
2a40 : FFFF           : DATA
2a41 : FFFF           : DATA
2a42 : FFFF           : DATA
2a43 : FFFF           : DATA
2a44 : FFFF           : DATA
2a45 : FFFF           : DATA
2a46 : FFFF           : DATA
2a47 : FFFF           : DATA
2a48 : FFFF           : DATA
2a49 : FFFF           : DATA
2a4a : FFFF           : DATA
2a4b : FFFF           : DATA
2a4c : FFFF           : DATA
2a4d : FFFF           : DATA
2a4e : FFFF           : DATA
2a4f : FFFF           : DATA
2a50 : FFFF           : DATA
2a51 : FFFF           : DATA
2a52 : FFFF           : DATA
2a53 : FFFF           : DATA
2a54 : FFFF           : DATA
2a55 : FFFF           : DATA
2a56 : FFFF           : DATA
2a57 : FFFF           : DATA
2a58 : FFFF           : DATA
2a59 : FFFF           : DATA
2a5a : FFFF           : DATA
2a5b : FFFF           : DATA
2a5c : FFFF           : DATA
2a5d : FFFF           : DATA
2a5e : FFFF           : DATA
2a5f : FFFF           : DATA
2a60 : FFFF           : DATA
2a61 : FFFF           : DATA
2a62 : FFFF           : DATA
2a63 : FFFF           : DATA
2a64 : FFFF           : DATA
2a65 : FFFF           : DATA
2a66 : FFFF           : DATA
2a67 : FFFF           : DATA
2a68 : FFFF           : DATA
2a69 : FFFF           : DATA
2a6a : FFFF           : DATA
2a6b : FFFF           : DATA
2a6c : FFFF           : DATA
2a6d : FFFF           : DATA
2a6e : FFFF           : DATA
2a6f : FFFF           : DATA
2a70 : FFFF           : DATA
2a71 : FFFF           : DATA
2a72 : FFFF           : DATA
2a73 : FFFF           : DATA
2a74 : FFFF           : DATA
2a75 : FFFF           : DATA
2a76 : FFFF           : DATA
2a77 : FFFF           : DATA
2a78 : FFFF           : DATA
2a79 : FFFF           : DATA
2a7a : FFFF           : DATA
2a7b : FFFF           : DATA
2a7c : FFFF           : DATA
2a7d : FFFF           : DATA
2a7e : FFFF           : DATA
2a7f : FFFF           : DATA
2a80 : FFFF           : DATA
2a81 : FFFF           : DATA
2a82 : FFFF           : DATA
2a83 : FFFF           : DATA
2a84 : FFFF           : DATA
2a85 : FFFF           : DATA
2a86 : FFFF           : DATA
2a87 : FFFF           : DATA
2a88 : FFFF           : DATA
2a89 : FFFF           : DATA
2a8a : FFFF           : DATA
2a8b : FFFF           : DATA
2a8c : FFFF           : DATA
2a8d : FFFF           : DATA
2a8e : FFFF           : DATA
2a8f : FFFF           : DATA
2a90 : FFFF           : DATA
2a91 : FFFF           : DATA
2a92 : FFFF           : DATA
2a93 : FFFF           : DATA
2a94 : FFFF           : DATA
2a95 : FFFF           : DATA
2a96 : FFFF           : DATA
2a97 : FFFF           : DATA
2a98 : FFFF           : DATA
2a99 : FFFF           : DATA
2a9a : FFFF           : DATA
2a9b : FFFF           : DATA
2a9c : FFFF           : DATA
2a9d : FFFF           : DATA
2a9e : FFFF           : DATA
2a9f : FFFF           : DATA
2aa0 : FFFF           : DATA
2aa1 : FFFF           : DATA
2aa2 : FFFF           : DATA
2aa3 : FFFF           : DATA
2aa4 : FFFF           : DATA
2aa5 : FFFF           : DATA
2aa6 : FFFF           : DATA
2aa7 : FFFF           : DATA
2aa8 : FFFF           : DATA
2aa9 : FFFF           : DATA
2aaa : FFFF           : DATA
2aab : FFFF           : DATA
2aac : FFFF           : DATA
2aad : FFFF           : DATA
2aae : FFFF           : DATA
2aaf : FFFF           : DATA
2ab0 : FFFF           : DATA
2ab1 : FFFF           : DATA
2ab2 : FFFF           : DATA
2ab3 : FFFF           : DATA
2ab4 : FFFF           : DATA
2ab5 : FFFF           : DATA
2ab6 : FFFF           : DATA
2ab7 : FFFF           : DATA
2ab8 : FFFF           : DATA
2ab9 : FFFF           : DATA
2aba : FFFF           : DATA
2abb : FFFF           : DATA
2abc : FFFF           : DATA
2abd : FFFF           : DATA
2abe : FFFF           : DATA
2abf : FFFF           : DATA
2ac0 : FFFF           : DATA
2ac1 : FFFF           : DATA
2ac2 : FFFF           : DATA
2ac3 : FFFF           : DATA
2ac4 : FFFF           : DATA
2ac5 : FFFF           : DATA
2ac6 : FFFF           : DATA
2ac7 : FFFF           : DATA
2ac8 : FFFF           : DATA
2ac9 : FFFF           : DATA
2aca : FFFF           : DATA
2acb : FFFF           : DATA
2acc : FFFF           : DATA
2acd : FFFF           : DATA
2ace : FFFF           : DATA
2acf : FFFF           : DATA
2ad0 : FFFF           : DATA
2ad1 : FFFF           : DATA
2ad2 : FFFF           : DATA
2ad3 : FFFF           : DATA
2ad4 : FFFF           : DATA
2ad5 : FFFF           : DATA
2ad6 : FFFF           : DATA
2ad7 : FFFF           : DATA
2ad8 : FFFF           : DATA
2ad9 : FFFF           : DATA
2ada : FFFF           : DATA
2adb : FFFF           : DATA
2adc : FFFF           : DATA
2add : FFFF           : DATA
2ade : FFFF           : DATA
2adf : FFFF           : DATA
2ae0 : FFFF           : DATA
2ae1 : FFFF           : DATA
2ae2 : FFFF           : DATA
2ae3 : FFFF           : DATA
2ae4 : FFFF           : DATA
2ae5 : FFFF           : DATA
2ae6 : FFFF           : DATA
2ae7 : FFFF           : DATA
2ae8 : FFFF           : DATA
2ae9 : FFFF           : DATA
2aea : FFFF           : DATA
2aeb : FFFF           : DATA
2aec : FFFF           : DATA
2aed : FFFF           : DATA
2aee : FFFF           : DATA
2aef : FFFF           : DATA
2af0 : FFFF           : DATA
2af1 : FFFF           : DATA
2af2 : FFFF           : DATA
2af3 : FFFF           : DATA
2af4 : FFFF           : DATA
2af5 : FFFF           : DATA
2af6 : FFFF           : DATA
2af7 : FFFF           : DATA
2af8 : FFFF           : DATA
2af9 : FFFF           : DATA
2afa : FFFF           : DATA
2afb : FFFF           : DATA
2afc : FFFF           : DATA
2afd : FFFF           : DATA
2afe : FFFF           : DATA
2aff : FFFF           : DATA
2b00 : FFFF           : DATA
2b01 : FFFF           : DATA
2b02 : FFFF           : DATA
2b03 : FFFF           : DATA
2b04 : FFFF           : DATA
2b05 : FFFF           : DATA
2b06 : FFFF           : DATA
2b07 : FFFF           : DATA
2b08 : FFFF           : DATA
2b09 : FFFF           : DATA
2b0a : FFFF           : DATA
2b0b : FFFF           : DATA
2b0c : FFFF           : DATA
2b0d : FFFF           : DATA
2b0e : FFFF           : DATA
2b0f : FFFF           : DATA
2b10 : FFFF           : DATA
2b11 : FFFF           : DATA
2b12 : FFFF           : DATA
2b13 : FFFF           : DATA
2b14 : FFFF           : DATA
2b15 : FFFF           : DATA
2b16 : FFFF           : DATA
2b17 : FFFF           : DATA
2b18 : FFFF           : DATA
2b19 : FFFF           : DATA
2b1a : FFFF           : DATA
2b1b : FFFF           : DATA
2b1c : FFFF           : DATA
2b1d : FFFF           : DATA
2b1e : FFFF           : DATA
2b1f : FFFF           : DATA
2b20 : FFFF           : DATA
2b21 : FFFF           : DATA
2b22 : FFFF           : DATA
2b23 : FFFF           : DATA
2b24 : FFFF           : DATA
2b25 : FFFF           : DATA
2b26 : FFFF           : DATA
2b27 : FFFF           : DATA
2b28 : FFFF           : DATA
2b29 : FFFF           : DATA
2b2a : FFFF           : DATA
2b2b : FFFF           : DATA
2b2c : FFFF           : DATA
2b2d : FFFF           : DATA
2b2e : FFFF           : DATA
2b2f : FFFF           : DATA
2b30 : FFFF           : DATA
2b31 : FFFF           : DATA
2b32 : FFFF           : DATA
2b33 : FFFF           : DATA
2b34 : FFFF           : DATA
2b35 : FFFF           : DATA
2b36 : FFFF           : DATA
2b37 : FFFF           : DATA
2b38 : FFFF           : DATA
2b39 : FFFF           : DATA
2b3a : FFFF           : DATA
2b3b : FFFF           : DATA
2b3c : FFFF           : DATA
2b3d : FFFF           : DATA
2b3e : FFFF           : DATA
2b3f : FFFF           : DATA
2b40 : FFFF           : DATA
2b41 : FFFF           : DATA
2b42 : FFFF           : DATA
2b43 : FFFF           : DATA
2b44 : FFFF           : DATA
2b45 : FFFF           : DATA
2b46 : FFFF           : DATA
2b47 : FFFF           : DATA
2b48 : FFFF           : DATA
2b49 : FFFF           : DATA
2b4a : FFFF           : DATA
2b4b : FFFF           : DATA
2b4c : FFFF           : DATA
2b4d : FFFF           : DATA
2b4e : FFFF           : DATA
2b4f : FFFF           : DATA
2b50 : FFFF           : DATA
2b51 : FFFF           : DATA
2b52 : FFFF           : DATA
2b53 : FFFF           : DATA
2b54 : FFFF           : DATA
2b55 : FFFF           : DATA
2b56 : FFFF           : DATA
2b57 : FFFF           : DATA
2b58 : FFFF           : DATA
2b59 : FFFF           : DATA
2b5a : FFFF           : DATA
2b5b : FFFF           : DATA
2b5c : FFFF           : DATA
2b5d : FFFF           : DATA
2b5e : FFFF           : DATA
2b5f : FFFF           : DATA
2b60 : FFFF           : DATA
2b61 : FFFF           : DATA
2b62 : FFFF           : DATA
2b63 : FFFF           : DATA
2b64 : FFFF           : DATA
2b65 : FFFF           : DATA
2b66 : FFFF           : DATA
2b67 : FFFF           : DATA
2b68 : FFFF           : DATA
2b69 : FFFF           : DATA
2b6a : FFFF           : DATA
2b6b : FFFF           : DATA
2b6c : FFFF           : DATA
2b6d : FFFF           : DATA
2b6e : FFFF           : DATA
2b6f : FFFF           : DATA
2b70 : FFFF           : DATA
2b71 : FFFF           : DATA
2b72 : FFFF           : DATA
2b73 : FFFF           : DATA
2b74 : FFFF           : DATA
2b75 : FFFF           : DATA
2b76 : FFFF           : DATA
2b77 : FFFF           : DATA
2b78 : FFFF           : DATA
2b79 : FFFF           : DATA
2b7a : FFFF           : DATA
2b7b : FFFF           : DATA
2b7c : FFFF           : DATA
2b7d : FFFF           : DATA
2b7e : FFFF           : DATA
2b7f : FFFF           : DATA
2b80 : FFFF           : DATA
2b81 : FFFF           : DATA
2b82 : FFFF           : DATA
2b83 : FFFF           : DATA
2b84 : FFFF           : DATA
2b85 : FFFF           : DATA
2b86 : FFFF           : DATA
2b87 : FFFF           : DATA
2b88 : FFFF           : DATA
2b89 : FFFF           : DATA
2b8a : FFFF           : DATA
2b8b : FFFF           : DATA
2b8c : FFFF           : DATA
2b8d : FFFF           : DATA
2b8e : FFFF           : DATA
2b8f : FFFF           : DATA
2b90 : FFFF           : DATA
2b91 : FFFF           : DATA
2b92 : FFFF           : DATA
2b93 : FFFF           : DATA
2b94 : FFFF           : DATA
2b95 : FFFF           : DATA
2b96 : FFFF           : DATA
2b97 : FFFF           : DATA
2b98 : FFFF           : DATA
2b99 : FFFF           : DATA
2b9a : FFFF           : DATA
2b9b : FFFF           : DATA
2b9c : FFFF           : DATA
2b9d : FFFF           : DATA
2b9e : FFFF           : DATA
2b9f : FFFF           : DATA
2ba0 : FFFF           : DATA
2ba1 : FFFF           : DATA
2ba2 : FFFF           : DATA
2ba3 : FFFF           : DATA
2ba4 : FFFF           : DATA
2ba5 : FFFF           : DATA
2ba6 : FFFF           : DATA
2ba7 : FFFF           : DATA
2ba8 : FFFF           : DATA
2ba9 : FFFF           : DATA
2baa : FFFF           : DATA
2bab : FFFF           : DATA
2bac : FFFF           : DATA
2bad : FFFF           : DATA
2bae : FFFF           : DATA
2baf : FFFF           : DATA
2bb0 : FFFF           : DATA
2bb1 : FFFF           : DATA
2bb2 : FFFF           : DATA
2bb3 : FFFF           : DATA
2bb4 : FFFF           : DATA
2bb5 : FFFF           : DATA
2bb6 : FFFF           : DATA
2bb7 : FFFF           : DATA
2bb8 : FFFF           : DATA
2bb9 : FFFF           : DATA
2bba : FFFF           : DATA
2bbb : FFFF           : DATA
2bbc : FFFF           : DATA
2bbd : FFFF           : DATA
2bbe : FFFF           : DATA
2bbf : FFFF           : DATA
2bc0 : FFFF           : DATA
2bc1 : FFFF           : DATA
2bc2 : FFFF           : DATA
2bc3 : FFFF           : DATA
2bc4 : FFFF           : DATA
2bc5 : FFFF           : DATA
2bc6 : FFFF           : DATA
2bc7 : FFFF           : DATA
2bc8 : FFFF           : DATA
2bc9 : FFFF           : DATA
2bca : FFFF           : DATA
2bcb : FFFF           : DATA
2bcc : FFFF           : DATA
2bcd : FFFF           : DATA
2bce : FFFF           : DATA
2bcf : FFFF           : DATA
2bd0 : FFFF           : DATA
2bd1 : FFFF           : DATA
2bd2 : FFFF           : DATA
2bd3 : FFFF           : DATA
2bd4 : FFFF           : DATA
2bd5 : FFFF           : DATA
2bd6 : FFFF           : DATA
2bd7 : FFFF           : DATA
2bd8 : FFFF           : DATA
2bd9 : FFFF           : DATA
2bda : FFFF           : DATA
2bdb : FFFF           : DATA
2bdc : FFFF           : DATA
2bdd : FFFF           : DATA
2bde : FFFF           : DATA
2bdf : FFFF           : DATA
2be0 : FFFF           : DATA
2be1 : FFFF           : DATA
2be2 : FFFF           : DATA
2be3 : FFFF           : DATA
2be4 : FFFF           : DATA
2be5 : FFFF           : DATA
2be6 : FFFF           : DATA
2be7 : FFFF           : DATA
2be8 : FFFF           : DATA
2be9 : FFFF           : DATA
2bea : FFFF           : DATA
2beb : FFFF           : DATA
2bec : FFFF           : DATA
2bed : FFFF           : DATA
2bee : FFFF           : DATA
2bef : FFFF           : DATA
2bf0 : FFFF           : DATA
2bf1 : FFFF           : DATA
2bf2 : FFFF           : DATA
2bf3 : FFFF           : DATA
2bf4 : FFFF           : DATA
2bf5 : FFFF           : DATA
2bf6 : FFFF           : DATA
2bf7 : FFFF           : DATA
2bf8 : FFFF           : DATA
2bf9 : FFFF           : DATA
2bfa : FFFF           : DATA
2bfb : FFFF           : DATA
2bfc : FFFF           : DATA
2bfd : FFFF           : DATA
2bfe : FFFF           : DATA
2bff : FFFF           : DATA
2c00 : FFFF           : DATA
2c01 : FFFF           : DATA
2c02 : FFFF           : DATA
2c03 : FFFF           : DATA
2c04 : FFFF           : DATA
2c05 : FFFF           : DATA
2c06 : FFFF           : DATA
2c07 : FFFF           : DATA
2c08 : FFFF           : DATA
2c09 : FFFF           : DATA
2c0a : FFFF           : DATA
2c0b : FFFF           : DATA
2c0c : FFFF           : DATA
2c0d : FFFF           : DATA
2c0e : FFFF           : DATA
2c0f : FFFF           : DATA
2c10 : FFFF           : DATA
2c11 : FFFF           : DATA
2c12 : FFFF           : DATA
2c13 : FFFF           : DATA
2c14 : FFFF           : DATA
2c15 : FFFF           : DATA
2c16 : FFFF           : DATA
2c17 : FFFF           : DATA
2c18 : FFFF           : DATA
2c19 : FFFF           : DATA
2c1a : FFFF           : DATA
2c1b : FFFF           : DATA
2c1c : FFFF           : DATA
2c1d : FFFF           : DATA
2c1e : FFFF           : DATA
2c1f : FFFF           : DATA
2c20 : FFFF           : DATA
2c21 : FFFF           : DATA
2c22 : FFFF           : DATA
2c23 : FFFF           : DATA
2c24 : FFFF           : DATA
2c25 : FFFF           : DATA
2c26 : FFFF           : DATA
2c27 : FFFF           : DATA
2c28 : FFFF           : DATA
2c29 : FFFF           : DATA
2c2a : FFFF           : DATA
2c2b : FFFF           : DATA
2c2c : FFFF           : DATA
2c2d : FFFF           : DATA
2c2e : FFFF           : DATA
2c2f : FFFF           : DATA
2c30 : FFFF           : DATA
2c31 : FFFF           : DATA
2c32 : FFFF           : DATA
2c33 : FFFF           : DATA
2c34 : FFFF           : DATA
2c35 : FFFF           : DATA
2c36 : FFFF           : DATA
2c37 : FFFF           : DATA
2c38 : FFFF           : DATA
2c39 : FFFF           : DATA
2c3a : FFFF           : DATA
2c3b : FFFF           : DATA
2c3c : FFFF           : DATA
2c3d : FFFF           : DATA
2c3e : FFFF           : DATA
2c3f : FFFF           : DATA
2c40 : FFFF           : DATA
2c41 : FFFF           : DATA
2c42 : FFFF           : DATA
2c43 : FFFF           : DATA
2c44 : FFFF           : DATA
2c45 : FFFF           : DATA
2c46 : FFFF           : DATA
2c47 : FFFF           : DATA
2c48 : FFFF           : DATA
2c49 : FFFF           : DATA
2c4a : FFFF           : DATA
2c4b : FFFF           : DATA
2c4c : FFFF           : DATA
2c4d : FFFF           : DATA
2c4e : FFFF           : DATA
2c4f : FFFF           : DATA
2c50 : FFFF           : DATA
2c51 : FFFF           : DATA
2c52 : FFFF           : DATA
2c53 : FFFF           : DATA
2c54 : FFFF           : DATA
2c55 : FFFF           : DATA
2c56 : FFFF           : DATA
2c57 : FFFF           : DATA
2c58 : FFFF           : DATA
2c59 : FFFF           : DATA
2c5a : FFFF           : DATA
2c5b : FFFF           : DATA
2c5c : FFFF           : DATA
2c5d : FFFF           : DATA
2c5e : FFFF           : DATA
2c5f : FFFF           : DATA
2c60 : FFFF           : DATA
2c61 : FFFF           : DATA
2c62 : FFFF           : DATA
2c63 : FFFF           : DATA
2c64 : FFFF           : DATA
2c65 : FFFF           : DATA
2c66 : FFFF           : DATA
2c67 : FFFF           : DATA
2c68 : FFFF           : DATA
2c69 : FFFF           : DATA
2c6a : FFFF           : DATA
2c6b : FFFF           : DATA
2c6c : FFFF           : DATA
2c6d : FFFF           : DATA
2c6e : FFFF           : DATA
2c6f : FFFF           : DATA
2c70 : FFFF           : DATA
2c71 : FFFF           : DATA
2c72 : FFFF           : DATA
2c73 : FFFF           : DATA
2c74 : FFFF           : DATA
2c75 : FFFF           : DATA
2c76 : FFFF           : DATA
2c77 : FFFF           : DATA
2c78 : FFFF           : DATA
2c79 : FFFF           : DATA
2c7a : FFFF           : DATA
2c7b : FFFF           : DATA
2c7c : FFFF           : DATA
2c7d : FFFF           : DATA
2c7e : FFFF           : DATA
2c7f : FFFF           : DATA
2c80 : FFFF           : DATA
2c81 : FFFF           : DATA
2c82 : FFFF           : DATA
2c83 : FFFF           : DATA
2c84 : FFFF           : DATA
2c85 : FFFF           : DATA
2c86 : FFFF           : DATA
2c87 : FFFF           : DATA
2c88 : FFFF           : DATA
2c89 : FFFF           : DATA
2c8a : FFFF           : DATA
2c8b : FFFF           : DATA
2c8c : FFFF           : DATA
2c8d : FFFF           : DATA
2c8e : FFFF           : DATA
2c8f : FFFF           : DATA
2c90 : FFFF           : DATA
2c91 : FFFF           : DATA
2c92 : FFFF           : DATA
2c93 : FFFF           : DATA
2c94 : FFFF           : DATA
2c95 : FFFF           : DATA
2c96 : FFFF           : DATA
2c97 : FFFF           : DATA
2c98 : FFFF           : DATA
2c99 : FFFF           : DATA
2c9a : FFFF           : DATA
2c9b : FFFF           : DATA
2c9c : FFFF           : DATA
2c9d : FFFF           : DATA
2c9e : FFFF           : DATA
2c9f : FFFF           : DATA
2ca0 : FFFF           : DATA
2ca1 : FFFF           : DATA
2ca2 : FFFF           : DATA
2ca3 : FFFF           : DATA
2ca4 : FFFF           : DATA
2ca5 : FFFF           : DATA
2ca6 : FFFF           : DATA
2ca7 : FFFF           : DATA
2ca8 : FFFF           : DATA
2ca9 : FFFF           : DATA
2caa : FFFF           : DATA
2cab : FFFF           : DATA
2cac : FFFF           : DATA
2cad : FFFF           : DATA
2cae : FFFF           : DATA
2caf : FFFF           : DATA
2cb0 : FFFF           : DATA
2cb1 : FFFF           : DATA
2cb2 : FFFF           : DATA
2cb3 : FFFF           : DATA
2cb4 : FFFF           : DATA
2cb5 : FFFF           : DATA
2cb6 : FFFF           : DATA
2cb7 : FFFF           : DATA
2cb8 : FFFF           : DATA
2cb9 : FFFF           : DATA
2cba : FFFF           : DATA
2cbb : FFFF           : DATA
2cbc : FFFF           : DATA
2cbd : FFFF           : DATA
2cbe : FFFF           : DATA
2cbf : FFFF           : DATA
2cc0 : FFFF           : DATA
2cc1 : FFFF           : DATA
2cc2 : FFFF           : DATA
2cc3 : FFFF           : DATA
2cc4 : FFFF           : DATA
2cc5 : FFFF           : DATA
2cc6 : FFFF           : DATA
2cc7 : FFFF           : DATA
2cc8 : FFFF           : DATA
2cc9 : FFFF           : DATA
2cca : FFFF           : DATA
2ccb : FFFF           : DATA
2ccc : FFFF           : DATA
2ccd : FFFF           : DATA
2cce : FFFF           : DATA
2ccf : FFFF           : DATA
2cd0 : FFFF           : DATA
2cd1 : FFFF           : DATA
2cd2 : FFFF           : DATA
2cd3 : FFFF           : DATA
2cd4 : FFFF           : DATA
2cd5 : FFFF           : DATA
2cd6 : FFFF           : DATA
2cd7 : FFFF           : DATA
2cd8 : FFFF           : DATA
2cd9 : FFFF           : DATA
2cda : FFFF           : DATA
2cdb : FFFF           : DATA
2cdc : FFFF           : DATA
2cdd : FFFF           : DATA
2cde : FFFF           : DATA
2cdf : FFFF           : DATA
2ce0 : FFFF           : DATA
2ce1 : FFFF           : DATA
2ce2 : FFFF           : DATA
2ce3 : FFFF           : DATA
2ce4 : FFFF           : DATA
2ce5 : FFFF           : DATA
2ce6 : FFFF           : DATA
2ce7 : FFFF           : DATA
2ce8 : FFFF           : DATA
2ce9 : FFFF           : DATA
2cea : FFFF           : DATA
2ceb : FFFF           : DATA
2cec : FFFF           : DATA
2ced : FFFF           : DATA
2cee : FFFF           : DATA
2cef : FFFF           : DATA
2cf0 : FFFF           : DATA
2cf1 : FFFF           : DATA
2cf2 : FFFF           : DATA
2cf3 : FFFF           : DATA
2cf4 : FFFF           : DATA
2cf5 : FFFF           : DATA
2cf6 : FFFF           : DATA
2cf7 : FFFF           : DATA
2cf8 : FFFF           : DATA
2cf9 : FFFF           : DATA
2cfa : FFFF           : DATA
2cfb : FFFF           : DATA
2cfc : FFFF           : DATA
2cfd : FFFF           : DATA
2cfe : FFFF           : DATA
2cff : FFFF           : DATA
2d00 : FFFF           : DATA
2d01 : FFFF           : DATA
2d02 : FFFF           : DATA
2d03 : FFFF           : DATA
2d04 : FFFF           : DATA
2d05 : FFFF           : DATA
2d06 : FFFF           : DATA
2d07 : FFFF           : DATA
2d08 : FFFF           : DATA
2d09 : FFFF           : DATA
2d0a : FFFF           : DATA
2d0b : FFFF           : DATA
2d0c : FFFF           : DATA
2d0d : FFFF           : DATA
2d0e : FFFF           : DATA
2d0f : FFFF           : DATA
2d10 : FFFF           : DATA
2d11 : FFFF           : DATA
2d12 : FFFF           : DATA
2d13 : FFFF           : DATA
2d14 : FFFF           : DATA
2d15 : FFFF           : DATA
2d16 : FFFF           : DATA
2d17 : FFFF           : DATA
2d18 : FFFF           : DATA
2d19 : FFFF           : DATA
2d1a : FFFF           : DATA
2d1b : FFFF           : DATA
2d1c : FFFF           : DATA
2d1d : FFFF           : DATA
2d1e : FFFF           : DATA
2d1f : FFFF           : DATA
2d20 : FFFF           : DATA
2d21 : FFFF           : DATA
2d22 : FFFF           : DATA
2d23 : FFFF           : DATA
2d24 : FFFF           : DATA
2d25 : FFFF           : DATA
2d26 : FFFF           : DATA
2d27 : FFFF           : DATA
2d28 : FFFF           : DATA
2d29 : FFFF           : DATA
2d2a : FFFF           : DATA
2d2b : FFFF           : DATA
2d2c : FFFF           : DATA
2d2d : FFFF           : DATA
2d2e : FFFF           : DATA
2d2f : FFFF           : DATA
2d30 : FFFF           : DATA
2d31 : FFFF           : DATA
2d32 : FFFF           : DATA
2d33 : FFFF           : DATA
2d34 : FFFF           : DATA
2d35 : FFFF           : DATA
2d36 : FFFF           : DATA
2d37 : FFFF           : DATA
2d38 : FFFF           : DATA
2d39 : FFFF           : DATA
2d3a : FFFF           : DATA
2d3b : FFFF           : DATA
2d3c : FFFF           : DATA
2d3d : FFFF           : DATA
2d3e : FFFF           : DATA
2d3f : FFFF           : DATA
2d40 : FFFF           : DATA
2d41 : FFFF           : DATA
2d42 : FFFF           : DATA
2d43 : FFFF           : DATA
2d44 : FFFF           : DATA
2d45 : FFFF           : DATA
2d46 : FFFF           : DATA
2d47 : FFFF           : DATA
2d48 : FFFF           : DATA
2d49 : FFFF           : DATA
2d4a : FFFF           : DATA
2d4b : FFFF           : DATA
2d4c : FFFF           : DATA
2d4d : FFFF           : DATA
2d4e : FFFF           : DATA
2d4f : FFFF           : DATA
2d50 : FFFF           : DATA
2d51 : FFFF           : DATA
2d52 : FFFF           : DATA
2d53 : FFFF           : DATA
2d54 : FFFF           : DATA
2d55 : FFFF           : DATA
2d56 : FFFF           : DATA
2d57 : FFFF           : DATA
2d58 : FFFF           : DATA
2d59 : FFFF           : DATA
2d5a : FFFF           : DATA
2d5b : FFFF           : DATA
2d5c : FFFF           : DATA
2d5d : FFFF           : DATA
2d5e : FFFF           : DATA
2d5f : FFFF           : DATA
2d60 : FFFF           : DATA
2d61 : FFFF           : DATA
2d62 : FFFF           : DATA
2d63 : FFFF           : DATA
2d64 : FFFF           : DATA
2d65 : FFFF           : DATA
2d66 : FFFF           : DATA
2d67 : FFFF           : DATA
2d68 : FFFF           : DATA
2d69 : FFFF           : DATA
2d6a : FFFF           : DATA
2d6b : FFFF           : DATA
2d6c : FFFF           : DATA
2d6d : FFFF           : DATA
2d6e : FFFF           : DATA
2d6f : FFFF           : DATA
2d70 : FFFF           : DATA
2d71 : FFFF           : DATA
2d72 : FFFF           : DATA
2d73 : FFFF           : DATA
2d74 : FFFF           : DATA
2d75 : FFFF           : DATA
2d76 : FFFF           : DATA
2d77 : FFFF           : DATA
2d78 : FFFF           : DATA
2d79 : FFFF           : DATA
2d7a : FFFF           : DATA
2d7b : FFFF           : DATA
2d7c : FFFF           : DATA
2d7d : FFFF           : DATA
2d7e : FFFF           : DATA
2d7f : FFFF           : DATA
2d80 : FFFF           : DATA
2d81 : FFFF           : DATA
2d82 : FFFF           : DATA
2d83 : FFFF           : DATA
2d84 : FFFF           : DATA
2d85 : FFFF           : DATA
2d86 : FFFF           : DATA
2d87 : FFFF           : DATA
2d88 : FFFF           : DATA
2d89 : FFFF           : DATA
2d8a : FFFF           : DATA
2d8b : FFFF           : DATA
2d8c : FFFF           : DATA
2d8d : FFFF           : DATA
2d8e : FFFF           : DATA
2d8f : FFFF           : DATA
2d90 : FFFF           : DATA
2d91 : FFFF           : DATA
2d92 : FFFF           : DATA
2d93 : FFFF           : DATA
2d94 : FFFF           : DATA
2d95 : FFFF           : DATA
2d96 : FFFF           : DATA
2d97 : FFFF           : DATA
2d98 : FFFF           : DATA
2d99 : FFFF           : DATA
2d9a : FFFF           : DATA
2d9b : FFFF           : DATA
2d9c : FFFF           : DATA
2d9d : FFFF           : DATA
2d9e : FFFF           : DATA
2d9f : FFFF           : DATA
2da0 : FFFF           : DATA
2da1 : FFFF           : DATA
2da2 : FFFF           : DATA
2da3 : FFFF           : DATA
2da4 : FFFF           : DATA
2da5 : FFFF           : DATA
2da6 : FFFF           : DATA
2da7 : FFFF           : DATA
2da8 : FFFF           : DATA
2da9 : FFFF           : DATA
2daa : FFFF           : DATA
2dab : FFFF           : DATA
2dac : FFFF           : DATA
2dad : FFFF           : DATA
2dae : FFFF           : DATA
2daf : FFFF           : DATA
2db0 : FFFF           : DATA
2db1 : FFFF           : DATA
2db2 : FFFF           : DATA
2db3 : FFFF           : DATA
2db4 : FFFF           : DATA
2db5 : FFFF           : DATA
2db6 : FFFF           : DATA
2db7 : FFFF           : DATA
2db8 : FFFF           : DATA
2db9 : FFFF           : DATA
2dba : FFFF           : DATA
2dbb : FFFF           : DATA
2dbc : FFFF           : DATA
2dbd : FFFF           : DATA
2dbe : FFFF           : DATA
2dbf : FFFF           : DATA
2dc0 : FFFF           : DATA
2dc1 : FFFF           : DATA
2dc2 : FFFF           : DATA
2dc3 : FFFF           : DATA
2dc4 : FFFF           : DATA
2dc5 : FFFF           : DATA
2dc6 : FFFF           : DATA
2dc7 : FFFF           : DATA
2dc8 : FFFF           : DATA
2dc9 : FFFF           : DATA
2dca : FFFF           : DATA
2dcb : FFFF           : DATA
2dcc : FFFF           : DATA
2dcd : FFFF           : DATA
2dce : FFFF           : DATA
2dcf : FFFF           : DATA
2dd0 : FFFF           : DATA
2dd1 : FFFF           : DATA
2dd2 : FFFF           : DATA
2dd3 : FFFF           : DATA
2dd4 : FFFF           : DATA
2dd5 : FFFF           : DATA
2dd6 : FFFF           : DATA
2dd7 : FFFF           : DATA
2dd8 : FFFF           : DATA
2dd9 : FFFF           : DATA
2dda : FFFF           : DATA
2ddb : FFFF           : DATA
2ddc : FFFF           : DATA
2ddd : FFFF           : DATA
2dde : FFFF           : DATA
2ddf : FFFF           : DATA
2de0 : FFFF           : DATA
2de1 : FFFF           : DATA
2de2 : FFFF           : DATA
2de3 : FFFF           : DATA
2de4 : FFFF           : DATA
2de5 : FFFF           : DATA
2de6 : FFFF           : DATA
2de7 : FFFF           : DATA
2de8 : FFFF           : DATA
2de9 : FFFF           : DATA
2dea : FFFF           : DATA
2deb : FFFF           : DATA
2dec : FFFF           : DATA
2ded : FFFF           : DATA
2dee : FFFF           : DATA
2def : FFFF           : DATA
2df0 : FFFF           : DATA
2df1 : FFFF           : DATA
2df2 : FFFF           : DATA
2df3 : FFFF           : DATA
2df4 : FFFF           : DATA
2df5 : FFFF           : DATA
2df6 : FFFF           : DATA
2df7 : FFFF           : DATA
2df8 : FFFF           : DATA
2df9 : FFFF           : DATA
2dfa : FFFF           : DATA
2dfb : FFFF           : DATA
2dfc : FFFF           : DATA
2dfd : FFFF           : DATA
2dfe : FFFF           : DATA
2dff : FFFF           : DATA
2e00 : FFFF           : DATA
2e01 : FFFF           : DATA
2e02 : FFFF           : DATA
2e03 : FFFF           : DATA
2e04 : FFFF           : DATA
2e05 : FFFF           : DATA
2e06 : FFFF           : DATA
2e07 : FFFF           : DATA
2e08 : FFFF           : DATA
2e09 : FFFF           : DATA
2e0a : FFFF           : DATA
2e0b : FFFF           : DATA
2e0c : FFFF           : DATA
2e0d : FFFF           : DATA
2e0e : FFFF           : DATA
2e0f : FFFF           : DATA
2e10 : FFFF           : DATA
2e11 : FFFF           : DATA
2e12 : FFFF           : DATA
2e13 : FFFF           : DATA
2e14 : FFFF           : DATA
2e15 : FFFF           : DATA
2e16 : FFFF           : DATA
2e17 : FFFF           : DATA
2e18 : FFFF           : DATA
2e19 : FFFF           : DATA
2e1a : FFFF           : DATA
2e1b : FFFF           : DATA
2e1c : FFFF           : DATA
2e1d : FFFF           : DATA
2e1e : FFFF           : DATA
2e1f : FFFF           : DATA
2e20 : FFFF           : DATA
2e21 : FFFF           : DATA
2e22 : FFFF           : DATA
2e23 : FFFF           : DATA
2e24 : FFFF           : DATA
2e25 : FFFF           : DATA
2e26 : FFFF           : DATA
2e27 : FFFF           : DATA
2e28 : FFFF           : DATA
2e29 : FFFF           : DATA
2e2a : FFFF           : DATA
2e2b : FFFF           : DATA
2e2c : FFFF           : DATA
2e2d : FFFF           : DATA
2e2e : FFFF           : DATA
2e2f : FFFF           : DATA
2e30 : FFFF           : DATA
2e31 : FFFF           : DATA
2e32 : FFFF           : DATA
2e33 : FFFF           : DATA
2e34 : FFFF           : DATA
2e35 : FFFF           : DATA
2e36 : FFFF           : DATA
2e37 : FFFF           : DATA
2e38 : FFFF           : DATA
2e39 : FFFF           : DATA
2e3a : FFFF           : DATA
2e3b : FFFF           : DATA
2e3c : FFFF           : DATA
2e3d : FFFF           : DATA
2e3e : FFFF           : DATA
2e3f : FFFF           : DATA
2e40 : FFFF           : DATA
2e41 : FFFF           : DATA
2e42 : FFFF           : DATA
2e43 : FFFF           : DATA
2e44 : FFFF           : DATA
2e45 : FFFF           : DATA
2e46 : FFFF           : DATA
2e47 : FFFF           : DATA
2e48 : FFFF           : DATA
2e49 : FFFF           : DATA
2e4a : FFFF           : DATA
2e4b : FFFF           : DATA
2e4c : FFFF           : DATA
2e4d : FFFF           : DATA
2e4e : FFFF           : DATA
2e4f : FFFF           : DATA
2e50 : FFFF           : DATA
2e51 : FFFF           : DATA
2e52 : FFFF           : DATA
2e53 : FFFF           : DATA
2e54 : FFFF           : DATA
2e55 : FFFF           : DATA
2e56 : FFFF           : DATA
2e57 : FFFF           : DATA
2e58 : FFFF           : DATA
2e59 : FFFF           : DATA
2e5a : FFFF           : DATA
2e5b : FFFF           : DATA
2e5c : FFFF           : DATA
2e5d : FFFF           : DATA
2e5e : FFFF           : DATA
2e5f : FFFF           : DATA
2e60 : FFFF           : DATA
2e61 : FFFF           : DATA
2e62 : FFFF           : DATA
2e63 : FFFF           : DATA
2e64 : FFFF           : DATA
2e65 : FFFF           : DATA
2e66 : FFFF           : DATA
2e67 : FFFF           : DATA
2e68 : FFFF           : DATA
2e69 : FFFF           : DATA
2e6a : FFFF           : DATA
2e6b : FFFF           : DATA
2e6c : FFFF           : DATA
2e6d : FFFF           : DATA
2e6e : FFFF           : DATA
2e6f : FFFF           : DATA
2e70 : FFFF           : DATA
2e71 : FFFF           : DATA
2e72 : FFFF           : DATA
2e73 : FFFF           : DATA
2e74 : FFFF           : DATA
2e75 : FFFF           : DATA
2e76 : FFFF           : DATA
2e77 : FFFF           : DATA
2e78 : FFFF           : DATA
2e79 : FFFF           : DATA
2e7a : FFFF           : DATA
2e7b : FFFF           : DATA
2e7c : FFFF           : DATA
2e7d : FFFF           : DATA
2e7e : FFFF           : DATA
2e7f : FFFF           : DATA
2e80 : FFFF           : DATA
2e81 : FFFF           : DATA
2e82 : FFFF           : DATA
2e83 : FFFF           : DATA
2e84 : FFFF           : DATA
2e85 : FFFF           : DATA
2e86 : FFFF           : DATA
2e87 : FFFF           : DATA
2e88 : FFFF           : DATA
2e89 : FFFF           : DATA
2e8a : FFFF           : DATA
2e8b : FFFF           : DATA
2e8c : FFFF           : DATA
2e8d : FFFF           : DATA
2e8e : FFFF           : DATA
2e8f : FFFF           : DATA
2e90 : FFFF           : DATA
2e91 : FFFF           : DATA
2e92 : FFFF           : DATA
2e93 : FFFF           : DATA
2e94 : FFFF           : DATA
2e95 : FFFF           : DATA
2e96 : FFFF           : DATA
2e97 : FFFF           : DATA
2e98 : FFFF           : DATA
2e99 : FFFF           : DATA
2e9a : FFFF           : DATA
2e9b : FFFF           : DATA
2e9c : FFFF           : DATA
2e9d : FFFF           : DATA
2e9e : FFFF           : DATA
2e9f : FFFF           : DATA
2ea0 : FFFF           : DATA
2ea1 : FFFF           : DATA
2ea2 : FFFF           : DATA
2ea3 : FFFF           : DATA
2ea4 : FFFF           : DATA
2ea5 : FFFF           : DATA
2ea6 : FFFF           : DATA
2ea7 : FFFF           : DATA
2ea8 : FFFF           : DATA
2ea9 : FFFF           : DATA
2eaa : FFFF           : DATA
2eab : FFFF           : DATA
2eac : FFFF           : DATA
2ead : FFFF           : DATA
2eae : FFFF           : DATA
2eaf : FFFF           : DATA
2eb0 : FFFF           : DATA
2eb1 : FFFF           : DATA
2eb2 : FFFF           : DATA
2eb3 : FFFF           : DATA
2eb4 : FFFF           : DATA
2eb5 : FFFF           : DATA
2eb6 : FFFF           : DATA
2eb7 : FFFF           : DATA
2eb8 : FFFF           : DATA
2eb9 : FFFF           : DATA
2eba : FFFF           : DATA
2ebb : FFFF           : DATA
2ebc : FFFF           : DATA
2ebd : FFFF           : DATA
2ebe : FFFF           : DATA
2ebf : FFFF           : DATA
2ec0 : FFFF           : DATA
2ec1 : FFFF           : DATA
2ec2 : FFFF           : DATA
2ec3 : FFFF           : DATA
2ec4 : FFFF           : DATA
2ec5 : FFFF           : DATA
2ec6 : FFFF           : DATA
2ec7 : FFFF           : DATA
2ec8 : FFFF           : DATA
2ec9 : FFFF           : DATA
2eca : FFFF           : DATA
2ecb : FFFF           : DATA
2ecc : FFFF           : DATA
2ecd : FFFF           : DATA
2ece : FFFF           : DATA
2ecf : FFFF           : DATA
2ed0 : FFFF           : DATA
2ed1 : FFFF           : DATA
2ed2 : FFFF           : DATA
2ed3 : FFFF           : DATA
2ed4 : FFFF           : DATA
2ed5 : FFFF           : DATA
2ed6 : FFFF           : DATA
2ed7 : FFFF           : DATA
2ed8 : FFFF           : DATA
2ed9 : FFFF           : DATA
2eda : FFFF           : DATA
2edb : FFFF           : DATA
2edc : FFFF           : DATA
2edd : FFFF           : DATA
2ede : FFFF           : DATA
2edf : FFFF           : DATA
2ee0 : FFFF           : DATA
2ee1 : FFFF           : DATA
2ee2 : FFFF           : DATA
2ee3 : FFFF           : DATA
2ee4 : FFFF           : DATA
2ee5 : FFFF           : DATA
2ee6 : FFFF           : DATA
2ee7 : FFFF           : DATA
2ee8 : FFFF           : DATA
2ee9 : FFFF           : DATA
2eea : FFFF           : DATA
2eeb : FFFF           : DATA
2eec : FFFF           : DATA
2eed : FFFF           : DATA
2eee : FFFF           : DATA
2eef : FFFF           : DATA
2ef0 : FFFF           : DATA
2ef1 : FFFF           : DATA
2ef2 : FFFF           : DATA
2ef3 : FFFF           : DATA
2ef4 : FFFF           : DATA
2ef5 : FFFF           : DATA
2ef6 : FFFF           : DATA
2ef7 : FFFF           : DATA
2ef8 : FFFF           : DATA
2ef9 : FFFF           : DATA
2efa : FFFF           : DATA
2efb : FFFF           : DATA
2efc : FFFF           : DATA
2efd : FFFF           : DATA
2efe : FFFF           : DATA
2eff : FFFF           : DATA
2f00 : FFFF           : DATA
2f01 : FFFF           : DATA
2f02 : FFFF           : DATA
2f03 : FFFF           : DATA
2f04 : FFFF           : DATA
2f05 : FFFF           : DATA
2f06 : FFFF           : DATA
2f07 : FFFF           : DATA
2f08 : FFFF           : DATA
2f09 : FFFF           : DATA
2f0a : FFFF           : DATA
2f0b : FFFF           : DATA
2f0c : FFFF           : DATA
2f0d : FFFF           : DATA
2f0e : FFFF           : DATA
2f0f : FFFF           : DATA
2f10 : FFFF           : DATA
2f11 : FFFF           : DATA
2f12 : FFFF           : DATA
2f13 : FFFF           : DATA
2f14 : FFFF           : DATA
2f15 : FFFF           : DATA
2f16 : FFFF           : DATA
2f17 : FFFF           : DATA
2f18 : FFFF           : DATA
2f19 : FFFF           : DATA
2f1a : FFFF           : DATA
2f1b : FFFF           : DATA
2f1c : FFFF           : DATA
2f1d : FFFF           : DATA
2f1e : FFFF           : DATA
2f1f : FFFF           : DATA
2f20 : FFFF           : DATA
2f21 : FFFF           : DATA
2f22 : FFFF           : DATA
2f23 : FFFF           : DATA
2f24 : FFFF           : DATA
2f25 : FFFF           : DATA
2f26 : FFFF           : DATA
2f27 : FFFF           : DATA
2f28 : FFFF           : DATA
2f29 : FFFF           : DATA
2f2a : FFFF           : DATA
2f2b : FFFF           : DATA
2f2c : FFFF           : DATA
2f2d : FFFF           : DATA
2f2e : FFFF           : DATA
2f2f : FFFF           : DATA
2f30 : FFFF           : DATA
2f31 : FFFF           : DATA
2f32 : FFFF           : DATA
2f33 : FFFF           : DATA
2f34 : FFFF           : DATA
2f35 : FFFF           : DATA
2f36 : FFFF           : DATA
2f37 : FFFF           : DATA
2f38 : FFFF           : DATA
2f39 : FFFF           : DATA
2f3a : FFFF           : DATA
2f3b : FFFF           : DATA
2f3c : FFFF           : DATA
2f3d : FFFF           : DATA
2f3e : FFFF           : DATA
2f3f : FFFF           : DATA
2f40 : FFFF           : DATA
2f41 : FFFF           : DATA
2f42 : FFFF           : DATA
2f43 : FFFF           : DATA
2f44 : FFFF           : DATA
2f45 : FFFF           : DATA
2f46 : FFFF           : DATA
2f47 : FFFF           : DATA
2f48 : FFFF           : DATA
2f49 : FFFF           : DATA
2f4a : FFFF           : DATA
2f4b : FFFF           : DATA
2f4c : FFFF           : DATA
2f4d : FFFF           : DATA
2f4e : FFFF           : DATA
2f4f : FFFF           : DATA
2f50 : FFFF           : DATA
2f51 : FFFF           : DATA
2f52 : FFFF           : DATA
2f53 : FFFF           : DATA
2f54 : FFFF           : DATA
2f55 : FFFF           : DATA
2f56 : FFFF           : DATA
2f57 : FFFF           : DATA
2f58 : FFFF           : DATA
2f59 : FFFF           : DATA
2f5a : FFFF           : DATA
2f5b : FFFF           : DATA
2f5c : FFFF           : DATA
2f5d : FFFF           : DATA
2f5e : FFFF           : DATA
2f5f : FFFF           : DATA
2f60 : FFFF           : DATA
2f61 : FFFF           : DATA
2f62 : FFFF           : DATA
2f63 : FFFF           : DATA
2f64 : FFFF           : DATA
2f65 : FFFF           : DATA
2f66 : FFFF           : DATA
2f67 : FFFF           : DATA
2f68 : FFFF           : DATA
2f69 : FFFF           : DATA
2f6a : FFFF           : DATA
2f6b : FFFF           : DATA
2f6c : FFFF           : DATA
2f6d : FFFF           : DATA
2f6e : FFFF           : DATA
2f6f : FFFF           : DATA
2f70 : FFFF           : DATA
2f71 : FFFF           : DATA
2f72 : FFFF           : DATA
2f73 : FFFF           : DATA
2f74 : FFFF           : DATA
2f75 : FFFF           : DATA
2f76 : FFFF           : DATA
2f77 : FFFF           : DATA
2f78 : FFFF           : DATA
2f79 : FFFF           : DATA
2f7a : FFFF           : DATA
2f7b : FFFF           : DATA
2f7c : FFFF           : DATA
2f7d : FFFF           : DATA
2f7e : FFFF           : DATA
2f7f : FFFF           : DATA
2f80 : FFFF           : DATA
2f81 : FFFF           : DATA
2f82 : FFFF           : DATA
2f83 : FFFF           : DATA
2f84 : FFFF           : DATA
2f85 : FFFF           : DATA
2f86 : FFFF           : DATA
2f87 : FFFF           : DATA
2f88 : FFFF           : DATA
2f89 : FFFF           : DATA
2f8a : FFFF           : DATA
2f8b : FFFF           : DATA
2f8c : FFFF           : DATA
2f8d : FFFF           : DATA
2f8e : FFFF           : DATA
2f8f : FFFF           : DATA
2f90 : FFFF           : DATA
2f91 : FFFF           : DATA
2f92 : FFFF           : DATA
2f93 : FFFF           : DATA
2f94 : FFFF           : DATA
2f95 : FFFF           : DATA
2f96 : FFFF           : DATA
2f97 : FFFF           : DATA
2f98 : FFFF           : DATA
2f99 : FFFF           : DATA
2f9a : FFFF           : DATA
2f9b : FFFF           : DATA
2f9c : FFFF           : DATA
2f9d : FFFF           : DATA
2f9e : FFFF           : DATA
2f9f : FFFF           : DATA
2fa0 : FFFF           : DATA
2fa1 : FFFF           : DATA
2fa2 : FFFF           : DATA
2fa3 : FFFF           : DATA
2fa4 : FFFF           : DATA
2fa5 : FFFF           : DATA
2fa6 : FFFF           : DATA
2fa7 : FFFF           : DATA
2fa8 : FFFF           : DATA
2fa9 : FFFF           : DATA
2faa : FFFF           : DATA
2fab : FFFF           : DATA
2fac : FFFF           : DATA
2fad : FFFF           : DATA
2fae : FFFF           : DATA
2faf : FFFF           : DATA
2fb0 : FFFF           : DATA
2fb1 : FFFF           : DATA
2fb2 : FFFF           : DATA
2fb3 : FFFF           : DATA
2fb4 : FFFF           : DATA
2fb5 : FFFF           : DATA
2fb6 : FFFF           : DATA
2fb7 : FFFF           : DATA
2fb8 : FFFF           : DATA
2fb9 : FFFF           : DATA
2fba : FFFF           : DATA
2fbb : FFFF           : DATA
2fbc : FFFF           : DATA
2fbd : FFFF           : DATA
2fbe : FFFF           : DATA
2fbf : FFFF           : DATA
2fc0 : FFFF           : DATA
2fc1 : FFFF           : DATA
2fc2 : FFFF           : DATA
2fc3 : FFFF           : DATA
2fc4 : FFFF           : DATA
2fc5 : FFFF           : DATA
2fc6 : FFFF           : DATA
2fc7 : FFFF           : DATA
2fc8 : FFFF           : DATA
2fc9 : FFFF           : DATA
2fca : FFFF           : DATA
2fcb : FFFF           : DATA
2fcc : FFFF           : DATA
2fcd : FFFF           : DATA
2fce : FFFF           : DATA
2fcf : FFFF           : DATA
2fd0 : FFFF           : DATA
2fd1 : FFFF           : DATA
2fd2 : FFFF           : DATA
2fd3 : FFFF           : DATA
2fd4 : FFFF           : DATA
2fd5 : FFFF           : DATA
2fd6 : FFFF           : DATA
2fd7 : FFFF           : DATA
2fd8 : FFFF           : DATA
2fd9 : FFFF           : DATA
2fda : FFFF           : DATA
2fdb : FFFF           : DATA
2fdc : FFFF           : DATA
2fdd : FFFF           : DATA
2fde : FFFF           : DATA
2fdf : FFFF           : DATA
2fe0 : FFFF           : DATA
2fe1 : FFFF           : DATA
2fe2 : FFFF           : DATA
2fe3 : FFFF           : DATA
2fe4 : FFFF           : DATA
2fe5 : FFFF           : DATA
2fe6 : FFFF           : DATA
2fe7 : FFFF           : DATA
2fe8 : FFFF           : DATA
2fe9 : FFFF           : DATA
2fea : FFFF           : DATA
2feb : FFFF           : DATA
2fec : FFFF           : DATA
2fed : FFFF           : DATA
2fee : FFFF           : DATA
2fef : FFFF           : DATA
2ff0 : FFFF           : DATA
2ff1 : FFFF           : DATA
2ff2 : FFFF           : DATA
2ff3 : FFFF           : DATA
2ff4 : FFFF           : DATA
2ff5 : FFFF           : DATA
2ff6 : FFFF           : DATA
2ff7 : FFFF           : DATA
2ff8 : FFFF           : DATA
2ff9 : FFFF           : DATA
2ffa : FFFF           : DATA
2ffb : FFFF           : DATA
2ffc : FFFF           : DATA
2ffd : FFFF           : DATA
2ffe : FFFF           : DATA
2fff : FFFF           : DATA
3000 : FFFF           : DATA
3001 : FFFF           : DATA
3002 : FFFF           : DATA
3003 : FFFF           : DATA
3004 : FFFF           : DATA
3005 : FFFF           : DATA
3006 : FFFF           : DATA
3007 : FFFF           : DATA
3008 : FFFF           : DATA
3009 : FFFF           : DATA
300a : FFFF           : DATA
300b : FFFF           : DATA
300c : FFFF           : DATA
300d : FFFF           : DATA
300e : FFFF           : DATA
300f : FFFF           : DATA
3010 : FFFF           : DATA
3011 : FFFF           : DATA
3012 : FFFF           : DATA
3013 : FFFF           : DATA
3014 : FFFF           : DATA
3015 : FFFF           : DATA
3016 : FFFF           : DATA
3017 : FFFF           : DATA
3018 : FFFF           : DATA
3019 : FFFF           : DATA
301a : FFFF           : DATA
301b : FFFF           : DATA
301c : FFFF           : DATA
301d : FFFF           : DATA
301e : FFFF           : DATA
301f : FFFF           : DATA
3020 : FFFF           : DATA
3021 : FFFF           : DATA
3022 : FFFF           : DATA
3023 : FFFF           : DATA
3024 : FFFF           : DATA
3025 : FFFF           : DATA
3026 : FFFF           : DATA
3027 : FFFF           : DATA
3028 : FFFF           : DATA
3029 : FFFF           : DATA
302a : FFFF           : DATA
302b : FFFF           : DATA
302c : FFFF           : DATA
302d : FFFF           : DATA
302e : FFFF           : DATA
302f : FFFF           : DATA
3030 : FFFF           : DATA
3031 : FFFF           : DATA
3032 : FFFF           : DATA
3033 : FFFF           : DATA
3034 : FFFF           : DATA
3035 : FFFF           : DATA
3036 : FFFF           : DATA
3037 : FFFF           : DATA
3038 : FFFF           : DATA
3039 : FFFF           : DATA
303a : FFFF           : DATA
303b : FFFF           : DATA
303c : FFFF           : DATA
303d : FFFF           : DATA
303e : FFFF           : DATA
303f : FFFF           : DATA
3040 : FFFF           : DATA
3041 : FFFF           : DATA
3042 : FFFF           : DATA
3043 : FFFF           : DATA
3044 : FFFF           : DATA
3045 : FFFF           : DATA
3046 : FFFF           : DATA
3047 : FFFF           : DATA
3048 : FFFF           : DATA
3049 : FFFF           : DATA
304a : FFFF           : DATA
304b : FFFF           : DATA
304c : FFFF           : DATA
304d : FFFF           : DATA
304e : FFFF           : DATA
304f : FFFF           : DATA
3050 : FFFF           : DATA
3051 : FFFF           : DATA
3052 : FFFF           : DATA
3053 : FFFF           : DATA
3054 : FFFF           : DATA
3055 : FFFF           : DATA
3056 : FFFF           : DATA
3057 : FFFF           : DATA
3058 : FFFF           : DATA
3059 : FFFF           : DATA
305a : FFFF           : DATA
305b : FFFF           : DATA
305c : FFFF           : DATA
305d : FFFF           : DATA
305e : FFFF           : DATA
305f : FFFF           : DATA
3060 : FFFF           : DATA
3061 : FFFF           : DATA
3062 : FFFF           : DATA
3063 : FFFF           : DATA
3064 : FFFF           : DATA
3065 : FFFF           : DATA
3066 : FFFF           : DATA
3067 : FFFF           : DATA
3068 : FFFF           : DATA
3069 : FFFF           : DATA
306a : FFFF           : DATA
306b : FFFF           : DATA
306c : FFFF           : DATA
306d : FFFF           : DATA
306e : FFFF           : DATA
306f : FFFF           : DATA
3070 : FFFF           : DATA
3071 : FFFF           : DATA
3072 : FFFF           : DATA
3073 : FFFF           : DATA
3074 : FFFF           : DATA
3075 : FFFF           : DATA
3076 : FFFF           : DATA
3077 : FFFF           : DATA
3078 : FFFF           : DATA
3079 : FFFF           : DATA
307a : FFFF           : DATA
307b : FFFF           : DATA
307c : FFFF           : DATA
307d : FFFF           : DATA
307e : FFFF           : DATA
307f : FFFF           : DATA
3080 : FFFF           : DATA
3081 : FFFF           : DATA
3082 : FFFF           : DATA
3083 : FFFF           : DATA
3084 : FFFF           : DATA
3085 : FFFF           : DATA
3086 : FFFF           : DATA
3087 : FFFF           : DATA
3088 : FFFF           : DATA
3089 : FFFF           : DATA
308a : FFFF           : DATA
308b : FFFF           : DATA
308c : FFFF           : DATA
308d : FFFF           : DATA
308e : FFFF           : DATA
308f : FFFF           : DATA
3090 : FFFF           : DATA
3091 : FFFF           : DATA
3092 : FFFF           : DATA
3093 : FFFF           : DATA
3094 : FFFF           : DATA
3095 : FFFF           : DATA
3096 : FFFF           : DATA
3097 : FFFF           : DATA
3098 : FFFF           : DATA
3099 : FFFF           : DATA
309a : FFFF           : DATA
309b : FFFF           : DATA
309c : FFFF           : DATA
309d : FFFF           : DATA
309e : FFFF           : DATA
309f : FFFF           : DATA
30a0 : FFFF           : DATA
30a1 : FFFF           : DATA
30a2 : FFFF           : DATA
30a3 : FFFF           : DATA
30a4 : FFFF           : DATA
30a5 : FFFF           : DATA
30a6 : FFFF           : DATA
30a7 : FFFF           : DATA
30a8 : FFFF           : DATA
30a9 : FFFF           : DATA
30aa : FFFF           : DATA
30ab : FFFF           : DATA
30ac : FFFF           : DATA
30ad : FFFF           : DATA
30ae : FFFF           : DATA
30af : FFFF           : DATA
30b0 : FFFF           : DATA
30b1 : FFFF           : DATA
30b2 : FFFF           : DATA
30b3 : FFFF           : DATA
30b4 : FFFF           : DATA
30b5 : FFFF           : DATA
30b6 : FFFF           : DATA
30b7 : FFFF           : DATA
30b8 : FFFF           : DATA
30b9 : FFFF           : DATA
30ba : FFFF           : DATA
30bb : FFFF           : DATA
30bc : FFFF           : DATA
30bd : FFFF           : DATA
30be : FFFF           : DATA
30bf : FFFF           : DATA
30c0 : FFFF           : DATA
30c1 : FFFF           : DATA
30c2 : FFFF           : DATA
30c3 : FFFF           : DATA
30c4 : FFFF           : DATA
30c5 : FFFF           : DATA
30c6 : FFFF           : DATA
30c7 : FFFF           : DATA
30c8 : FFFF           : DATA
30c9 : FFFF           : DATA
30ca : FFFF           : DATA
30cb : FFFF           : DATA
30cc : FFFF           : DATA
30cd : FFFF           : DATA
30ce : FFFF           : DATA
30cf : FFFF           : DATA
30d0 : FFFF           : DATA
30d1 : FFFF           : DATA
30d2 : FFFF           : DATA
30d3 : FFFF           : DATA
30d4 : FFFF           : DATA
30d5 : FFFF           : DATA
30d6 : FFFF           : DATA
30d7 : FFFF           : DATA
30d8 : FFFF           : DATA
30d9 : FFFF           : DATA
30da : FFFF           : DATA
30db : FFFF           : DATA
30dc : FFFF           : DATA
30dd : FFFF           : DATA
30de : FFFF           : DATA
30df : FFFF           : DATA
30e0 : FFFF           : DATA
30e1 : FFFF           : DATA
30e2 : FFFF           : DATA
30e3 : FFFF           : DATA
30e4 : FFFF           : DATA
30e5 : FFFF           : DATA
30e6 : FFFF           : DATA
30e7 : FFFF           : DATA
30e8 : FFFF           : DATA
30e9 : FFFF           : DATA
30ea : FFFF           : DATA
30eb : FFFF           : DATA
30ec : FFFF           : DATA
30ed : FFFF           : DATA
30ee : FFFF           : DATA
30ef : FFFF           : DATA
30f0 : FFFF           : DATA
30f1 : FFFF           : DATA
30f2 : FFFF           : DATA
30f3 : FFFF           : DATA
30f4 : FFFF           : DATA
30f5 : FFFF           : DATA
30f6 : FFFF           : DATA
30f7 : FFFF           : DATA
30f8 : FFFF           : DATA
30f9 : FFFF           : DATA
30fa : FFFF           : DATA
30fb : FFFF           : DATA
30fc : FFFF           : DATA
30fd : FFFF           : DATA
30fe : FFFF           : DATA
30ff : FFFF           : DATA
3100 : FFFF           : DATA
3101 : FFFF           : DATA
3102 : FFFF           : DATA
3103 : FFFF           : DATA
3104 : FFFF           : DATA
3105 : FFFF           : DATA
3106 : FFFF           : DATA
3107 : FFFF           : DATA
3108 : FFFF           : DATA
3109 : FFFF           : DATA
310a : FFFF           : DATA
310b : FFFF           : DATA
310c : FFFF           : DATA
310d : FFFF           : DATA
310e : FFFF           : DATA
310f : FFFF           : DATA
3110 : FFFF           : DATA
3111 : FFFF           : DATA
3112 : FFFF           : DATA
3113 : FFFF           : DATA
3114 : FFFF           : DATA
3115 : FFFF           : DATA
3116 : FFFF           : DATA
3117 : FFFF           : DATA
3118 : FFFF           : DATA
3119 : FFFF           : DATA
311a : FFFF           : DATA
311b : FFFF           : DATA
311c : FFFF           : DATA
311d : FFFF           : DATA
311e : FFFF           : DATA
311f : FFFF           : DATA
3120 : FFFF           : DATA
3121 : FFFF           : DATA
3122 : FFFF           : DATA
3123 : FFFF           : DATA
3124 : FFFF           : DATA
3125 : FFFF           : DATA
3126 : FFFF           : DATA
3127 : FFFF           : DATA
3128 : FFFF           : DATA
3129 : FFFF           : DATA
312a : FFFF           : DATA
312b : FFFF           : DATA
312c : FFFF           : DATA
312d : FFFF           : DATA
312e : FFFF           : DATA
312f : FFFF           : DATA
3130 : FFFF           : DATA
3131 : FFFF           : DATA
3132 : FFFF           : DATA
3133 : FFFF           : DATA
3134 : FFFF           : DATA
3135 : FFFF           : DATA
3136 : FFFF           : DATA
3137 : FFFF           : DATA
3138 : FFFF           : DATA
3139 : FFFF           : DATA
313a : FFFF           : DATA
313b : FFFF           : DATA
313c : FFFF           : DATA
313d : FFFF           : DATA
313e : FFFF           : DATA
313f : FFFF           : DATA
3140 : FFFF           : DATA
3141 : FFFF           : DATA
3142 : FFFF           : DATA
3143 : FFFF           : DATA
3144 : FFFF           : DATA
3145 : FFFF           : DATA
3146 : FFFF           : DATA
3147 : FFFF           : DATA
3148 : FFFF           : DATA
3149 : FFFF           : DATA
314a : FFFF           : DATA
314b : FFFF           : DATA
314c : FFFF           : DATA
314d : FFFF           : DATA
314e : FFFF           : DATA
314f : FFFF           : DATA
3150 : FFFF           : DATA
3151 : FFFF           : DATA
3152 : FFFF           : DATA
3153 : FFFF           : DATA
3154 : FFFF           : DATA
3155 : FFFF           : DATA
3156 : FFFF           : DATA
3157 : FFFF           : DATA
3158 : FFFF           : DATA
3159 : FFFF           : DATA
315a : FFFF           : DATA
315b : FFFF           : DATA
315c : FFFF           : DATA
315d : FFFF           : DATA
315e : FFFF           : DATA
315f : FFFF           : DATA
3160 : FFFF           : DATA
3161 : FFFF           : DATA
3162 : FFFF           : DATA
3163 : FFFF           : DATA
3164 : FFFF           : DATA
3165 : FFFF           : DATA
3166 : FFFF           : DATA
3167 : FFFF           : DATA
3168 : FFFF           : DATA
3169 : FFFF           : DATA
316a : FFFF           : DATA
316b : FFFF           : DATA
316c : FFFF           : DATA
316d : FFFF           : DATA
316e : FFFF           : DATA
316f : FFFF           : DATA
3170 : FFFF           : DATA
3171 : FFFF           : DATA
3172 : FFFF           : DATA
3173 : FFFF           : DATA
3174 : FFFF           : DATA
3175 : FFFF           : DATA
3176 : FFFF           : DATA
3177 : FFFF           : DATA
3178 : FFFF           : DATA
3179 : FFFF           : DATA
317a : FFFF           : DATA
317b : FFFF           : DATA
317c : FFFF           : DATA
317d : FFFF           : DATA
317e : FFFF           : DATA
317f : FFFF           : DATA
3180 : FFFF           : DATA
3181 : FFFF           : DATA
3182 : FFFF           : DATA
3183 : FFFF           : DATA
3184 : FFFF           : DATA
3185 : FFFF           : DATA
3186 : FFFF           : DATA
3187 : FFFF           : DATA
3188 : FFFF           : DATA
3189 : FFFF           : DATA
318a : FFFF           : DATA
318b : FFFF           : DATA
318c : FFFF           : DATA
318d : FFFF           : DATA
318e : FFFF           : DATA
318f : FFFF           : DATA
3190 : FFFF           : DATA
3191 : FFFF           : DATA
3192 : FFFF           : DATA
3193 : FFFF           : DATA
3194 : FFFF           : DATA
3195 : FFFF           : DATA
3196 : FFFF           : DATA
3197 : FFFF           : DATA
3198 : FFFF           : DATA
3199 : FFFF           : DATA
319a : FFFF           : DATA
319b : FFFF           : DATA
319c : FFFF           : DATA
319d : FFFF           : DATA
319e : FFFF           : DATA
319f : FFFF           : DATA
31a0 : FFFF           : DATA
31a1 : FFFF           : DATA
31a2 : FFFF           : DATA
31a3 : FFFF           : DATA
31a4 : FFFF           : DATA
31a5 : FFFF           : DATA
31a6 : FFFF           : DATA
31a7 : FFFF           : DATA
31a8 : FFFF           : DATA
31a9 : FFFF           : DATA
31aa : FFFF           : DATA
31ab : FFFF           : DATA
31ac : FFFF           : DATA
31ad : FFFF           : DATA
31ae : FFFF           : DATA
31af : FFFF           : DATA
31b0 : FFFF           : DATA
31b1 : FFFF           : DATA
31b2 : FFFF           : DATA
31b3 : FFFF           : DATA
31b4 : FFFF           : DATA
31b5 : FFFF           : DATA
31b6 : FFFF           : DATA
31b7 : FFFF           : DATA
31b8 : FFFF           : DATA
31b9 : FFFF           : DATA
31ba : FFFF           : DATA
31bb : FFFF           : DATA
31bc : FFFF           : DATA
31bd : FFFF           : DATA
31be : FFFF           : DATA
31bf : FFFF           : DATA
31c0 : FFFF           : DATA
31c1 : FFFF           : DATA
31c2 : FFFF           : DATA
31c3 : FFFF           : DATA
31c4 : FFFF           : DATA
31c5 : FFFF           : DATA
31c6 : FFFF           : DATA
31c7 : FFFF           : DATA
31c8 : FFFF           : DATA
31c9 : FFFF           : DATA
31ca : FFFF           : DATA
31cb : FFFF           : DATA
31cc : FFFF           : DATA
31cd : FFFF           : DATA
31ce : FFFF           : DATA
31cf : FFFF           : DATA
31d0 : FFFF           : DATA
31d1 : FFFF           : DATA
31d2 : FFFF           : DATA
31d3 : FFFF           : DATA
31d4 : FFFF           : DATA
31d5 : FFFF           : DATA
31d6 : FFFF           : DATA
31d7 : FFFF           : DATA
31d8 : FFFF           : DATA
31d9 : FFFF           : DATA
31da : FFFF           : DATA
31db : FFFF           : DATA
31dc : FFFF           : DATA
31dd : FFFF           : DATA
31de : FFFF           : DATA
31df : FFFF           : DATA
31e0 : FFFF           : DATA
31e1 : FFFF           : DATA
31e2 : FFFF           : DATA
31e3 : FFFF           : DATA
31e4 : FFFF           : DATA
31e5 : FFFF           : DATA
31e6 : FFFF           : DATA
31e7 : FFFF           : DATA
31e8 : FFFF           : DATA
31e9 : FFFF           : DATA
31ea : FFFF           : DATA
31eb : FFFF           : DATA
31ec : FFFF           : DATA
31ed : FFFF           : DATA
31ee : FFFF           : DATA
31ef : FFFF           : DATA
31f0 : FFFF           : DATA
31f1 : FFFF           : DATA
31f2 : FFFF           : DATA
31f3 : FFFF           : DATA
31f4 : FFFF           : DATA
31f5 : FFFF           : DATA
31f6 : FFFF           : DATA
31f7 : FFFF           : DATA
31f8 : FFFF           : DATA
31f9 : FFFF           : DATA
31fa : FFFF           : DATA
31fb : FFFF           : DATA
31fc : FFFF           : DATA
31fd : FFFF           : DATA
31fe : FFFF           : DATA
31ff : FFFF           : DATA
3200 : FFFF           : DATA
3201 : FFFF           : DATA
3202 : FFFF           : DATA
3203 : FFFF           : DATA
3204 : FFFF           : DATA
3205 : FFFF           : DATA
3206 : FFFF           : DATA
3207 : FFFF           : DATA
3208 : FFFF           : DATA
3209 : FFFF           : DATA
320a : FFFF           : DATA
320b : FFFF           : DATA
320c : FFFF           : DATA
320d : FFFF           : DATA
320e : FFFF           : DATA
320f : FFFF           : DATA
3210 : FFFF           : DATA
3211 : FFFF           : DATA
3212 : FFFF           : DATA
3213 : FFFF           : DATA
3214 : FFFF           : DATA
3215 : FFFF           : DATA
3216 : FFFF           : DATA
3217 : FFFF           : DATA
3218 : FFFF           : DATA
3219 : FFFF           : DATA
321a : FFFF           : DATA
321b : FFFF           : DATA
321c : FFFF           : DATA
321d : FFFF           : DATA
321e : FFFF           : DATA
321f : FFFF           : DATA
3220 : FFFF           : DATA
3221 : FFFF           : DATA
3222 : FFFF           : DATA
3223 : FFFF           : DATA
3224 : FFFF           : DATA
3225 : FFFF           : DATA
3226 : FFFF           : DATA
3227 : FFFF           : DATA
3228 : FFFF           : DATA
3229 : FFFF           : DATA
322a : FFFF           : DATA
322b : FFFF           : DATA
322c : FFFF           : DATA
322d : FFFF           : DATA
322e : FFFF           : DATA
322f : FFFF           : DATA
3230 : FFFF           : DATA
3231 : FFFF           : DATA
3232 : FFFF           : DATA
3233 : FFFF           : DATA
3234 : FFFF           : DATA
3235 : FFFF           : DATA
3236 : FFFF           : DATA
3237 : FFFF           : DATA
3238 : FFFF           : DATA
3239 : FFFF           : DATA
323a : FFFF           : DATA
323b : FFFF           : DATA
323c : FFFF           : DATA
323d : FFFF           : DATA
323e : FFFF           : DATA
323f : FFFF           : DATA
3240 : FFFF           : DATA
3241 : FFFF           : DATA
3242 : FFFF           : DATA
3243 : FFFF           : DATA
3244 : FFFF           : DATA
3245 : FFFF           : DATA
3246 : FFFF           : DATA
3247 : FFFF           : DATA
3248 : FFFF           : DATA
3249 : FFFF           : DATA
324a : FFFF           : DATA
324b : FFFF           : DATA
324c : FFFF           : DATA
324d : FFFF           : DATA
324e : FFFF           : DATA
324f : FFFF           : DATA
3250 : FFFF           : DATA
3251 : FFFF           : DATA
3252 : FFFF           : DATA
3253 : FFFF           : DATA
3254 : FFFF           : DATA
3255 : FFFF           : DATA
3256 : FFFF           : DATA
3257 : FFFF           : DATA
3258 : FFFF           : DATA
3259 : FFFF           : DATA
325a : FFFF           : DATA
325b : FFFF           : DATA
325c : FFFF           : DATA
325d : FFFF           : DATA
325e : FFFF           : DATA
325f : FFFF           : DATA
3260 : FFFF           : DATA
3261 : FFFF           : DATA
3262 : FFFF           : DATA
3263 : FFFF           : DATA
3264 : FFFF           : DATA
3265 : FFFF           : DATA
3266 : FFFF           : DATA
3267 : FFFF           : DATA
3268 : FFFF           : DATA
3269 : FFFF           : DATA
326a : FFFF           : DATA
326b : FFFF           : DATA
326c : FFFF           : DATA
326d : FFFF           : DATA
326e : FFFF           : DATA
326f : FFFF           : DATA
3270 : FFFF           : DATA
3271 : FFFF           : DATA
3272 : FFFF           : DATA
3273 : FFFF           : DATA
3274 : FFFF           : DATA
3275 : FFFF           : DATA
3276 : FFFF           : DATA
3277 : FFFF           : DATA
3278 : FFFF           : DATA
3279 : FFFF           : DATA
327a : FFFF           : DATA
327b : FFFF           : DATA
327c : FFFF           : DATA
327d : FFFF           : DATA
327e : FFFF           : DATA
327f : FFFF           : DATA
3280 : FFFF           : DATA
3281 : FFFF           : DATA
3282 : FFFF           : DATA
3283 : FFFF           : DATA
3284 : FFFF           : DATA
3285 : FFFF           : DATA
3286 : FFFF           : DATA
3287 : FFFF           : DATA
3288 : FFFF           : DATA
3289 : FFFF           : DATA
328a : FFFF           : DATA
328b : FFFF           : DATA
328c : FFFF           : DATA
328d : FFFF           : DATA
328e : FFFF           : DATA
328f : FFFF           : DATA
3290 : FFFF           : DATA
3291 : FFFF           : DATA
3292 : FFFF           : DATA
3293 : FFFF           : DATA
3294 : FFFF           : DATA
3295 : FFFF           : DATA
3296 : FFFF           : DATA
3297 : FFFF           : DATA
3298 : FFFF           : DATA
3299 : FFFF           : DATA
329a : FFFF           : DATA
329b : FFFF           : DATA
329c : FFFF           : DATA
329d : FFFF           : DATA
329e : FFFF           : DATA
329f : FFFF           : DATA
32a0 : FFFF           : DATA
32a1 : FFFF           : DATA
32a2 : FFFF           : DATA
32a3 : FFFF           : DATA
32a4 : FFFF           : DATA
32a5 : FFFF           : DATA
32a6 : FFFF           : DATA
32a7 : FFFF           : DATA
32a8 : FFFF           : DATA
32a9 : FFFF           : DATA
32aa : FFFF           : DATA
32ab : FFFF           : DATA
32ac : FFFF           : DATA
32ad : FFFF           : DATA
32ae : FFFF           : DATA
32af : FFFF           : DATA
32b0 : FFFF           : DATA
32b1 : FFFF           : DATA
32b2 : FFFF           : DATA
32b3 : FFFF           : DATA
32b4 : FFFF           : DATA
32b5 : FFFF           : DATA
32b6 : FFFF           : DATA
32b7 : FFFF           : DATA
32b8 : FFFF           : DATA
32b9 : FFFF           : DATA
32ba : FFFF           : DATA
32bb : FFFF           : DATA
32bc : FFFF           : DATA
32bd : FFFF           : DATA
32be : FFFF           : DATA
32bf : FFFF           : DATA
32c0 : FFFF           : DATA
32c1 : FFFF           : DATA
32c2 : FFFF           : DATA
32c3 : FFFF           : DATA
32c4 : FFFF           : DATA
32c5 : FFFF           : DATA
32c6 : FFFF           : DATA
32c7 : FFFF           : DATA
32c8 : FFFF           : DATA
32c9 : FFFF           : DATA
32ca : FFFF           : DATA
32cb : FFFF           : DATA
32cc : FFFF           : DATA
32cd : FFFF           : DATA
32ce : FFFF           : DATA
32cf : FFFF           : DATA
32d0 : FFFF           : DATA
32d1 : FFFF           : DATA
32d2 : FFFF           : DATA
32d3 : FFFF           : DATA
32d4 : FFFF           : DATA
32d5 : FFFF           : DATA
32d6 : FFFF           : DATA
32d7 : FFFF           : DATA
32d8 : FFFF           : DATA
32d9 : FFFF           : DATA
32da : FFFF           : DATA
32db : FFFF           : DATA
32dc : FFFF           : DATA
32dd : FFFF           : DATA
32de : FFFF           : DATA
32df : FFFF           : DATA
32e0 : FFFF           : DATA
32e1 : FFFF           : DATA
32e2 : FFFF           : DATA
32e3 : FFFF           : DATA
32e4 : FFFF           : DATA
32e5 : FFFF           : DATA
32e6 : FFFF           : DATA
32e7 : FFFF           : DATA
32e8 : FFFF           : DATA
32e9 : FFFF           : DATA
32ea : FFFF           : DATA
32eb : FFFF           : DATA
32ec : FFFF           : DATA
32ed : FFFF           : DATA
32ee : FFFF           : DATA
32ef : FFFF           : DATA
32f0 : FFFF           : DATA
32f1 : FFFF           : DATA
32f2 : FFFF           : DATA
32f3 : FFFF           : DATA
32f4 : FFFF           : DATA
32f5 : FFFF           : DATA
32f6 : FFFF           : DATA
32f7 : FFFF           : DATA
32f8 : FFFF           : DATA
32f9 : FFFF           : DATA
32fa : FFFF           : DATA
32fb : FFFF           : DATA
32fc : FFFF           : DATA
32fd : FFFF           : DATA
32fe : FFFF           : DATA
32ff : FFFF           : DATA
3300 : FFFF           : DATA
3301 : FFFF           : DATA
3302 : FFFF           : DATA
3303 : FFFF           : DATA
3304 : FFFF           : DATA
3305 : FFFF           : DATA
3306 : FFFF           : DATA
3307 : FFFF           : DATA
3308 : FFFF           : DATA
3309 : FFFF           : DATA
330a : FFFF           : DATA
330b : FFFF           : DATA
330c : FFFF           : DATA
330d : FFFF           : DATA
330e : FFFF           : DATA
330f : FFFF           : DATA
3310 : FFFF           : DATA
3311 : FFFF           : DATA
3312 : FFFF           : DATA
3313 : FFFF           : DATA
3314 : FFFF           : DATA
3315 : FFFF           : DATA
3316 : FFFF           : DATA
3317 : FFFF           : DATA
3318 : FFFF           : DATA
3319 : FFFF           : DATA
331a : FFFF           : DATA
331b : FFFF           : DATA
331c : FFFF           : DATA
331d : FFFF           : DATA
331e : FFFF           : DATA
331f : FFFF           : DATA
3320 : FFFF           : DATA
3321 : FFFF           : DATA
3322 : FFFF           : DATA
3323 : FFFF           : DATA
3324 : FFFF           : DATA
3325 : FFFF           : DATA
3326 : FFFF           : DATA
3327 : FFFF           : DATA
3328 : FFFF           : DATA
3329 : FFFF           : DATA
332a : FFFF           : DATA
332b : FFFF           : DATA
332c : FFFF           : DATA
332d : FFFF           : DATA
332e : FFFF           : DATA
332f : FFFF           : DATA
3330 : FFFF           : DATA
3331 : FFFF           : DATA
3332 : FFFF           : DATA
3333 : FFFF           : DATA
3334 : FFFF           : DATA
3335 : FFFF           : DATA
3336 : FFFF           : DATA
3337 : FFFF           : DATA
3338 : FFFF           : DATA
3339 : FFFF           : DATA
333a : FFFF           : DATA
333b : FFFF           : DATA
333c : FFFF           : DATA
333d : FFFF           : DATA
333e : FFFF           : DATA
333f : FFFF           : DATA
3340 : FFFF           : DATA
3341 : FFFF           : DATA
3342 : FFFF           : DATA
3343 : FFFF           : DATA
3344 : FFFF           : DATA
3345 : FFFF           : DATA
3346 : FFFF           : DATA
3347 : FFFF           : DATA
3348 : FFFF           : DATA
3349 : FFFF           : DATA
334a : FFFF           : DATA
334b : FFFF           : DATA
334c : FFFF           : DATA
334d : FFFF           : DATA
334e : FFFF           : DATA
334f : FFFF           : DATA
3350 : FFFF           : DATA
3351 : FFFF           : DATA
3352 : FFFF           : DATA
3353 : FFFF           : DATA
3354 : FFFF           : DATA
3355 : FFFF           : DATA
3356 : FFFF           : DATA
3357 : FFFF           : DATA
3358 : FFFF           : DATA
3359 : FFFF           : DATA
335a : FFFF           : DATA
335b : FFFF           : DATA
335c : FFFF           : DATA
335d : FFFF           : DATA
335e : FFFF           : DATA
335f : FFFF           : DATA
3360 : FFFF           : DATA
3361 : FFFF           : DATA
3362 : FFFF           : DATA
3363 : FFFF           : DATA
3364 : FFFF           : DATA
3365 : FFFF           : DATA
3366 : FFFF           : DATA
3367 : FFFF           : DATA
3368 : FFFF           : DATA
3369 : FFFF           : DATA
336a : FFFF           : DATA
336b : FFFF           : DATA
336c : FFFF           : DATA
336d : FFFF           : DATA
336e : FFFF           : DATA
336f : FFFF           : DATA
3370 : FFFF           : DATA
3371 : FFFF           : DATA
3372 : FFFF           : DATA
3373 : FFFF           : DATA
3374 : FFFF           : DATA
3375 : FFFF           : DATA
3376 : FFFF           : DATA
3377 : FFFF           : DATA
3378 : FFFF           : DATA
3379 : FFFF           : DATA
337a : FFFF           : DATA
337b : FFFF           : DATA
337c : FFFF           : DATA
337d : FFFF           : DATA
337e : FFFF           : DATA
337f : FFFF           : DATA
3380 : FFFF           : DATA
3381 : FFFF           : DATA
3382 : FFFF           : DATA
3383 : FFFF           : DATA
3384 : FFFF           : DATA
3385 : FFFF           : DATA
3386 : FFFF           : DATA
3387 : FFFF           : DATA
3388 : FFFF           : DATA
3389 : FFFF           : DATA
338a : FFFF           : DATA
338b : FFFF           : DATA
338c : FFFF           : DATA
338d : FFFF           : DATA
338e : FFFF           : DATA
338f : FFFF           : DATA
3390 : FFFF           : DATA
3391 : FFFF           : DATA
3392 : FFFF           : DATA
3393 : FFFF           : DATA
3394 : FFFF           : DATA
3395 : FFFF           : DATA
3396 : FFFF           : DATA
3397 : FFFF           : DATA
3398 : FFFF           : DATA
3399 : FFFF           : DATA
339a : FFFF           : DATA
339b : FFFF           : DATA
339c : FFFF           : DATA
339d : FFFF           : DATA
339e : FFFF           : DATA
339f : FFFF           : DATA
33a0 : FFFF           : DATA
33a1 : FFFF           : DATA
33a2 : FFFF           : DATA
33a3 : FFFF           : DATA
33a4 : FFFF           : DATA
33a5 : FFFF           : DATA
33a6 : FFFF           : DATA
33a7 : FFFF           : DATA
33a8 : FFFF           : DATA
33a9 : FFFF           : DATA
33aa : FFFF           : DATA
33ab : FFFF           : DATA
33ac : FFFF           : DATA
33ad : FFFF           : DATA
33ae : FFFF           : DATA
33af : FFFF           : DATA
33b0 : FFFF           : DATA
33b1 : FFFF           : DATA
33b2 : FFFF           : DATA
33b3 : FFFF           : DATA
33b4 : FFFF           : DATA
33b5 : FFFF           : DATA
33b6 : FFFF           : DATA
33b7 : FFFF           : DATA
33b8 : FFFF           : DATA
33b9 : FFFF           : DATA
33ba : FFFF           : DATA
33bb : FFFF           : DATA
33bc : FFFF           : DATA
33bd : FFFF           : DATA
33be : FFFF           : DATA
33bf : FFFF           : DATA
33c0 : FFFF           : DATA
33c1 : FFFF           : DATA
33c2 : FFFF           : DATA
33c3 : FFFF           : DATA
33c4 : FFFF           : DATA
33c5 : FFFF           : DATA
33c6 : FFFF           : DATA
33c7 : FFFF           : DATA
33c8 : FFFF           : DATA
33c9 : FFFF           : DATA
33ca : FFFF           : DATA
33cb : FFFF           : DATA
33cc : FFFF           : DATA
33cd : FFFF           : DATA
33ce : FFFF           : DATA
33cf : FFFF           : DATA
33d0 : FFFF           : DATA
33d1 : FFFF           : DATA
33d2 : FFFF           : DATA
33d3 : FFFF           : DATA
33d4 : FFFF           : DATA
33d5 : FFFF           : DATA
33d6 : FFFF           : DATA
33d7 : FFFF           : DATA
33d8 : FFFF           : DATA
33d9 : FFFF           : DATA
33da : FFFF           : DATA
33db : FFFF           : DATA
33dc : FFFF           : DATA
33dd : FFFF           : DATA
33de : FFFF           : DATA
33df : FFFF           : DATA
33e0 : FFFF           : DATA
33e1 : FFFF           : DATA
33e2 : FFFF           : DATA
33e3 : FFFF           : DATA
33e4 : FFFF           : DATA
33e5 : FFFF           : DATA
33e6 : FFFF           : DATA
33e7 : FFFF           : DATA
33e8 : FFFF           : DATA
33e9 : FFFF           : DATA
33ea : FFFF           : DATA
33eb : FFFF           : DATA
33ec : FFFF           : DATA
33ed : FFFF           : DATA
33ee : FFFF           : DATA
33ef : FFFF           : DATA
33f0 : FFFF           : DATA
33f1 : FFFF           : DATA
33f2 : FFFF           : DATA
33f3 : FFFF           : DATA
33f4 : FFFF           : DATA
33f5 : FFFF           : DATA
33f6 : FFFF           : DATA
33f7 : FFFF           : DATA
33f8 : FFFF           : DATA
33f9 : FFFF           : DATA
33fa : FFFF           : DATA
33fb : FFFF           : DATA
33fc : FFFF           : DATA
33fd : FFFF           : DATA
33fe : FFFF           : DATA
33ff : FFFF           : DATA
3400 : FFFF           : DATA
3401 : FFFF           : DATA
3402 : FFFF           : DATA
3403 : FFFF           : DATA
3404 : FFFF           : DATA
3405 : FFFF           : DATA
3406 : FFFF           : DATA
3407 : FFFF           : DATA
3408 : FFFF           : DATA
3409 : FFFF           : DATA
340a : FFFF           : DATA
340b : FFFF           : DATA
340c : FFFF           : DATA
340d : FFFF           : DATA
340e : FFFF           : DATA
340f : FFFF           : DATA
3410 : FFFF           : DATA
3411 : FFFF           : DATA
3412 : FFFF           : DATA
3413 : FFFF           : DATA
3414 : FFFF           : DATA
3415 : FFFF           : DATA
3416 : FFFF           : DATA
3417 : FFFF           : DATA
3418 : FFFF           : DATA
3419 : FFFF           : DATA
341a : FFFF           : DATA
341b : FFFF           : DATA
341c : FFFF           : DATA
341d : FFFF           : DATA
341e : FFFF           : DATA
341f : FFFF           : DATA
3420 : FFFF           : DATA
3421 : FFFF           : DATA
3422 : FFFF           : DATA
3423 : FFFF           : DATA
3424 : FFFF           : DATA
3425 : FFFF           : DATA
3426 : FFFF           : DATA
3427 : FFFF           : DATA
3428 : FFFF           : DATA
3429 : FFFF           : DATA
342a : FFFF           : DATA
342b : FFFF           : DATA
342c : FFFF           : DATA
342d : FFFF           : DATA
342e : FFFF           : DATA
342f : FFFF           : DATA
3430 : FFFF           : DATA
3431 : FFFF           : DATA
3432 : FFFF           : DATA
3433 : FFFF           : DATA
3434 : FFFF           : DATA
3435 : FFFF           : DATA
3436 : FFFF           : DATA
3437 : FFFF           : DATA
3438 : FFFF           : DATA
3439 : FFFF           : DATA
343a : FFFF           : DATA
343b : FFFF           : DATA
343c : FFFF           : DATA
343d : FFFF           : DATA
343e : FFFF           : DATA
343f : FFFF           : DATA
3440 : FFFF           : DATA
3441 : FFFF           : DATA
3442 : FFFF           : DATA
3443 : FFFF           : DATA
3444 : FFFF           : DATA
3445 : FFFF           : DATA
3446 : FFFF           : DATA
3447 : FFFF           : DATA
3448 : FFFF           : DATA
3449 : FFFF           : DATA
344a : FFFF           : DATA
344b : FFFF           : DATA
344c : FFFF           : DATA
344d : FFFF           : DATA
344e : FFFF           : DATA
344f : FFFF           : DATA
3450 : FFFF           : DATA
3451 : FFFF           : DATA
3452 : FFFF           : DATA
3453 : FFFF           : DATA
3454 : FFFF           : DATA
3455 : FFFF           : DATA
3456 : FFFF           : DATA
3457 : FFFF           : DATA
3458 : FFFF           : DATA
3459 : FFFF           : DATA
345a : FFFF           : DATA
345b : FFFF           : DATA
345c : FFFF           : DATA
345d : FFFF           : DATA
345e : FFFF           : DATA
345f : FFFF           : DATA
3460 : FFFF           : DATA
3461 : FFFF           : DATA
3462 : FFFF           : DATA
3463 : FFFF           : DATA
3464 : FFFF           : DATA
3465 : FFFF           : DATA
3466 : FFFF           : DATA
3467 : FFFF           : DATA
3468 : FFFF           : DATA
3469 : FFFF           : DATA
346a : FFFF           : DATA
346b : FFFF           : DATA
346c : FFFF           : DATA
346d : FFFF           : DATA
346e : FFFF           : DATA
346f : FFFF           : DATA
3470 : FFFF           : DATA
3471 : FFFF           : DATA
3472 : FFFF           : DATA
3473 : FFFF           : DATA
3474 : FFFF           : DATA
3475 : FFFF           : DATA
3476 : FFFF           : DATA
3477 : FFFF           : DATA
3478 : FFFF           : DATA
3479 : FFFF           : DATA
347a : FFFF           : DATA
347b : FFFF           : DATA
347c : FFFF           : DATA
347d : FFFF           : DATA
347e : FFFF           : DATA
347f : FFFF           : DATA
3480 : FFFF           : DATA
3481 : FFFF           : DATA
3482 : FFFF           : DATA
3483 : FFFF           : DATA
3484 : FFFF           : DATA
3485 : FFFF           : DATA
3486 : FFFF           : DATA
3487 : FFFF           : DATA
3488 : FFFF           : DATA
3489 : FFFF           : DATA
348a : FFFF           : DATA
348b : FFFF           : DATA
348c : FFFF           : DATA
348d : FFFF           : DATA
348e : FFFF           : DATA
348f : FFFF           : DATA
3490 : FFFF           : DATA
3491 : FFFF           : DATA
3492 : FFFF           : DATA
3493 : FFFF           : DATA
3494 : FFFF           : DATA
3495 : FFFF           : DATA
3496 : FFFF           : DATA
3497 : FFFF           : DATA
3498 : FFFF           : DATA
3499 : FFFF           : DATA
349a : FFFF           : DATA
349b : FFFF           : DATA
349c : FFFF           : DATA
349d : FFFF           : DATA
349e : FFFF           : DATA
349f : FFFF           : DATA
34a0 : FFFF           : DATA
34a1 : FFFF           : DATA
34a2 : FFFF           : DATA
34a3 : FFFF           : DATA
34a4 : FFFF           : DATA
34a5 : FFFF           : DATA
34a6 : FFFF           : DATA
34a7 : FFFF           : DATA
34a8 : FFFF           : DATA
34a9 : FFFF           : DATA
34aa : FFFF           : DATA
34ab : FFFF           : DATA
34ac : FFFF           : DATA
34ad : FFFF           : DATA
34ae : FFFF           : DATA
34af : FFFF           : DATA
34b0 : FFFF           : DATA
34b1 : FFFF           : DATA
34b2 : FFFF           : DATA
34b3 : FFFF           : DATA
34b4 : FFFF           : DATA
34b5 : FFFF           : DATA
34b6 : FFFF           : DATA
34b7 : FFFF           : DATA
34b8 : FFFF           : DATA
34b9 : FFFF           : DATA
34ba : FFFF           : DATA
34bb : FFFF           : DATA
34bc : FFFF           : DATA
34bd : FFFF           : DATA
34be : FFFF           : DATA
34bf : FFFF           : DATA
34c0 : FFFF           : DATA
34c1 : FFFF           : DATA
34c2 : FFFF           : DATA
34c3 : FFFF           : DATA
34c4 : FFFF           : DATA
34c5 : FFFF           : DATA
34c6 : FFFF           : DATA
34c7 : FFFF           : DATA
34c8 : FFFF           : DATA
34c9 : FFFF           : DATA
34ca : FFFF           : DATA
34cb : FFFF           : DATA
34cc : FFFF           : DATA
34cd : FFFF           : DATA
34ce : FFFF           : DATA
34cf : FFFF           : DATA
34d0 : FFFF           : DATA
34d1 : FFFF           : DATA
34d2 : FFFF           : DATA
34d3 : FFFF           : DATA
34d4 : FFFF           : DATA
34d5 : FFFF           : DATA
34d6 : FFFF           : DATA
34d7 : FFFF           : DATA
34d8 : FFFF           : DATA
34d9 : FFFF           : DATA
34da : FFFF           : DATA
34db : FFFF           : DATA
34dc : FFFF           : DATA
34dd : FFFF           : DATA
34de : FFFF           : DATA
34df : FFFF           : DATA
34e0 : FFFF           : DATA
34e1 : FFFF           : DATA
34e2 : FFFF           : DATA
34e3 : FFFF           : DATA
34e4 : FFFF           : DATA
34e5 : FFFF           : DATA
34e6 : FFFF           : DATA
34e7 : FFFF           : DATA
34e8 : FFFF           : DATA
34e9 : FFFF           : DATA
34ea : FFFF           : DATA
34eb : FFFF           : DATA
34ec : FFFF           : DATA
34ed : FFFF           : DATA
34ee : FFFF           : DATA
34ef : FFFF           : DATA
34f0 : FFFF           : DATA
34f1 : FFFF           : DATA
34f2 : FFFF           : DATA
34f3 : FFFF           : DATA
34f4 : FFFF           : DATA
34f5 : FFFF           : DATA
34f6 : FFFF           : DATA
34f7 : FFFF           : DATA
34f8 : FFFF           : DATA
34f9 : FFFF           : DATA
34fa : FFFF           : DATA
34fb : FFFF           : DATA
34fc : FFFF           : DATA
34fd : FFFF           : DATA
34fe : FFFF           : DATA
34ff : FFFF           : DATA
3500 : FFFF           : DATA
3501 : FFFF           : DATA
3502 : FFFF           : DATA
3503 : FFFF           : DATA
3504 : FFFF           : DATA
3505 : FFFF           : DATA
3506 : FFFF           : DATA
3507 : FFFF           : DATA
3508 : FFFF           : DATA
3509 : FFFF           : DATA
350a : FFFF           : DATA
350b : FFFF           : DATA
350c : FFFF           : DATA
350d : FFFF           : DATA
350e : FFFF           : DATA
350f : FFFF           : DATA
3510 : FFFF           : DATA
3511 : FFFF           : DATA
3512 : FFFF           : DATA
3513 : FFFF           : DATA
3514 : FFFF           : DATA
3515 : FFFF           : DATA
3516 : FFFF           : DATA
3517 : FFFF           : DATA
3518 : FFFF           : DATA
3519 : FFFF           : DATA
351a : FFFF           : DATA
351b : FFFF           : DATA
351c : FFFF           : DATA
351d : FFFF           : DATA
351e : FFFF           : DATA
351f : FFFF           : DATA
3520 : FFFF           : DATA
3521 : FFFF           : DATA
3522 : FFFF           : DATA
3523 : FFFF           : DATA
3524 : FFFF           : DATA
3525 : FFFF           : DATA
3526 : FFFF           : DATA
3527 : FFFF           : DATA
3528 : FFFF           : DATA
3529 : FFFF           : DATA
352a : FFFF           : DATA
352b : FFFF           : DATA
352c : FFFF           : DATA
352d : FFFF           : DATA
352e : FFFF           : DATA
352f : FFFF           : DATA
3530 : FFFF           : DATA
3531 : FFFF           : DATA
3532 : FFFF           : DATA
3533 : FFFF           : DATA
3534 : FFFF           : DATA
3535 : FFFF           : DATA
3536 : FFFF           : DATA
3537 : FFFF           : DATA
3538 : FFFF           : DATA
3539 : FFFF           : DATA
353a : FFFF           : DATA
353b : FFFF           : DATA
353c : FFFF           : DATA
353d : FFFF           : DATA
353e : FFFF           : DATA
353f : FFFF           : DATA
3540 : FFFF           : DATA
3541 : FFFF           : DATA
3542 : FFFF           : DATA
3543 : FFFF           : DATA
3544 : FFFF           : DATA
3545 : FFFF           : DATA
3546 : FFFF           : DATA
3547 : FFFF           : DATA
3548 : FFFF           : DATA
3549 : FFFF           : DATA
354a : FFFF           : DATA
354b : FFFF           : DATA
354c : FFFF           : DATA
354d : FFFF           : DATA
354e : FFFF           : DATA
354f : FFFF           : DATA
3550 : FFFF           : DATA
3551 : FFFF           : DATA
3552 : FFFF           : DATA
3553 : FFFF           : DATA
3554 : FFFF           : DATA
3555 : FFFF           : DATA
3556 : FFFF           : DATA
3557 : FFFF           : DATA
3558 : FFFF           : DATA
3559 : FFFF           : DATA
355a : FFFF           : DATA
355b : FFFF           : DATA
355c : FFFF           : DATA
355d : FFFF           : DATA
355e : FFFF           : DATA
355f : FFFF           : DATA
3560 : FFFF           : DATA
3561 : FFFF           : DATA
3562 : FFFF           : DATA
3563 : FFFF           : DATA
3564 : FFFF           : DATA
3565 : FFFF           : DATA
3566 : FFFF           : DATA
3567 : FFFF           : DATA
3568 : FFFF           : DATA
3569 : FFFF           : DATA
356a : FFFF           : DATA
356b : FFFF           : DATA
356c : FFFF           : DATA
356d : FFFF           : DATA
356e : FFFF           : DATA
356f : FFFF           : DATA
3570 : FFFF           : DATA
3571 : FFFF           : DATA
3572 : FFFF           : DATA
3573 : FFFF           : DATA
3574 : FFFF           : DATA
3575 : FFFF           : DATA
3576 : FFFF           : DATA
3577 : FFFF           : DATA
3578 : FFFF           : DATA
3579 : FFFF           : DATA
357a : FFFF           : DATA
357b : FFFF           : DATA
357c : FFFF           : DATA
357d : FFFF           : DATA
357e : FFFF           : DATA
357f : FFFF           : DATA
3580 : FFFF           : DATA
3581 : FFFF           : DATA
3582 : FFFF           : DATA
3583 : FFFF           : DATA
3584 : FFFF           : DATA
3585 : FFFF           : DATA
3586 : FFFF           : DATA
3587 : FFFF           : DATA
3588 : FFFF           : DATA
3589 : FFFF           : DATA
358a : FFFF           : DATA
358b : FFFF           : DATA
358c : FFFF           : DATA
358d : FFFF           : DATA
358e : FFFF           : DATA
358f : FFFF           : DATA
3590 : FFFF           : DATA
3591 : FFFF           : DATA
3592 : FFFF           : DATA
3593 : FFFF           : DATA
3594 : FFFF           : DATA
3595 : FFFF           : DATA
3596 : FFFF           : DATA
3597 : FFFF           : DATA
3598 : FFFF           : DATA
3599 : FFFF           : DATA
359a : FFFF           : DATA
359b : FFFF           : DATA
359c : FFFF           : DATA
359d : FFFF           : DATA
359e : FFFF           : DATA
359f : FFFF           : DATA
35a0 : FFFF           : DATA
35a1 : FFFF           : DATA
35a2 : FFFF           : DATA
35a3 : FFFF           : DATA
35a4 : FFFF           : DATA
35a5 : FFFF           : DATA
35a6 : FFFF           : DATA
35a7 : FFFF           : DATA
35a8 : FFFF           : DATA
35a9 : FFFF           : DATA
35aa : FFFF           : DATA
35ab : FFFF           : DATA
35ac : FFFF           : DATA
35ad : FFFF           : DATA
35ae : FFFF           : DATA
35af : FFFF           : DATA
35b0 : FFFF           : DATA
35b1 : FFFF           : DATA
35b2 : FFFF           : DATA
35b3 : FFFF           : DATA
35b4 : FFFF           : DATA
35b5 : FFFF           : DATA
35b6 : FFFF           : DATA
35b7 : FFFF           : DATA
35b8 : FFFF           : DATA
35b9 : FFFF           : DATA
35ba : FFFF           : DATA
35bb : FFFF           : DATA
35bc : FFFF           : DATA
35bd : FFFF           : DATA
35be : FFFF           : DATA
35bf : FFFF           : DATA
35c0 : FFFF           : DATA
35c1 : FFFF           : DATA
35c2 : FFFF           : DATA
35c3 : FFFF           : DATA
35c4 : FFFF           : DATA
35c5 : FFFF           : DATA
35c6 : FFFF           : DATA
35c7 : FFFF           : DATA
35c8 : FFFF           : DATA
35c9 : FFFF           : DATA
35ca : FFFF           : DATA
35cb : FFFF           : DATA
35cc : FFFF           : DATA
35cd : FFFF           : DATA
35ce : FFFF           : DATA
35cf : FFFF           : DATA
35d0 : FFFF           : DATA
35d1 : FFFF           : DATA
35d2 : FFFF           : DATA
35d3 : FFFF           : DATA
35d4 : FFFF           : DATA
35d5 : FFFF           : DATA
35d6 : FFFF           : DATA
35d7 : FFFF           : DATA
35d8 : FFFF           : DATA
35d9 : FFFF           : DATA
35da : FFFF           : DATA
35db : FFFF           : DATA
35dc : FFFF           : DATA
35dd : FFFF           : DATA
35de : FFFF           : DATA
35df : FFFF           : DATA
35e0 : FFFF           : DATA
35e1 : FFFF           : DATA
35e2 : FFFF           : DATA
35e3 : FFFF           : DATA
35e4 : FFFF           : DATA
35e5 : FFFF           : DATA
35e6 : FFFF           : DATA
35e7 : FFFF           : DATA
35e8 : FFFF           : DATA
35e9 : FFFF           : DATA
35ea : FFFF           : DATA
35eb : FFFF           : DATA
35ec : FFFF           : DATA
35ed : FFFF           : DATA
35ee : FFFF           : DATA
35ef : FFFF           : DATA
35f0 : FFFF           : DATA
35f1 : FFFF           : DATA
35f2 : FFFF           : DATA
35f3 : FFFF           : DATA
35f4 : FFFF           : DATA
35f5 : FFFF           : DATA
35f6 : FFFF           : DATA
35f7 : FFFF           : DATA
35f8 : FFFF           : DATA
35f9 : FFFF           : DATA
35fa : FFFF           : DATA
35fb : FFFF           : DATA
35fc : FFFF           : DATA
35fd : FFFF           : DATA
35fe : FFFF           : DATA
35ff : FFFF           : DATA
3600 : FFFF           : DATA
3601 : FFFF           : DATA
3602 : FFFF           : DATA
3603 : FFFF           : DATA
3604 : FFFF           : DATA
3605 : FFFF           : DATA
3606 : FFFF           : DATA
3607 : FFFF           : DATA
3608 : FFFF           : DATA
3609 : FFFF           : DATA
360a : FFFF           : DATA
360b : FFFF           : DATA
360c : FFFF           : DATA
360d : FFFF           : DATA
360e : FFFF           : DATA
360f : FFFF           : DATA
3610 : FFFF           : DATA
3611 : FFFF           : DATA
3612 : FFFF           : DATA
3613 : FFFF           : DATA
3614 : FFFF           : DATA
3615 : FFFF           : DATA
3616 : FFFF           : DATA
3617 : FFFF           : DATA
3618 : FFFF           : DATA
3619 : FFFF           : DATA
361a : FFFF           : DATA
361b : FFFF           : DATA
361c : FFFF           : DATA
361d : FFFF           : DATA
361e : FFFF           : DATA
361f : FFFF           : DATA
3620 : FFFF           : DATA
3621 : FFFF           : DATA
3622 : FFFF           : DATA
3623 : FFFF           : DATA
3624 : FFFF           : DATA
3625 : FFFF           : DATA
3626 : FFFF           : DATA
3627 : FFFF           : DATA
3628 : FFFF           : DATA
3629 : FFFF           : DATA
362a : FFFF           : DATA
362b : FFFF           : DATA
362c : FFFF           : DATA
362d : FFFF           : DATA
362e : FFFF           : DATA
362f : FFFF           : DATA
3630 : FFFF           : DATA
3631 : FFFF           : DATA
3632 : FFFF           : DATA
3633 : FFFF           : DATA
3634 : FFFF           : DATA
3635 : FFFF           : DATA
3636 : FFFF           : DATA
3637 : FFFF           : DATA
3638 : FFFF           : DATA
3639 : FFFF           : DATA
363a : FFFF           : DATA
363b : FFFF           : DATA
363c : FFFF           : DATA
363d : FFFF           : DATA
363e : FFFF           : DATA
363f : FFFF           : DATA
3640 : FFFF           : DATA
3641 : FFFF           : DATA
3642 : FFFF           : DATA
3643 : FFFF           : DATA
3644 : FFFF           : DATA
3645 : FFFF           : DATA
3646 : FFFF           : DATA
3647 : FFFF           : DATA
3648 : FFFF           : DATA
3649 : FFFF           : DATA
364a : FFFF           : DATA
364b : FFFF           : DATA
364c : FFFF           : DATA
364d : FFFF           : DATA
364e : FFFF           : DATA
364f : FFFF           : DATA
3650 : FFFF           : DATA
3651 : FFFF           : DATA
3652 : FFFF           : DATA
3653 : FFFF           : DATA
3654 : FFFF           : DATA
3655 : FFFF           : DATA
3656 : FFFF           : DATA
3657 : FFFF           : DATA
3658 : FFFF           : DATA
3659 : FFFF           : DATA
365a : FFFF           : DATA
365b : FFFF           : DATA
365c : FFFF           : DATA
365d : FFFF           : DATA
365e : FFFF           : DATA
365f : FFFF           : DATA
3660 : FFFF           : DATA
3661 : FFFF           : DATA
3662 : FFFF           : DATA
3663 : FFFF           : DATA
3664 : FFFF           : DATA
3665 : FFFF           : DATA
3666 : FFFF           : DATA
3667 : FFFF           : DATA
3668 : FFFF           : DATA
3669 : FFFF           : DATA
366a : FFFF           : DATA
366b : FFFF           : DATA
366c : FFFF           : DATA
366d : FFFF           : DATA
366e : FFFF           : DATA
366f : FFFF           : DATA
3670 : FFFF           : DATA
3671 : FFFF           : DATA
3672 : FFFF           : DATA
3673 : FFFF           : DATA
3674 : FFFF           : DATA
3675 : FFFF           : DATA
3676 : FFFF           : DATA
3677 : FFFF           : DATA
3678 : FFFF           : DATA
3679 : FFFF           : DATA
367a : FFFF           : DATA
367b : FFFF           : DATA
367c : FFFF           : DATA
367d : FFFF           : DATA
367e : FFFF           : DATA
367f : FFFF           : DATA
3680 : FFFF           : DATA
3681 : FFFF           : DATA
3682 : FFFF           : DATA
3683 : FFFF           : DATA
3684 : FFFF           : DATA
3685 : FFFF           : DATA
3686 : FFFF           : DATA
3687 : FFFF           : DATA
3688 : FFFF           : DATA
3689 : FFFF           : DATA
368a : FFFF           : DATA
368b : FFFF           : DATA
368c : FFFF           : DATA
368d : FFFF           : DATA
368e : FFFF           : DATA
368f : FFFF           : DATA
3690 : FFFF           : DATA
3691 : FFFF           : DATA
3692 : FFFF           : DATA
3693 : FFFF           : DATA
3694 : FFFF           : DATA
3695 : FFFF           : DATA
3696 : FFFF           : DATA
3697 : FFFF           : DATA
3698 : FFFF           : DATA
3699 : FFFF           : DATA
369a : FFFF           : DATA
369b : FFFF           : DATA
369c : FFFF           : DATA
369d : FFFF           : DATA
369e : FFFF           : DATA
369f : FFFF           : DATA
36a0 : FFFF           : DATA
36a1 : FFFF           : DATA
36a2 : FFFF           : DATA
36a3 : FFFF           : DATA
36a4 : FFFF           : DATA
36a5 : FFFF           : DATA
36a6 : FFFF           : DATA
36a7 : FFFF           : DATA
36a8 : FFFF           : DATA
36a9 : FFFF           : DATA
36aa : FFFF           : DATA
36ab : FFFF           : DATA
36ac : FFFF           : DATA
36ad : FFFF           : DATA
36ae : FFFF           : DATA
36af : FFFF           : DATA
36b0 : FFFF           : DATA
36b1 : FFFF           : DATA
36b2 : FFFF           : DATA
36b3 : FFFF           : DATA
36b4 : FFFF           : DATA
36b5 : FFFF           : DATA
36b6 : FFFF           : DATA
36b7 : FFFF           : DATA
36b8 : FFFF           : DATA
36b9 : FFFF           : DATA
36ba : FFFF           : DATA
36bb : FFFF           : DATA
36bc : FFFF           : DATA
36bd : FFFF           : DATA
36be : FFFF           : DATA
36bf : FFFF           : DATA
36c0 : FFFF           : DATA
36c1 : FFFF           : DATA
36c2 : FFFF           : DATA
36c3 : FFFF           : DATA
36c4 : FFFF           : DATA
36c5 : FFFF           : DATA
36c6 : FFFF           : DATA
36c7 : FFFF           : DATA
36c8 : FFFF           : DATA
36c9 : FFFF           : DATA
36ca : FFFF           : DATA
36cb : FFFF           : DATA
36cc : FFFF           : DATA
36cd : FFFF           : DATA
36ce : FFFF           : DATA
36cf : FFFF           : DATA
36d0 : FFFF           : DATA
36d1 : FFFF           : DATA
36d2 : FFFF           : DATA
36d3 : FFFF           : DATA
36d4 : FFFF           : DATA
36d5 : FFFF           : DATA
36d6 : FFFF           : DATA
36d7 : FFFF           : DATA
36d8 : FFFF           : DATA
36d9 : FFFF           : DATA
36da : FFFF           : DATA
36db : FFFF           : DATA
36dc : FFFF           : DATA
36dd : FFFF           : DATA
36de : FFFF           : DATA
36df : FFFF           : DATA
36e0 : FFFF           : DATA
36e1 : FFFF           : DATA
36e2 : FFFF           : DATA
36e3 : FFFF           : DATA
36e4 : FFFF           : DATA
36e5 : FFFF           : DATA
36e6 : FFFF           : DATA
36e7 : FFFF           : DATA
36e8 : FFFF           : DATA
36e9 : FFFF           : DATA
36ea : FFFF           : DATA
36eb : FFFF           : DATA
36ec : FFFF           : DATA
36ed : FFFF           : DATA
36ee : FFFF           : DATA
36ef : FFFF           : DATA
36f0 : FFFF           : DATA
36f1 : FFFF           : DATA
36f2 : FFFF           : DATA
36f3 : FFFF           : DATA
36f4 : FFFF           : DATA
36f5 : FFFF           : DATA
36f6 : FFFF           : DATA
36f7 : FFFF           : DATA
36f8 : FFFF           : DATA
36f9 : FFFF           : DATA
36fa : FFFF           : DATA
36fb : FFFF           : DATA
36fc : FFFF           : DATA
36fd : FFFF           : DATA
36fe : FFFF           : DATA
36ff : FFFF           : DATA
3700 : FFFF           : DATA
3701 : FFFF           : DATA
3702 : FFFF           : DATA
3703 : FFFF           : DATA
3704 : FFFF           : DATA
3705 : FFFF           : DATA
3706 : FFFF           : DATA
3707 : FFFF           : DATA
3708 : FFFF           : DATA
3709 : FFFF           : DATA
370a : FFFF           : DATA
370b : FFFF           : DATA
370c : FFFF           : DATA
370d : FFFF           : DATA
370e : FFFF           : DATA
370f : FFFF           : DATA
3710 : FFFF           : DATA
3711 : FFFF           : DATA
3712 : FFFF           : DATA
3713 : FFFF           : DATA
3714 : FFFF           : DATA
3715 : FFFF           : DATA
3716 : FFFF           : DATA
3717 : FFFF           : DATA
3718 : FFFF           : DATA
3719 : FFFF           : DATA
371a : FFFF           : DATA
371b : FFFF           : DATA
371c : FFFF           : DATA
371d : FFFF           : DATA
371e : FFFF           : DATA
371f : FFFF           : DATA
3720 : FFFF           : DATA
3721 : FFFF           : DATA
3722 : FFFF           : DATA
3723 : FFFF           : DATA
3724 : FFFF           : DATA
3725 : FFFF           : DATA
3726 : FFFF           : DATA
3727 : FFFF           : DATA
3728 : FFFF           : DATA
3729 : FFFF           : DATA
372a : FFFF           : DATA
372b : FFFF           : DATA
372c : FFFF           : DATA
372d : FFFF           : DATA
372e : FFFF           : DATA
372f : FFFF           : DATA
3730 : FFFF           : DATA
3731 : FFFF           : DATA
3732 : FFFF           : DATA
3733 : FFFF           : DATA
3734 : FFFF           : DATA
3735 : FFFF           : DATA
3736 : FFFF           : DATA
3737 : FFFF           : DATA
3738 : FFFF           : DATA
3739 : FFFF           : DATA
373a : FFFF           : DATA
373b : FFFF           : DATA
373c : FFFF           : DATA
373d : FFFF           : DATA
373e : FFFF           : DATA
373f : FFFF           : DATA
3740 : FFFF           : DATA
3741 : FFFF           : DATA
3742 : FFFF           : DATA
3743 : FFFF           : DATA
3744 : FFFF           : DATA
3745 : FFFF           : DATA
3746 : FFFF           : DATA
3747 : FFFF           : DATA
3748 : FFFF           : DATA
3749 : FFFF           : DATA
374a : FFFF           : DATA
374b : FFFF           : DATA
374c : FFFF           : DATA
374d : FFFF           : DATA
374e : FFFF           : DATA
374f : FFFF           : DATA
3750 : FFFF           : DATA
3751 : FFFF           : DATA
3752 : FFFF           : DATA
3753 : FFFF           : DATA
3754 : FFFF           : DATA
3755 : FFFF           : DATA
3756 : FFFF           : DATA
3757 : FFFF           : DATA
3758 : FFFF           : DATA
3759 : FFFF           : DATA
375a : FFFF           : DATA
375b : FFFF           : DATA
375c : FFFF           : DATA
375d : FFFF           : DATA
375e : FFFF           : DATA
375f : FFFF           : DATA
3760 : FFFF           : DATA
3761 : FFFF           : DATA
3762 : FFFF           : DATA
3763 : FFFF           : DATA
3764 : FFFF           : DATA
3765 : FFFF           : DATA
3766 : FFFF           : DATA
3767 : FFFF           : DATA
3768 : FFFF           : DATA
3769 : FFFF           : DATA
376a : FFFF           : DATA
376b : FFFF           : DATA
376c : FFFF           : DATA
376d : FFFF           : DATA
376e : FFFF           : DATA
376f : FFFF           : DATA
3770 : FFFF           : DATA
3771 : FFFF           : DATA
3772 : FFFF           : DATA
3773 : FFFF           : DATA
3774 : FFFF           : DATA
3775 : FFFF           : DATA
3776 : FFFF           : DATA
3777 : FFFF           : DATA
3778 : FFFF           : DATA
3779 : FFFF           : DATA
377a : FFFF           : DATA
377b : FFFF           : DATA
377c : FFFF           : DATA
377d : FFFF           : DATA
377e : FFFF           : DATA
377f : FFFF           : DATA
3780 : FFFF           : DATA
3781 : FFFF           : DATA
3782 : FFFF           : DATA
3783 : FFFF           : DATA
3784 : FFFF           : DATA
3785 : FFFF           : DATA
3786 : FFFF           : DATA
3787 : FFFF           : DATA
3788 : FFFF           : DATA
3789 : FFFF           : DATA
378a : FFFF           : DATA
378b : FFFF           : DATA
378c : FFFF           : DATA
378d : FFFF           : DATA
378e : FFFF           : DATA
378f : FFFF           : DATA
3790 : FFFF           : DATA
3791 : FFFF           : DATA
3792 : FFFF           : DATA
3793 : FFFF           : DATA
3794 : FFFF           : DATA
3795 : FFFF           : DATA
3796 : FFFF           : DATA
3797 : FFFF           : DATA
3798 : FFFF           : DATA
3799 : FFFF           : DATA
379a : FFFF           : DATA
379b : FFFF           : DATA
379c : FFFF           : DATA
379d : FFFF           : DATA
379e : FFFF           : DATA
379f : FFFF           : DATA
37a0 : FFFF           : DATA
37a1 : FFFF           : DATA
37a2 : FFFF           : DATA
37a3 : FFFF           : DATA
37a4 : FFFF           : DATA
37a5 : FFFF           : DATA
37a6 : FFFF           : DATA
37a7 : FFFF           : DATA
37a8 : FFFF           : DATA
37a9 : FFFF           : DATA
37aa : FFFF           : DATA
37ab : FFFF           : DATA
37ac : FFFF           : DATA
37ad : FFFF           : DATA
37ae : FFFF           : DATA
37af : FFFF           : DATA
37b0 : FFFF           : DATA
37b1 : FFFF           : DATA
37b2 : FFFF           : DATA
37b3 : FFFF           : DATA
37b4 : FFFF           : DATA
37b5 : FFFF           : DATA
37b6 : FFFF           : DATA
37b7 : FFFF           : DATA
37b8 : FFFF           : DATA
37b9 : FFFF           : DATA
37ba : FFFF           : DATA
37bb : FFFF           : DATA
37bc : FFFF           : DATA
37bd : FFFF           : DATA
37be : FFFF           : DATA
37bf : FFFF           : DATA
37c0 : FFFF           : DATA
37c1 : FFFF           : DATA
37c2 : FFFF           : DATA
37c3 : FFFF           : DATA
37c4 : FFFF           : DATA
37c5 : FFFF           : DATA
37c6 : FFFF           : DATA
37c7 : FFFF           : DATA
37c8 : FFFF           : DATA
37c9 : FFFF           : DATA
37ca : FFFF           : DATA
37cb : FFFF           : DATA
37cc : FFFF           : DATA
37cd : FFFF           : DATA
37ce : FFFF           : DATA
37cf : FFFF           : DATA
37d0 : FFFF           : DATA
37d1 : FFFF           : DATA
37d2 : FFFF           : DATA
37d3 : FFFF           : DATA
37d4 : FFFF           : DATA
37d5 : FFFF           : DATA
37d6 : FFFF           : DATA
37d7 : FFFF           : DATA
37d8 : FFFF           : DATA
37d9 : FFFF           : DATA
37da : FFFF           : DATA
37db : FFFF           : DATA
37dc : FFFF           : DATA
37dd : FFFF           : DATA
37de : FFFF           : DATA
37df : FFFF           : DATA
37e0 : FFFF           : DATA
37e1 : FFFF           : DATA
37e2 : FFFF           : DATA
37e3 : FFFF           : DATA
37e4 : FFFF           : DATA
37e5 : FFFF           : DATA
37e6 : FFFF           : DATA
37e7 : FFFF           : DATA
37e8 : FFFF           : DATA
37e9 : FFFF           : DATA
37ea : FFFF           : DATA
37eb : FFFF           : DATA
37ec : FFFF           : DATA
37ed : FFFF           : DATA
37ee : FFFF           : DATA
37ef : FFFF           : DATA
37f0 : FFFF           : DATA
37f1 : FFFF           : DATA
37f2 : FFFF           : DATA
37f3 : FFFF           : DATA
37f4 : FFFF           : DATA
37f5 : FFFF           : DATA
37f6 : FFFF           : DATA
37f7 : FFFF           : DATA
37f8 : FFFF           : DATA
37f9 : FFFF           : DATA
37fa : FFFF           : DATA
37fb : FFFF           : DATA
37fc : FFFF           : DATA
37fd : FFFF           : DATA
37fe : FFFF           : DATA
37ff : FFFF           : DATA
