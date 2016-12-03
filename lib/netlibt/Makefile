# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt

all: driver.out

driver.out: driver.o netlibt.o $(SYSLIBT).o $(IOLIBT).o
	ld -o $@ $+

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../netlibt

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../netlibt

netlibt.o: netlibt.s netconst.s
	as $(SW) -o $@ $<

driver.o: driver.s
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
