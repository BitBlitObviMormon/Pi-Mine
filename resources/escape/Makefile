all: escape

escape: escape.o
	gcc -o $@ $+

escape.o: escape.c
	gcc -c -std=c99 -O3 $<

clean:
	rm -vf escape *.o *~ *#
