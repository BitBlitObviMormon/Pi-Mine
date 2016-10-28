SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: vfp.out arm.out

vfp.out: vfp.o
	ld -o $@ $+

vfp.o: vfp.s
	as $(SW) -o $@ $<

arm.out: arm.o
	ld -o $@ $+

arm.o: arm.s
	as $(SW) -o $@ $<

clean:
	rm -vf vfp.out arm.out *.o *# *~
