# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt

all: driver.out

driver.out: driver.o $(IOLIBT).o $(SYSLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../macrolib

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../macrolib

driver.o: driver.s macrolib.inc
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
