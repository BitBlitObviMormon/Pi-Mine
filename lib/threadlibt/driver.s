/* Threading Library (Thumb) Driver */
/* Depends on Macro, Memory, and System Libraries */

.include "threadconst.inc"	// Include thread flags and info
.include "../macrolib/macrolib.inc"	// For mov32

// FLAGS
.set	CLONE_FLAGS,	(CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_PARENT | CLONE_THREAD | CLONE_IO)

// OTHER CONSTANTS
.set	STDOUT,	   0x1	     // The standard output stream
.set	STRLEN,	   12	     // How many characters to print
.set	STACKSIZE, 0x4000    // The size of the child thread's stack (16KB)
.set	DELAY1,    250000000 // The delay for main thread (0.25sec)
.set	DELAY2,    200000000 // The delay for second thread (0.2sec)

// SHARED DATA AND STRINGS
.data
.align	2
SHAREDDATA:
	.ascii	"0"
TEXT1:
	.ascii	"Thread 1: "
DATA1:
	.ascii	"0\n" // Edit memory to change number for TEXT1
TEXT2:
	.ascii	"Thread 2: "
DATA2:
	.ascii	"0\n" // Edit memory to change number for TEXT2
.text

/* void main() */
/* The main thread */
.arm
.align	2
.global _start
_start:
.global	main
main:
	// Set to thumb mode
	add	pc, #1
	nop

.thumb
.syntax	unified
	//  Create a new thread
	mov32	r0, thread_main
	movw	r1, #STACKSIZE
	bl	createThread
	push	{r0}	// Save its process id for later
.Loop1:
	// Print the shared data then exit the loop if it is 9 or greater
	bl	print1	// Print the shared data
	cmp	r3, #'9'
	blo	.Loop1

	// Wait for the second thread to finish
	pop	{r0}
	bl	join

	// Exit the program
	mov	r0, #0
	b	sysExit

/* void thread_main() */
/* The second thread */
.global	thread_main
thread_main:
	// Print the shared data then exit the loop if it is 9 or greater
	bl	print2	// Print the shared data
	mov	r0, #'9'
	cmp	r3, r0
	blo	thread_main

	// Exit the program
	mov	r0, #0
	b	sysExit

/* int[r3] print1() */
/* Prints the shared data onto the screen (for main thread) */
.global	print1
print1:
	push	{lr}

	// Increment the shared data and then store it in the private data
	mov32	r0, SHAREDDATA
	mov32	r2, DATA1
	ldrb	r3, [r0]	// Read value from address SHAREDDATA
	add	r3, #1		// Add 1 to it
	strb	r3, [r0]	// Store it in SHAREDDATA
	strb	r3, [r2]	// Store it in DATA1

	// Print the shared data
	mov32	r1, TEXT1
	bl	print

	// Sleep for a while (We'll assume we aren't interrupted in the middle)
	mov	r0, #0
	mov32	r1, DELAY1	// ~0.25 seconds
	bl	nanosleep

	pop	{pc}

/* void print2() */
/* Prints the shared data onto the screen (for second thread) */
.global	print2
print2:
	push	{lr}

	// Load the shared data and then store it in the private data
	mov32	r0, SHAREDDATA
	mov32	r2, DATA2
	ldrb	r3, [r0]	// Read value from address SHAREDDATA
	strb	r3, [r2]	// Store it in DATA2

	// Print the shared data
	mov32	r1, TEXT2
	bl	print

	// Sleep for a while (We'll assume we aren't interrupted in the middle)
	mov	r0, #0
	mov32	r1, DELAY2	// ~0.2 seconds
	bl	nanosleep

	pop	{pc}

/* int[r3] print(char* buf[r1]) */
/* Prints the string at a specific length, always. */
.global	print
print:
	mov	r0, #STDOUT	// Write to the standard output stream
	mov	r2, #STRLEN	// Write a constant number of characters
	b	sysWrite

