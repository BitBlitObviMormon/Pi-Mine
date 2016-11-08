all: escape.out

escape.out: escape.o
	gcc -o $@ $+

escape.o: escape.c
	gcc -c -std=c99 -O3 $<

clean:
	rm -vf escape.out *.o *~ *#
