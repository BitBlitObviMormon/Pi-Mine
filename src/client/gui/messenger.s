/* Messenger GUI */
/* CHARACTERS */
.set	VER, '|'	//Vertical bar
.set	HOR, '-'	//Horizontal bar
.set	RJN, '>'	//Right Junction
.set	LJN, '<'	//Left Junction
.set	TJN, '+'	//Top Junction
.set	BJN, '+'	//Bottom Junction
.set	JUN, '+'	//4-way Junction
.set	SPA, ' '	//Empty Space
.set	CUR, '#'	//Cursor
.set	TLC, '/'	//Top-Left Corner
.set	TRC, '\\'	//Top-Right Corner
.set	BLC, '\\'	//Bottom-Left Corner
.set	BRC, '/'	//Bottom-Right Corner

/* COLORS */
.set	BACKCLR, 0x4	//Background Color
.set	FORECLR, 0xE	//Foreground Color
.set	EMPHCLR, 0xB	//Emphasis Color
.set	ERRCLR,  0x9	//Error Color

.data
CURSOR: //The location of the Messenger's cursor
	.short	0	//short cursorPos = 0
	.byte	0	//bool blinkState = false (0=off, 1=on)

.text
.thumb
.syntax	unified

/* void initMessenger(int width[r0], int height[r1], */
/*		      struct block* blocks[r2]) */
/* Generates a gui of size width*height onto the buffer buf. */
/* Make sure that buf has width*height*3 bytes of space or more! */
/* Data Races: The block array blocks is written to */
.thumb_func
.global	initMessenger
.type	initMessenger, %function
initMessenger:
	push	{r4-r6, lr}	//Save variables and return point for later

	//Save the arguments into variables
	movs	r4, r0		//width
	movs	r5, r1		//height
	movs	r6, r2		//blocks

	//Get the expected end-buffer address
	mul	r3, r0, r1	//bufSize = width * height (number of blocks)
	movs	r0, #3
	mul	r3, r0, r3	//bufSize = width * height * 3 (size of buf)
	adds	r3, r2, r3	//bufEnd = buf + bufSize

.LMessengerSpaceLoop:
	//Generate Colors
	movs	r0, #FORECLR
	strb	r0, [r2]	//*buf = foregroundColor
	adds	r2, #1		//buf++
	movs	r0, #BACKCLR
	strb	r0, [r2]	//*buf = backgroundColor
	adds	r2, #1		//buf++
	movs	r0, #SPA
	strb	r0, [r2]	//*buf = space
	adds	r2, #1		//buf++

	//If buf < bufEnd Then Repeat
	cmp	r2, r3
	blo	.LMessengerSpaceLoop

	//Generate Vertical Bar on left
	movs	r0, r4		//width
	movs	r1, r5		//height
	movs	r2, r6		//blocks
	bl	generateVerBar

	//Generate Vertical Bar on right
	movs	r0, r4		//width
	movs	r1, r5		//height
	movs	r2, r6		//blocks
	movs	r3, #3
	mul	r3, r0, r3	//offset = width * 3
	adds	r2, r3		//blocks += offset
	subs	r2, #3		//blocks -= 3
	bl	generateVerBar

	//Generate Horizontal Bar on top
	movs	r0, r4		//width
	movs	r1, r6		//blocks
	bl	generateHorBar

	//Generate Horizontal Bar in middle
	movs	r0, r4		//width
	movs	r1, r6		//blocks
	movs	r2, r5		//height
	movs	r3, #3
	subs	r2, #3		//height -= 3
	mul	r3, r3, r0	//offset = 3 * width
	mul	r3, r3, r2	//offset = 3 * width * height
	adds	r1, r3		//blocks += offset
	bl	generateHorBar

	//Generate Horizontal Bar on bottom
	movs	r0, r4		//width
	movs	r1, r6		//blocks
	movs	r2, r5		//height
	movs	r3, #3
	subs	r2, #1		//height -= 1
	mul	r3, r3, r0	//offset = 3 * width
	mul	r3, r3, r2	//offset = 3 * width * height
	adds	r1, r3		//blocks += offset
	bl	generateHorBar

	//Generate top-left corner
	adds	r0, r6, #2	//blocks += 2
	movs	r1, #TLC	//Top-Left Corner
	strb	r1, [r0]

	//Generate top-right corner
	subs	r0, r6, #1	//blocks -= 1
	movs	r2, #3
	mul	r2, r4, r2	//offset = width * 3
	adds	r0, r2		//blocks += offset
	movs	r1, #TRC	//Top-Right Corner
	strb	r1, [r0]

	//Generate bottom-left corner
	adds	r0, r6, #2	//blocks += 2
	movs	r2, #3
	mul	r2, r4, r2	//offset = width * 3
	subs	r3, r5, #1	//height -= 1
	mul	r2, r2, r3	//offset = width * (height-1) * 3
	adds	r0, r2		//blocks += offset
	movs	r1, #BLC	//Bottom-Left Corner
	strb	r1, [r0]

	//Generate bottom-right corner
	subs	r0, r6, #1	//blocks -= 1
	movs	r2, #3
	mul	r2, r4, r2	//offset = width * 3
	mul	r2, r2, r5	//offset = width * height * 3
	adds	r0, r2		//blocks += offset
	movs	r1, #BRC	//Bottom-Right Corner
	strb	r1, [r0]

	//Generate Left Junction
	adds	r0, r6, #2	//blocks += 2
	movs	r2, #3
	mul	r2, r4, r2	//offset = width * 3
	subs	r3, r5, #3	//height -= 3
	mul	r2, r2, r3	//offset = width * (height-3) * 3
	adds	r0, r2		//blocks += offset
	movs	r1, #LJN	//Left Junction
	strb	r1, [r0]

	//Generate Right Junction
	subs	r0, r6, #1	//blocks -= 1
	movs	r2, #3
	mul	r2, r4, r2	//offset = width * 3
	subs	r3, r5, #2	//height -= 2
	mul	r2, r2, r3	//offset = width * (height-2) * 3
	adds	r0, r2		//blocks += offset
	movs	r1, #RJN	//Right Junction
	strb	r1, [r0]

	pop	{r4-r6, pc}	//Return

/* void updateMessengerCursor(int width[r0], int height[r1], */
/*			      struct block* blocks[r2]) */
/* Call this every cursor tick to make the cursor blink on or off */
/* Data Races: The data CURSOR is read, the block array blocks is written to */
.thumb_func
.global	updateMessengerCursor
.type	updateMessengerCursor, %function
updateMessengerCursor:
	//Get the cursor's address in memory
	subs	r1, #1		//height-- (remove a line)
	mul	r3, r0, r1	//bufSize = width * height (number of blocks)
	movs	r0, #3
	mul	r3, r0, r3	//bufSize = width * height * 3 (size of buf)
	adds	r3, r2, r3	//bufEnd = buf + bufSize
	ldrh	r0, =CURSOR	//Get cusorPos
	adds	r3, r3, r0	//bufEnd += cursorPos
	adds	r3, #2		//bufEnd += 2
	
	ldrb	r1, =CURSOR+2	//Get the cursor's blink state

	//If blinkState Then Goto BlinkOn Else Goto BlinkOff
	cmp	r1, #0
	beq	.LCursorBlinkOff
.LCursorBlinkOn:
	//If the cursor's state is set to on then turn it off
	movs	r2, #0
	strb	r2, [r1]	//blinkState = false
	movs	r0, #SPA
	strb	r0, [r3]	//Blink the cursor off
	b	.LupdateMessengerCursorEnd
.LCursorBlinkOff:
	//If the cursor's state is set to off then turn it on
	movs	r2, #1
	strb	r2, [r1]	//blinkState = true
	movs	r0, #CUR
	strb	r0, [r3]	//Blink the cursor on
.LupdateMessengerCursorEnd:
	bx	lr		//Return

/* void generateHorBar(int width[r0], struct block* blocks[r1]) */
/* Generates a horizontal bar of length width in the given buffer */
/* Data Races: Writes to blocks */
.thumb_func
.type	generateHorBar, %function
generateHorBar:
	adds	r1, #2		//Align the array to the block section
	movs	r3, #HOR	//letter = horizontalBar
.LHorBarLoop:
	cbz	r0, .LHorBarEnd	//while (width != 0)
	strb	r3, [r1]	//*blocks = letter
	adds	r1, #3		//blocks += 3
	subs	r0, #1		//width--
	b	.LHorBarLoop	//Loop again
.LHorBarEnd:
	bx	lr		//Return

/* void generateVerBar(int width[r0], int height[r1], */
/*		       struct block* blocks[r2]) */
/* Generates a vertical bar of length height in the given buffer */
/* Data Races: Writes to blocks */
.thumb_func
.type	generateVerBar, %function
generateVerBar:
	adds	r2, #2		//Align the array to the block section
	movs	r3, #3
	mul	r0, r0, r3	//offset = width * 3
	movs	r3, #VER	//letter = verticalBar
.LVerBarLoop:
	cbz	r1, .LVerBarEnd	//while (height != 0)
	strb	r3, [r2]	//*blocks = letter
	adds	r2, r0		//blocks += offset
	subs	r1, #1		//height--
	b	.LVerBarLoop	//Loop again
.LVerBarEnd:
	bx	lr		//Return
