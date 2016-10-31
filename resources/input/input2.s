// I/O CONSTANTS
.set	STDIN, 0x0
.set	STDOUT, 0x1
.set	STDERR, 0x2

// FUNCTION CONSTANTS
.set	TCGETS, 0x5401
.set	TCSETS, 0x5402
.set	ICANON, 2
.set	ECHO, 8
.set	VMIN, 6
.set	VTIME, 5
.set	NCCS, 32

// MEMORY SIZE
.set	TERMIOS, 60
.set	TCFLAG_T, 4
.set	CC_T, 1
.set	SPEED_T, 4

// MEMORY LAYOUT
.set	C_IFLAG, 0
.set	C_OFLAG, 4
.set	C_CFLAG, 8
.set	C_LFLAG, 12
.set	C_CC, 17
.set	C_ISPEED, 52
.set	C_OSPEED, 56

// SYSTEM CALLS
.set	READ, 0x3
.set	WRITE, 0x4
.set	IOCTL, 0x36

.data
savedState:
	/* Save enough space to backup the terminal's settings */
	/* (Replace with brk system call to allow several saved states) */
	.skip	TERMIOS	//sizeof(termios)
newState:
	/* Save enough space to change the terminal's settings */
	/* (Replace with brk system call to allow several saved states) */
	.skip	TERMIOS	//sizeof(termios)
	
.text
.arm
.global	_start
_start:
	blx main

/* int main() */
.thumb
.global	main
.type	main, %function
main:
	bl	setConsoleFlags
	mov	r7, #1
	svc	#0

/* termios*[r0] setConsoleFlags() */
/* Sets all of the necessary flags for a game */
.thumb
.global	setConsoleFlags
.type	setConsoleFlags, %function
setConsoleFlags:
	push	{r7, lr}	//Save return point for later
	mov	r0, #STDIN	//stdin
	ldr	r2, =newState	//Write to the new state
	mov	r7, #IOCTL	//Ioctl
	ldr	r1, =TCGETS	//	TCGETS (0x5401)
	svc	#0		//		system call
	mov	r0, r2		//copyFrom = newState
	ldr	r1, =savedState //copyTo = savedState
	bl	copyConsole	//Backs up the console flags to memory
	pop	{r7, pc}	//Return

/* void copyConsole(termios* copyFrom[r0], termios* copyTo[r1]) */
/* Copies the console copyFrom to copyTo */	
.thumb
.global	copyConsole
.type	copyConsole, %function
copyConsole:
	push	{r4-r6}	//Backup these registers

	//Copy 60 bytes of data from copyFrom to copyTo
	ldmia	r0!, {r2-r6}	//Copy bytes 01-20
	stmia	r1!, {r2-r6}
	ldmia	r0!, {r2-r6}	//Copy bytes 21-40
	stmia	r1!, {r2-r6}
	ldmia	r0!, {r2-r6}	//Copy bytes 41-60
	stmia	r1!, {r2-r6}
	
	pop	{r4-r6}	//Return these registers to normal
	bx	lr

/* void resetConsoleFlags(termios* savedState[r0]) */
/* Applies the saved state to restore the console to normal */
.thumb
.global	resetConsoleFlags
.type	resetConsoleFlags, %function
resetConsoleFlags:
	push	{r7, lr}	//Save return point for later
	mov	r0, #STDIN	//stdin
	ldr	r2, =savedState	//Apply the old state
	mov	r7, #IOCTL	//Ioctl
	ldr	r1, =TCSETS	//	TCSETS (0x5402)
	svc	#0		//		system call
	pop	{r7, pc}	//Return

/* void read(uint fd, char* buf, size_t count) */
/* Uses the system call to read from a buffer */
.thumb
.global	sysRead
.type	sysRead, %function
sysRead:
	mov	r7, $READ	//Prepare to invoke syscall read
	svc	#0		//Invoke system call read
	bx	lr		//Return
	
/* void write(uint fd, const char* buf, size_t count) */
/* Uses the system call to write to a buffer */
.thumb
.global	sysWrite
.type	sysWrite, %function
sysWrite:
	mov	r7, $WRITE	//Prepare to invoke syscall write
	svc	#0		//Invoke system call write
	bx	lr		//Return
