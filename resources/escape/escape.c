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
  printf("\n");
  
  for (char i = 0; i < 9; i++) {
    //I'm going to ignore 3 and 6, they don't do anything for either terminal
    if (i != 3 && i != 6) {
      for (char x = 0; x < 8; x++) {
	for (char y = 0; y < 8; y++) {
	  //Write a block and its escape sequences
	  printf("\e[0m\e[%dm\e[3%dm\e[4%dm %d%d%d ", i, x, y, i, x, y);
	}
      
	//Start a new line for each background color (without formatting)
	printf("\e[0m\e[37m\e[40m\n");
      }
    }
  }

  printf("\n");
}

int main() {
  //Run all of the color codes
  codes();

  return 0;
}
