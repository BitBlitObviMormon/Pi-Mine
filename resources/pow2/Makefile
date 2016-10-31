all: pow2

pow2: pow2.o
	ld -o $@ $+

pow2.o: pow2.s
	as -o $@ $<

clean:
	rm -vf pow2 *.o *# *~
