.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

//int main()
.thumb
.global main
main:
	//Create a socket
	bl	createSocket

	mov	r0, #13		//Move #13 to r0
	b	sysExit
