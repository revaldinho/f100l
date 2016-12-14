

.SUFFIXES: .asm .hex
.asm.hex:; ../F100Asm.py -f $< -o $@ -g hex | tee $*.lst

all: test2.hex mul32.hex


clean:
	rm *hex *lst *~
