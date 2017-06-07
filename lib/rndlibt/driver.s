/* Random Library (Thumb) Driver */
/* Depends on System and Macro libraries */

.include "../macrolib/macrolib.inc"

.bss
DISBYTES:
	.skip	128	// A value to store 32 random ints in

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

/* int[r0] main() */
.thumb
.global main
main:
	// Open up and seed the random number generator
	bl	openRnd		// Open the RNG engine
	bl	seedRnd		// Seed the RNG engine

	// Get 128 bytes of random data
	mov32	r4, DISBYTES	// Load our little pun into r4
	movs	r1, r4
	movs	r2, #128	// We're loading 128 bytes
	bl	randomArray	// Fill the array with entropic data

	// Print out 4 bytes of random data
	mov32	r5, BTEXT
	movs	r1, r5
	bl	prints		// Print "Byte: "
	bl	randByte	// Generate a random byte
	movs	r1, r0
	bl	puti		// Print the byte
	movs	r1, r5
	bl	prints		// Print "Byte: "
	bl	randByte	// Generate a random byte
	movs	r1, r0
	bl	puti		// Print the byte
	movs	r1, r5
	bl	prints		// Print "Byte: "
	bl	randByte	// Generate a random byte
	movs	r1, r0
	bl	puti		// Print the byte
	movs	r1, r5
	bl	prints		// Print "Byte: "
	bl	randByte	// Generate a random byte
	movs	r1, r0
	bl	puti		// Print the byte

	// Print out 4 shorts of random data
	mov32	r5, STEXT
	movs	r1, r5
	bl	prints		// Print "Short: "
	bl	randShort	// Generate a random short
	movs	r1, r0
	bl	puti		// Print the short
	movs	r1, r5
	bl	prints		// Print "Short: "
	bl	randShort	// Generate a random short
	movs	r1, r0
	bl	puti		// Print the short
	movs	r1, r5
	bl	prints		// Print "Short: "
	bl	randShort	// Generate a random short
	movs	r1, r0
	bl	puti		// Print the short
	movs	r1, r5
	bl	prints		// Print "Short: "
	bl	randShort	// Generate a random short
	movs	r1, r0
	bl	puti		// Print the short

	// Print out 4 signed ints of random data
	mov32	r5, ITEXT
	movs	r1, r5
	bl	prints		// Print "Int: "
	bl	randInt		// Generate a random int
	movs	r1, r0
	bl	puti		// Print the int
	movs	r1, r5
	bl	prints		// Print "Int: "
	bl	randInt		// Generate a random int
	movs	r1, r0
	bl	puti		// Print the int
	movs	r1, r5
	bl	prints		// Print "Int: "
	bl	randInt		// Generate a random int
	movs	r1, r0
	bl	puti		// Print the int
	movs	r1, r5
	bl	prints		// Print "Int: "
	bl	randInt		// Generate a random int
	movs	r1, r0
	bl	puti		// Print the int

	// Close the random number generator and then exit
	bl	closeRnd	// Close the RNG engine
	movs	r0, r4		// Exit with a random number as the exit code
	b	sysExit		// Exit

.section .rodata
BTEXT:
	.asciz	"Byte: "
STEXT:
	.asciz	"Short: "
ITEXT:
	.asciz	"Int: "
LTEXT:
	.asciz	"Long: "
