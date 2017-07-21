.set	EXIT, 1	// Exit system call

/* Loads a 32-bit immediate onto a register without a data access */
.macro	mov32, reg, val
	movw	\reg, #:lower16:\val
	movt	\reg, #:upper16:\val
.endm

/* Counts Trailing Zeros */
.macro	ctz, reg0, reg1
	rbit	\reg0, \reg1
	clz	\reg0, \reg0
.endm

.text
.arm
.syntax	unified

/* long[r0-r1] mul64(int[r0], int[r1]) */
/* Signed 64-bit multiply */
.type	mul64, %function
mul64:
	smull	r0, r1, r0, r1
	bx	lr

/* void parallelMath(int[r0], int[r1], int[r2], int[r3]) */
/* Does parallel math on the vector processor */
.type	parallelMath, %function
parallelMath:
	// Pull the registers into the fpu
	vmov.s32 s0, r0
	vmov.s32 s1, r1
	vmov.s32 s2, r2
	vmov.s32 s3, r3

	// Pull 5s into four fpu registers
	mov	 r0, #5
	mov	 r1, #5
	mov	 r2, #5
	mov	 r3, #5
	vmov.s32 s4, r0
	vmov.s32 s5, r1
	vmov.s32 s6, r2
	vmov.s32 s7, r3

	// Do math on all eight registers parallely
	vadd.s32 q0, q0, q1 // args += 5
	vsub.s32 q0, q0, q1 // args -= 5
	vmul.s32 q0, q0, q1 // args *= 5

	// vdiv appears to complain with scalar math: I cannot do it in parallel
//	vdiv q0, q0, q1 // ASSEMBLER ERROR
	vcvt.s32.f32 s0, s0
	vcvt.s32.f32 s1, s1
	vcvt.s32.f32 s2, s2
	vcvt.s32.f32 s3, s3
	vdiv.f32 s0, s0, s4
	vdiv.f32 s1, s1, s5
	vdiv.f32 s2, s2, s6
	vdiv.f32 s3, s3, s7

	bx	lr

/* bool[r0] isPow2(int num[r0]) */
/* Returns (CLZ(num) + CTZ(num)) == 31 */
.type	isPow2, %function
isPow2:
	// temp[r0] = CLZ(num) + CTZ(num)
	clz	r1, r0
	ctz	r2, r0
	add	r0, r1, r2

	// return (temp == 31)
	mov	r3, #31
	cmp	r0, r3
	moveq	r0, #1
	movne	r0, #0
	bx	lr

.global	_start
_start:
.global main
main:
	// 150123 * 508716
	mov32	r0, #150123
	mov32	r1, #508716
	bl	mul64

	// Do some parallel math
	bl	parallelMath

	// Return whether 8 is a power of 2
	mov	r7, #EXIT
	mov	r0, #8
	bl	isPow2	// Returns true (1)
	svc	#0
	
