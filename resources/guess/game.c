#include "game.h"
#include "random.h"
#include <stdio.h>

//Make the user guess a number
int guess(unsigned long long bigNum)
{
  unsigned long long guess;
  char done = 0;
  int tries = 0;

  do
  {
    //Get the response
    ++tries;
    printf("? ");
    scanf("%llu", &guess);

    //If the number was lower
    if (guess < bigNum)
      printf("Guess higher!\n");
    //If the number was higher
    else if (guess > bigNum)
      printf("Guess lower!\n");
    //If the number was just right
    else
      done = 1; //You guessed it, yay!
  } while (!done);

  //Print the number of tries the user took
  printf("You took %d tries to guess %llu!\n", tries, bigNum);
  return tries;
}

//Guess a byte
void guessByte()
{
  printf("Guess a number between 0 and 255.\n");
  guess((unsigned long long)randomByte() & 0x00000000000000ffL);
  printf("\nEasy? Good. Now try this one.\n");
}

//Guess a short
void guessShort()
{
  printf("Guess a number between 0 and 65535.\n");
  guess((unsigned long long)randomShort() & 0x000000000000ffffL);
  printf("\nNice! See if you can beat this one.\n");
}

//Guess an int
void guessInt()
{
  printf("Guess a number between 0 and 4294967295. Good luck!\n");
  guess((unsigned long long)randomInt() & 0x00000000ffffffffL);
  printf("\nHard? That was only 32 bits! Let's see how well you do with 64!\n");
}

//Guess a long (good luck!)
void guessLong()
{
  printf("Guess a number between 0 and 18446744073709551616...\nI hope you live through this one.\n");
  guess((unsigned long long)randomLong());
  printf("\nI don't know how you did it, but congratulations.\n");
}
