/* MACRO LIBRARY */
/* Filled with macros that are too important to be without! */

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
