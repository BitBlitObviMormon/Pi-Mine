/* Random Library (Thumb) */
/* SIZES */
.set	MODE_T, 4
.set	ENTROPY_T, 256

/* SYSCALLS */
.set	READ,  3
.set	WRITE, 4
.set	OPEN,  5
.set	CLOSE, 6

/* CONSTANTS */
.set	O_RDONLY, 0
.set	O_WRONLY, 1
.set	O_RDWR,   2

.data
.align	2	
RNDPTR:
	.word	0x00		//The file pointer
ENTROPYSIZE:
	.word	ENTROPY_T	//The amount of space the entropic array holds
ENTROPY:
	.skip	ENTROPY_T	//Space in which to store entropy
ENTROPYPTR:
	.word	ENTROPY		//The pointer to the entropic array
ENTROPYLCK:		//If this is 1, then the entropic array is being used
	.word	0x00	//This is meant to prevent data races when threaded

.text

/* void openRnd() */
/* Opens /dev/urandom for reading */
/* Data Races: RNDPTR and URNDPTR are written to */
.thumb
.global	openRnd
.type	openRnd, %function
openRnd:
	push	{r4, lr}	//Save return point for later

	//If there is already a value written to the file handle, skip it
	ldr	r4, =RNDPTR
	ldr	r0, [r4]
	cbnz	r0, openDONE

	//Open /dev/urandom
	ldr	r0, =RANDOM	//The filename
	mov	r1, #O_RDONLY	//Only reading privileges
	mov	r2, #0		//Not creating a file, so no mode_t
	bl	sysOpen		//Open the file

	//Store the pointer in memory so that we don't lose it
	str	r0, [r4]
openDONE:
	pop	{r4, pc}	//Return

/* void closeRnd() */
/* Closes /dev/urandom */
/* Data Races: RNDPTR and URNDPTR are written to */
.thumb
.global	closeRnd
.type	closeRnd, %function
closeRnd:
	push	{r4, lr}	//Save return point for later

	//If there is already no value written to the file handle, skip it
	ldr	r4, =RNDPTR
	ldr	r0, [r4]
	cbz	r4, closeDONE

	//Close /dev/urandom
	bl	sysClose	//Close the file

	//Clear the pointer from memory so that we don't use it again
	mov	r0, #0
	str	r0, [r4]
closeDONE:
	pop	{r4, pc}	//Return

/* void randomArray(void* memory[r1], size_t size[r2]) */
/* Fills the given array with entropic data */
/* Data Races: The memory given is written to */
.thumb
.global	randomArray
.type	randomArray, %function
randomArray:
	push	{lr}		//Save return point for later
	ldr	r0, =RNDPTR	//The file pointer to /dev/urandom
	ldr	r0, [r0]
	bl	sysRead		//Read entropic data from the file
	pop	{pc}		//Return

/* void seedRnd() */
/* Fills the entropy array with entropic data */
/* Data Races: ENTROPY, ENTROPYPTR, and ENTROPYLCK are written to */
.thumb
.global	seedRnd
.type	seedRnd, %function
seedRnd:
	push	{lr}		//Save return point for later

	//Lock the entropic array
	bl	lock

	//Refill the entropic array with random data
	ldr	r1, =ENTROPY	//Load the entropic array
	mov	r3, r1
	ldr	r2, =ENTROPYSIZE//Set the read size to 256
	ldr	r2, [r2]
	bl	randomArray	//Fill the entropic array with random data

	//Reset the entropy pointer
	ldr	r0, =ENTROPYPTR
	str	r3, [r0]

	//Unlock the entropic array
	bl	unlock

	pop	{pc}	//Return

/* void checkPtr() */
/* Checks if the entropy pointer is valid and */
/* reseeds the array if it is invalid. */
.thumb
checkPtr:
	push	{lr}	//Save the return point for later

	//Check if the entropy pointer is valid
	ldr	r0, =ENTROPYPTR	//&entropyPTR
	ldr	r1, [r0]	//entropyPTR
	
	//If the pointer is greater or equal to the reference then reseed
	cmp	r1, r0
	blo	checkSKIPSEED
	bl	seedRnd
checkSKIPSEED:
	pop	{pc}	//Return

/* char[r0] randByte() */
/* Generates a random byte */
/* Data Races: Uses lock and unlock */
.thumb
.global	randByte
.type	randByte, %function
randByte:
	push	{lr}		//Save return point for later
	bl	checkPtr	//Make sure the entropy pointer is valid
	bl	lock		//Lock the entropic array

	ldr	r1, =ENTROPYPTR	//Load the entropy pointer
	ldr	r2, [r1]	//Dereference the pointer
	ldrb	r0, [r2]	//Dereference again and
	add	r2, #1		//Move the pointer
	str	r2, [r1]	//Store the updated address
	push	{r0}		//Store the answer

	bl	unlock		//Unlock the entropic array
	pop	{r0, pc}	//Return

/* short[r0] randShort() */
/* Generates a random short */
/* Data Races: Uses lock and unlock */
.thumb
.global	randShort
.type	randShort, %function
randShort:
	push	{lr}		//Save return point for later
	bl	checkPtr	//Make sure the entropy pointer is valid
	bl	lock		//Lock the entropic array

	ldr	r1, =ENTROPYPTR	//Load the entropy pointer
	ldr	r2, [r1]	//Dereference the pointer
	ldrh	r0, [r2]	//Dereference again and
	add	r2, #2		//Move the pointer
	str	r2, [r1]	//Store the updated address
	push	{r0}		//Store the answer

	bl	unlock		//Unlock the entropic array
	pop	{r0, pc}	//Return

/* int[r0] randInt() */
/* Generates a random int */
/* Data Races: Uses lock and unlock */
.thumb
.global	randInt
.type	randInt, %function
randInt:
	push	{lr}		//Save return point for later
	bl	checkPtr	//Make sure the entropy pointer is valid
	bl	lock		//Lock the entropic array

	ldr	r1, =ENTROPYPTR	//Load the entropy pointer
	ldr	r2, [r1]	//Dereference the pointer
	ldr	r0, [r2]	//Dereference again and
	add	r2, #4		//Move the pointer
	str	r2, [r1]	//Store the updated address
	push	{r0}		//Store the answer

	bl	unlock		//Unlock the entropic array
	pop	{r0, pc}	//Return

/* long[r0-r1] randLong() */
/* Generates a random long */
/* Data Races: Uses lock and unlock */
.thumb
.global	randLong
.type	randLong, %function
randLong:
	push	{lr}		//Save return point for later
	bl	checkPtr	//Make sure the entropy pointer is valid
	bl	lock		//Lock the entropic array

	ldr	r2, =ENTROPYPTR	//Load the entropy pointer
	ldr	r3, [r2]	//Dereference the pointer
	ldrd	r0, [r3]	//Dereference again and
	add	r3, #8		//Move the pointer
	str	r3, [r2]	//Store the updated address
	push	{r0, r1}	//Store the answer

	bl	unlock		//Unlock the entropic array
	pop	{r0, r1, pc}	//Return

/* void lock() */
/* Waits for the entropic array to unlock before locking it again */
/* Data Races: ENTROPYLCK is read and written to in a non data racey way */
.thumb
lock:
	//If the entropic array is locked then wait until it's unlocked
	ldr	r1, =ENTROPYLCK
	ldr	r0, [r1]
	cbz	r0, lockDONE
	b	lock
lockDONE:
	//Lock the entropic array
	mov	r0, #1
	str	r0, [r1]
	
	bx	lr	//Return

/* void unlock() */
/* Unlocks the entropic array: must be called after a lock */
/* Data Races: ENTROPYLCK is written to */
.thumb
unlock:
	//Unlock the entropic array
	ldr	r1, =ENTROPYLCK
	mov	r0, #0
	str	r0, [r1]
	bx	lr	//Return

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

.text
.align 2
RANDOM:
	.asciz	"/dev/urandom"
