/* Input/Output Library (Thumb) */
// I/O CONSTANTS
.set	STDIN,  0
.set	STDOUT, 1
.set	STDERR, 2

// SYSCALLS
.set	READ,  3
.set	WRITE, 4
.set	OPEN,  5
.set	CLOSE, 6

// ASCII CONSTANTS
.set	ZERO,    0x30
.set	NINE,    0x39
.set	DECIMAL, 0x2e
.set	MINUS,   0x2d

/* READ CONSTANTS */
.set	O_RDONLY, 0
.set	O_WRONLY, 1
.set	O_RDWR,   2

// SIZE OF INT -> STRING ARRAY
.set	ISSIZE, 12	//sign + 10 chars + null

.data
INTS:	//Space for the string of an int (int -> string)
	.skip	ISSIZE	//Make room for the int's char buffer
	.asciz	"Ya!" //If this data is changed, we've got a memory leak
	
//$$$ USE A SYSTEM CALL TO GET INPUT FROM THE CONSOLE
/* void fgets(int fd[r0], char* buf[r1], int length[r2]) */
/* Grabs a string from the stream fd and null-terminates it */
/* Data Races: fgets writes to the character array buf */
.text
.thumb
.global	fgets
.type	fgets, %function
fgets:
	push	{r1, r4, lr}//Save return point for later
	sub	r2, #1		//Make room for the null-terminator
	push	{r2}		//Save the length of the buffer
	bl	sysRead
	mov	r3, #0
	pop	{r1, r2}	//Get the arguments again: length, *buf
	add	r2, r1		//Move the buffer pointer over to the end
	strb	r3, [r1]	//Null-terminate the buffer
	pop	{r4, pc}	//Return

/* int[r0] fgeti(int fd[r0])  */
/* Grabs an integer from the stream fd */
/* Data Races: fgeti modifies static address space, */	
/* DON'T RUN ON MULTIPLE THREADS! */
.thumb
.global	fgeti
.type	fgeti, %function
fgeti:
	push	{lr}	//Save the return point for later
	ldr	r1, =INTS
	mov	r2, #ISSIZE
	bl	fgets	//Get a string from the console
	bl	stoi	//String -> Int
	mov	r0, r2
	pop	{pc}	//Return

//$$$ USE A SYSTEM CALL TO OUTPUT AN INTEGER TO CONSOLE
/* void fprinti(int fd[r0], const int num[r1]) */
/* Prints an integer onto the stream */
/* Data Races: No memory is changed */
.thumb
.global	fprinti
.type	fprinti, %function
fprinti:
	push	{r0, lr}//Save return point for later
	mov	r0, r1
	bl	itos	//Convert the int into a string
	mov	r1, r0	//Ready the string for printing
	pop	{r0}
	bl	fprints	//Print the string
	pop	{pc}	//Return

/* void fprints(int fd[r0], char* buf[r1]) */
/* Prints a string onto the stream */
/* Data Races: The character array is read from */
.thumb
.global	fprints
.type	fprints, %function
fprints:
	push	{lr}	//Store return point for later

	//Prepare sysWrite(uint fd, const char* buf, size_t count)
	mov	r2, #0	//count = 0

	//Calculate the length of the string
	push	{r1}		//Save the buffer address for later
.Lfprintsloop:
	ldrb	r3, [r1]	//temp = buf[i]
	add	r1, #1		//i++
	cbz	r3, .Lfprintsend//If character is null, end the loop
	add	r2, #1		//count++
	b	.Lfprintsloop	//Loop back to the beginning
.Lfprintsend:
	pop	{r1}		//Retrieve the buffer address
	bl	sysWrite	//Print the string to the stream
	
	pop	{pc}	//Return

/* void fputi(const int num[r0]) */
/* Prints an integer onto the stream and appends a newline */
/* Data races: No memory is changed */
.thumb
.global	fputi
.type	fputi, %function
fputi:
	push	{r0, lr}//Save return point for later
	bl	itos	//Convert the int into a string
	mov	r1, r0	//Ready the string for printing
	pop	{r0}	//Get the file stream
	bl	fputs	//Print the string
	pop	{pc}	//Return

//$$$ CREATE A FOR LOOP USING THUMB2 INSTRUCTIONS
//$$$ TRAVERSE AN ARRAY	
//$$$ USE A SYSTEM CALL TO OUTPUT DATA TO THE CONSOLE
//$$$ USE A SYSTEM CALL TO OUTPUT TEXT TO THE CONSOLE	
/* void fputs(int fd[r0], char* buf[r1]) */
/* Prints a string onto the stream and appends a newline */
/* Data Races: The character array buf is read from */
.thumb
.global	fputs
.type	fputs, %function
fputs:
	push	{r0, lr}//Store return point for later
	bl	fprints
	pop	{r0}	//Get the file stream
	ldr	r1, =ENDLINE
	bl	fprints
	pop	{pc}	//Return

/* int[r0] fopen(int fd[r0]) */
/* Closes the filehandle's file */
/* Data races: No memory is accessed */
.thumb
.global	fclose
.type	fclose, %function
fclose:
	b	sysClose	//Close the file

/* int[r0] fopen(const char* filename[r0]) */
/* Opens a file for *READING AND WRITING* and returns the file handle */
/* Data races: The character array filename is read */
.thumb
.global	fopen
.type	fopen, %function
fopen:
	mov	r1, #O_RDWR	//Declare reading and writing
	mov	r2, #0		//Not creating a file, so no mode_t
	b	sysOpen		//Open the file

/* int[r0] fread(const char* filename[r0]) */
/* Opens a file for *READING* and returns the file handle */
/* Data races: The character array filename is read */
.thumb
.global	fread
.type	fread, %function
fread:
	mov	r1, #O_RDONLY	//Declare reading only
	mov	r2, #0		//Not creating a file, so no mode_t
	b	sysOpen		//Open the file
	
/* int[r0] fwrite(const char* filename[r0]) */
/* Opens a file for *WRITING* and returns the file handle */
/* It will create a file if necessary, but will not create a directory path */
/* Data races: The character array filename is read */
.thumb
.global	fwrite
.type	fwrite, %function
fwrite:
	mov	r1, #O_WRONLY	//Declare writing only

	//TODO: CREATING A FILE SO I NEED TO IMPLEMENT A MODE_T
	mov	r2, #0		//Not creating a file, so no mode_t
	b	sysOpen		//Open the file
	
//$$$ USE A SYSTEM CALL TO GET INPUT FROM THE CONSOLE
/* void gets(char* buf[r1], int length[r2]) */
/* Grabs a string from the console */
/* Data Races: gets writes to the character array buf */
.text
.thumb
.global	gets
.type	gets, %function
gets:
	mov	r0, #STDIN	//Use the standard input stream and
	b	fgets		//Pretend we called fgets instead

/* int[r0] geti()  */
/* Grabs an integer from the console */
/* Data Races: geti modifies static address space, */	
/* DON'T RUN ON MULTIPLE THREADS! */
.thumb
.global	geti
.type	geti, %function
geti:
	mov	r0, #STDIN	//Use the standard input stream and
	b	fgeti		//Pretend we called fgeti instead

/* char*[r1] itos(const int[r0]) */
/* Takes an integer and returns a null-terminated char array */
/* Data Races: Returns static memory which is overwritten on */
/* the next itos call; Needs to be replaced with a brk call! */
.thumb
.global	itos
.type	itos, %function
itos:
	push	{r0, lr}	//Save return point for later
	
	pop	{r0, pc}	//Return

/* int[r2] pow(const int x[r0], int n[r1]) */
/* Returns x ^ n */
/* Data races: No memory is changed */
.thumb
pow:	//X(r0)^N(r1)
	cbz	r1, .Lpowend	//End loop if iterator is zero
	mul	r2, r2, r0	//Multiply by ten
	sub	r1, #1		//One less power to go
	b	pow		//If the loop isn't over keep going
.Lpowend:	
	bx	lr	//Return

//$$$ USE A SYSTEM CALL TO OUTPUT AN INTEGER TO CONSOLE
/* void printi(const int) */
/* Prints an integer onto the console and appends a new line */
/* Data Races: No memory is changed */
.thumb
.global	printi
.type	printi, %function
printi:
	mov	r0, #STDOUT	//Use the standard output stream and
	b	fprinti		//Pretend we called fprinti instead

/* void prints(char* buf[r1]) */
/* Prints a string onto the console */
/* Data Races: The character array is read from */
.thumb
.global	prints
.type	prints, %function
prints:
	mov	r0, #STDOUT	//Use the standard output stream and
	b	fprints		//Pretend we called fprints instead

/* void puti(const int num[r0]) */
/* Prints an integer onto the console */
/* Data races: No memory is changed */
.thumb
.global	puti
.type	puti, %function
puti:
	mov	r0, #STDOUT	//Use the standard output stream and
	b	fputi		//Pretend we called fputi instead

//$$$ CREATE A FOR LOOP USING THUMB2 INSTRUCTIONS
//$$$ TRAVERSE AN ARRAY	
//$$$ USE A SYSTEM CALL TO OUTPUT DATA TO THE CONSOLE
//$$$ USE A SYSTEM CALL TO OUTPUT TEXT TO THE CONSOLE	
/* void puts(char* buf[r1]) */
/* Prints a string onto the console and appends a newline */
/* Data Races: The character array is read from */
.thumb
.global	puts
.type	puts, %function
puts:
	mov	r0, #STDOUT	//Use the standard output stream and
	b	fputs		//Pretend we called fputs instead

/* int[r1] stoi(const char*[r0]) */
/* Takes a null-terminated char array and returns an integer */
/* Data Races: The character array is read from */
.thumb
.global	stoi
.type	stoi, %function
stoi:
	push	{r4-r7, lr}	//Save return point for later
	mov	r3, r0
	mov	r4, r0
	mov	r5, #0		//i = 0
	mov	r6, #0  	//Ans = 0

	//Check the sign of the number
	ldrb	r7, [r4]
	sub	r7, #MINUS

	//If the sign is negative then trim the '-'
	cbnz	r7, .Lstoiloop
	add	r3, #1
.Lstoiloop:
	// Seek to the end of the string
	ldrb	r0, [r4]
	add	r4, #1

	//If we're not done seeking then loop back up
	cbz	r0, .Lstoimiddle	//If null then end the loop
	b	.Lstoiloop
.Lstoimiddle:
	// Add each number to the register result
	sub	r4, #1
	ldrb	r2, [r4]
	add	r5, #1	//i++
	mov	r0, #10	//n = 10 (n^x)
	sub	r2, #48	//ASCII -> INT
	mov	r1, r5	//x = i  (n^x)
	bl	pow	//n^x

	//If the answer is positive then add, else subtract
	cbnz	r7, .Lstoiadd
.Lstoisub:
	sub	r6, r2	//Ans -= pow()
	b	.Lstoiend
.Lstoiadd:
	add	r6, r2	//Ans += pow()
.Lstoiend:
	//If address of r4 equals address of r3 then end the loop
	cmp	r3, r4
	bne	.Lstoimiddle

	pop	{r4-r7, pc}	//Return

/* ssize_t[r0] sysRead(uint fd[r0], char* buf[r1], size_t count[r2]) */
/* Uses the system call to read from a buffer */
/* Data Races: The string buf is written to */
.thumb
sysRead:
	push	{r7, lr}	//Save return point for later
	mov	r7, $READ	//Prepare to invoke read system call
	svc	#0		//Invoke read system call
	pop	{r7, pc}	//Return
	
/* ssize_t[r0] sysWrite(uint fd[r0], const char* buf[r1], size_t count[r2]) */
/* Uses the system call to write to a buffer */
/* Data Races: The string buf is read from */
.thumb
sysWrite:
	push	{r7, lr}	//Save return point for later
	mov	r7, $WRITE	//Prepare to invoke write system call
	svc	#0		//Invoke write system call
	pop	{r7, pc}	//Return


/* int[r0] sysOpen(const char* pathname[r0], int flags[r1], mode_t mode[r2]) */
/* Uses the system call to open a file and get its file handle */
/* Data Races: The character array pathname is read */
.thumb
sysOpen:	
	push	{r7, lr}	//Save return point for later
	mov	r7, $OPEN	//Prepare to invoke open system call
	svc	#0		//Invoke open system call
	pop	{r7, pc}	//Return

/* int[r0] sysClose(int fd[r0]) */
/* Uses the system call to close a file */
/* Data Races: close does not access memory */
.thumb
sysClose:
	push	{r7, lr}	//Save return point for later
	mov	r7, $CLOSE	//Prepare to invoke close system call
	svc	#0		//Invoke close system call
	pop	{r7, pc}	//Return

/* char*[r1] utos(const int[r0]) */
/* Takes an unsigned int and returns a null-terminated char array */
/* Data Races: Returns static memory which is overwritten on */
/* the next utos/itos call; Needs to be replaced with a brk call! */
.thumb
.global	utos
.type	utos, %function
utos:
	bx	=.LutosARM
.arm
.LutosARM:	
	push	{r4-r5, lr}		//Save return point for later
	mov	r4, r0			//preserve arguments over following
	mov	r5, r1			//function calls
	mov	r0, r1

	//Divide r0 by ten
	ldr	r2, =DIV10		//Load the magic number for r0 / 10
	umull	r2, r0, r2, r0		//r2 *= MAGICNUM (high bits is r0 / 10)

	sub	r5, r5, r0, LSL #3	//number - 8*quotient
	sub	r5, r5, r0, LSL #1	// - 2*quotient = remainder

	cmp	r0, #0			//quotient non-zero?
	movne	r1, r0			//quotient to r1...
	mov	r0, r4			//buffer pointer unconditionally to r0
	blne	utos			//conditional recursive call to utos

	add	r5, r5, #'0'		//final digit
	strb	r5, [r0], #1		//store digit at end of buffer

	bx	=.LutosTHUMB
.thumb
.LutosTHUMB:	
	pop	{r4-r5, pc}		//Return
	
.align	2
TEXT:
	.word	ENDLINE
	.word	HELLO
DIV10:
	.word	0x1999999a
ENDLINE:
	.asciz	"\012"
HELLO:
	.asciz	"Hello! \342\227\257"
