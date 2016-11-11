.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

//int main()
.thumb
.global main
main:
	mov	r0, #13		//Move #13 to r0
	b	sysExit
