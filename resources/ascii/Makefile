all: ascii.out

ascii.out: ascii.o
	gcc -o $@ $+

ascii.o: ascii.c
	gcc -c -std=c99 -O3 $<

clean:
	rm -vf ascii.out *.o *~ *#
