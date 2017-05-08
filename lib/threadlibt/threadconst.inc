// CLONE FLAGS
.set	CLONE_VM,	0x100
.set	CLONE_FS,	0x200
.set	CLONE_FILES,	0x400
.set	CLONE_SIGHAND,	0x800
.set	CLONE_PARENT,	0x8000
.set	CLONE_THREAD,	0x10000
.set	CLONE_IO,	0x80000000

// WAIT4 FLAGS
.set	WNOHANG,	0x1	// Don't wait if process is dead or invalid
.set	WUNTRACED,	0x2	// Don't wait for processes that are stopped
