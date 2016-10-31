	.text
	.align	2
	.global	getInput
	.type	getInput, %function

//Grabs input from the user and then does math with it
//$$$ CREATE A FUNCTION
//$$$ CREATE A FUNCTION THAT TAKES AN ARGUMENT BY REFERENCE
//getInput(char* question)
getInput:
	//$$$ OUTPUT TEXT WITH PRINTF
	//printf(question);
	stmfd	sp!, {r4, lr}	//Push the question and callee-save
	sub	sp, sp, #8
	ldr	r4, VAR		//Pass question into printf
	bl	printf		//Call printf

	//$$$ GET INPUT WITH SCANF
	//$$$ CREATE A LOCAL VARIABLE ON THE STACK
	//scanf("%d", &response);
	push	{r1}		//Push a local var on the stack
	pop	{r1}		//Pop the local var from the stack
	add	r1, sp, #4	//Pass register to scanf (to use as local var)
	ldr	r0, VAR+4	//Pass INTIO to scanf
	bl	__isoc99_scanf	//Call scanf

	//$$$ OUTPUT NON-TEXT WITH PRINTF
	//$$$ DO SIMPLE MATH (ADD)
	//printf("response + global = stuff");
	ldr	r2, [r4]	//Pass global to printf
	ldr	r1, [sp, #4]	//Pass response to printf
	ldr	r0, VAR+8	//Pass TEXTADD to printf
	add	r3, r1, r2	//Pass stuff (response + global) to printf
	bl	printf		//Call printf

	//$$$ DO SIMPLE MATH (SUBTRACT)
	//printf("response - global = stuff");
	ldr	r2, [r4]	//Pass global to printf
	ldr	r1, [sp, #4]	//Pass response to printf
	ldr	r0, VAR+12	//Pass TEXTSUB to printf
	rsb	r3, r2, r1	//Pass stuff (response - global) to printf
	bl	printf		//Call printf

	//$$$ DO SIMPLE MATH (MULTIPLY)
	//printf("response * 2 = stuff");
	ldr	r1, [sp, #4]	//Pass response to printf
	ldr	r0, VAR+16	//Pass TEXTMUL to printf
	mov	r3, $2		//Load 2 into global
	mul	r2, r1, r3	//Pass stuff (response * 2) to printf
	bl	printf		//Call printf

	//$$$ DO SIMPLE MATH (DIVIDE)
	//printf("response / 2 = stuff");
	ldr	r1, [sp, #4]	//Pass response to printf
	ldr	r0, VAR+20	//Pass TEXTDIV to printf
	mov	r2, r1, lsr #1	//Pass stuff (response / 2) to printf
	bl	printf		//Call printf

	ldr	r0, [sp, #4]
	add	sp, sp, #8
	ldmfd	sp!, {r4, pc}
VAR:
	.word	.LANCHOR0
	.word	INTIO
	.word	TEXTADD
	.word	TEXTSUB
	.word	TEXTMUL
	.word	TEXTDIV
	.word	TEXTFAV
	.word	stdout
	.size	getInput, .-getInput
	.align	2

	.global	main
	.type	main, %function
main:
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r4, #0		//Make value = 0
	ldr	r0, VAR+24	//Pass TEXTFAV to getInput
	bl	getInput	//Call getInput
	mov	r5, r0
//Prints "123456789\n" on the command line
print:
	mov	r4, #0		//i = 0;
	//$$$ CREATE A LOOP
	//$$$ CREATE A FOR LOOP
LOOP:
	add	r4, r4, #1	//++i;
	mov	r1, r4		//Pass i to printf
	ldr	r0, VAR+4	//Pass INTIO to printf
	bl	printf		//Call printf
	cmp	r4, #9		//If i != 9
	bne	LOOP		//Go back to LOOP
	ldr	r3, VAR+28	//Pass stdout to putchar
	mov	r0, #10		//Pass '\n' to putchar
	ldr	r1, [r3]	//Pass &stdout to putchar
	bl	_IO_putc	//Call putchar
	mov	r0, r5		//Return
	ldmfd	sp!, {r3, r4, r5, pc}

	.data
	.align	2
.LANCHOR0 = . + 0
	.type	global, %object
	.size	global, 4
global:
	.word	5
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
	//$$$ CREATE STATIC DATA IN MEMORY
INTIO:
	.ascii	"%d\000"
	.space	1
TEXTADD:
	.ascii	"Your answer, %d, plus %d is %d.\012\000"
	.space	3
TEXTSUB:
	.ascii	"Your answer, %d, minus %d is %d.\012\000"
	.space	2
TEXTMUL:
	.ascii	"Your answer, %d, times 2 is %d.\012\000"
	.space	3
TEXTDIV:
	.ascii	"Your answer, %d, divided by 2 is more or less %d.\012\000"
	.space	1
TEXTFAV:
	.ascii	"What is your favorite number? \000"
