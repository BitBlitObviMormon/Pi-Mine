#include "stdio.h"

int global = 5;

//Get input from the user
int getInput(char* question) {
  //The local variable to store the response to
  int response;

  //Ask the question
  printf(question);

  //Recieve input
  scanf("%d", &response);

  int stuff = response + global;

  //Say the response and do math with it
  printf("Your answer, %d, plus %d is %d.\n", response, global, stuff);
  stuff = response - global;
  printf("Your answer, %d, minus %d is %d.\n", response, global, stuff);
  stuff = response * 2;
  printf("Your answer, %d, times 2 is %d.\n", response, stuff);  
  stuff = response / 2;
  printf("Your answer, %d, divided by 2 is more or less %d.\n", response, stuff);

  //Return the response
  return response;
}

//Print the numbers 1-9;
void print() {
  char i = '0';
 PRINT:
  putchar(++i);
  if (i < '9')
    goto PRINT;
}

//The main function call
int main() {
  //Grab user input and return the result
  int value = getInput("What is your favorite number? ");

  //Print the numbers 1-9
  print();
  putchar('\n');

  //Return the input from earlier
  return value;
}
