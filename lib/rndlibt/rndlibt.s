/* Random Library (Thumb) */
/* Depends on System Library */
/* SIZES */
.set	MODE_T, 4
.set	ENTROPY_T, 256

/* READ CONSTANTS */
.set	O_RDONLY, 0
.set	O_WRONLY, 1
.set	O_RDWR,   2

.data
.balign	2	
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
.thumb
.syntax	unified
.balign	2

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
	ldr	r1, =.LrfJUMP
	ldr	r0, [sp]//Peek at the top of the stack
	add	r0, r0	//Double r0 (2 bytes per register)
	add	r1, r0	//then add r1
	bx	r1	//Jump to somewhere on the jump table
	
//A jump table for the switch-case block
.LrfJUMP:	nop	//We don't expect the user to pass in 0 as an argument
	b	.Lrf0
	b	.Lrf1
	b	.Lrf2
	b	.Lrf3
	b	.Lrf4
	b	.Lrf5
	b	.Lrf6
	b	.Lrf7
	b	.Lrf8
	b	.Lrf9
	b	.Lrf0
	b	.Lrf11
	b	.Lrf12
	b	.Lrf13
	b	.Lrf14
	b	.Lrf15
	b	.Lrf16
	b	.Lrf17
	b	.Lrf18
	b	.Lrf19
	b	.Lrf20
	b	.Lrf21
	b	.Lrf22
	b	.Lrf23
	b	.Lrf24
	b	.Lrf25
	b	.Lrf26
	b	.Lrf27
	b	.Lrf28
	b	.Lrf29
	b	.Lrf30
	b	.Lrf31
.Lrf0:
	vldr.32	s0, [r3]	//Load the register
	add	r3, #4		//Increment the pointer
	b	.LrfCON	//Exit the switch
.Lrf1:
	vldmia.32	r3!, {s0-s1}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf2:
	vldmia.32	r3!, {s0-s2}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf3:
	vldmia.32	r3!, {s0-s3}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf4:
	vldmia.32	r3!, {s0-s4}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf5:
	vldmia.32	r3!, {s0-s5}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf6:
	vldmia.32	r3!, {s0-s6}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf7:
	vldmia.32	r3!, {s0-s7}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf8:
	vldmia.32	r3!, {s0-s8}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf9:
	vldmia.32	r3!, {s0-s9}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf10:
	vldmia.32	r3!, {s0-s10}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf11:
	vldmia.32	r3!, {s0-s11}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf12:
	vldmia.32	r3!, {s0-s12}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf13:
	vldmia.32	r3!, {s0-s13}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf14:
	vldmia.32	r3!, {s0-s14}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf15:
	vldmia.32	r3!, {s0-s15}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf16:
	vldmia.32	r3!, {s0-s16}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf17:
	vldmia.32	r3!, {s0-s17}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf18:
	vldmia.32	r3!, {s0-s18}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf19:
	vldmia.32	r3!, {s0-s19}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf20:
	vldmia.32	r3!, {s0-s20}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf21:
	vldmia.32	r3!, {s0-s21}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf22:
	vldmia.32	r3!, {s0-s22}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf23:
	vldmia.32	r3!, {s0-s23}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf24:
	vldmia.32	r3!, {s0-s24}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf25:
	vldmia.32	r3!, {s0-s25}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf26:
	vldmia.32	r3!, {s0-s26}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf27:
	vldmia.32	r3!, {s0-s27}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf28:
	vldmia.32	r3!, {s0-s28}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf29:
	vldmia.32	r3!, {s0-s29}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf30:
	vldmia.32	r3!, {s0-s30}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.Lrf31:
	vldmia.32	r3!, {s0-s31}	//Load the registers and increment
	b	.LrfCON	//Exit the switch
.LrfCON:
	str	r3, [r2]	//Store the pointer
	pop	{r0}		//Get the number of variables

	//Convert the random values to floats
	vcvt.f32.u32	s0, s0
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s1, s1
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s2, s2
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s3, s3
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s4, s4
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s5, s5
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s6, s6
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s7, s7
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s8, s8
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s9, s9
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s10, s10
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s11, s11
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s12, s12
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s13, s13
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s14, s14
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s15, s15
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s16, s16
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s17, s17
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s18, s18
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s19, s19
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s20, s20
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s21, s21
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s22, s22
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s23, s23
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s24, s24
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s25, s25
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s26, s26
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s27, s27
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s28, s28
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s29, s29
	sub	r0, #1
	beq	.LrfDIV
	vcvt.f32.u32	s30, s30
	sub	r0, #1
	beq	.LrfDIV
	//Special case for s31 (Not enough room)
	vcvt.f32.u32	s31, s31
	vpush.32	{s31}	
.LrfDIV:
	//Load the max 32-bit value as a float
	ldr	r3, =MAX32	//Get the location of the max 32-bit value
	vldr.f32	s31, [r3]	//Load the max 32-bit value into the vfp

	//Divide each float by the max value
	vdiv.f32	s0, s0, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s1, s1, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s2, s2, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s3, s3, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s4, s4, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s5, s5, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s6, s6, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s7, s7, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s8, s8, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s9, s9, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s10, s10, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s11, s11, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s12, s12, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s13, s13, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s14, s14, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s15, s15, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s16, s16, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s17, s17, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s18, s18, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s19, s19, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s20, s20, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s21, s21, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s22, s22, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s23, s23, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s24, s24, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s25, s25, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s26, s26, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s27, s27, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s28, s28, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s29, s29, s31
	sub	r0, #1
	beq	.LrfEND
	vdiv.f32	s30, s30, s31
	sub	r0, #1
	beq	.LrfEND
	//Special case for s31 (Stored the actual 32nd value earlier)
	vpop.f32	{s31}	//Recover the old value
	vpush.32	{s30}	//Save s30 for later (we're using it now)
	vldr.f32	s30, [r3]	//Load the max 32-bit value again
	vdiv.f32	s31, s31, s30	//s31 / MAX32
	vpop.f32	{s30}	//Retrieve s30
	sub	r0, #1
	beq	.LrfEND

.LrfEND:
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
	cbnz	r0, .LopenDONE

	//Open /dev/urandom
	ldr	r0, =RANDOM	//The filename
	mov	r1, #O_RDONLY	//Only reading privileges
	mov	r2, #0		//Not creating a file, so no mode_t
	bl	sysOpen		//Open the file

	//Store the pointer in memory so that we don't lose it
	str	r0, [r4]
.LopenDONE:
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
	cbz	r4, .LcloseDONE

	//Close /dev/urandom
	bl	sysClose	//Close the file

	//Clear the pointer from memory so that we don't use it again
	mov	r0, #0
	str	r0, [r4]
.LcloseDONE:
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
	blo	.LcheckSKIPSEED
	bl	seedRnd
.LcheckSKIPSEED:
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
.balign 2
.thumb
lock:
	//If the entropic array is locked then wait until it's unlocked
	ldr	r1, =ENTROPYLCK
	ldr	r0, [r1]
	cbz	r0, .LockDONE
	b	lock
.LockDONE:
	//Lock the entropic array
	mov	r0, #1
	str	r0, [r1]
	
	bx	lr	//Return

/* void unlock() */
/* Unlocks the entropic array: must be called after a lock */
/* Data Races: ENTROPYLCK is written to */
.balign	2
.thumb
unlock:
	//Unlock the entropic array
	ldr	r1, =ENTROPYLCK
	mov	r0, #0
	str	r0, [r1]
	bx	lr	//Return

.text
.balign 2
RANDOM:
	.asciz	"/dev/urandom"
MAX32:
	.single	4294967295.0
MAX64:
	.double	18446744073709551615.0
