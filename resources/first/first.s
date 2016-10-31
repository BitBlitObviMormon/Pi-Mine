/* -- first.s */
.global _start
_start:
	@ Set the error code to 2
	mov r0, #2

	@ Return to the operating system
	mov r7, #1
	svc #0
