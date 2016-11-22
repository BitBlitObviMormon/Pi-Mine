# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7
SYSLIBT = ../syslibt/syslibt
IOLIBT = ../iolibt/iolibt

all: driver.out

driver.out: driver.o errlibt.o $(SYSLIBT).o $(IOLIBT).o
	ld -o $@ $+

$(SYSLIBT).o: $(SYSLIBT).s
	cd ../syslibt; make; cd ../errlibt

$(IOLIBT).o: $(IOLIBT).s
	cd ../iolibt; make; cd ../errlibt

errlibt.o: errlibt.s
	as $(SW) -o $@ $<

driver.o: driver.s
	as $(SW) -o $@ $<

errlibt.s: generate.out
	./generate.out

errlibt.h: generate.out
	./generate.out

generate.out: generate.o
	gcc -o $@ $+

generate.o: generate.c
	gcc -c -std=c99 -O3 $<

clean:
	rm -vf *.out *.o *# *~ errlibt.s errlibt.h