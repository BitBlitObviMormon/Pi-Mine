# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt
ERRNO = ../errlibt/errno
MACROLIB = ../macrolib/macrolib

all: driver.out

driver.out: driver.o netlibt.o $(SYSLIBT).o $(IOLIBT).o
	ld -o $@ $+

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../netlibt

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../netlibt

$(ERRNO).inc:
	cd ../errlibt; make; cd ../netlibt

netlibt.o: netlibt.s netconst.inc $(ERRNO).inc $(MACROLIB).inc
	as $(SW) -o $@ $<

driver.o: driver.s $(MACROLIB).inc
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
