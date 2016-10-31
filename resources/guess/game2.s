	.file	"game.c"
	.text
	.align	2
	.global	guess
	.type	guess, %function
//$$$ CREATE A FUNCTION THAT RETURNS SOME VALUE
//$$$ CREATE A FUNCTION THAT TAKES AN ARGUMENT BY VALUE	
//Makes the user guess an unsigned 64 bit number
//int guess(unsigned long long bigNum)
guess:
	push	{r0, r1, r4, r5, r6, r7, lr}
	mov	r6, r0
	mov	r7, r1
	mov	r4, #0

	//$$$ CREATE A WHILE LOOP
.LOOP:  //Do...
	//printf("? ")
	ldr	r0, TEXT
	add	r4, r4, #1	//tries++
	bl	printf

	//scanf("%llu", &guess)
	ldr	r0, TEXT+4
	mov	r1, sp
	bl	__isoc99_scanf

	//$$$ CREATE AN IF/ELSE STATEMENT
	//$$$ CREATE AN IF/ELSEIF/ELSE STATEMENT
	ldrd	r2, [sp]	//r2 = guess
	cmp	r3, r7		//If
	cmpeq	r2, r6		//  guess == bigNum
	ldrcc	r0, TEXT+8	//Assume guess higher
	bcc	.ENDIF		//If not equal jump to print string
	bls	.ENDLP		//If less than
	ldr	r0, TEXT+12	//Assume guess lower
.ENDIF:	
	bl	puts		//Print result
	b	.LOOP		//Go back to guess again
.ENDLP:
	//printf(char*, int, unsigned long long)
	ldr	r0, TEXT+16

	mov	r1, r4
	mov	r2, r6
	mov	r3, r7
	bl	printf
	mov	r0, r4
	add	sp, sp, #8
	pop	{r4, r5, r6, r7, pc}

//Makes the user guess a random byte
//void guessByte()
	.global	guessByte
	.type	guessByte, %function
guessByte:
	push	{lr}

	//Print GUESSBYTE
	ldr	r0, TEXT+20
	bl 	printf

	//$$$ CAST FROM BYTE TO SHORT
	//$$$ CAST FROM SHORT TO INT
	//$$$ CAST FROM INT TO LONG
	//guess((long long)randomByte())
	bl	randomByte
	add	r0, #1	
	uxtb16	r0, r0	//Extend  8-bits to 16-bits
	sub	r0, #1
	uxth	r0, r0	//Extend 16-bits to 32-bits
	add	r0, #1
	mov	r1, #0	//Extend 32-bits to 64-bits
	sub	r0, #1
	bl	guess
	
	//Print BEATBYTE
	ldr	r0, TEXT+36
	bl	printf

	pop	{pc}

//Makes the user guess a random short
//void guessShort()
	.global	guessShort
	.type	guessShort, %function
guessShort:
	push	{lr}

	//Print GUESSSHORT
	ldr	r0, TEXT+24
	bl 	printf

	//guess((long long)randomShort())
	bl	randomShort
	uxth	r0, r0	//Extend 16-bits to 32-bits
	mov	r1, #0	//Extend 32-bits to 64-bits
	bl	guess
	
	//Print BEATSHORT
	ldr	r0, TEXT+40
	bl	printf

	pop	{pc}

//Makes the user guess a random int
//void guessInt()
	.global	guessInt
	.type	guessInt, %function
guessInt:
	push	{lr}
	
	//Print GUESSINT
	ldr	r0, TEXT+28
	bl 	printf

	//guess((long long)randomInt())
	bl	randomInt
	mov	r1, #0	//Extend 32-bits to 64-bits
	bl	guess
	
	//Print BEATINT
	ldr	r0, TEXT+44
	bl	printf

	pop	{pc}

//Makes the user guess a random long
//void guessLong()
	.global	guessLong
	.type	guessLong, %function
guessLong:
	push	{lr}
	
	//Print GUESSLONG
	ldr	r0, TEXT+32
	bl 	printf

	//guess(randomLong())
	bl	randomLong
	bl	guess

	//Print BEATLONG
	ldr	r0, TEXT+48
	bl	printf

	pop	{pc}

//All of the strings are contained in this location
TEXT:
	.word	PROMPTINPUT
	.word	INPUTLONG
	.word	HIGHER
	.word	LOWER
	.word	PRINTTRIES
	.word	GUESSBYTE
	.word	GUESSSHORT
	.word	GUESSINT
	.word	GUESSLONG
	.word	BEATBYTE
	.word	BEATSHORT
	.word	BEATINT
	.word	BEATLONG
PROMPTINPUT:
	.ascii	"? \000"
INPUTLONG:
	.ascii	"%llu\000"
HIGHER:
	.ascii	"Guess higher!\012\000"
LOWER:
	.ascii	"Guess lower!\012\000"
PRINTTRIES:
	.ascii	"You took %d tries to guess %llu!\012\000"
GUESSBYTE:
	.ascii	"Guess a number between 0 and 255.\012\000"
BEATBYTE:
	.ascii	"\012Easy? Good. Now try this one.\012\000"
GUESSSHORT:
	.ascii	"Guess a number between 0 and 65535.\012\000"
BEATSHORT:
	.ascii	"\012Nice! See if you can beat this one.\012\000"
GUESSINT:
	.ascii	"Guess a number between 0 and 4294967295. Good luck!\012\000"
BEATINT:
	.ascii	"\012Hard? That was only 32 bits! Let's see how well"
	.ascii	" you do with 64!\012\000"
GUESSLONG:
	.ascii	"Guess a number between 0 and 18446744073709551616...\012"
	.ascii	"I hope you live through this one.\012\000"
BEATLONG:
	.ascii	"\012I don't know how you did it, but congratulations.\012\000"
