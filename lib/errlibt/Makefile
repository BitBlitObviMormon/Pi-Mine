# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt
MACROLIB = ../macrolib/macrolib

all: driver.out

driver.out: driver.o errlibt.o $(SYSLIBT).o $(IOLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../errlibt

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../errlibt

errlibt.o: errlibt.s
	as $(SW) -o $@ $<

driver.o: driver.s errno.inc $(MACROLIB).inc
	as $(SW) -o $@ $<

errlibt.s: generate.out
	./generate.out

errno.inc: errlibt.s ;

generate.out: generate.o
	gcc -o $@ $+

generate.o: generate.c $(MACROLIB).inc
	gcc -c -std=c99 -Os $<

clean:
	rm -vf *.out *.o *# *~ errlibt.s errno.inc
