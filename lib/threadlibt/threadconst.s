// CLONE FLAGS
.set	CLONE_VM,	0x100
.set	CLONE_FS,	0x200
.set	CLONE_FILES,	0x400
.set	CLONE_SIGHAND,	0x800
.set	CLONE_PARENT,	0x8000
.set	CLONE_THREAD,	0x10000
.set	CLONE_IO,	0x80000000

// MEMORY MAP FLAGS
.set	PROT_READ,	0x1	// Reading privileges
.set	PROT_WRITE,	0x2	// Writing privileges
.set	MAP_SHARED,	0x1	// Shared between processes
.set	MAP_PRIVATE,	0x2	// Not shared between processes
.set	MAP_ANONYMOUS,	0x20	// Not mapped to a file (memory only)
.set	MAP_GROWSDOWN,	0x100	// For stacks (like this one)

// WAIT4 FLAGS
.set	WNOHANG,	0x1	// Don't wait if process is dead or invalid
.set	WUNTRACED,	0x2	// Don't wait for processes that are stopped
