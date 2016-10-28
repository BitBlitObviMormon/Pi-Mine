SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: driver.out

driver.out: driver.o gamelibt.o
	ld -o $@ $+

gamelibt.o: gamelibt.s
	as $(SW) -o $@ $<

driver.o: driver.s
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
