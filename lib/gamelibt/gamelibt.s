/* Game Input Library (Thumb) */
/* Depends on Input/Output Library and System Library */
// I/O CONSTANTS
.set	STDIN,  0
.set	STDOUT, 1
.set	STDERR, 2

.data
COLORTEXT:	//The string to print the fore-back-color escape code
	.ascii	"\e[38;5;"
FOREGROUND:	//Edit characters at mem address to change foreground color
	.ascii	"???m\e[48;5;"
BACKGROUND:	//Edit characters at mem address to change background color
	.asciz	"???m"

.text

/* void loadCursor() */
/* Tells the terminal to load the previously saved cursor location */
/* Data Races: The terminal *may* load the cursor location */
.thumb
.global	loadCursor
.type	loadCursor, %function
loadCursor:
	ldr	r1, =LOADCURSOR	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void saveCursor() */
/* Tells the terminal to save the cursor location */
/* Data Races: The terminal *may* save the cursor location */
.thumb
.global	saveCursor
.type	saveCursor, %function
saveCursor:
	ldr	r1, =SAVECURSOR	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void setColor(char foreground[r0], char background[r1]) */
/* Sets the foreground and background colors for the next text displayed */
/* Data Races: The console text color is modified and the data COLORTEXT */
/* through BACKGROUND is modified. */
.thumb
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
.thumb
.global	clearFrame
.type	clearFrame, %function
clearFrame:
	ldr	r1, =CLEARFRAME	//Load the escape code from memory
	b	prints		//Print the escape code onto the console

/* void loadTerminal() */
/* Restores the terminal's state to the previously saved state */
/* Data Races: Reads from %INSERT_VAR_HERE% */
.thumb
.global	loadTerminal
.type	loadTerminal, %function
loadTerminal:
	push	{lr}	//Save return point for later
	pop	{pc}	//Return

/* void saveTerminal() */
/* Saves the terminal's state so that it can restored (needed for RAW mode) */
/* Data Races: Writes to %INSERT_VAR_HERE% */
.thumb
.global	saveTerminal
.type	saveTerminal, %function
saveTerminal:
	push	{lr}	//Save return point for later
	pop	{pc}	//Return

/* void rawMode() */
/* Sets the terminal state to RAW mode; input is not echoed onto the screen */
/* Data Races: The terminal's settings are overwritten */
.thumb
.global	rawMode
.type	rawMode, %function
rawMode:
	push	{lr}	//Save return point for later
	pop	{pc}	//Return

.text
.align	2
SAVECURSOR:
	.asciz	"\e[s"
LOADCURSOR:
	.asciz	"\e[u"
CLEARFRAME:
	.asciz	"\e[2J\e[1;1H"
