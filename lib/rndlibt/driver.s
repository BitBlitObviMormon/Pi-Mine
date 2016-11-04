/* SYSCALLS */
.set	WRITE, 4

.data
DISBYTES:
	.byte	0	//A value to store a random number in

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
	mov	r2, #1		//We're only loading one byte

	// Apparently this uses a bad file number... need to check out.
	bl	randomArray	//Fill the byte with entropic data
	
	bl	closeRnd	//Close the RNG engine
	ldr	r0, [r4]	//Exit with the random number as an error code
	b	exit		//Exit

/* ssize_t[r0] sysWrite(uint fd[r0], const char* buf[r1], size_t count[r2]) */
/* Uses the system call to write to a buffer */
/* Data Races: The string buf is read from */
.thumb
sysWrite:
	push	{r7, lr}	//Save return point for later
	mov	r7, $WRITE	//Prepare to invoke write system call
	svc	#0		//Invoke write system call
	pop	{r7, pc}	//Return
