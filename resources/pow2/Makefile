# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: pow2

pow2: pow2.o
	ld -o $@ $+

pow2.o: pow2.s
	as $(SW) -o $@ $<

clean:
	rm -vf pow2 *.o *# *~
