/* Macro Library Driver */
/* Depends on System and Input/Output (Thumb) Libraries */

.include "macrolib.inc"	// For mov32

/* void main() */
/* The main thread */
.arm
.align	2
.global _start
_start:
.global	main
main:
	// Set to thumb mode
	add	pc, #1
	nop

.thumb
.syntax	unified

	// Load a memory address without reading it from memory
	mov32	r1, TEXT
	bl	prints

	// Exit
	movs	r0, #0
	b	sysExit

.text
TEXT:
	.asciz	"Hello World of Macros!\n"
