all: escape.out escape2.out

escape.out: escape.o
	gcc -o $@ $+

escape.o: escape.c
	gcc -c -std=c99 -O3 $<

escape2.out: escape2.o
	gcc -o $@ $+

escape2.o: escape2.c
	gcc -c -std=c99 -O3 $<

clean:
	rm -vf escape.out *.o *~ *#
