/* Painting Tool */

.include "lib/macrolib/macrolib.inc"

.text
.thumb
.syntax	unified

/****************************************************************
 * PAINT LIBRARY BLOCK STRUCTURE                                *
 ****************************************************************
 * 1st Byte: Foreground Color                                   *
 * 2nd Byte: Background Color                                   *
 * 3rd Byte: Block                                              *
 ****************************************************************
 * PAINT LIBRARY BLOCK CHARACTERS                               *
 ****************************************************************
 * 0x00-0x1F: Unicode Block Elements (U+25[xx+0x80])            *
 * 0x20-0x7E: ASCII characters (of same value)                  *
 * 0x7F:      To be determined (Probably Smiley Face)           *
 * 0x80-0xFF: Unicode Box Drawing Characters (U+25[xx-0x80])    *
 ****************************************************************/

/* void paintBlock(struct block* blocks[r0], char* buffer[r1]) */
/* Paints one block and writes it to the buffer, incrementing both pointers */
/* Data Races: The array blocks is read and incremented */
/*             and the array buffer is written to and incremented */
.thumb_func
paintBlock:
	push	{r4, lr}

	// Store the foreground paint header onto the buffer
	mov32	r2, FOREGROUND	// Load the foreground header
	ldm	r2, {r3-r4}	// Load 8 bytes from the header
	stm	r1, {r3-r4}	// Store those 8 bytes
	adds	r1, r1, #7	// We actually only wanted to store 7 bytes
	adds	r2, r2, #7	// So we need to overwrite the 8th byte
	
	// Grab the foreground paint information
	ldrb	r2, [r0]	// Load the foreground paint info
	adds	r0, r0, #1	// Increment the pointer by a byte
	push	{r0, r1}	// Save the passed arguments for later
	movs	r0, r2		// Use the foreground paint info as an argument
	bl	utos		// Convert the foreground paint info to ascii
	movs	r2, r1		// Get the resulting string
	pop	{r0, r1}	// Get back the original arguments

	// Store the foreground paint information
.LforeLoop:
	ldrb	r3, [r2]	// Load a byte from the returned string
	cbz	r3, .LforeSkip	// If we read a null byte then stop
	strb	r3, [r1]	// Write the byte to the buffer
	adds	r1, r1, #1	// Increment the buffer pointer by a byte
	adds	r2, r2, #1	// Increment the returned string by a byte
	b	.LforeLoop	// Loop again
.LforeSkip:

	// Store the background paint header onto the buffer
	mov32	r2, BACKGROUND	// Load the background header
	ldm	r2, {r3-r4}	// Load 8 bytes from the header
	stm	r1, {r3-r4}	// Store those 8 bytes
	adds	r1, r1, #8	// Increment the pointers by 8 bytes
	adds	r2, r2, #8

	// Grab the background paint information
	ldrb	r2, [r0]	// Load the background paint info
	adds	r0, r0, #1	// Increment the pointer by a byte
	push	{r0, r1}	// Save the passed arguments for later
	movs	r0, r2		// Use the background paint info as an argument
	bl	utos		// Convert the background paint info to ascii
	movs	r2, r1		// Get the resulting string
	pop	{r0, r1}	// Get back the original arguments

	// Store the background paint information
.LbackLoop:
	ldrb	r3, [r2]	// Load a byte from the returned string
	cbz	r3, .LbackSkip	// If we read a null byte then stop
	strb	r3, [r1]	// Write the byte to the buffer
	adds	r1, r1, #1	// Increment the buffer pointer by a byte
	adds	r2, r2, #1	// Increment the returned string by a byte
	b	.LbackLoop	// Loop again
.LbackSkip:
	movs	r3, #'m'	// Don't forget to append an 'm' at the end
	strb	r3, [r1]	// Store the 'm'
	adds	r1, r1, #1	// Increment the buffer pointer by a byte

	// Read the block character
	ldrb	r2, [r0]	// Load the block info
	adds	r0, r0, #1	// Increment the pointer by a byte

	// "Style" the block (Convert it to Unicode)
	// For now we'll just print it out and hope Unicode chars aren't passed
	// TODO: Implement Unicode characters
	strb	r2, [r1]	// Store the ASCII character
	adds	r1, r1, #1	// Increment the pointer by a byte

	pop	{r4, pc}

/* void paint(struct block* blocks[r0], char* buffer[r1], int numBlocks[r2]) */
/* Paints numBlocks blocks and writes them to the buffer as a string */
/* Make sure you have AT LEAST 30 characters of buffer space per block! */
/* Unicode characters mixed with escape codes take up a lot of memory! */
/* Note: The pointers are returned to their normal location (unmodified) */
/* Data Races: The array blocks is read and the array buffer is written to */
.thumb_func
.global	paint
.type	paint, %function
paint:
	push	{r0-r1, r4, lr}	// Save return point and args for later
	movs	r4, r2		// Put the length in a local variable

	// While the length is not zero, keep on parsing blocks
.LpaintLoop:
	cbz	r4, .LpaintSkip	// If the length is zero, finish
	subs	r4, r4, #1	// Decrement the length by 1
	bl	paintBlock	// Paint the block
	b	.LpaintLoop	// Move on to the next block

.LpaintSkip:
	pop	{r0-r1, r4, pc}	// Return

.text
FOREGROUND:	// The string to print the foreground color escape code
	.byte	033
	.ascii	"[38;5;"
BACKGROUND:	// The string to print the background color escape code
	.ascii	"m"
	.byte	033
	.ascii	"[48;5;"

