all: first

first: first.o
	ld -o $@ $+

first.o: first.s
	as -o $@ $<

clean:
	rm -vf first *.o
