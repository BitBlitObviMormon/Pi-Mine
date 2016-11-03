# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: driver.out

driver.out: driver.o rndlibt.o
	ld -o $@ $+

rndlibt.o: rndlibt.s
	as $(SW) -o $@ $<

driver.o: driver.s
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
