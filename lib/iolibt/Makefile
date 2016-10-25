SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: driver.out

driver.out: thumb.o iolibt.o
	ld -o $@ $+

iolibt.o: iolibt.s
	as $(SW) -o $@ $<

thumb.o: thumb.s
	as $(SW) -o $@ $<

clean:
	rm -vf thumb *.o *# *~
