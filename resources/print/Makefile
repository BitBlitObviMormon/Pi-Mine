all: print print2

print2: print2.o
	gcc -o $@ $+

print: print.o
	gcc -o $@ $+

print2.o: print2.s
	gcc -c $<

print.o: print.s
	gcc -c $<

print.s: print.c
	gcc -S -O3 $<

clean:
	rm -vf print print2 *.o
