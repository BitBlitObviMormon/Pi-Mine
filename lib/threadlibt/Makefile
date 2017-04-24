# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt

all: driver.out

driver.out: driver.o threadlibt.o $(SYSLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../threadlibt

threadlibt.o: threadlibt.s threadconst.s
	as $(SW) -o $@ $<

driver.o: driver.s threadconst.s
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
