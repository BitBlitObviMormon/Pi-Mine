// Escape Codes C
#include <stdio.h>

/**************************************
 * Prints all of the ascii characters *
 **************************************/
void ascii() {
  for (char i = 0; i < 255; ++i)
    putchar(i);
  
  printf("%c\n", 255);
}

int main() {
  // Print all of the ascii characters
  ascii();

  return 0;
}
