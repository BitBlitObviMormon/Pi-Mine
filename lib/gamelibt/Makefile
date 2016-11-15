# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt

all: driver.out

driver.out: driver.o gamelibt.o $(SYSLIBT).o $(IOLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../gamelibt

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../gamelibt

gamelibt.o: gamelibt.s
	as $(SW) -o $@ $<

driver.o: driver.s
	as $(SW) -o $@ $<

clean:
	rm -vf driver.out *.o *# *~
