/* Loads a 32-bit immediate onto a register without a data access */
.macro	mov32, reg, val
	movw	\reg, #:lower16:\val
	movt	\reg, #:upper16:\val
.endm

.text
.global	main
main:
	push	{r0, lr}	// Save return point for later

	// Allocate 16 bytes of data for no reason
	mov	r0, #16
	bl	malloc

	// Output some text
	mov32	r0, TEXT
	bl	printf

	// Get a float as input
	mov32	r0, IFLOAT
	bl	scanf

	// Print that float
	bl	printFloat

	pop	{r0, pc}	// Return

/* void printFloat(float value[s0]) */
.global	printFloat
printFloat:
	push	{r0, lr}

	// Convert the float to a double
	vcvt.f64.f32	d0, s0
	vmov	r2, r3, d0

	// Print the float
	mov32	r0, OFLOAT
	bl	printf

	pop	{r0, pc}

.data
TEXT:
	.asciz	"Give me a float! "
IFLOAT:
	.asciz	"%f"
OFLOAT:
	.asciz	"You gave me %f!\n"
