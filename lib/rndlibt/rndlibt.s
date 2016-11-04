/* Random Library (Thumb) */
/* SIZES */
.set	MODE_T, 4

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
	.word	0x00	//The /dev/urandom file pointer
ENTROPY:
	.skip	256	//Space in which to store entropy
ENTROPYPTR:
	.word	ENTROPY	//The pointer to the entropic array
ENTROPYLCK:	  //If set to 1, then the entropic array is being used
	.byte	0 //This is meant to prevent data races when threaded

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
	mov	r2, #0		//Not creating a file so no mode_t
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
	push	{r4, lr}	//Save the return point for later
randomCHECKLOCK:
	//If the entropic array is locked then wait until its unlocked
	ldr	r4, =ENTROPYLCK
	cbz	r4, randomDONECHECK
	b	randomCHECKLOCK
randomDONECHECK:
	//Lock the entropic array
	mov	r0, #1
	str	r0, [r4]

	//Refill the entropic array with random data
	ldr	r1, =ENTROPY	//Load the entropic array
	mov	r2, #255	//Set the read size to 256
	add	r2, #1
	bl	randomArray	//Fill the entropic array with random data

	//Unlock the entropic array
	mov	r0, #0
	str	r0, [r4]

	pop	{r4, pc}	//Return

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
	.asciz	"/dev/random"
