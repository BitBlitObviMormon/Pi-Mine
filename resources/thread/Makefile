# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7

all: thread.out

thread.out: thread.o
	ld -o $@ $+

thread.o: thread.s
	as $(SW) -o $@ $<
