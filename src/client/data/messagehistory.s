/* Data.MessageHistory.s */
/* CONSTANTS */
.set	BUFLEN,	4096

.include "lib/macrolib/macrolib.inc"

.bss
.balign	2
FHANDLE:// The message history's file handle
	.word	0
MSGBEG:	// The pointer to the beginning of the message history
	.word	0
MSGEND:	// The pointer to the end of the message history
	.word	0

.data
FILENAME:
	.asciz	"log.txt"
ENDL:
	.asciz	"\n"

.text
.thumb
.syntax	unified

/* void initMessageHistory() */
/* Initializes the message history object */
.thumb_func
.global	initMessageHistory
.type	initMessageHistory, %function
initMessageHistory:
	push	{lr}	// Save return point for later

	// Create a file and get its handle
	mov32	r0, FILENAME
	movs	r1, #0	//Default file permissions
	bl	fwrite
	mov32	r1, FHANDLE
	str	r0, [r1]

	pop	{pc}	// Return
	
/* void closeMessageHistory() */
/* Uninitializes the message history object */
.thumb_func
.global	closeMessageHistory
.type	closeMessageHistory, %function
closeMessageHistory:
	push	{lr}	// Save return point for later

	// Close the file handle and set it to null
	mov32	r1, FHANDLE
	ldr	r0, [r1]
	bl	fclose
	movs	r0, #0
	mov32	r1, FHANDLE
	str	r0, [r1]

	pop	{pc}	// Return

/* void writeToMessageHistory(int len[r0], char* buf[r1]) */
/* Writes the buffer to the message history */
.thumb_func
.global	writeToMessageHistory
.type	writeToMessageHistory, %function
writeToMessageHistory:
	push	{lr}	// Save return point for later

	// Write to the file
	movs	r2, r0
	mov32	r0, FHANDLE
	ldr	r0, [r0]
	bl	sysWrite

	// Write an endline
	mov32	r1, ENDL
	movs	r2, #1
	mov32	r0, FHANDLE
	ldr	r0, [r0]
	bl	sysWrite

	pop	{pc}	// Return
