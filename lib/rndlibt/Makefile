# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt

all: driver.out

driver.out: driver.o rndlibt.o $(SYSLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../rndlibt

rndlibt.o: rndlibt.s
	as $(SW) -o $@ $<

driver.o: driver.s
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
