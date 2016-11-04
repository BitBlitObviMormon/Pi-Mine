/* SYSCALLS */
.set	WRITE, 4

.data
DISBYTES:
	.skip	128	//A value to store 32 random ints in

.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

/* void exit(int[r0]) */
/* Exits with the error code given */
.thumb
.global exit
exit:
	mov	r7, #1	//Exit with
	svc	#0	//	whatever is in r0

/* int[r0] main() */
.thumb
.global main
main:
	bl	openRnd		//Open the RNG engine

	//Get a byte of random data
	ldr	r4, =DISBYTES	//Load our little pun into r4
	mov	r1, r4
	mov	r2, #128	//We're loading 128 bytes

	bl	randomArray	//Fill the array with entropic data

	bl	seedRnd

	bl	closeRnd	//Close the RNG engine
	ldrb	r0, [r4]	//Exit with a random number as the exit code
	b	exit		//Exit
