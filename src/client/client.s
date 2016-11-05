.set	EXIT, 1

.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

.thumb
.global exit
/* void exit(int) */
/* Exits with the error code given */
exit:
	mov	r7, #EXIT	//Exit with
	svc	#0		//	whatever is in r0

//int main()
.thumb
.global main
main:
	mov	r0, #2		//Move #13 to r0
	b	exit
