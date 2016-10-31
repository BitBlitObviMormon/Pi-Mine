/* -- pow2.s */
.global _start
_start:
	// The goal here is to see if a number is a power of 2
	// See this: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0068b/CIHJGJED.html

	// Set the error code to 2
	mov r0, #2

	// Return to the operating system
	mov r7, #1
	svc #0
