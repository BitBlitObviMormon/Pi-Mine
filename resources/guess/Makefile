# Compiler version
CC = gcc-4.9

# Compiler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mtune=cortex-a7

all: guess guess2

guess: guess.o random.o game.o
	$(CC) -o $@ $+

guess2: guess2.o random2.o game2.o
	$(CC) -o $@ $+

random2.o: random2.s
	$(CC) -c $(SW) $<

guess2.o: guess2.s
	$(CC) -c $(SW) $<

game2.o: game2.s
	$(CC) -c $(SW) $<

guess.o: guess.s
	$(CC) -c $(SW) $<

guess.s: guess.c random.h game.h
	$(CC) -S -Os $(SW) $<

random.o: random.s
	$(CC) -c $(SW) $<

random.s: random.c random.h
	$(CC) -S -Os $(SW) $<

game.o: game.s
	$(CC) -c $(SW) $<

game.s: game.c game.h
	$(CC) -S -Os $(SW) $<

clean:
	rm -vf guess guess2 *.o *~ *#
