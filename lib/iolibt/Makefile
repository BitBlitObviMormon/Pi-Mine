# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
MACROLIB = ../macrolib/macrolib

all: driver.out

driver.out: driver.o iolibt.o $(SYSLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../iolibt

iolibt.o: iolibt.s ioconst.inc $(MACROLIB).inc
	as $(SW) -o $@ $<

driver.o: driver.s $(MACROLIB).inc
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
