/* Input/Output Library (Thumb) */
/* Depends on System and Macro Libraries */

.include "../macrolib/macrolib.inc"	// For mov32
.include "ioconst.inc"	//  INCLUDE I/O STREAM INFO

//  ASCII CONSTANTS
.set	ZERO,    0x30
.set	NINE,    0x39
.set	DECIMAL, 0x2e
.set	MINUS,   0x2d

//  SIZE OF INT -> STRING ARRAY
.set	ISSIZE, 12	// sign + 10 chars + null

.data
	.asciz	"Ya!"
	.skip	ISSIZE	// Make room for the int's char buffer
INTS:	// Space for the string of an int written backwards (int -> string)

.text
.syntax	unified

/* void fgets(int fd[r0], char* buf[r1], int length[r2]) */
/* Grabs a string from the stream fd and null-terminates it */
/* Data Races: fgets writes to the character array buf */
.thumb_func
.global	fgets
.type	fgets, %function
fgets:
	push	{r1, r4, lr}// Save return point for later
	subs	r2, #1		// Make room for the null-terminator
	push	{r2}		// Save the length of the buffer
	bl	sysRead
	movs	r3, #0
	pop	{r1, r2}	// Get the arguments again: length, *buf
	adds	r2, r1		// Move the buffer pointer over to the end
	strb	r3, [r1]	// Null-terminate the buffer
	pop	{r4, pc}	// Return

/* int[r0] fgeti(int fd[r0])  */
/* Grabs an integer from the stream fd */
/* Data Races: fgeti modifies static address space, */	
/* DON'T RUN ON MULTIPLE THREADS! */
.thumb_func
.global	fgeti
.type	fgeti, %function
fgeti:
	push	{lr}	// Save the return point for later
	mov32	r1, INTS
	movs	r2, #ISSIZE
	bl	fgets	// Get a string from the console
	bl	stoi	// String -> Int
	movs	r0, r2
	pop	{pc}	// Return

/* void fprinti(int fd[r0], const int num[r1]) */
/* Prints an integer onto the stream */
/* Data Races: No memory is changed */
.thumb_func
.global	fprinti
.type	fprinti, %function
fprinti:
	push	{r0, lr}// Save return point for later
	movs	r0, r1
	bl	itos	// Convert the int into a string
	movs	r1, r0	// Ready the string for printing
	pop	{r0}	// Get the file stream
	bl	fprints	// Print the string
	pop	{pc}	// Return

/* void fprints(int fd[r0], char* buf[r1]) */
/* Prints a string onto the stream */
/* Data Races: The character array is read from */
.thumb_func
.global	fprints
.type	fprints, %function
fprints:
	push	{lr}	// Store return point for later

	// Prepare sysWrite(uint fd, const char* buf, size_t count)
	movs	r2, #0	// count = 0

	bl	len		// Get the length of the string
	bl	sysWrite	// Print the string to the stream

	pop	{pc}	// Return

/* void fputi(int fd[r0], const int num[r0]) */
/* Prints an integer onto the stream and appends a newline */
/* Data races: No memory is changed */
.thumb_func
.global	fputi
.type	fputi, %function
fputi:
	push	{r0, lr}// Save return point for later
	movs	r0, r1
	bl	itos	// Convert the int into a string
	movs	r1, r0	// Ready the string for printing
	pop	{r0}	// Get the file stream
	bl	fputs	// Print the string
	pop	{pc}	// Return

/* void fputs(int fd[r0], char* buf[r1]) */
/* Prints a string onto the stream and appends a newline */
/* Data Races: The character array buf is read from */
.thumb_func
.global	fputs
.type	fputs, %function
fputs:
	push	{r0, lr}// Store return point for later
	bl	fprints
	pop	{r0}	// Get the file stream
	mov32	r1, ENDLINE
	bl	fprints
	pop	{pc}	// Return

/* int[r0] fopen(int fd[r0]) */
/* Closes the filehandle's file */
/* Data races: No memory is accessed */
.thumb_func
.global	fclose
.type	fclose, %function
fclose:
	b	sysClose	// Close the file

/* int[r0] fopen(const char* filename[r0]) */
/* Opens a file for *READING AND WRITING* and returns the file handle */
/* Data races: The character array filename is read */
.thumb_func
.global	fopen
.type	fopen, %function
fopen:
	movs	r1, #O_RDWR	// Declare reading and writing
	movs	r2, #0		// Not creating a file, so no mode_t
	b	sysOpen		// Open the file

/* int[r0] fread(const char* filename[r0]) */
/* Opens a file for *READING* and returns the file handle */
/* Data races: The character array filename is read */
.thumb_func
.global	fread
.type	fread, %function
fread:
	movs	r1, #O_RDONLY	// Declare reading only
	movs	r2, #0		// Not creating a file, so no mode_t
	b	sysOpen		// Open the file
	
/* int[r0] fwrite(const char* filename[r0]) */
/* Opens a file for *WRITING* and returns the file handle */
/* It will create a file if necessary, but will not create a directory path */
/* Data races: The character array filename is read */
.thumb_func
.global	fwrite
.type	fwrite, %function
fwrite:
	movs	r1, #O_WRONLY	// Declare writing only

	// TODO: CREATING A FILE SO I NEED TO IMPLEMENT A MODE_T
	movs	r2, #0		// Not creating a file, so no mode_t
	b	sysOpen		// Open the file

/* void gets(char* buf[r1], int length[r2]) */
/* Grabs a string from the console */
/* Data Races: gets writes to the character array buf */
.text
.thumb_func
.global	gets
.type	gets, %function
gets:
	movs	r0, #STDIN	// Use the standard input stream and
	b	fgets		// Pretend we called fgets instead

/* int[r0] geti()  */
/* Grabs an integer from the console */
/* Data Races: geti modifies static address space, */	
/* DON'T RUN ON MULTIPLE THREADS! */
.thumb_func
.global	geti
.type	geti, %function
geti:
	movs	r0, #STDIN	// Use the standard input stream and
	b	fgeti		// Pretend we called fgeti instead

/* char*[r1] itos(const int[r0]) */
/* Takes an integer and returns a null-terminated char array */
/* Data Races: Returns static memory which is overwritten on */
/* the next itos call; Needs to be replaced with a brk call! */
.thumb_func
.global	itos
.type	itos, %function
itos:
	b	utos	// Call utos instead (itos is still under construction)

/* int[r2] len(const char* buf[r1]) */
/* IMPORTANT: This function passes register ONE and returns register TWO! */
/* Calculates the length of the null-terminated buffer */
/* The pointer to the buffer[r1] is left unchanged */
/* Data Races: The array buf is read */
.thumb_func
.global	len
.type	len, %function
len:
	push	{r1, lr}	// Save return point and buffer address
	movs	r2, #0		// count = 0
.Lenloop:
	ldrb	r3, [r1]	// temp = *buf
	adds	r1, #1		// buf++
	cbz	r3, .Lenend	// If character is null, end the loop
	adds	r2, #1		// count++
	b	.Lenloop	// Loop back to the beginning
.Lenend:
	pop	{r1, pc}	// Return

/* int[r2] pow(const int x[r0], int n[r1]) */
/* Returns x ^ n */
/* Data races: No memory is changed */
.thumb_func
pow:	// X(r0)^N(r1)
	cbz	r1, .Lpowend	// End loop if iterator is zero
	mul	r2, r2, r0	// Multiply by ten
	subs	r1, #1		// One less power to go
	b	pow		// If the loop isn't over keep going
.Lpowend:	
	bx	lr	// Return

/* void printi(const int[r1]) */
/* Prints an integer onto the console and appends a new line */
/* Data Races: No memory is changed */
.thumb_func
.global	printi
.type	printi, %function
printi:
	movs	r0, #STDOUT	// Use the standard output stream and
	b	fprinti		// Pretend we called fprinti instead

/* void prints(char* buf[r1]) */
/* Prints a string onto the console */
/* Data Races: The character array is read from */
.thumb_func
.global	prints
.type	prints, %function
prints:
	movs	r0, #STDOUT	// Use the standard output stream and
	b	fprints		// Pretend we called fprints instead

/* void puti(const int num[r1]) */
/* Prints an integer onto the console */
/* Data races: No memory is changed */
.thumb_func
.global	puti
.type	puti, %function
puti:
	movs	r0, #STDOUT	// Use the standard output stream and
	b	fputi		// Pretend we called fputi instead

/* void puts(char* buf[r1]) */
/* Prints a string onto the console and appends a newline */
/* Data Races: The character array is read from */
.thumb_func
.global	puts
.type	puts, %function
puts:
	movs	r0, #STDOUT	// Use the standard output stream and
	b	fputs		// Pretend we called fputs instead

/* int[r1] stoi(const char*[r0]) */
/* Takes a null-terminated char array and returns an integer */
/* Data Races: The character array is read from */
.thumb_func
.global	stoi
.type	stoi, %function
stoi:
	push	{r4-r7, lr}	// Save return point for later
	movs	r3, r0
	movs	r4, r0
	movs	r5, #0		// i = 0
	movs	r6, #0  	// Ans = 0

	// Check the sign of the number
	ldrb	r7, [r4]
	subs	r7, #MINUS

	// If the sign is negative then trim the '-'
	cbnz	r7, .Lstoiloop
	adds	r3, #1
.Lstoiloop:
	//  Seek to the end of the string
	ldrb	r0, [r4]
	adds	r4, #1

	// If we're not done seeking then loop back up
	cbz	r0, .Lstoimiddle	// If null then end the loop
	b	.Lstoiloop
.Lstoimiddle:
	//  Add each number to the register result
	subs	r4, #1
	ldrb	r2, [r4]
	adds	r5, #1	// i++
	movs	r0, #10	// n = 10 (n^x)
	subs	r2, #48	// ASCII -> INT
	movs	r1, r5	// x = i  (n^x)
	bl	pow	// n^x

	// If the answer is positive then add, else subtract
	cbnz	r7, .Lstoiadd
.Lstoisub:
	subs	r6, r2	// Ans -= pow()
	b	.Lstoiend
.Lstoiadd:
	adds	r6, r2	// Ans += pow()
.Lstoiend:
	// If address of r4 equals address of r3 then end the loop
	cmp	r3, r4
	bne	.Lstoimiddle

	pop	{r4-r7, pc}	// Return

/* char*[r0] utos(int[r0]) */
/* Takes an unsigned int and returns a null-terminated char array */
/* Data Races: Returns static memory which is overwritten on */
/* the next utos/itos call; Needs to be replaced with a brk call! */
/* TODO: Allocate memory for string */
.thumb_func
.global	utos
.type	utos, %function
utos:
	push	{r4-r5, lr}	// Save return point for later

	// Write null to beginning
	mov32	r3, INTS	// String pointer
	movs	r4, #0
	strb	r4, [r3]	// Write null
	subs	r3, #1

	movs	r4, #10	
	movs	r5, #0xff
	and	r0, r5
	b	.LutosTestNonZero
.LutosWhileDigits:
	//  Divide/Modulus (r1, r2)
	udiv	r1, r0, r4
	mls	r2, r1, r4, r0

	adds	r2, r2, #48  //  r2 = r2 + "0"
	subs	r3, r3, #1
	strb	r2, [r3]

	movs	r0, r1

.LutosTestNonZero:
	cmp	r0, #0
	bne	.LutosWhileDigits
	movs	r0, r3

	pop	{r4-r5, pc}	// Return
	
.balign	2
TEXT:
	.word	ENDLINE
	.word	HELLO
DIV10:
	.word	0x1999999a
ENDLINE:
	.asciz	"\012"
HELLO:
	.asciz	"Hello! \342\227\257"
