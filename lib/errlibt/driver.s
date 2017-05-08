/* This driver depends on the Macro and Input/Output Libraries */

.include "../macrolib/macrolib.inc"	// For mov32

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

// int main()
.thumb
.global main
main:
	mov	r4, #0
	mov	r5, #133
	neg	r5, r5
.Loop:
	mov	r1, r4
	bl	printErr	//  Print the error string
	mov32	r1, COLON	//  Load the colon string
	bl	prints		//  Print a colon
	mov	r1, r4
	bl	printErrDetails	//  Print the error details
	mov32	r1, NEWLINE	//  Load the newline string
	bl	prints		//  Print a newline
	sub	r4, r4, #1	//  Decrement the error code
	cmp	r5, r4		//  If error code is less than or equal to -133
	ble	.Loop		//  then loop again

	mov	r0, #13		// Move #13 to r0
	bl	sysExit		// Exit

COLON:
	.asciz	": "
NEWLINE:
	.asciz	"\n"
