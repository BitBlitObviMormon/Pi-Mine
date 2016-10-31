#include <stdlib.h>
#include <time.h>
#include "random.h"

//The seeds of the random number generators
typedef struct {
  char       bseed;
  short      sseed;
  int        iseed;
  long long  lseed;
} SeedStruct;

//Our global struct that holds all of the RNG seeds
SeedStruct seeds = {0, 0, 0, 0};

//Seeds the random byte number generator with a byte value (0-255)
void seedBGen(char  seed) { seeds.bseed = seed; }

//Seeds the random short number generator with a short value (0-65536)
void seedSGen(short seed) { seeds.sseed = seed; }

//Seeds the random int number generator with an int value (0-4294967296)
void seedIGen(int   seed) { seeds.iseed = seed; }

//Seeds the random long number generator with a long value (0-Don't go there)
void seedLGen(long long seed) { seeds.lseed = seed; }

//Seeds the random number generators with the time
void seedGens() {
  char seeds[4] = {0, 0, 0, 0};

  //Get 4 pseudo-random numbers using the cpu's clock cycles and the time
  seeds[0] = (char)(clock() + time(NULL));
  seeds[1] = (char)(clock() + time(NULL));
  seeds[2] = (char)(clock() + time(NULL));
  seeds[3] = (char)(clock() + time(NULL));

  //Seed every generator using these values
  seedBGen(seeds[0]);
  seedSGen((short)seeds[1]);
  seedIGen((int)((short)seeds[2]));
  seedLGen((long long)((int)((short)seeds[3])));
}

//Get a random byte value
char randomByte() {
  srand(seeds.bseed);
  seeds.bseed = (char)rand() + 2;
  return seeds.bseed;
}

//Get a random short value
short randomShort()
{
  srand(seeds.sseed);
  seeds.sseed = (short)rand() + 2;
  return seeds.sseed;
}

//Get a random int value
int randomInt()
{
  srand(seeds.iseed);
  seeds.iseed = (int)rand() + 2;
  return seeds.iseed;
}

//Get a random long value (Two ints mashed together in this case)
long long randomLong()
{
  srand(seeds.lseed);
  seeds.iseed = (int)rand(); //Randomize least sig word
  seeds.iseed |= (((long long)(int)rand()) << 32) + 2; //Randomize most sig word
  return seeds.lseed;  
}
