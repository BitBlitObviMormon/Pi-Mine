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

	//Create a server
	mov	r0, #0		//Host on the ip address 0.0.0.0
	movw	r1, #12345	//Host on port 12345
	mov	r2, #255	//Only 255 bytes of backlog
	mov	r3, #0		//Don't block in order to wait for clients
	bl	createServer	//Create the server socket

	mov	r0, #13		//Move #13 to r0
	b	sysExit
