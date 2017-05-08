# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
MEMLIBT = ../memlibt/memlibt

all: driver.out

driver.out: driver.o threadlibt.o $(MEMLIBT).o $(SYSLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../threadlibt

$(MEMLIBT).o: $(MEMLIBT).s
	cd ../memlibt; make; cd ../threadlibt

threadlibt.o: threadlibt.s threadconst.inc
	as $(SW) -o $@ $<

driver.o: driver.s threadconst.inc
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
