/* Messenger GUI */
/* CHARACTERS */
.set	VER, '|'	//Vertical bar
.set	HOR, '-'	//Horizontal bar
.set	RJN, '+'	//Right Junction
.set	LJN, '+'	//Left Junction
.set	TJN, '+'	//Top Junction
.set	BJN, '+'	//Bottom Junction
.set	JUN, '+'	//4-way Junction
.set	SPA, ' '	//Empty Space
.set	CUR, '#'	//Cursor
.set	TLC, '/'	//Top-Left Corner
.set	TRC, '\'	//Top-Right Corner
.set	BLC, '\'	//Bottom-Left Corner
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
	//Get the expected end-buffer address
	mul	r3, r0, r1	//bufSize = width * height (number of blocks)
	movs	r0, #3
	mul	r3, r0, r3	//bufSize = width * height * 3 (size of buf)
	adds	r3, r2, r3	//bufEnd = buf + bufSize

.LinitMessengerLoop:
	//Generate nothing but junctions for now
	//TODO: Make GUI
	movs	r0, #FORECLR
	strb	r0, [r2]	//*buf = foregroundColor
	adds	r2, #1		//buf++
	movs	r0, #BACKCLR
	strb	r0, [r2]	//*buf = backgroundColor
	adds	r2, #1		//buf++
	movs	r0, #JUN
	strb	r0, [r2]	//*buf = junctionBlock
	adds	r2, #1		//buf++

	//If buf < bufEnd Then Repeat
	cmp	r2, r3
	blo	.LinitMessengerLoop
	bx	lr		//Return

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
