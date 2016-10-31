	.file	"guess.c"
	.text
	.global	main
	.type	main, %function
main:
	push	{r3, lr}	//Push all sensitive registers onto the stack
	bl	seedGens	//Seed the random generators
	bl	guessByte	//Make the user guess a random byte
	bl	guessShort	//Make the user guess a random short
	bl	guessInt	//Make the user guess a random int
	bl	guessLong	//Make the user guess a random long! >:D
	mov	r0, #0
	pop	{r3, pc}	//Pop all saved values off of the stack
