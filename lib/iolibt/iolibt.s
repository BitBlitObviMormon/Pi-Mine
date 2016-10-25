/* Input/Output Library (Thumb) */
// I/O CONSTANTS
.set	STDIN,  0
.set	STDOUT, 1
.set	STDERR, 2

// SYSCALLS
.set	READ, 3	
.set	WRITE, 4

// ASCII CONSTANTS
.set	ZERO, 0x30
.set	NINE, 0x39
.set	DECIMAL, 0x2e
.set	MINUS, 0x2d

// SIZE OF INT -> STRING ARRAY
.set	ISSIZE, 12

.data
INTS:	//Space for the string of an int (int -> string)
	.skip	ISSIZE	//sign + 10 chars + null
	.asciz	"Ya!" //If this data is changed, we've got a memory leak

//$$$ USE A SYSTEM CALL TO GET INPUT FROM THE CONSOLE
/* gets(char*[r1], int[r2]) */
/* Grabs a string from the console */
/* Data Races: gets modifies the string given */
.text
.thumb
.global	gets
.type	gets, %function
gets:
	push	{r4, lr}	//Save return point for later
	mov	r0, #STDOUT
	bl	sysRead
	mov	r0, #0
	add	r2, #1
	add	r1, r2
	strb	r0, [r1]	//Null-terminate string
	
	pop	{r4, pc}	//Return

/* int[r0] geti()  */
/* Grabs an integer from the console */
/* Data Races: geti modifies static address space, */	
/* DON'T RUN ON MULTIPLE THREADS! */
.thumb
.global	geti
.type	geti, %function
geti:
	push	{lr}	//Save the return point for later
	ldr	r1, =INTS
	mov	r2, #ISSIZE
	bl	gets	//Get a string from the console
	bl	stoi	//String -> Int
	mov	r0, r2
	pop	{pc}	//Return

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

/* int[r2] pow(const int[r0], int [r1]) */
/* Returns r0 ^ r1 */
/* Data races: No memory is changed */
.thumb
pow:	//X(r0)^N(r1)
	cbz	r1, powend	//End loop if iterator is zero
	mul	r2, r2, r0	//Multiply by ten
	sub	r1, #1		//One less power to go
	b	pow		//If the loop isn't over keep going
powend:	
	bx	lr	//Return

//$$$ CREATE A FOR LOOP USING THUMB2 INSTRUCTIONS
//$$$ TRAVERSE AN ARRAY	
//$$$ USE A SYSTEM CALL TO OUTPUT DATA TO THE CONSOLE
//$$$ USE A SYSTEM CALL TO OUTPUT TEXT TO THE CONSOLE	
/* void prints(char*) */
/* Prints a string onto the console */
/* Data Races: No memory is changed */
.thumb
.global	prints
.type	prints, %function
prints:
	push	{lr}	//Store return point for later

	//Prepare sysWrite(uint fd, const char* buf, size_t count)
	mov	r1, r0	//buf = passedBuffer
	mov	r0, $1	//fd = stdout
	mov	r2, #0	//count = 0

	//Calculate the length of the string
	push	{r1}		//Save the buffer address for later
printsloop:
	ldrb	r3, [r1]	//temp = buf[i]
	add	r1, #1		//i++
	cbz	r3, printsend	//If character is null, end the loop
	add	r2, #1		//count++
	b	printsloop	//Loop back to the beginning
printsend:
	pop	{r1}		//Retrieve the buffer address
	bl	sysWrite	//Print the string to the console
	
	pop	{pc}	//Return

//$$$ USE A SYSTEM CALL TO OUTPUT AN INTEGER TO CONSOLE
/* void printi(const int) */
/* Prints an integer onto the console and appends a new line */
/* Data Races: No memory is changed */
.thumb
.global	printi
.type	printi, %function
printi:
	push	{r0, lr}	//Save return point for later
	bl	puti		//Put the int onto the console
	ldr	r0, TEXT	//Append a new line
	bl	prints		//Print the new line
	pop	{r0, pc}	//Return

/* void puti(const int) */
/* Prints an integer onto the console */
/* Data races: No memory is changed */
.thumb
.global	puti
.type	puti, %function
puti:
	push	{r0, lr}	//Save return point for later
	ldr	r0, TEXT+4	//Ready the string for printing
	bl	prints		//Print the string
	pop	{r0, pc}	//Return

/* int[r1] stoi(const char*[r0]) */
/* Takes a null-terminated char array and returns an integer */
/* Data Races: No memory is changed */
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
	cbnz	r7, stoiloop
	add	r3, #1
stoiloop:
	// Seek to the end of the string
	ldrb	r0, [r4]
	add	r4, #1

	//If we're not done seeking then loop back up
	cbz	r0, stoimiddle	//If null then end the loop
	b	stoiloop
stoimiddle:
	// Add each number to the register result
	sub	r4, #1
	ldrb	r2, [r4]
	add	r5, #1	//i++
	mov	r0, #10	//n = 10 (n^x)
	sub	r2, #48	//ASCII -> INT
	mov	r1, r5	//x = i  (n^x)
	bl	pow	//n^x

	//If the answer is positive then add, else subtract
	cbnz	r7, stoiadd
stoisub:
	sub	r6, r2	//Ans -= pow()
	b	stoiend
stoiadd:
	add	r6, r2	//Ans += pow()
stoiend:
	//If address of r4 equals address of r3 then end the loop
	cmp	r3, r4
	bne	stoimiddle

	pop	{r4-r7, pc}	//Return
	
/* void sysRead(uint fd, char* buf, size_t count) */
/* Uses the system call to read from a buffer */
/* Data Races: No memory is changed */
.thumb
.global	sysRead
.type	sysRead, %function
sysRead:
	mov	r7, $READ	//Prepare to invoke syscall read
	svc	#0		//Invoke system call read
	bx	lr		//Return
	
/* void sysWrite(uint fd, const char* buf, size_t count) */
/* Uses the system call to write to a buffer */
/* Data Races: No memory is changed */
.thumb
.global	sysWrite
.type	sysWrite, %function
sysWrite:
	mov	r7, $WRITE	//Prepare to invoke syscall write
	svc	#0		//Invoke system call write
	bx	lr		//Return

/* char*[r1] utos(const int[r0]) */
/* Takes an unsigned int and returns a null-terminated char array */
/* Data Races: Returns static memory which is overwritten on */
/* the next utos/itos call; Needs to be replaced with a brk call! */
.thumb
.global	utos
.type	utos, %function
utos:
	push	{r0, lr}	//Save return point for later
	
	pop	{r0, pc}	//Return

.align	2
TEXT:
	.word	ENDLINE
	.word	HELLO
ENDLINE:
	.asciz	"\012"
HELLO:
	.asciz	"Hello! \342\227\257"
