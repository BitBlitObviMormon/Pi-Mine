/* Input/Output (Thumb) Library Driver */
/* Depends on System and Macro Libraries */

.include "../macrolib/macrolib.inc"

// SIZE OF STRING BUFFER
.set	BUFSIZE, 255

/* Allocated Data */
.bss
BUFFER:
	.space	BUFSIZE

/* Read-Only Data */
.section .rodata
PROMPT:
	.asciz	"Word to put in file? "
FILENAME:
	.asciz	"temp"

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

.balign	2
.thumb
.syntax	unified

/* int[r0] main() */
.thumb_func
.global main
main:
	// Prompt for input
	mov32	r1, PROMPT
	bl	promptString

	// Write to a file called "temp"
	mov32	r0, FILENAME
	bl	writeToFile

	// Now read that file and display its contents
	mov32	r0, FILENAME
	bl	readFromFile

	// Exit with no error code
	movs	r0, #0		// Move #0 to r0
	b	sysExit

/* char*[r1] promptString(char* buf[r1]) */
.thumb_func
.global	promptString
.type	promptString, %function
promptString:
	push	{lr}	// Save return point for later

	// Print the given string
	bl	prints

	// Use allocated memory as a string buffer
	mov32	r1, BUFFER

	// Prompt for input
	movs	r2, #BUFSIZE
	bl	gets

	pop	{pc}	// Return

/* void writeToFile(char* filename[r0], char* buf[r1]) */
.thumb_func
.global	writeToFile
.type	writeToFile, %function
writeToFile:
	push	{r1, r4-r5, lr}	// Save return point for later

	// Create the file and save its handle
	movs	r1, #0		// Use the default file permissions
	bl	fwrite
	movs	r4, r0

	// Write the passed string
	pop	{r1}
	bl	fprints

	// Write 1234567890
	movs	r0, r4
	mov32	r1, #1234567890
	bl	fputi

	// Write -1234567890
	movs	r0, r4
	mov32	r1, #-1234567890
	bl	fputi

	// Write the numbers -9 through 9
	mov32	r5, #-9
.LwriteLoop:
	// Print i
	movs	r0, r4
	movs	r1, r5
	bl	fputi

	// i++
	adds	r5, #1

	// If i <= 9 then continue
	movs	r0, #9
	cmp	r5, r0
	ble	.LwriteLoop

	// Close the file
	movs	r0, r4
	bl	fclose

	pop	{r4-r5, pc}	// Return

/* void readFromFile(char* filename[r0]) */
.thumb_func
.global	readFromFile
.type	readFromFile, %function
readFromFile:
	push	{r0, r4-r5, lr}	// Save return point for later

	// Open the file for reading
	bl	fread
	movs	r4, r0	// Save the file handle

	// 

	// Use allocated memory as a string buffer
	mov32	r5, BUFFER
.LKeepReading:

	// Read from the file
	movs	r0, r4		// File handle
	movs	r1, r5		// Buffer
	movs	r2, #BUFSIZE	// Buffer length
	bl	fgets

	// If fgets returns zero then we hit the end of the file.
	movs	r3, #0
	cmp	r0, r3
	ble	.LStopReading

	// Print the output read from the file
	bl	prints
	b	.LKeepReading
.LStopReading:

	// Close the file
	movs	r0, r4
	bl	fclose

	// Delete the file
	pop	{r0}
	bl	fdelete

	pop	{r4-r5, pc}	// Return
