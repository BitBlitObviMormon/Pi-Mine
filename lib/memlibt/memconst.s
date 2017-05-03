// MEMORY MAP FLAGS
.set	PROT_READ,	0x1	// Reading privileges
.set	PROT_WRITE,	0x2	// Writing privileges
.set	MAP_SHARED,	0x1	// Shared between processes
.set	MAP_PRIVATE,	0x2	// Not shared between processes
.set	MAP_ANONYMOUS,	0x20	// Not mapped to a file (memory only)
.set	MAP_GROWSDOWN,	0x100	// For stacks (like this one)
