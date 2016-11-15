# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7

all: pow2.out

pow2.out: pow2.o
	ld -o $@ $+

pow2.o: pow2.s
	as $(SW) -o $@ $<

clean:
	rm -vf pow2.out *.o *# *~
