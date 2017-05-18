#define _GNU_SOURCE
#include <features.h>
#include <sched.h>

#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <fcntl.h>

int main() {
	struct termios a;

	printf("sizeof termios  : 0x%x\n", sizeof a);
	printf("sizeof tcflag_t : 0x%x\n", sizeof(tcflag_t));
	printf("sizeof cc_t     : 0x%x\n", sizeof(cc_t));
	printf("sizeof speed_t  : 0x%x\n", sizeof(speed_t));
	printf("sizeof mode_t   : 0x%x\n", sizeof(mode_t));

	printf("\nConstants\n");
	printf("TCGETS : 0x%x\n", TCGETS);
	printf("TCSETS : 0x%x\n", TCSETS);
	printf("ICANON : 0x%x\n", ICANON);
	printf("ECHO   : 0x%x\n", ECHO);
	printf("VMIN   : 0x%x\n", VMIN);
	printf("VTIME  : 0x%x\n", VTIME);
	printf("NCCS   : 0x%x\n", NCCS);

	printf("STDIN  : 0x%x\n", STDIN_FILENO);
	printf("STDOUT : 0x%x\n", STDOUT_FILENO);

	printf("O_RDONLY : 0x%x\n", O_RDONLY);
	printf("O_WRONLY : 0x%x\n", O_WRONLY);
	printf("O_RDWR   : 0x%x\n", O_RDWR);
	printf("O_CREAT  : 0x%x\n", O_CREAT);
	printf("O_EXCL   : 0x%x\n", O_EXCL);
	printf("O_NOCTTY : 0x%x\n", O_NOCTTY);
	printf("O_TRUNC  : 0x%x\n", O_TRUNC);

	printf("R_OK : 0x%x\n", R_OK);
	printf("W_OK : 0x%x\n", W_OK);
	printf("X_OK : 0x%x\n", X_OK);
	printf("F_OK : 0x%x\n", F_OK);

	printf("S_IXOTH : 0x%x\n", S_IXOTH);
	printf("S_IWOTH : 0x%x\n", S_IWOTH);
	printf("S_IROTH : 0x%x\n", S_IROTH);
	printf("S_IXGRP : 0x%x\n", S_IXGRP);
	printf("S_IWGRP : 0x%x\n", S_IWGRP);
	printf("S_IRGRP : 0x%x\n", S_IRGRP);
	printf("S_IXUSR : 0x%x\n", S_IXUSR);
	printf("S_IWUSR : 0x%x\n", S_IWUSR);
	printf("S_IRUSR : 0x%x\n", S_IRUSR);

	printf("SHUT_RD   : 0x%x\n", SHUT_RD);
	printf("SHUT_WR   : 0x%x\n", SHUT_WR);
	printf("SHUT_RDWR : 0x%x\n", SHUT_RDWR);

	printf("MSG_OOB       : 0x%x\n", MSG_OOB);
	printf("MSG_PEEK      : 0x%x\n", MSG_PEEK);
	printf("MSG_DONTROUTE : 0x%x\n", MSG_DONTROUTE);
	printf("MSG_CTRUNC    : 0x%x\n", MSG_CTRUNC);
	printf("MSG_TRUNC     : 0x%x\n", MSG_TRUNC);
	printf("MSG_DONTWAIT  : 0x%x\n", MSG_DONTWAIT);
	printf("MSG_EOR       : 0x%x\n", MSG_EOR);
	printf("MSG_WAITALL   : 0x%x\n", MSG_WAITALL);
	printf("MSG_CONFIRM   : 0x%x\n", MSG_CONFIRM);
	printf("MSG_ERRQUEUE  : 0x%x\n", MSG_ERRQUEUE);
	printf("MSG_NOSIGNAL  : 0x%x\n", MSG_NOSIGNAL);

	printf("PF_UNIX      : 0x%x\n", PF_UNIX);
	printf("PF_LOCAL     : 0x%x\n", PF_LOCAL);
	printf("PF_INET      : 0x%x\n", PF_INET);
	printf("PF_INET6     : 0x%x\n", PF_INET6);
	printf("PF_IPX       : 0x%x\n", PF_IPX);
	printf("PF_NETLINK   : 0x%x\n", PF_NETLINK);
	printf("PF_X25       : 0x%x\n", PF_X25);
	printf("PF_AX25      : 0x%x\n", PF_AX25);
	printf("PF_ATMPVC    : 0x%x\n", PF_ATMPVC);
	printf("PF_APPLETALK : 0x%x\n", PF_APPLETALK);
	printf("PF_PACKET    : 0x%x\n", PF_PACKET);

        printf("SOCK_STREAM    : 0x%x\n", SOCK_STREAM);
        printf("SOCK_DGRAM     : 0x%x\n", SOCK_DGRAM);
        printf("SOCK_SEQPACKET : 0x%x\n", SOCK_SEQPACKET);
        printf("SOCK_RAW       : 0x%x\n", SOCK_RAW);
        printf("SOCK_RDM       : 0x%x\n", SOCK_RDM);
        printf("SOCK_PACKET    : 0x%x\n", SOCK_PACKET);

	printf("SIOCGIFADDR    : 0x%x\n", SIOCGIFADDR);
	printf("SIOCGIDNAME    : 0x%x\n", SIOCGIFNAME);

	printf("\nTermios Memory Layout\n");
	printf("c_iflag  : 0x%x\n", (unsigned int)&a.c_iflag - (unsigned int)&a);
	printf("c_oflag  : 0x%x\n", (unsigned int)&a.c_oflag - (unsigned int)&a);
	printf("c_cflag  : 0x%x\n", (unsigned int)&a.c_cflag - (unsigned int)&a);
	printf("c_lflag  : 0x%x\n", (unsigned int)&a.c_lflag - (unsigned int)&a);
	printf("c_cc     : 0x%x\n", (unsigned int)&a.c_cc - (unsigned int)&a);
	printf("c_ispeed : 0x%x\n", (unsigned int)&a.c_ispeed - (unsigned int)&a);
	printf("c_ospeed : 0x%x\n", (unsigned int)&a.c_ospeed - (unsigned int)&a);

	printf("\nClone Thread Flags\n");
	printf("CLONE_THREAD  : 0x%x\n", CLONE_THREAD);
	printf("CLONE_VM      : 0x%x\n", CLONE_VM);
	printf("CLONE_PARENT  : 0x%x\n", CLONE_PARENT);
	printf("CLONE_SIGHAND : 0x%x\n", CLONE_SIGHAND);
	printf("CLONE_FS      : 0x%x\n", CLONE_FS);
	printf("CLONE_FILES   : 0x%x\n", CLONE_FILES);
	printf("CLONE_IO      : 0x%x\n", CLONE_IO);

	printf("\nMemory Map Flags\n");
	printf("PROT_EXEC  : 0x%x\n", PROT_EXEC);
	printf("PROT_READ  : 0x%x\n", PROT_READ);
	printf("PROT_WRITE : 0x%x\n", PROT_WRITE);
	printf("PROT_NONE  : 0x%x\n", PROT_NONE);
	printf("PROT_EXEC  : 0x%x\n", PROT_EXEC);
	printf("MAP_FIXED      : 0x%x\n", MAP_FIXED);
	printf("MAP_SHARED     : 0x%x\n", MAP_SHARED);
	printf("MAP_PRIVATE    : 0x%x\n", MAP_PRIVATE);
	printf("MAP_EXECUTABLE : 0x%x\n", MAP_EXECUTABLE);
	printf("MAP_DENYWRITE  : 0x%x\n", MAP_DENYWRITE);
	printf("MAP_NORESERVE  : 0x%x\n", MAP_NORESERVE);
	printf("MAP_LOCKED     : 0x%x\n", MAP_LOCKED);
	printf("MAP_GROWSDOWN  : 0x%x\n", MAP_GROWSDOWN);
	printf("MAP_ANONYMOUS  : 0x%x\n", MAP_ANONYMOUS);

	printf("\nWait4 Flags\n");
	printf("WNOHANG   : 0x%x\n", WNOHANG);
	printf("WUNTRACED : 0x%x\n", WUNTRACED);
	printf("P_PID  : 0x%x\n", P_PID);
	printf("P_PGID : 0x%x\n", P_PGID);
	printf("P_ALL  : 0x%x\n", P_ALL);

        return 0;
}
