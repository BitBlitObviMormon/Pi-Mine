/* Threading Library (Thumb) */
/* Depends on System Call Library */

.include "threadconst.s"	// Include thread flags and info

//  SYSTEM CALLS
.set	EXIT,	   0x01	  // Exit system call
.set	CLONE,	   0x78	  // Clone system call
.set	NANOSLEEP, 0xa2   // Nanosleep system call
.set	MUNMAP,    0x5b   // Memory Unmap system call
.set	MMAP2,	   0xc0   // Memory Map 2 system call
.set	WRITE,	   0x04	  // Write system call

// FLAGS
.set	CLONE_FLAGS,	(CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_PARENT | CLONE_THREAD | CLONE_IO)
.set	PROT_FLAGS,	(PROT_READ | PROT_WRITE)
.set	MAP_FLAGS,	(MAP_SHARED | MAP_ANONYMOUS)

// OTHER CONSTANTS
.set	STDOUT,	   0x1	  // The standard output stream
.set	STRLEN,	   12	  // How many characters to print
.set	STACKSIZE, 0x4000 // The size of the child thread's stack (16KB)

.data
.text

