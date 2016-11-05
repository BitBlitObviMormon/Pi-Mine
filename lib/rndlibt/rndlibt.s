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
.align	2
/* float[s0] ... float[s31] randFloat(int numFloats[r0]) */
/* Generates the specified number of floats in registers s0-s31 */
/* All of the random values are between 0 and 1 */
/* Example: randFloat(3) returns three floats */
/* Data Races: Uses lock and unlock */
randFloat:
	push	{r0, lr}	//Save return point for later
	bl	checkPtr	//Make sure the entropy pointer is valid
	bl	lock		//Lock the entropic array

	ldr	r2, =ENTROPYPTR	//Load the entropy pointer
	ldr	r3, [r2]	//Dereference the pointer

	//Jump to the code that loads the desired number of floats
	ldr	r1, =rfJUMP
	ldr	r0, [sp]//Peek at the top of the stack
	add	r0, r0	//Double r0 (2 bytes per register)
	add	r1, r0	//then add r1
	bx	r1	//Jump to somewhere on the jump table
	
//A jump table for the switch-case block
rfJUMP:	nop	//We don't expect the user to pass in 0 as an argument
	b	rf0
	b	rf1
	b	rf2
	b	rf3
	b	rf4
	b	rf5
	b	rf6
	b	rf7
	b	rf8
	b	rf9
	b	rf0
	b	rf11
	b	rf12
	b	rf13
	b	rf14
	b	rf15
	b	rf16
	b	rf17
	b	rf18
	b	rf19
	b	rf20
	b	rf21
	b	rf22
	b	rf23
	b	rf24
	b	rf25
	b	rf26
	b	rf27
	b	rf28
	b	rf29
	b	rf30
	b	rf31
rf0:
	vldr.32	s0, [r3]	//Load the register
	add	r3, #4		//Increment the pointer
	b	rfCON	//Exit the switch
rf1:
	vldmia.32	r3!, {s0-s1}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf2:
	vldmia.32	r3!, {s0-s2}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf3:
	vldmia.32	r3!, {s0-s3}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf4:
	vldmia.32	r3!, {s0-s4}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf5:
	vldmia.32	r3!, {s0-s5}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf6:
	vldmia.32	r3!, {s0-s6}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf7:
	vldmia.32	r3!, {s0-s7}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf8:
	vldmia.32	r3!, {s0-s8}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf9:
	vldmia.32	r3!, {s0-s9}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf10:
	vldmia.32	r3!, {s0-s10}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf11:
	vldmia.32	r3!, {s0-s11}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf12:
	vldmia.32	r3!, {s0-s12}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf13:
	vldmia.32	r3!, {s0-s13}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf14:
	vldmia.32	r3!, {s0-s14}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf15:
	vldmia.32	r3!, {s0-s15}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf16:
	vldmia.32	r3!, {s0-s16}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf17:
	vldmia.32	r3!, {s0-s17}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf18:
	vldmia.32	r3!, {s0-s18}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf19:
	vldmia.32	r3!, {s0-s19}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf20:
	vldmia.32	r3!, {s0-s20}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf21:
	vldmia.32	r3!, {s0-s21}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf22:
	vldmia.32	r3!, {s0-s22}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf23:
	vldmia.32	r3!, {s0-s23}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf24:
	vldmia.32	r3!, {s0-s24}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf25:
	vldmia.32	r3!, {s0-s25}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf26:
	vldmia.32	r3!, {s0-s26}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf27:
	vldmia.32	r3!, {s0-s27}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf28:
	vldmia.32	r3!, {s0-s28}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf29:
	vldmia.32	r3!, {s0-s29}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf30:
	vldmia.32	r3!, {s0-s30}	//Load the registers and increment
	b	rfCON	//Exit the switch
rf31:
	vldmia.32	r3!, {s0-s31}	//Load the registers and increment
	b	rfCON	//Exit the switch
rfCON:
	str	r3, [r2]	//Store the pointer
	pop	{r0}		//Get the number of variables

	//Convert the random values to floats
	vcvt.f32.u32	s0, s0
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s1, s1
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s2, s2
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s3, s3
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s4, s4
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s5, s5
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s6, s6
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s7, s7
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s8, s8
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s9, s9
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s10, s10
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s11, s11
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s12, s12
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s13, s13
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s14, s14
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s15, s15
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s16, s16
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s17, s17
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s18, s18
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s19, s19
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s20, s20
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s21, s21
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s22, s22
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s23, s23
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s24, s24
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s25, s25
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s26, s26
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s27, s27
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s28, s28
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s29, s29
	sub	r0, #1
	beq	rfDIV
	vcvt.f32.u32	s30, s30
	sub	r0, #1
	beq	rfDIV
	//Special case for s31 (Not enough room)
	vcvt.f32.u32	s31, s31
	vpush.32	{s31}	
rfDIV:
	//Load the max 32-bit value as a float
	ldr	r3, =MAX32	//Get the location of the max 32-bit value
	vldr.f32	s31, [r3]	//Load the max 32-bit value into the vfp

	//Divide each float by the max value
	vdiv.f32	s0, s0, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s1, s1, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s2, s2, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s3, s3, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s4, s4, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s5, s5, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s6, s6, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s7, s7, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s8, s8, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s9, s9, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s10, s10, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s11, s11, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s12, s12, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s13, s13, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s14, s14, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s15, s15, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s16, s16, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s17, s17, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s18, s18, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s19, s19, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s20, s20, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s21, s21, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s22, s22, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s23, s23, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s24, s24, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s25, s25, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s26, s26, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s27, s27, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s28, s28, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s29, s29, s31
	sub	r0, #1
	beq	rfEND
	vdiv.f32	s30, s30, s31
	sub	r0, #1
	beq	rfEND
	//Special case for s31 (Stored the actual 32nd value earlier)
	vpop.f32	{s31}	//Recover the old value
	vpush.32	{s30}	//Save s30 for later (we're using it now)
	vldr.f32	s30, [r3]	//Load the max 32-bit value again
	vdiv.f32	s31, s31, s30	//s31 / MAX32
	vpop.f32	{s30}	//Retrieve s30
	sub	r0, #1
	beq	rfEND

rfEND:
	bl	unlock	//Unlock the entropic array
	pop	{pc}	//Return

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
.align	2
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
.align 2
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
.align	2
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
MAX32:
	.single	4294967295.0
MAX64:
	.double	18446744073709551615.0
