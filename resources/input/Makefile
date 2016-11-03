# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: input input2 info

input: input.o
	gcc -o $@ $+

input2: input2.o
	ld -o $@ $+

info: info.o
	gcc -o $@ $+

input.o: input.c
	gcc -c -std=c11 -O3 $<

input2.o: input2.s
	as $(SW) -o $@ $<

info.o: info.c
	gcc -c -std=c11 -O3 $<

clean:
	rm -vf input input2 info *.o *~ *#
