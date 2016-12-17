

.SUFFIXES: .cpp .hex
.cpp.hex:; ../F100Asm.py -f $< -o $@ -g hex | tee $*.lst

.SUFFIXES: .asm .cpp
.asm.cpp:; cpp -E $< | grep -v '^#'>  $@

all: test2.hex mul32.hex


clean:
	rm *hex *lst *~ *cpp
