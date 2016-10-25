//$$$ WRITE A SIMPLE PROGRAM USING ONLY THUMB2 INSTRUCTIONS
.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

.thumb
.global exit
/* void exit(int) */
/* Exits with the error code given */
exit:
	mov	r7, #1	//Exit with
	svc	#0	//	whatever is in r0

//int main()
.thumb
.global main
main:
	bl	printNums	//Call printPositive()
	mov	r0, #13		//Move #13 to r0
	b	exit

//$$$ CREATE AN IF/ELSE STATEMENT USING THUMB2 INSTRUCTIONS
//$$$ CREATE A WHILE LOOP USING THUMB2 INSTRUCTIONS
/* void printNums() */
/* Prints the numbers 1-9 onto the screen */
.thumb
.global printNums
printNums:
	push	{lr}		//Save return point for later

	//For loop
	mov	r0, #9	//x = 9
loop:	bl	printi	//print(x)
	sub	r0, #1	//x--
	bne	loop	//If x != 0 jump back to the loop
	pop	{pc}	//Return

TEXT:
	.word	positiveText
	.word	negativeText
positiveText:
	.ascii	" is a positive number.\012\000"
negativeText:
	.ascii	" is a negative number.\012\000"
