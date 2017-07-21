/* Client.s */
/* CONSTANTS */
.set	WIDTH,    80
.set	HEIGHT,   24
.set	BLOCKS,   HEIGHT * WIDTH
.set	BLOCKLEN, BLOCKS * 3
.set	BUFLEN,   BLOCKS * 30

.include "lib/macrolib/macrolib.inc"

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

.thumb
.syntax	unified

/* int main() */
.thumb_func
.global main
main:
	// Allocate 5,760 bytes of space for block data
	movw	r1, #BLOCKLEN
	bl	malloc
	movs	r4, r0

	// Allocate 57,600 bytes of space for buffer
	movw	r1, #BUFLEN
	bl	malloc
	movs	r5, r0

	// Start up the message history
	bl	initMessageHistory

	// Initialize the gui
	movs	r0, #WIDTH	// width  = 80
	movs	r1, #HEIGHT	// height = 24
	movs	r2, r4		// blockBuffer
	bl	initMessenger
	bl	initMessageHistory

	// Add a few messages
	mov32	r1, PITEXT
	bl	len
	mov32	r0, PITEXT
	movs	r1, r4
	bl	messengerMessage
	mov32	r1, PITEXT
	bl	len
	mov32	r1, PITEXT
	mov	r0, r2
	bl	writeToMessageHistory
	mov32	r1, NAMETEXT
	bl	len
	mov32	r0, NAMETEXT
	movs	r1, r4
	bl	messengerMessage
	mov32	r1, NAMETEXT
	bl	len
	mov32	r0, NAMETEXT
	mov	r0, r2
	bl	writeToMessageHistory

	// Paint the gui into a printable format
	movs	r0, r4		// blockBuffer
	movs	r1, r5		// charBuffer
	movs	r2, #BLOCKS	// length
	bl	paint		// Paint blockBuffer -> charBuffer

	// Print the buffer
	movs	r1, r5
	bl	prints

	// Get input from the messenger
	bl	messengerInput
	movs	r6, r0
	movs	r7, r1

	// Print the input and write it to the message history
	bl	writeToMessageHistory
	movs	r1, r7
	bl	prints

	// Close the Message History
	bl	closeMessageHistory
	
	// Unallocate all of the buffers
	movs	r0, r4
	movw	r1, #BUFLEN
	bl	free
	movs	r0, r5
	movw	r1, #BLOCKLEN
	bl	free

	// Exit
	movs	r0, #2		// Move #13 to r0
	b	sysExit

.text
PITEXT:
	.asciz	"Welcome to the Pi-Mine Messenger!"
NAMETEXT:
	.asciz	"What is your name?"
