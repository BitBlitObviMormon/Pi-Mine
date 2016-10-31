#ifndef RANDOM_H
#define RANDOM_H

//Seeds the random byte number generator with a byte value (0-255)
void seedBGen(char  seed);

//Seeds the random short number generator with a short value (0-65536)
void seedSGen(short seed);

//Seeds the random int number generator with an int value (0-4294967296)
void seedIGen(int   seed);

//Seeds the random long number generator with a long value (0-Don't go there)
void seedLGen(long long seed);

//Seeds the random number generators with the time
void seedGens();

//Get a random byte value
char randomByte();

//Get a random short value
short randomShort();

//Get a random int value
int randomInt();

//Get a random long value
long long randomLong();

#endif //RANDOM_H
