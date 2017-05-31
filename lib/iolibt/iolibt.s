/* Input/Output Library (Thumb) */
/* Depends on System and Macro Libraries */

.include "../macrolib/macrolib.inc"	// For mov32
.include "ioconst.inc"	//  INCLUDE I/O STREAM INFO

// Reference malloc if the memory library is linked, but use a data region if it is not linked
.weakref malloc, .LmallocFromData

// ASCII CONSTANTS
.set	NULL,	 0x00
.set	ZERO,    0x30
.set	NINE,    0x39
.set	DECIMAL, 0x2e
.set	MINUS,   0x2d

// SIZE OF INT -> STRING ARRAY
.set	ISSIZE, 16	// sign + 10 chars + null

.data
	.asciz	"Ya!"
	.skip	ISSIZE	// Make room for the int's char buffer
INTS:	// Space for the string of an int written backwards (int -> string)

.text
.syntax	unified

/* void*[r0] mallocFromData() */
/* Returns 16 bytes of global data - Used only when memlibt is not linked */
/* Data Races: Returns the same memory region every time - NOT THREAD SAFE! */
.thumb_func
.LmallocFromData:
	mov32	r0, INTS
	bx	lr

/* int[r0] fgets(int fd[r0], char* buf[r1], int length[r2]) */
/* Grabs a string from the stream fd and null-terminates it */
/* It returns the number of characters read from the stream */
/* Data Races: fgets writes to the character array buf */
.thumb_func
.global	fgets
.type	fgets, %function
fgets:
	push	{r4, lr}	// Save return point for later

	// Get a string
	bl	sysRead

	// Null-terminate the string
	adds	r1, r1, r0
	movs	r3, #NULL
	strb	r3, [r1]
	subs	r1, r1, r0

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

/* void fputi(int fd[r0], const int num[r1]) */
/* Prints an integer onto the stream and appends a newline */
/* Data races: No memory is changed */
.thumb_func
.global	fputi
.type	fputi, %function
fputi:
	push	{r0, lr}// Save return point for later
	movs	r0, r1
	bl	itos	// Convert the int into a string
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

/* int[r0] fclose(int fd[r0]) */
/* Closes the filehandle's file */
/* Data races: The given file stream is closed and no longer valid */
.thumb_func
.global	fclose
.type	fclose, %function
fclose:
	b	sysClose	// Close the file

/* int[r0] fdelete(char* pathname[r0]) */
/* Deletes the given file */
/* Data races: The given file is deleted if nothing is accessing it */
.thumb_func
.global	fdelete
.type	fdelete, %function
fdelete:
	b	sysUnlink	// Delete the file

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
	
/* int[r0] fwrite(const char* filename[r0], mode_t permissions[r1] = 0) */
/* Opens a file for *WRITING* and returns the file handle */
/* It will create a file if necessary, but will not create a directory path */
/* Data races: The character array filename is read */
.thumb_func
.global	fwrite
.type	fwrite, %function
fwrite:
	// Make the file writeable by the user's group and readable by all
	movs	r2, #(S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP | S_IROTH)

	// If the user did not give any permissions then use the defaults
	cbz	r1, .LfwriteUseDefaults
	movs	r2, r1	// Use the given file permissions
.LfwriteUseDefaults:

	// Declare writing and (re)create the file
	movw	r1, #(O_WRONLY | O_CREAT | O_TRUNC)

	// Open the file
	b	sysOpen

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

/* char*[r1] itos(int value[r0]) */
/* Takes an integer and returns a null-terminated char array. */
/* Note: Don't forget to unallocate strings returned by this: */
/* potential memory leak! */
/* Data Races: New memory is created and used */
.thumb_func
.global	itos
.type	itos, %function
itos:
	push	{r0, lr}	// Save return point for later

	// Allocate some memory to use for itosFast
	movs	r1, #ISSIZE
	bl	malloc
	movs	r1, r0

	// Call itosFast
	pop	{r0}
	bl	itosFast

	pop	{pc}		// Return

/* char*[r1] utos(int value[r0]) */
/* Takes an unsigned integer and returns a null-terminated char array. */
/* Note: Don't forget to unallocate strings returned by this: */
/* potential memory leak! */
/* Data Races: New memory is created and used */
.thumb_func
.global	utos
.type	utos, %function
utos:
	push	{r0, lr}	// Save return point for later

	// Allocate some memory to use for utosFast
	movs	r1, #ISSIZE
	bl	malloc

	// Call utosFast
	movs	r1, r0
	pop	{r0}
	bl	utosFast

	pop	{pc}		// Return

/* void itosFast(int value[r0], char* buf[r1]) */
/* Takes a signed integer and writes its string representation onto a char */
/* array. Keep in mind that the pointer's location may be modified and that */
/* itosFast always assumes that the length of buf is 16 bytes or more. */
.thumb_func
.global	itosFast
.type	itosFast, %function
itosFast:
	push	{r4, lr}	// Save return point for later

	movs	r2, #0
	cmp	r0, r2
	ITEE	GE		// If value > 0
	  // If
	  movge	r4, #0		// then negative = false
	  // Else
	  movlt	r4, #1		// else negative = true
	  neglt r0, r0		// and value = -value
	// End if

	// Call utos
	bl	utosFast

	// If the value was positive then return, otherwise add a sign to buf
	movs	r2, #0
	cmp	r4, r2
	beq	.LitosReturn

	// Add a sign to the char buffer if the value was negative
	subs	r1, #1		// buf--
	movs	r2, #MINUS	// *buf = '-'
	strb	r2, [r1]
.LitosReturn:
	pop	{r4, pc}	// Return


/* void utosFast(int value[r0], char* buf[r1]) */
/* Takes an unsigned integer and writes its string representation onto a char */
/* array. Keep in mind that the pointer's location may be modified and that */
/* utosFast always assumes that the length of buf is 16 bytes or more. */
.thumb_func
.global	utosFast
.type	utosFast, %function
utosFast:
	push	{r4, lr}	// Save return point for later

  /* C CODE *//*
   void utosFast(int value, char* string) {
      // Null terminate string
      string[16] = '\0'
      count = 0;
	
      do {
         int digit = value % 10;

         // Append the digit onto the string
         count++;
         string[16 - count] = digit;

         value /= 10;
      } while (value > 0);

      string = string + count;
   }
*/

	// Null-terminate the array
	adds	r1, r1, #16	// buf += 16
	movs	r2, #NULL	// *buf = '\0'
	strb	r2, [r1]

.LutosLoop:
	// Get a digit from the value (r2 = r0 / r3)
	movs	r3, #10		// Divide the value by ten
	udiv	r2, r0, r3	// temp = FLOOR(value / 10)
	mls	r3, r3, r2, r0	// digit = value - (10 * temp)
	movs	r0, r2		// value = temp

	// Append the digit onto the string
	adds	r3, r3, #ZERO	// digit += '0'
	subs	r1, r1, #1	// buf--
	strb	r3, [r1]	// *buf = digit

	// If value > 0 then work some more
	movs	r3, #0
	cmp	r0, r3
	bhi	.LutosLoop

	pop	{r4, pc}	// Return
	
.balign	2
TEXT:
	.word	ENDLINE
ENDLINE:
	.asciz	"\012"
