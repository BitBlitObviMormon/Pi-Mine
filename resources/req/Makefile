# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7

all: cast.out float.out req.out

cast.out: cast.o
	ld -o $@ $+

cast.o: cast.s
	as $(SW) -o $@ $<

float.out: float.s
	gcc $(SW) -o $@ $<

req.out: req.o
	ld -o $@ $+

req.o: req.s
	as $(SW) -o $@ $<

clean:
	rm -vf *.out *.o *# *~
