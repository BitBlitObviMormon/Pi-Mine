# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt
IOCONST = ../iolibt/ioconst
MACROLIB = ../macrolib/macrolib

all: driver.out

driver.out: driver.o gamelibt.o $(SYSLIBT).o $(IOLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../gamelibt

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../gamelibt

gamelibt.o: gamelibt.s $(IOCONST).inc $(MACROLIB).inc
	as $(SW) -o $@ $<

driver.o: driver.s $(MACROLIB).inc
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
