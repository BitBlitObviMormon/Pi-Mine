/* Data.MessageHistory.s */
/* CONSTANTS */
.set	BUFLEN,	4096

.include "lib/macrolib/macrolib.inc"

.bss
.balign	2
HANDLE:	// The message history's file handle
	.word	0
MSGBEG:	// The pointer to the beginning of the message history
	.word	0
MSGEND:	// The pointer to the end of the message history
	.word	0

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
	pop	{pc}	// Return
	
/* void closeMessageHistory() */
/* Uninitializes the message history object */
.thumb_func
.global	closeMessageHistory
.type	closeMessageHistory, %function
closeMessageHistory:
	push	{lr}	// Save return point for later
	pop	{pc}	// Return

/* void writeToMessageHistory(int len[r0], char* buf[r1]) */
/* Writes the buffer to the message history */
.thumb_func
.global	writeToMessageHistory
.type	writeToMessageHistory, %function
writeToMessageHistory:
	push	{lr}	// Save return point for later
	pop	{pc}	// Return
