.data
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
	bl	openRnd		// Open the RNG engine

	// Get a byte of random data
	ldr	r4, =DISBYTES	// Load our little pun into r4
	mov	r1, r4
	mov	r2, #128	// We're loading 128 bytes

	bl	randomArray	// Fill the array with entropic data
	bl	seedRnd		// Seed the RNG engine
	bl	randByte	// Generate a random byte
	mov	r4, r0

	bl	closeRnd	// Close the RNG engine
	mov	r0, r4		// Exit with a random number as the exit code
	b	sysExit		// Exit
