/* Input/Output (Thumb) Library Driver */
/* Depends on System and Macro Libraries */

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

// int main()
.thumb
.global main
main:
	bl	printNums	// Call printPositive()
	mov	r0, #13		// Move #13 to r0
	b	sysExit

/* void printNums() */
/* Prints the numbers 1-9 onto the screen */
.thumb
.global printNums
printNums:
	push	{lr}		// Save return point for later

	// For loop
	mov	r0, #9	// x = 9
loop:	bl	printi	// print(x)
	sub	r0, #1	// x--
	bne	loop	// If x != 0 jump back to the loop
	pop	{pc}	// Return

TEXT:
	.word	positiveText
	.word	negativeText
positiveText:
	.ascii	" is a positive number.\012\000"
negativeText:
	.ascii	" is a negative number.\012\000"
