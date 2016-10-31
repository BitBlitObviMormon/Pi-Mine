#include "random.h"

//The main function call
int main() {
  //Seed the random number generators
  seedGens();

  //Guess all of the stuff
  guessByte();
  guessShort();
  guessInt();
  guessLong();

  //Return to the operating system
  return 0;
}
