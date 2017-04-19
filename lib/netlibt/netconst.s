/* Network Constants */
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

/* IOCTL CALLS */
.set	SIOCGIFNAME,	0x8910	// Get ip name
.set	SIOCGIFADDR,	0x8915	// Get ip address

/* MESSAGE CONSTANTS */
.set	MSG_OOB,	0x0001
.set	MSG_PEEK,	0x0002
.set	MSG_DONTROUTE,	0x0004
.set	MSG_CTRUNC,	0x0008
.set	MSG_TRUNC,	0x0020
.set	MSG_DONTWAIT,	0x0040
.set	MSG_EOR,	0x0080
.set	MSG_WAITALL,	0x0100
.set	MSG_CONFIRM,	0x0800
.set	MSG_ERRQUEUE,	0x2000
.set	MSG_NOSIGNAL,	0x4000

/* SHUTDOWN CONSTANTS */
.set	SHUT_RD,	0	// Shutdown output
.set	SHUT_WR,	1	// Shutdown input
.set	SHUT_RDWR,	2	// Shutdown all
