/* Network Library (Thumb) */
/* Depends on System Library */

/* Include network constants and error values */
.include "netconst.s"
.include "../errlibt/errno.s"

.text

/* socket*[r0] createSocket() */
/* Creates an IPv4 socket on the local host */
/* Data Races: No memory is accessed */
.thumb
.global	createSocket
.type	createSocket, %function
createSocket:
	mov	r0, #PF_INET	//Use IPv4 domain
	mov	r1, #SOCK_STREAM//Use standard socket stream
	mov	r2, #0		//Use the recommended protocol
	b	sysSocket	//Call socket system call

/* socket*[r0] createServer(int port[r0], bool block[r1]) */
/* Creates an IPv4 socket on the local host and binds it to a local address */
/* on the specified port where it will listen for incoming clients */
/* If block is set to true, any acceptClient calls will wait until a client */
/* connects. If it is false then using acceptClient whenever there is no */
/* client waiting to connect will return EAGAIN instead */
/* Data Races: No memory is accessed */
.thumb
.global	createServer
.type	createServer, %function
createServer:
	push	{lr}		//Save return point for later
	mov	r0, #PF_INET	//Use IPv4 domain
	mov	r1, #SOCK_STREAM//Use standard socket stream
	mov	r2, #0		//Use the recommended protocol
	bl	sysSocket	//Call socket system call
	push	{r0}		//Save the socket address for later

	//Get the local host's ip address
	bl	getIP

	pop	{r0, pc}	//Return


/* int ip[r0] getIP() */
/* Gets the local host's ip address */
/* Data Races: No memory is accessed */
.thumb
.global	getIP
.type	getIP, %function
getIP:
	push	{lr}		//Save return point for later
	pop	{pc}		//Return
