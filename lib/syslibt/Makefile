# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7

all: syslibt.o

syslibt.o: syslibt.s sysconst.inc
	as $(SW) -o $@ $<

clean:
	rm -vf *.o *# *~
