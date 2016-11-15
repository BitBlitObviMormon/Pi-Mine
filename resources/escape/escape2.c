//Escape Codes C
#include <stdio.h>

/***********************************************************
 * Spits out text, clears the console, then spits out more *
 ***********************************************************/
void codes() {
  printf("\e[2J\e[1;1H");

  for (int i = 0; i < 30; i++)
    printf("This is awesome!\n");

  printf("\e[1;1H");

  for (int i = 0; i < 23; i++)
    printf("Will be\n");
}

int main() {
  //Run all of the color codes
  codes();

  return 0;
}
