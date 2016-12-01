/* Game Input Library (Thumb) */
/* Depends on Input/Output Library and System Library */

.include "../iolibt/ioconst.s" // INCLUDE FILE STREAM INFO

// FUNCTION CONSTANTS
.set	TCGETS, 0x5401
.set	TCSETS, 0x5402

// VARIABLE CONSTANTS
.set	ICANON, 2
.set	VTIME,  5
.set	VMIN,   6
.set	ECHO,   8
.set	NCCS,  32

// MEMORY SIZE
.set	TERMIOSSIZE, 60
.set	TCFLAG_T,     4
.set	CC_T,	      1
.set	SPEED_T,      4

// MEMORY LAYOUT
.set	IFLAG,   0
.set	OFLAG,   4
.set	CFLAG,   8
.set	LFLAG,  12
.set	C_CC,	  17
.set	ISPEED, 52
.set	OSPEED, 56

.data
COLORTEXT:	//The string to print the fore-back-color escape code
	.ascii	"\e[38;5;"
FOREGROUND:	//Edit characters at mem address to change foreground color
	.ascii	"???m\e[48;5;"
BACKGROUND:	//Edit characters at mem address to change background color
	.asciz	"???m"
TERMIOS:	//This is where the old termios struct will be saved for later
	.skip	TERMIOSSIZE

.text
.syntax	unified

/* void hideCursor() */
/* Tells the terminal to hide the cursor */
/* Data Races: The terminal *may* hide the cursor */
.thumb_func
.global	hideCursor
.type	hideCursor, %function
hideCursor:
	ldr	r1, =HIDECURSOR	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void showCursor() */
/* Tells the terminal to show the cursor */
/* Data Races: The terminal *may* show the cursor */
.thumb_func
.global	showCursor
.type	showCursor, %function
showCursor:
	ldr	r1, =SHOWCURSOR	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void loadCursor() */
/* Tells the terminal to load the previously saved cursor location */
/* Data Races: The terminal *may* load the cursor location */
.thumb_func
.global	loadCursor
.type	loadCursor, %function
loadCursor:
	ldr	r1, =LOADCURSOR	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void saveCursor() */
/* Tells the terminal to save the cursor location */
/* Data Races: The terminal *may* save the cursor location */
.thumb_func
.global	saveCursor
.type	saveCursor, %function
saveCursor:
	ldr	r1, =SAVECURSOR	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void setColor(char foreground[r0], char background[r1]) */
/* Sets the foreground and background colors for the next text displayed */
/* Data Races: The console text color is modified and the data COLORTEXT */
/* through BACKGROUND is modified. */
.thumb_func
.global	setColor
.type	setColor, %function
setColor:
	push	{lr}	//Save return point for later
	// Convert r0 to ascii
	// Write r0 to foreground color
	// Convert r1 to ascii
	// Write r1 to background color
	// Print the fore-back-color escape code
	pop	{pc}	//Return

/* void clearFrame() */
/* Clears the screen and sets the position to home */
/* (Setting the cursor to home and simply writing over will be quicker) */
/* Data Races: Clears the console's screen and sets cursor position to home */
.thumb_func
.global	clearFrame
.type	clearFrame, %function
clearFrame:
	ldr	r1, =CLEARFRAME	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void restoreTerminal() */
/* Restores the terminal's state to its original state. */
/* This function MUST be called after using raw mode */
/* or the terminal will be left in an unusable state! */
/* Data Races: Reads from TERMIOS */
.thumb_func
.global	restoreTerminal
.type	restoreTerminal, %function
restoreTerminal:
	movs	r0, #STDIN	//Use the standard input stream
	movw	r1, #TCSETS	//Tell the terminal to apply terminal settings
	ldr	r2, =TERMIOS	//Tell the terminal to apply the backup settings
	b	sysIoctl	//Use the I/O Control system call

/* void rawMode() */
/* Sets the terminal state to raw mode; input is not echoed onto the screen */
/* restoreTerminal MUST be called after using raw mode */
/* or the terminal will be left in an unusable state! */
/* Data Races: TERMIOS and the terminal's settings are overwritten */
.thumb_func
.global	rawMode
.type	rawMode, %function
rawMode:
	push	{lr}		//Save return point for later

	subs	sp, sp, #TERMIOSSIZE	//Allocate stack space for termios

	movs	r0, #STDIN	//Use the standard input stream
	movw	r1, #TCGETS	//Tell the terminal to get terminal settings
	ldr	r2, =TERMIOS	//Tell it to write the settings onto the backup
	bl	sysIoctl	//Use the I/O Control system call

	//Copy the global struct to local stack for modification
	mov	r1, sp		//Get the address of the stack
	ldr	r0, =TERMIOS	//Get the address of the global struct
	ldm r0!, {r2-r7} // Copy 24 bytes
	stm r1!, {r2-r7}
	ldm r0!, {r2-r7} // Copy 24 bytes
	stm r1!, {r2-r7}
	ldm r0!, {r2-r4} // Copy 12 bytes
	stm r1!, {r2-r4}
//	vldmia.32 r0!, {s0-s14}	//Copy 60 bytes
//	vstmia.32 r1!, {s0-s14}

	//Now we need to modify the struct on the stack
	ldr	r0, [sp, #LFLAG]	//Get the control flags
	movs	r3, #(ECHO | ICANON)	//Disable Echo and Canonical mode
	bic	r0, r0, r3
	str	r0, [sp, #LFLAG]	//Set the control flags

	//Make input non-blocking, with no timeout
	//(essentially set to polling mode)
	movs	r0, #0			//VTIME and VMIN are adjacent bytes, so
	strh	r0, [r1, #(C_CC + VTIME)] // VTIME and VMIN are adjacent bytes, so writing a halfword to VTIME should overwrite both
	//Ready to write back to the device driver now
	mov	r2, sp		//Apply the terminal settings from the stack
	movs	r0, #STDIN	//Use the standard input stream
	movw	r1, #TCSETS	//Tell the terminal to apply terminal settings
	bl	sysIoctl	//Use an I/O Control system call

	adds	sp, sp, #60	//Delete the terminal settings from the stack

	pop	{pc}		//Return

.text
.align	2
SAVECURSOR:
	.asciz	"\e[s"
LOADCURSOR:
	.asciz	"\e[u"
HIDECURSOR:
	.asciz	"\e[?25l"
SHOWCURSOR:
	.asciz	"\e[?25h"
CLEARFRAME:
	.asciz	"\e[2J\e[1;1H"
