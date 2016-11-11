# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

all: syslibt.o

syslibt.o: syslibt.s
	as $(SW) -o $@ $<

clean:
	rm -vf *.o *# *~
