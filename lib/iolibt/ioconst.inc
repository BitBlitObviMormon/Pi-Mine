/* Input/Output Constants */

/*  I/O CONSTANTS */
.set	STDIN,  0
.set	STDOUT, 1
.set	STDERR, 2

/* FILE STREAM PERMISSIONS */
.set	O_RDONLY, 0x000
.set	O_WRONLY, 0x001
.set	O_RDWR,   0x002
.set	O_CREAT,  0x040
.set	O_EXCL,	  0x080
.set	O_NOCTTY, 0x100
.set	O_TRUNC,  0x200

/* FILE ACCESS PERMISSIONS (ACCESS SYSCALL) */
.set	F_OK, 0x0 // Can check if the file exists
.set	X_OK, 0x1 // Can execute the file
.set	W_OK, 0x2 // Can write to the file
.set	R_OK, 0x4 // Can read the file

/* FILE ACCESS PERMISSIONS (OPEN, CREAT SYSCALLS) */
.set	S_IXOTH, 0x001
.set	S_IWOTH, 0x002
.set	S_IROTH, 0x004
.set	S_IXGRP, 0x008
.set	S_IWGRP, 0x010
.set	S_IRGRP, 0x020
.set	S_IXUSR, 0x040
.set	S_IWUSR, 0x080
.set	S_IRUSR, 0x100
