//Escape Codes C
#include <stdio.h>

/**********************************************************
 * Runs all of the valid character codes for the terminal *
 * The first number (i) is the style (normal, bold, etc)  *
 * The second number (x) is the foreground color          *
 * The third number (y) is the background color           *
 **********************************************************
 * Styles:                                                *
 * 0. Clear formatting                                    *
 * 1. Make bold                                           *
 * 2. Make dim                                            *
 * 4. Make underlined                                     *
 * 5. Make the text blink (although it's never done so)   *
 * 7. Swap background and foreground colors               *
 * 8. Make text hidden                                    *
 **********************************************************/
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
