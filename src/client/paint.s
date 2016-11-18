/* Painting Tool */

.text

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
.thumb
paintBlock:
	push	{lr}

	//Store the foreground paint header onto the buffer
	ldr	r2, =FOREGROUND	//Load the foreground header
	vldm.32	r2, {s0-s1}	//Load 8 bytes from the header
	vstm.32	r1, {s0-s1}	//Store those 8 bytes
	add	r1, r1, #7	//We actually only wanted to store 7 bytes
	add	r2, r2, #7	//So we need to overwrite the 8th byte
	
	//Grab the foreground paint information
	ldrb	r2, [r0]	//Load the foreground paint info
	add	r0, r0, #1	//Increment the pointer by a byte
	push	{r0, r1}	//Save the passed arguments for later
	mov	r0, r2		//Use the foreground paint info as an argument
	bl	utos		//Convert the foreground paint info to ascii
	mov	r2, r0		//Get the resulting string
	pop	{r0, r1}	//Get back the original arguments

	//Store the foreground paint information
.LforeLoop:
	ldrb	r3, [r2]	//Load a byte from the returned string
	cbz	r3, .LforeSkip	//If we read a null byte then stop
	strb	r3, [r1]	//Write the byte to the buffer
	add	r1, r1, #1	//Increment the buffer pointer by a byte
	b	.LforeLoop	//Loop again
.LforeSkip:

	//Store the background paint header onto the buffer
	ldr	r2, =BACKGROUND	//Load the background header
	vldm.32	r2, {s0-s1}	//Load 8 bytes from the header
	vstm.32	r1, {s0-s1}	//Store those 8 bytes
	add	r1, r1, #8	//Increment the pointers by 8 bytes
	add	r2, r2, #8

	//Grab the background paint information
	ldrb	r2, [r0]	//Load the background paint info
	add	r0, r0, #1	//Increment the pointer by a byte
	push	{r0, r1}	//Save the passed arguments for later
	mov	r0, r2		//Use the background paint info as an argument
	bl	utos		//Convert the background paint info to ascii
	mov	r2, r0		//Get the resulting string
	pop	{r0, r1}	//Get back the original arguments

	//Store the background paint information
.LbackLoop:
	ldrb	r3, [r2]	//Load a byte from the returned string
	cbz	r3, .LbackSkip	//If we read a null byte then stop
	strb	r3, [r1]	//Write the byte to the buffer
	add	r1, r1, #1	//Increment the buffer pointer by a byte
	b	.LbackLoop	//Loop again
.LbackSkip:
	mov	r3, #'m'	//Don't forget to append an 'm' at the end
	strb	r3, [r1]	//Store the 'm'
	add	r1, r1, #1	//Increment the buffer pointer by a byte

	//Read the block character
	ldrb	r2, [r0]	//Load the block info
	add	r0, r0, #1	//Increment the pointer by a byte

	//"Style" the block (Convert it to Unicode)
	//For now we'll just print it out and hope Unicode chars aren't passed
	strb	r2, [r1]	//Store the ASCII character
	add	r1, r1, #1	//Increment the pointer by a byte

	pop	{pc}

/* void paint(struct block* blocks[r0], char* buffer[r1], int length[r2]) */
/* Paints a length number of blocks and writes them to the buffer as a string */
/* Make sure you have AT LEAST 30 characters of buffer space per block! */
/* Unicode characters mixed with escape codes take up a lot of memory! */
/* Note: The pointers are returned to their normal location (unmodified) */
/* Data Races: The array blocks is read and the array buffer is written to */
.thumb
.global	paint
.type	paint, %function
paint:
	push	{r0-r1, r4, lr}	//Save return point and args for later
	mov	r4, r2		//Put the length in a local variable

	//While the length is not zero, keep on parsing blocks
.LpaintLoop:
	cbz	r4, .LpaintSkip	//If the length is zero, finish
	sub	r4, r4, #1	//Decrement the length by 1
	bl	paintBlock	//Paint the block
	b	.LpaintLoop	//Move on to the next block

.LpaintSkip:
	pop	{r0-r1, r4, pc}	//Return

.text
FOREGROUND:	//The string to print the foreground color escape code
	.ascii	"\e[38;5;"
BACKGROUND:	//The string to print the background color escape code
	.ascii	"m\e[48;5;"

