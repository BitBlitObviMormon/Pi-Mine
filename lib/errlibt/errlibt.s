/* Error Library (Thumb) */
/* Depends on Input/Output Library and System Library */

/* FILE STREAMS */
.set	STDOUT, 1

/* ERROR VALUES */
.set	ESUCC,             0  // Success
.set	EPERM,             1  // Operation not permitted
.set	ENOENT,            2  // No such file or directory
.set	ESRCH,             3  // No such process
.set	EINTR,             4  // Interrupted system call
.set	EIO,               5  // Input/output error
.set	ENXIO,             6  // No such device or address
.set	E2BIG,             7  // Argument list too long
.set	ENOEXEC,           8  // Exec format error
.set	EBADF,             9  // Bad file descriptor
.set	ECHILD,           10  // No child processes
.set	EAGAIN,           11  // Resource temporarily unavailable
.set	ENOMEM,           12  // Cannot allocate memory
.set	EACCES,           13  // Permission denied
.set	EFAULT,           14  // Bad address
.set	ENOTBLK,          15  // Block device required
.set	EBUSY,            16  // Device or resource busy
.set	EEXIST,           17  // File exists
.set	EXDEV,            18  // Invalid cross-device link
.set	ENODEV,           19  // No such device
.set	ENOTDIR,          20  // Not a directory
.set	EISDIR,           21  // Is a directory
.set	EINVAL,           22  // Invalid argument
.set	ENFILE,           23  // Too many open files in system
.set	EMFILE,           24  // Too many open files
.set	ENOTTY,           25  // Inappropriate ioctl for device
.set	ETXTBSY,          26  // Text file busy
.set	EFBIG,            27  // File too large
.set	ENOSPC,           28  // No space left on device
.set	ESPIPE,           29  // Illegal seek
.set	EROFS,            30  // Read-only file system
.set	EMLINK,           31  // Too many links
.set	EPIPE,            32  // Broken pipe
.set	EDOM,             33  // Numerical argument out of domain
.set	ERANGE,           34  // Numerical result out of range
.set	EDEADLK,          35  // Resource deadlock avoided
.set	ENAMETOOLONG,     36  // File name too long
.set	ENOLCK,           37  // No locks available
.set	ENOSYS,           38  // Function not implemented
.set	ENOTEMPTY,        39  // Directory not empty
.set	ELOOP,            40  // Too many levels of symbolic links
.set	ENOMSG,           42  // No message of desired type
.set	EIDRM,            43  // Identifier removed
.set	ECHRNG,           44  // Channel number out of range
.set	EL2NSYNC,         45  // Level 2 not synchronized
.set	EL3HLT,           46  // Level 3 halted
.set	EL3RST,           47  // Level 3 reset
.set	ELNRNG,           48  // Link number out of range
.set	EUNATCH,          49  // Protocol driver not attached
.set	ENOCSI,           50  // No CSI structure available
.set	EL2HLT,           51  // Level 2 halted
.set	EBADE,            52  // Invalid exchange
.set	EBADR,            53  // Invalid request descriptor
.set	EXFULL,           54  // Exchange full
.set	ENOANO,           55  // No anode
.set	EBADRQC,          56  // Invalid request code
.set	EBADSLT,          57  // Invalid slot
.set	EBFONT,           59  // Bad font file format
.set	ENOSTR,           60  // Device not a stream
.set	ENODATA,          61  // No data available
.set	ETIME,            62  // Timer expired
.set	ENOSR,            63  // Out of streams resources
.set	ENONET,           64  // Machine is not on the network
.set	ENOPKG,           65  // Package not installed
.set	EREMOTE,          66  // Object is remote
.set	ENOLINK,          67  // Link has been severed
.set	EADV,             68  // Advertise error
.set	ESRMNT,           69  // Srmount error
.set	ECOMM,            70  // Communication error on send
.set	EPROTO,           71  // Protocol error
.set	EMULTIHOP,        72  // Multihop attempted
.set	EDOTDOT,          73  // RFS specific error
.set	EBADMSG,          74  // Bad message
.set	EOVERFLOW,        75  // Value too large for defined data type
.set	ENOTUNIQ,         76  // Name not unique on network
.set	EBADFD,           77  // File descriptor in bad state
.set	EREMCHG,          78  // Remote address changed
.set	ELIBACC,          79  // Can not access a needed shared library
.set	ELIBBAD,          80  // Accessing a corrupted shared library
.set	ELIBSCN,          81  // .lib section in a.out corrupted
.set	ELIBMAX,          82  // Attempting to link in too many shared libraries
.set	ELIBEXEC,         83  // Cannot exec a shared library directly
.set	EILSEQ,           84  // Invalid or incomplete multibyte or wide character
.set	ERESTART,         85  // Interrupted system call should be restarted
.set	ESTRPIPE,         86  // Streams pipe error
.set	EUSERS,           87  // Too many users
.set	ENOTSOCK,         88  // Socket operation on non-socket
.set	EDESTADDRREQ,     89  // Destination address required
.set	EMSGSIZE,         90  // Message too long
.set	EPROTOTYPE,       91  // Protocol wrong type for socket
.set	ENOPROTOOPT,      92  // Protocol not available
.set	EPROTONOSUPPORT,  93  // Protocol not supported
.set	ESOCKTNOSUPPORT,  94  // Socket type not supported
.set	EOPNOTSUPP,       95  // Operation not supported
.set	EPFNOSUPPORT,     96  // Protocol family not supported
.set	EAFNOSUPPORT,     97  // Address family not supported by protocol
.set	EADDRINUSE,       98  // Address already in use
.set	EADDRNOTAVAIL,    99  // Cannot assign requested address
.set	ENETDOWN,        100  // Network is down
.set	ENETUNREACH,     101  // Network is unreachable
.set	ENETRESET,       102  // Network dropped connection on reset
.set	ECONNABORTED,    103  // Software caused connection abort
.set	ECONNRESET,      104  // Connection reset by peer
.set	ENOBUFS,         105  // No buffer space available
.set	EISCONN,         106  // Transport endpoint is already connected
.set	ENOTCONN,        107  // Transport endpoint is not connected
.set	ESHUTDOWN,       108  // Cannot send after transport endpoint shutdown
.set	ETOOMANYREFS,    109  // Too many references: cannot splice
.set	ETIMEDOUT,       110  // Connection timed out
.set	ECONNREFUSED,    111  // Connection refused
.set	EHOSTDOWN,       112  // Host is down
.set	EHOSTUNREACH,    113  // No route to host
.set	EALREADY,        114  // Operation already in progress
.set	EINPROGRESS,     115  // Operation now in progress
.set	ESTALE,          116  // Stale file handle
.set	EUCLEAN,         117  // Structure needs cleaning
.set	ENOTNAM,         118  // Not a XENIX named type file
.set	ENAVAIL,         119  // No XENIX semaphores available
.set	EISNAM,          120  // Is a named type file
.set	EREMOTEIO,       121  // Remote I/O error
.set	EDQUOT,          122  // Disk quota exceeded
.set	ENOMEDIUM,       123  // No medium found
.set	EMEDIUMTYPE,     124  // Wrong medium type
.set	ECANCELED,       125  // Operation canceled
.set	ENOKEY,          126  // Required key not available
.set	EKEYEXPIRED,     127  // Key has expired
.set	EKEYREVOKED,     128  // Key has been revoked
.set	EKEYREJECTED,    129  // Key was rejected by service
.set	EOWNERDEAD,      130  // Owner died
.set	ENOTRECOVERABLE, 131  // State not recoverable
.set	ERFKILL,         132  // Operation not possible due to RF-kill
.set	EHWPOISON,       133  // Memory page has hardware error

.text

/* void fprinterr(int fd[r0], int errno[r1]) */
/* Writes the symbolic message of the error number errno to the stream fd */
/* Data Races: Only static memory is accessed */
.thumb
.global	fprinterr
.type	fprinterr, %function
fprinterr:
	push	{r1, lr}	// Save return point
	bl	makePositive	// Make the number positive
	mov	r2, #4
	mul	r1, r1, r2	// Multiply the number by 4 (for addresses)
	ldr	r2, =ERRNO	// Load the address
	add	r2, r2, r1	// Add the offset to the address
	ldr	r2, [r2]		// Load the string from that address
	mov	r1, r2
	bl	fprints		// Print the error string
	pop	{r1, pc}	// Return

/* void fprinterrdetails(int fd[r0], int errno[r1]) */
/* Writes a detailed description of the error number errno to the stream fd */
/* Data Races: Only static memory is accessed */
.thumb
.global	fprinterrdetails
.type	fprinterrdetails, %function
fprinterrdetails:
	push	{r1, lr}	// Save return point
	bl	makePositive	// Make the number positive
	mov	r2, #4
	mul	r1, r1, r2	// Multiply the number by 4 (for addresses)
	ldr	r2, =ERRNODET	// Load the address
	add	r2, r2, r1	// Add the offset to the address
	ldr	r2, [r2]		// Load the string from that address
	mov	r1, r2
	bl	fprints		// Print the error string
	pop	{r1, pc}	// Return

/* int [r1] makePositive(int num[r1]) */
/* If the number is negative then it will become positive */
/* Data Races: No memory is accessed */
.thumb
makePositive:
	cmp	r1, #0	// If r0 is greater or equal to zero then skip
	bpl	.LskipPositive
	neg	r1, r1	// Negate the number
.LskipPositive:
	bx	lr	// Return

/* void printerr(int errno[r1]) */
/* Prints the symbolic message of the error number errno to the console */
/* Data Races: Only static memory is accessed */
.thumb
.global	printerr
.type	printerr, %function
printerr:
	mov	r0, #STDOUT
	b	fprinterr

/* void printerrdetails(int fd[r0], int errno[r1]) */
/* Prints a detailed description of the error number errno to the console */
/* Data Races: Only static memory is accessed */
.thumb
.global	printerrdetails
.type	printerrdetails, %function
printerrdetails:
	mov	r0, #STDOUT
	b	fprinterrdetails

.data

ERRNO:
	.word	ESUCCSTR
	.word	EPERMSTR
	.word	ENOENTSTR
	.word	ESRCHSTR
	.word	EINTRSTR
	.word	EIOSTR
	.word	ENXIOSTR
	.word	E2BIGSTR
	.word	ENOEXECSTR
	.word	EBADFSTR
	.word	ECHILDSTR
	.word	EAGAINSTR
	.word	ENOMEMSTR
	.word	EACCESSTR
	.word	EFAULTSTR
	.word	ENOTBLKSTR
	.word	EBUSYSTR
	.word	EEXISTSTR
	.word	EXDEVSTR
	.word	ENODEVSTR
	.word	ENOTDIRSTR
	.word	EISDIRSTR
	.word	EINVALSTR
	.word	ENFILESTR
	.word	EMFILESTR
	.word	ENOTTYSTR
	.word	ETXTBSYSTR
	.word	EFBIGSTR
	.word	ENOSPCSTR
	.word	ESPIPESTR
	.word	EROFSSTR
	.word	EMLINKSTR
	.word	EPIPESTR
	.word	EDOMSTR
	.word	ERANGESTR
	.word	EDEADLKSTR
	.word	ENAMETOOLONGSTR
	.word	ENOLCKSTR
	.word	ENOSYSSTR
	.word	ENOTEMPTYSTR
	.word	ELOOPSTR
	.word	EUNKNOWNERRSTR
	.word	ENOMSGSTR
	.word	EIDRMSTR
	.word	ECHRNGSTR
	.word	EL2NSYNCSTR
	.word	EL3HLTSTR
	.word	EL3RSTSTR
	.word	ELNRNGSTR
	.word	EUNATCHSTR
	.word	ENOCSISTR
	.word	EL2HLTSTR
	.word	EBADESTR
	.word	EBADRSTR
	.word	EXFULLSTR
	.word	ENOANOSTR
	.word	EBADRQCSTR
	.word	EBADSLTSTR
	.word	EUNKNOWNERRSTR
	.word	EBFONTSTR
	.word	ENOSTRSTR
	.word	ENODATASTR
	.word	ETIMESTR
	.word	ENOSRSTR
	.word	ENONETSTR
	.word	ENOPKGSTR
	.word	EREMOTESTR
	.word	ENOLINKSTR
	.word	EADVSTR
	.word	ESRMNTSTR
	.word	ECOMMSTR
	.word	EPROTOSTR
	.word	EMULTIHOPSTR
	.word	EDOTDOTSTR
	.word	EBADMSGSTR
	.word	EOVERFLOWSTR
	.word	ENOTUNIQSTR
	.word	EBADFDSTR
	.word	EREMCHGSTR
	.word	ELIBACCSTR
	.word	ELIBBADSTR
	.word	ELIBSCNSTR
	.word	ELIBMAXSTR
	.word	ELIBEXECSTR
	.word	EILSEQSTR
	.word	ERESTARTSTR
	.word	ESTRPIPESTR
	.word	EUSERSSTR
	.word	ENOTSOCKSTR
	.word	EDESTADDRREQSTR
	.word	EMSGSIZESTR
	.word	EPROTOTYPESTR
	.word	ENOPROTOOPTSTR
	.word	EPROTONOSUPPORTSTR
	.word	ESOCKTNOSUPPORTSTR
	.word	EOPNOTSUPPSTR
	.word	EPFNOSUPPORTSTR
	.word	EAFNOSUPPORTSTR
	.word	EADDRINUSESTR
	.word	EADDRNOTAVAILSTR
	.word	ENETDOWNSTR
	.word	ENETUNREACHSTR
	.word	ENETRESETSTR
	.word	ECONNABORTEDSTR
	.word	ECONNRESETSTR
	.word	ENOBUFSSTR
	.word	EISCONNSTR
	.word	ENOTCONNSTR
	.word	ESHUTDOWNSTR
	.word	ETOOMANYREFSSTR
	.word	ETIMEDOUTSTR
	.word	ECONNREFUSEDSTR
	.word	EHOSTDOWNSTR
	.word	EHOSTUNREACHSTR
	.word	EALREADYSTR
	.word	EINPROGRESSSTR
	.word	ESTALESTR
	.word	EUCLEANSTR
	.word	ENOTNAMSTR
	.word	ENAVAILSTR
	.word	EISNAMSTR
	.word	EREMOTEIOSTR
	.word	EDQUOTSTR
	.word	ENOMEDIUMSTR
	.word	EMEDIUMTYPESTR
	.word	ECANCELEDSTR
	.word	ENOKEYSTR
	.word	EKEYEXPIREDSTR
	.word	EKEYREVOKEDSTR
	.word	EKEYREJECTEDSTR
	.word	EOWNERDEADSTR
	.word	ENOTRECOVERABLESTR
	.word	ERFKILLSTR
	.word	EHWPOISONSTR
ERRNODET:
	.word	ESUCCDET
	.word	EPERMDET
	.word	ENOENTDET
	.word	ESRCHDET
	.word	EINTRDET
	.word	EIODET
	.word	ENXIODET
	.word	E2BIGDET
	.word	ENOEXECDET
	.word	EBADFDET
	.word	ECHILDDET
	.word	EAGAINDET
	.word	ENOMEMDET
	.word	EACCESDET
	.word	EFAULTDET
	.word	ENOTBLKDET
	.word	EBUSYDET
	.word	EEXISTDET
	.word	EXDEVDET
	.word	ENODEVDET
	.word	ENOTDIRDET
	.word	EISDIRDET
	.word	EINVALDET
	.word	ENFILEDET
	.word	EMFILEDET
	.word	ENOTTYDET
	.word	ETXTBSYDET
	.word	EFBIGDET
	.word	ENOSPCDET
	.word	ESPIPEDET
	.word	EROFSDET
	.word	EMLINKDET
	.word	EPIPEDET
	.word	EDOMDET
	.word	ERANGEDET
	.word	EDEADLKDET
	.word	ENAMETOOLONGDET
	.word	ENOLCKDET
	.word	ENOSYSDET
	.word	ENOTEMPTYDET
	.word	ELOOPDET
	.word	EUNKNOWNERRDET
	.word	ENOMSGDET
	.word	EIDRMDET
	.word	ECHRNGDET
	.word	EL2NSYNCDET
	.word	EL3HLTDET
	.word	EL3RSTDET
	.word	ELNRNGDET
	.word	EUNATCHDET
	.word	ENOCSIDET
	.word	EL2HLTDET
	.word	EBADEDET
	.word	EBADRDET
	.word	EXFULLDET
	.word	ENOANODET
	.word	EBADRQCDET
	.word	EBADSLTDET
	.word	EUNKNOWNERRDET
	.word	EBFONTDET
	.word	ENOSTRDET
	.word	ENODATADET
	.word	ETIMEDET
	.word	ENOSRDET
	.word	ENONETDET
	.word	ENOPKGDET
	.word	EREMOTEDET
	.word	ENOLINKDET
	.word	EADVDET
	.word	ESRMNTDET
	.word	ECOMMDET
	.word	EPROTODET
	.word	EMULTIHOPDET
	.word	EDOTDOTDET
	.word	EBADMSGDET
	.word	EOVERFLOWDET
	.word	ENOTUNIQDET
	.word	EBADFDDET
	.word	EREMCHGDET
	.word	ELIBACCDET
	.word	ELIBBADDET
	.word	ELIBSCNDET
	.word	ELIBMAXDET
	.word	ELIBEXECDET
	.word	EILSEQDET
	.word	ERESTARTDET
	.word	ESTRPIPEDET
	.word	EUSERSDET
	.word	ENOTSOCKDET
	.word	EDESTADDRREQDET
	.word	EMSGSIZEDET
	.word	EPROTOTYPEDET
	.word	ENOPROTOOPTDET
	.word	EPROTONOSUPPORTDET
	.word	ESOCKTNOSUPPORTDET
	.word	EOPNOTSUPPDET
	.word	EPFNOSUPPORTDET
	.word	EAFNOSUPPORTDET
	.word	EADDRINUSEDET
	.word	EADDRNOTAVAILDET
	.word	ENETDOWNDET
	.word	ENETUNREACHDET
	.word	ENETRESETDET
	.word	ECONNABORTEDDET
	.word	ECONNRESETDET
	.word	ENOBUFSDET
	.word	EISCONNDET
	.word	ENOTCONNDET
	.word	ESHUTDOWNDET
	.word	ETOOMANYREFSDET
	.word	ETIMEDOUTDET
	.word	ECONNREFUSEDDET
	.word	EHOSTDOWNDET
	.word	EHOSTUNREACHDET
	.word	EALREADYDET
	.word	EINPROGRESSDET
	.word	ESTALEDET
	.word	EUCLEANDET
	.word	ENOTNAMDET
	.word	ENAVAILDET
	.word	EISNAMDET
	.word	EREMOTEIODET
	.word	EDQUOTDET
	.word	ENOMEDIUMDET
	.word	EMEDIUMTYPEDET
	.word	ECANCELEDDET
	.word	ENOKEYDET
	.word	EKEYEXPIREDDET
	.word	EKEYREVOKEDDET
	.word	EKEYREJECTEDDET
	.word	EOWNERDEADDET
	.word	ENOTRECOVERABLEDET
	.word	ERFKILLDET
	.word	EHWPOISONDET
EUNKNOWNERRSTR:
	.asciz	"EUNKNOWNERR"
ESUCCSTR:
	.asciz	"ESUCC"
EPERMSTR:
	.asciz	"EPERM"
ENOENTSTR:
	.asciz	"ENOENT"
ESRCHSTR:
	.asciz	"ESRCH"
EINTRSTR:
	.asciz	"EINTR"
EIOSTR:
	.asciz	"EIO"
ENXIOSTR:
	.asciz	"ENXIO"
E2BIGSTR:
	.asciz	"E2BIG"
ENOEXECSTR:
	.asciz	"ENOEXEC"
EBADFSTR:
	.asciz	"EBADF"
ECHILDSTR:
	.asciz	"ECHILD"
EAGAINSTR:
	.asciz	"EAGAIN"
ENOMEMSTR:
	.asciz	"ENOMEM"
EACCESSTR:
	.asciz	"EACCES"
EFAULTSTR:
	.asciz	"EFAULT"
ENOTBLKSTR:
	.asciz	"ENOTBLK"
EBUSYSTR:
	.asciz	"EBUSY"
EEXISTSTR:
	.asciz	"EEXIST"
EXDEVSTR:
	.asciz	"EXDEV"
ENODEVSTR:
	.asciz	"ENODEV"
ENOTDIRSTR:
	.asciz	"ENOTDIR"
EISDIRSTR:
	.asciz	"EISDIR"
EINVALSTR:
	.asciz	"EINVAL"
ENFILESTR:
	.asciz	"ENFILE"
EMFILESTR:
	.asciz	"EMFILE"
ENOTTYSTR:
	.asciz	"ENOTTY"
ETXTBSYSTR:
	.asciz	"ETXTBSY"
EFBIGSTR:
	.asciz	"EFBIG"
ENOSPCSTR:
	.asciz	"ENOSPC"
ESPIPESTR:
	.asciz	"ESPIPE"
EROFSSTR:
	.asciz	"EROFS"
EMLINKSTR:
	.asciz	"EMLINK"
EPIPESTR:
	.asciz	"EPIPE"
EDOMSTR:
	.asciz	"EDOM"
ERANGESTR:
	.asciz	"ERANGE"
EDEADLKSTR:
	.asciz	"EDEADLK"
ENAMETOOLONGSTR:
	.asciz	"ENAMETOOLONG"
ENOLCKSTR:
	.asciz	"ENOLCK"
ENOSYSSTR:
	.asciz	"ENOSYS"
ENOTEMPTYSTR:
	.asciz	"ENOTEMPTY"
ELOOPSTR:
	.asciz	"ELOOP"
ENOMSGSTR:
	.asciz	"ENOMSG"
EIDRMSTR:
	.asciz	"EIDRM"
ECHRNGSTR:
	.asciz	"ECHRNG"
EL2NSYNCSTR:
	.asciz	"EL2NSYNC"
EL3HLTSTR:
	.asciz	"EL3HLT"
EL3RSTSTR:
	.asciz	"EL3RST"
ELNRNGSTR:
	.asciz	"ELNRNG"
EUNATCHSTR:
	.asciz	"EUNATCH"
ENOCSISTR:
	.asciz	"ENOCSI"
EL2HLTSTR:
	.asciz	"EL2HLT"
EBADESTR:
	.asciz	"EBADE"
EBADRSTR:
	.asciz	"EBADR"
EXFULLSTR:
	.asciz	"EXFULL"
ENOANOSTR:
	.asciz	"ENOANO"
EBADRQCSTR:
	.asciz	"EBADRQC"
EBADSLTSTR:
	.asciz	"EBADSLT"
EBFONTSTR:
	.asciz	"EBFONT"
ENOSTRSTR:
	.asciz	"ENOSTR"
ENODATASTR:
	.asciz	"ENODATA"
ETIMESTR:
	.asciz	"ETIME"
ENOSRSTR:
	.asciz	"ENOSR"
ENONETSTR:
	.asciz	"ENONET"
ENOPKGSTR:
	.asciz	"ENOPKG"
EREMOTESTR:
	.asciz	"EREMOTE"
ENOLINKSTR:
	.asciz	"ENOLINK"
EADVSTR:
	.asciz	"EADV"
ESRMNTSTR:
	.asciz	"ESRMNT"
ECOMMSTR:
	.asciz	"ECOMM"
EPROTOSTR:
	.asciz	"EPROTO"
EMULTIHOPSTR:
	.asciz	"EMULTIHOP"
EDOTDOTSTR:
	.asciz	"EDOTDOT"
EBADMSGSTR:
	.asciz	"EBADMSG"
EOVERFLOWSTR:
	.asciz	"EOVERFLOW"
ENOTUNIQSTR:
	.asciz	"ENOTUNIQ"
EBADFDSTR:
	.asciz	"EBADFD"
EREMCHGSTR:
	.asciz	"EREMCHG"
ELIBACCSTR:
	.asciz	"ELIBACC"
ELIBBADSTR:
	.asciz	"ELIBBAD"
ELIBSCNSTR:
	.asciz	"ELIBSCN"
ELIBMAXSTR:
	.asciz	"ELIBMAX"
ELIBEXECSTR:
	.asciz	"ELIBEXEC"
EILSEQSTR:
	.asciz	"EILSEQ"
ERESTARTSTR:
	.asciz	"ERESTART"
ESTRPIPESTR:
	.asciz	"ESTRPIPE"
EUSERSSTR:
	.asciz	"EUSERS"
ENOTSOCKSTR:
	.asciz	"ENOTSOCK"
EDESTADDRREQSTR:
	.asciz	"EDESTADDRREQ"
EMSGSIZESTR:
	.asciz	"EMSGSIZE"
EPROTOTYPESTR:
	.asciz	"EPROTOTYPE"
ENOPROTOOPTSTR:
	.asciz	"ENOPROTOOPT"
EPROTONOSUPPORTSTR:
	.asciz	"EPROTONOSUPPORT"
ESOCKTNOSUPPORTSTR:
	.asciz	"ESOCKTNOSUPPORT"
EOPNOTSUPPSTR:
	.asciz	"EOPNOTSUPP"
EPFNOSUPPORTSTR:
	.asciz	"EPFNOSUPPORT"
EAFNOSUPPORTSTR:
	.asciz	"EAFNOSUPPORT"
EADDRINUSESTR:
	.asciz	"EADDRINUSE"
EADDRNOTAVAILSTR:
	.asciz	"EADDRNOTAVAIL"
ENETDOWNSTR:
	.asciz	"ENETDOWN"
ENETUNREACHSTR:
	.asciz	"ENETUNREACH"
ENETRESETSTR:
	.asciz	"ENETRESET"
ECONNABORTEDSTR:
	.asciz	"ECONNABORTED"
ECONNRESETSTR:
	.asciz	"ECONNRESET"
ENOBUFSSTR:
	.asciz	"ENOBUFS"
EISCONNSTR:
	.asciz	"EISCONN"
ENOTCONNSTR:
	.asciz	"ENOTCONN"
ESHUTDOWNSTR:
	.asciz	"ESHUTDOWN"
ETOOMANYREFSSTR:
	.asciz	"ETOOMANYREFS"
ETIMEDOUTSTR:
	.asciz	"ETIMEDOUT"
ECONNREFUSEDSTR:
	.asciz	"ECONNREFUSED"
EHOSTDOWNSTR:
	.asciz	"EHOSTDOWN"
EHOSTUNREACHSTR:
	.asciz	"EHOSTUNREACH"
EALREADYSTR:
	.asciz	"EALREADY"
EINPROGRESSSTR:
	.asciz	"EINPROGRESS"
ESTALESTR:
	.asciz	"ESTALE"
EUCLEANSTR:
	.asciz	"EUCLEAN"
ENOTNAMSTR:
	.asciz	"ENOTNAM"
ENAVAILSTR:
	.asciz	"ENAVAIL"
EISNAMSTR:
	.asciz	"EISNAM"
EREMOTEIOSTR:
	.asciz	"EREMOTEIO"
EDQUOTSTR:
	.asciz	"EDQUOT"
ENOMEDIUMSTR:
	.asciz	"ENOMEDIUM"
EMEDIUMTYPESTR:
	.asciz	"EMEDIUMTYPE"
ECANCELEDSTR:
	.asciz	"ECANCELED"
ENOKEYSTR:
	.asciz	"ENOKEY"
EKEYEXPIREDSTR:
	.asciz	"EKEYEXPIRED"
EKEYREVOKEDSTR:
	.asciz	"EKEYREVOKED"
EKEYREJECTEDSTR:
	.asciz	"EKEYREJECTED"
EOWNERDEADSTR:
	.asciz	"EOWNERDEAD"
ENOTRECOVERABLESTR:
	.asciz	"ENOTRECOVERABLE"
ERFKILLSTR:
	.asciz	"ERFKILL"
EHWPOISONSTR:
	.asciz	"EHWPOISON"
EUNKNOWNERRDET:
	.asciz	"Invalid error number"
ESUCCDET:
	.asciz	"Success"
EPERMDET:
	.asciz	"Operation not permitted"
ENOENTDET:
	.asciz	"No such file or directory"
ESRCHDET:
	.asciz	"No such process"
EINTRDET:
	.asciz	"Interrupted system call"
EIODET:
	.asciz	"Input/output error"
ENXIODET:
	.asciz	"No such device or address"
E2BIGDET:
	.asciz	"Argument list too long"
ENOEXECDET:
	.asciz	"Exec format error"
EBADFDET:
	.asciz	"Bad file descriptor"
ECHILDDET:
	.asciz	"No child processes"
EAGAINDET:
	.asciz	"Resource temporarily unavailable"
ENOMEMDET:
	.asciz	"Cannot allocate memory"
EACCESDET:
	.asciz	"Permission denied"
EFAULTDET:
	.asciz	"Bad address"
ENOTBLKDET:
	.asciz	"Block device required"
EBUSYDET:
	.asciz	"Device or resource busy"
EEXISTDET:
	.asciz	"File exists"
EXDEVDET:
	.asciz	"Invalid cross-device link"
ENODEVDET:
	.asciz	"No such device"
ENOTDIRDET:
	.asciz	"Not a directory"
EISDIRDET:
	.asciz	"Is a directory"
EINVALDET:
	.asciz	"Invalid argument"
ENFILEDET:
	.asciz	"Too many open files in system"
EMFILEDET:
	.asciz	"Too many open files"
ENOTTYDET:
	.asciz	"Inappropriate ioctl for device"
ETXTBSYDET:
	.asciz	"Text file busy"
EFBIGDET:
	.asciz	"File too large"
ENOSPCDET:
	.asciz	"No space left on device"
ESPIPEDET:
	.asciz	"Illegal seek"
EROFSDET:
	.asciz	"Read-only file system"
EMLINKDET:
	.asciz	"Too many links"
EPIPEDET:
	.asciz	"Broken pipe"
EDOMDET:
	.asciz	"Numerical argument out of domain"
ERANGEDET:
	.asciz	"Numerical result out of range"
EDEADLKDET:
	.asciz	"Resource deadlock avoided"
ENAMETOOLONGDET:
	.asciz	"File name too long"
ENOLCKDET:
	.asciz	"No locks available"
ENOSYSDET:
	.asciz	"Function not implemented"
ENOTEMPTYDET:
	.asciz	"Directory not empty"
ELOOPDET:
	.asciz	"Too many levels of symbolic links"
ENOMSGDET:
	.asciz	"No message of desired type"
EIDRMDET:
	.asciz	"Identifier removed"
ECHRNGDET:
	.asciz	"Channel number out of range"
EL2NSYNCDET:
	.asciz	"Level 2 not synchronized"
EL3HLTDET:
	.asciz	"Level 3 halted"
EL3RSTDET:
	.asciz	"Level 3 reset"
ELNRNGDET:
	.asciz	"Link number out of range"
EUNATCHDET:
	.asciz	"Protocol driver not attached"
ENOCSIDET:
	.asciz	"No CSI structure available"
EL2HLTDET:
	.asciz	"Level 2 halted"
EBADEDET:
	.asciz	"Invalid exchange"
EBADRDET:
	.asciz	"Invalid request descriptor"
EXFULLDET:
	.asciz	"Exchange full"
ENOANODET:
	.asciz	"No anode"
EBADRQCDET:
	.asciz	"Invalid request code"
EBADSLTDET:
	.asciz	"Invalid slot"
EBFONTDET:
	.asciz	"Bad font file format"
ENOSTRDET:
	.asciz	"Device not a stream"
ENODATADET:
	.asciz	"No data available"
ETIMEDET:
	.asciz	"Timer expired"
ENOSRDET:
	.asciz	"Out of streams resources"
ENONETDET:
	.asciz	"Machine is not on the network"
ENOPKGDET:
	.asciz	"Package not installed"
EREMOTEDET:
	.asciz	"Object is remote"
ENOLINKDET:
	.asciz	"Link has been severed"
EADVDET:
	.asciz	"Advertise error"
ESRMNTDET:
	.asciz	"Srmount error"
ECOMMDET:
	.asciz	"Communication error on send"
EPROTODET:
	.asciz	"Protocol error"
EMULTIHOPDET:
	.asciz	"Multihop attempted"
EDOTDOTDET:
	.asciz	"RFS specific error"
EBADMSGDET:
	.asciz	"Bad message"
EOVERFLOWDET:
	.asciz	"Value too large for defined data type"
ENOTUNIQDET:
	.asciz	"Name not unique on network"
EBADFDDET:
	.asciz	"File descriptor in bad state"
EREMCHGDET:
	.asciz	"Remote address changed"
ELIBACCDET:
	.asciz	"Can not access a needed shared library"
ELIBBADDET:
	.asciz	"Accessing a corrupted shared library"
ELIBSCNDET:
	.asciz	".lib section in a.out corrupted"
ELIBMAXDET:
	.asciz	"Attempting to link in too many shared libraries"
ELIBEXECDET:
	.asciz	"Cannot exec a shared library directly"
EILSEQDET:
	.asciz	"Invalid or incomplete multibyte or wide character"
ERESTARTDET:
	.asciz	"Interrupted system call should be restarted"
ESTRPIPEDET:
	.asciz	"Streams pipe error"
EUSERSDET:
	.asciz	"Too many users"
ENOTSOCKDET:
	.asciz	"Socket operation on non-socket"
EDESTADDRREQDET:
	.asciz	"Destination address required"
EMSGSIZEDET:
	.asciz	"Message too long"
EPROTOTYPEDET:
	.asciz	"Protocol wrong type for socket"
ENOPROTOOPTDET:
	.asciz	"Protocol not available"
EPROTONOSUPPORTDET:
	.asciz	"Protocol not supported"
ESOCKTNOSUPPORTDET:
	.asciz	"Socket type not supported"
EOPNOTSUPPDET:
	.asciz	"Operation not supported"
EPFNOSUPPORTDET:
	.asciz	"Protocol family not supported"
EAFNOSUPPORTDET:
	.asciz	"Address family not supported by protocol"
EADDRINUSEDET:
	.asciz	"Address already in use"
EADDRNOTAVAILDET:
	.asciz	"Cannot assign requested address"
ENETDOWNDET:
	.asciz	"Network is down"
ENETUNREACHDET:
	.asciz	"Network is unreachable"
ENETRESETDET:
	.asciz	"Network dropped connection on reset"
ECONNABORTEDDET:
	.asciz	"Software caused connection abort"
ECONNRESETDET:
	.asciz	"Connection reset by peer"
ENOBUFSDET:
	.asciz	"No buffer space available"
EISCONNDET:
	.asciz	"Transport endpoint is already connected"
ENOTCONNDET:
	.asciz	"Transport endpoint is not connected"
ESHUTDOWNDET:
	.asciz	"Cannot send after transport endpoint shutdown"
ETOOMANYREFSDET:
	.asciz	"Too many references: cannot splice"
ETIMEDOUTDET:
	.asciz	"Connection timed out"
ECONNREFUSEDDET:
	.asciz	"Connection refused"
EHOSTDOWNDET:
	.asciz	"Host is down"
EHOSTUNREACHDET:
	.asciz	"No route to host"
EALREADYDET:
	.asciz	"Operation already in progress"
EINPROGRESSDET:
	.asciz	"Operation now in progress"
ESTALEDET:
	.asciz	"Stale file handle"
EUCLEANDET:
	.asciz	"Structure needs cleaning"
ENOTNAMDET:
	.asciz	"Not a XENIX named type file"
ENAVAILDET:
	.asciz	"No XENIX semaphores available"
EISNAMDET:
	.asciz	"Is a named type file"
EREMOTEIODET:
	.asciz	"Remote I/O error"
EDQUOTDET:
	.asciz	"Disk quota exceeded"
ENOMEDIUMDET:
	.asciz	"No medium found"
EMEDIUMTYPEDET:
	.asciz	"Wrong medium type"
ECANCELEDDET:
	.asciz	"Operation canceled"
ENOKEYDET:
	.asciz	"Required key not available"
EKEYEXPIREDDET:
	.asciz	"Key has expired"
EKEYREVOKEDDET:
	.asciz	"Key has been revoked"
EKEYREJECTEDDET:
	.asciz	"Key was rejected by service"
EOWNERDEADDET:
	.asciz	"Owner died"
ENOTRECOVERABLEDET:
	.asciz	"State not recoverable"
ERFKILLDET:
	.asciz	"Operation not possible due to RF-kill"
EHWPOISONDET:
	.asciz	"Memory page has hardware error"
