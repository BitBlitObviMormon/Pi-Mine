/* Network Library (Thumb) */
/* Depends on System Library */
/* NETWORK PROTOCOLS */
.set	PF_UNIX,	 1
.set	PF_LOCAL,	 1
.set	PF_INET,	 2
.set	PF_INET6,	10
.set	PF_IPX,		 4
.set	PF_NETLINK,	16
.set	PF_X25,		 9
.set	PF_AX25,	 3
.set	PF_ATMPVC,	 8
.set	PF_APPLETALK,	 5
.set	PF_PACKET,	17

/* NETWORK TYPES */
.set	SOCK_STREAM,	 1
.set	SOCK_DGRAM,	 2
.set	SOCK_RAW,	 3
.set	SOCK_RDM,	 4
.set	SOCK_SEQPACKET,	 5
.set	SOCK_PACKET,	10

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
