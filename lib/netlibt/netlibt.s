/* Network Library (Thumb) */
/* Depends on System Library */

/* Include network constants and error values */
.include "netconst.s"
.include "../errlibt/errno.s"

.data
STRUCT:
	// IFREQ(PF_INET) STRUCTURE
	// char*   ifr_name   [0] -> [3]
	// short   family     [4] -> [5]
	// short   port       [6] -> [7]  (REVERSE BYTE ORDER!) 0x1234->0x4321
	// int     ip_address [8] -> [11] (REVERSE BYTE ORDER!) 0x1234->0x4321
	// char[8] (padding)  [12] -> [19]
	.skip	20	//20 bytes of space for ifreq or sockaddr structs

.text
.thumb
.syntax	unified

/* socket*[r0] createSocket() */
/* Creates an IPv4 socket */
/* Data Races: No memory is accessed */
.thumb_func
.global	createSocket
.type	createSocket, %function
createSocket:
	//Create a socket
	mov	r0, #PF_INET	//Use IPv4 domain
	mov	r1, #SOCK_STREAM//Use standard socket stream
	mov	r2, #0		//Use the recommended protocol
	b	sysSocket	//Call socket system call

/* socket*[r0] createServer(int ip [r0], short port[r1], int backlog[r2],
	bool block[r3]) */
/* Creates an IPv4 socket on the local host and binds it to a local address */
/* on the specified port where it will listen for incoming clients */
/* The backlog is the maximum amount of data the socket can hold before */
/* further requests are rejected */
/* If block is set to true, any acceptClient calls will wait until a client */
/* connects. If it is false then using acceptClient whenever there is no */
/* client waiting to connect will return EAGAIN instead */
/* The return value is negative and set to errno if it fails */
/* Data Races: The memory STRUCT is read and written to */
.thumb_func
.global	createServer
.type	createServer, %function
createServer:
	push	{r4, r5, r6, r7, lr}	//Save variables and return point

	//Save the arguments into variables
	movs	r4, r0		//r4 = ip
	movs	r5, r1		//r5 = port
	movs	r6, r2		//r6 = backlog
	movs	r7, r3		//r7 = block
				//r8 = socket

	//Reverse the byte order of the ip and port (because memory structure)
	revsh	r4, r4		//Reverse ip's byte order
	revsh	r5, r5		//Reverse port's byte order


	//Create a socket to work with
	movs	r0, #PF_INET	//Use IPv4 domain
	movs	r1, #SOCK_STREAM//Use standard socket stream
	movs	r2, #0		//Use the recommended protocol
	bl	sysSocket	//Call the socket system call
	movs	r8, r0		//Save the socket for later

//	//Get the local host's ip name
//	mov	r0, r8		//Get the socket
//	movw	r1, #SIOCGIFNAME//Prepare to use SIOCGIFNAME Ioctl call
//	ldr	r2, =STRUCT	//Prepare space for the ifreq struct
//	bl	sysIoctl	//Call the Ioctl system call
//
//	//Get the local host's ip address
//	mov	r0, r8		//Get the socket
//	movw	r1, #SIOCGIFADDR//Prepare to use SIOCGIFADDR Ioctl call
//	ldr	r2, =STRUCT	//Prepare space for the ifreq struct
//	bl	sysIoctl	//Call the Ioctl system call

	//Set the network's family to PF_INET
	ldr	r0, =STRUCT+4	//Load the family part of the struct
	movs	r1, #PF_INET	//Prepare to write PF_INET to family
	strh	r1, [r0]	//Write PF_INET to family 

	//Set the network's port
	adds	r0, r0, #2	//Load the port part of the struct
	strh	r5, [r0]	//Store the port number in the struct

	//Set the network's ip address
	adds	r0, r0, #2	//Load the address part of the struct
	str	r4, [r0]	//Write the ip address

	//Bind the server to the returned address and the given port
	movs	r0, r8		//Get the socket
	ldr	r1, =STRUCT+4	//Get the sockaddr part of the struct
	movs	r2, #16		//The length of the struct is 8 bytes
	bl	sysBind		//Call the Bind system call

	//Tell the server to listen for incoming connections
	movs	r0, r8		//Get the socket
	movs	r1, r6		//Get the backlog
	bl	sysListen	//Call the Listen system call

	movs	r0, r8			//Return the socket file descriptor
	pop	{r4, r5, r6, r7, pc}	//Return

/* sockaddr* ip[r0] getIP() */
/* Gets the local host's ip address */
/* Data Races: No memory is accessed */
.thumb_func
.global	getIP
.type	getIP, %function
getIP:
	push	{lr}		//Save return point for later
	pop	{pc}		//Return
