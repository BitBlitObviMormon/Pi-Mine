# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7

all: input.out input2.out info.out

input.out: input.o
	gcc -o $@ $+

input2.out: input2.o
	ld -o $@ $+

info.out: info.o
	gcc -o $@ $+

input.o: input.c
	gcc -c -std=c11 -O3 $<

input2.o: input2.s
	as $(SW) -o $@ $<

info.o: info.c
	gcc -c -std=c11 -O3 $<

clean:
	rm -vf input input2 info *.o *~ *#
