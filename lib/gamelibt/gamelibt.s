/* Game Input Library (Thumb) */
/* Depends on Input/Output Library and System Library */

.include "../iolibt/ioconst.s" //  INCLUDE FILE STREAM INFO

//  FUNCTION CONSTANTS
.set	TCGETS, 0x5401
.set	TCSETS, 0x5402

//  VARIABLE CONSTANTS
.set	ICANON, 2
.set	VTIME,  5
.set	VMIN,   6
.set	ECHO,   8
.set	NCCS,  32

//  MEMORY SIZE
.set	TERMIOSSIZE, 60
.set	TCFLAG_T,     4
.set	CC_T,	      1
.set	SPEED_T,      4

//  MEMORY LAYOUT
.set	IFLAG,   0
.set	OFLAG,   4
.set	CFLAG,   8
.set	LFLAG,  12
.set	C_CC,	  17
.set	ISPEED, 52
.set	OSPEED, 56

.data
SETCOLOR:	// The string to print the fore-back-color escape code
	.byte	033
	.ascii	"[38;5;"
FORECOLOR:	// Edit characters at mem address to change foreground color
	.ascii	"???m"
	.byte	033
	.ascii	"[48;5;"
BACKCOLOR:	// Edit characters at mem address to change background color
	.asciz	"???m"
CURSORPOS:	// The string to print the set cursor position escape code
	.byte	033
	.ascii	"["
CURSORX:	// Edit characters at mem address to change X position
	.ascii	"???;"
CURSORY:	// Edit characters at mem address to change Y position
	.asciz	"???H"

.bss
TERMIOS:	// This is where the old termios struct will be saved for later
	.skip	TERMIOSSIZE

.text
.syntax	unified

/* void write3Digits(int num[r0], char* buf[r1]) */
/* Writes a number, padding zeros to make it three digits long */
/* Data Races: Writes to the character array buf */
.thumb_func
.type	write3Digits, %function
write3Digits:
	push	{r4, r5, lr}	// Save return point for later

	// Save buffer for later
	movs	r4, r1

	// Convert the number into a string and save it
	bl	utos
	movs	r5, r0

	// Get the length of the string
	movs	r1, r0		// Len gets its number from r1!
	bl	len		// Returns len in r2!
	adds	r5, r2		// Shift the string by len-1 bytes
	subs	r5, #1
	adds	r4, #2		// Shift the given string by 3 bytes
	movs	r0, #3		// count = 3

	// Store all of the digits of the number
.L3DigitsLoop:
	cbz	r2, .L3DigitZero// If we read enough then begin writing zeros
	ldrb	r3, [r5]	// Load a byte from the returned string
	strb	r3, [r4]	// Write the byte to the buffer
	subs	r4, r4, #1	// Decrement the buffer pointer by a byte
	subs	r5, r5, #1	// Decrement the returned string by a byte
	subs	r2, r2, #1	// Decrement len by 1
	subs	r0, r0, #1	// Decrement count by 1
	b	.L3DigitsLoop	// Loop again
	// Write zeros for every digit the number has less than 3
.L3DigitZero:
	cbz	r0, .L3DigitsEnd// If we wrote 3 digits then end
	movs	r3, '0'		// Get the ASCII number 0
	strb	r3, [r4]	// Write the byte to the buffer
	subs	r4, r4, #1	// Decrement the buffer pointer by a byte
	subs	r0, r0, #1	// Decrement count by 1
	b	.L3DigitZero	// Loop again
.L3DigitsEnd:

	pop	{r4, r5, pc}	// Return

/* void hideCursor() */
/* Tells the terminal to hide the cursor */
/* Data Races: The terminal *may* hide the cursor */
.thumb_func
.global	hideCursor
.type	hideCursor, %function
hideCursor:
	ldr	r1, =HIDECURSOR	// Load the escape code from memory
	b	prints		// Print the escape code onto the console

/* void showCursor() */
/* Tells the terminal to show the cursor */
/* Data Races: The terminal *may* show the cursor */
.thumb_func
.global	showCursor
.type	showCursor, %function
showCursor:
	ldr	r1, =SHOWCURSOR	// Load the escape code from memory
	b	prints		// Print the escape code onto the console

/* void loadCursor() */
/* Tells the terminal to load the previously saved cursor location */
/* Data Races: The terminal *may* load the cursor location */
.thumb_func
.global	loadCursor
.type	loadCursor, %function
loadCursor:
	ldr	r1, =LOADCURSOR	// Load the escape code from memory
	b	prints		// Print the escape code onto the console

/* void saveCursor(int x[r0], int y[r1]) */
/* Tells the terminal to save the cursor location */
/* Data Races: The terminal *may* save the cursor location */
.thumb_func
.global	saveCursor
.type	saveCursor, %function
saveCursor:
	ldr	r1, =SAVECURSOR	// Load the escape code from memory
	b	prints		// Print the escape code onto the console

/* void homeCursor() */
/* Sets the cursor's position to home (1,1) */
/* Data Races: Sets the terminal cursor's position */
.thumb_func
.global	homeCursor
.type	homeCursor, %function
homeCursor:
	ldr	r1, =HOMECURSOR	// Load the escape code from memory
	b	prints		// Print the escape code onto the console

/* void setCursor(int x[r0], int y[r1]) */
/* Sets the cursor's position to (x,y) */
/* Data Races: Sets the terminal cursor's position */
.thumb_func
.global	setCursor
.type	setCursor, %function
setCursor:
	push	{r4, lr}	// Save return point for later

	// Save cursor (x) position
	movs	r4, r0
	movs	r0, r1

	// Write the x number
	ldr	r1, =CURSORX
	bl	write3Digits

	// Write the y number
	movs	r0, r4
	ldr	r1, =CURSORY
	bl	write3Digits

	// Print out the resulting string
	ldr	r1, =CURSORPOS
	bl	prints

	pop	{r4, pc}	// Return

/* void setColor(char foreground[r0], char background[r1]) */
/* Sets the foreground and background colors for the next text displayed */
/* Data Races: The console text color is modified and the data COLORTEXT */
/* through BACKGROUND is modified. */
.thumb_func
.global	setColor
.type	setColor, %function
setColor:
	push	{r4, lr}	// Save return point for later

	// Save background color
	movs	r4, r1

	// Write the foreground color
	ldr	r1, =FORECOLOR
	bl	write3Digits

	// Write the background color
	movs	r0, r4
	ldr	r1, =BACKCOLOR
	bl	write3Digits

	// Print out the resulting string
	ldr	r1, =SETCOLOR
	bl	prints

	pop	{r4, pc}	// Return

/* void clearFrame() */
/* Clears the screen and sets the position to home */
/* (Setting the cursor to home and simply writing over will be quicker) */
/* Data Races: Clears the console's screen and sets cursor position to home */
.thumb_func
.global	clearFrame
.type	clearFrame, %function
clearFrame:
	ldr	r1, =CLEARFRAME	// Load the escape code from memory
	b	prints		// Print the escape code onto the console

/* void restoreTerminal() */
/* Restores the terminal's state to its original state. */
/* This function MUST be called after using raw mode */
/* or the terminal will be left in an unusable state! */
/* Data Races: Reads from TERMIOS */
.thumb_func
.global	restoreTerminal
.type	restoreTerminal, %function
restoreTerminal:
	movs	r0, #STDIN	// Use the standard input stream
	movw	r1, #TCSETS	// Tell the terminal to apply terminal settings
	ldr	r2, =TERMIOS	// Tell the terminal to apply the backup settings
	b	sysIoctl	// Use the I/O Control system call

/* void rawMode() */
/* Sets the terminal state to raw mode; input is not echoed onto the screen */
/* restoreTerminal MUST be called after using raw mode */
/* or the terminal will be left in an unusable state! */
/* Data Races: TERMIOS and the terminal's settings are overwritten */
.thumb_func
.global	rawMode
.type	rawMode, %function
rawMode:
	push	{lr}		// Save return point for later

	subs	sp, sp, #TERMIOSSIZE	// Allocate stack space for termios

	movs	r0, #STDIN	// Use the standard input stream
	movw	r1, #TCGETS	// Tell the terminal to get terminal settings
	ldr	r2, =TERMIOS	// Tell it to write the settings onto the backup
	bl	sysIoctl	// Use the I/O Control system call

	// Copy the global struct to local stack for modification
	mov	r1, sp		// Get the address of the stack
	ldr	r0, =TERMIOS	// Get the address of the global struct
	ldm r0!, {r2-r7} //  Copy 24 bytes
	stm r1!, {r2-r7}
	ldm r0!, {r2-r7} //  Copy 24 bytes
	stm r1!, {r2-r7}
	ldm r0!, {r2-r4} //  Copy 12 bytes
	stm r1!, {r2-r4}
//	vldmia.32 r0!, {s0-s14}	// Copy 60 bytes
// 	vstmia.32 r1!, {s0-s14}

	// Now we need to modify the struct on the stack
	ldr	r0, [sp, #LFLAG]	// Get the control flags
	movs	r3, #(ECHO | ICANON)	// Disable Echo and Canonical mode
	bic	r0, r0, r3
	str	r0, [sp, #LFLAG]	// Set the control flags

	// Make input non-blocking, with no timeout
	// (essentially set to polling mode)
	movs	r0, #0			// VTIME and VMIN are adjacent bytes, so
	strh	r0, [r1, #(C_CC + VTIME)] //  VTIME and VMIN are adjacent bytes, so writing a halfword to VTIME should overwrite both
	// Ready to write back to the device driver now
	mov	r2, sp		// Apply the terminal settings from the stack
	movs	r0, #STDIN	// Use the standard input stream
	movw	r1, #TCSETS	// Tell the terminal to apply terminal settings
	bl	sysIoctl	// Use an I/O Control system call

	adds	sp, sp, #60	// Delete the terminal settings from the stack

	pop	{pc}		// Return

.text
.align	2
SAVECURSOR:
	.byte	033
	.asciz	"[s"
LOADCURSOR:
	.byte	033
	.asciz	"[u"
HIDECURSOR:
	.byte	033
	.asciz	"[?25l"
SHOWCURSOR:
	.byte	033
	.asciz	"[?25h"
HOMECURSOR:
	.byte	033
	.asciz	"[H"
CLEARFRAME:
	.byte	033
	.asciz	"[2J\e[1;1H"
