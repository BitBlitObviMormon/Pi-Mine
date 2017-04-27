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

	printf("sizeof termios = %i\n", sizeof a);
	printf("sizeof tcflag_t = %i\n", sizeof(tcflag_t));
	printf("sizeof cc_t = %i\n", sizeof(cc_t));
	printf("sizeof speed_t = %i\n", sizeof(speed_t));
	printf("sizeof mode_t = %i\n", sizeof(mode_t));

	printf("\nConstants\n");
	printf("TCGETS = %i\n", TCGETS);
	printf("TCSETS = %i\n", TCSETS);

	printf("ICANON = %i\n", ICANON);
	printf("ECHO = %i\n", ECHO);

	printf("VMIN = %i\n", VMIN);
	printf("VTIME = %i\n", VTIME);

	printf("NCCS = %i\n", NCCS);

	printf("STDIN = %i\n", STDIN_FILENO);
	printf("STDOUT = %i\n", STDOUT_FILENO);

	printf("O_RDONLY = %i\n", O_RDONLY);
	printf("O_WRONLY = %i\n", O_WRONLY);
	printf("O_RDWR = %i\n", O_RDWR);

	printf("SHUT_RD = %i\n", SHUT_RD);
	printf("SHUT_WR = %i\n", SHUT_WR);
	printf("SHUT_RDWR = %i\n", SHUT_RDWR);

	printf("MSG_OOB = 0x%x\n", MSG_OOB);
	printf("MSG_PEEK = 0x%x\n", MSG_PEEK);
	printf("MSG_DONTROUTE = 0x%x\n", MSG_DONTROUTE);
	printf("MSG_CTRUNC = 0x%x\n", MSG_CTRUNC);
	printf("MSG_TRUNC = 0x%x\n", MSG_TRUNC);
	printf("MSG_DONTWAIT = 0x%x\n", MSG_DONTWAIT);
	printf("MSG_EOR = 0x%x\n", MSG_EOR);
	printf("MSG_WAITALL = 0x%x\n", MSG_WAITALL);
	printf("MSG_CONFIRM = 0x%x\n", MSG_CONFIRM);
	printf("MSG_ERRQUEUE = 0x%x\n", MSG_ERRQUEUE);
	printf("MSG_NOSIGNAL = 0x%x\n", MSG_NOSIGNAL);

	printf("PF_UNIX = %i\n", PF_UNIX);
	printf("PF_LOCAL = %i\n", PF_LOCAL);
	printf("PF_INET = %i\n", PF_INET);
	printf("PF_INET6 = %i\n", PF_INET6);
	printf("PF_IPX = %i\n", PF_IPX);
	printf("PF_NETLINK = %i\n", PF_NETLINK);
	printf("PF_X25 = %i\n", PF_X25);
	printf("PF_AX25 = %i\n", PF_AX25);
	printf("PF_ATMPVC = %i\n", PF_ATMPVC);
	printf("PF_APPLETALK = %i\n", PF_APPLETALK);
	printf("PF_PACKET = %i\n", PF_PACKET);

        printf("SOCK_STREAM = %i\n", SOCK_STREAM);
        printf("SOCK_DGRAM = %i\n", SOCK_DGRAM);
        printf("SOCK_SEQPACKET = %i\n", SOCK_SEQPACKET);
        printf("SOCK_RAW = %i\n", SOCK_RAW);
        printf("SOCK_RDM = %i\n", SOCK_RDM);
        printf("SOCK_PACKET = %i\n", SOCK_PACKET);

	printf("SIOCGIFADDR = %i\n", SIOCGIFADDR);
	printf("SIOCGIDNAME = %i\n", SIOCGIFNAME);

	printf("\nTermios Memory Layout\n");
	printf("c_iflag  : %i\n", (unsigned int)&a.c_iflag - (unsigned int)&a);
	printf("c_oflag  : %i\n", (unsigned int)&a.c_oflag - (unsigned int)&a);
	printf("c_cflag  : %i\n", (unsigned int)&a.c_cflag - (unsigned int)&a);
	printf("c_lflag  : %i\n", (unsigned int)&a.c_lflag - (unsigned int)&a);
	printf("c_cc     : %i\n", (unsigned int)&a.c_cc - (unsigned int)&a);
	printf("c_ispeed : %i\n", (unsigned int)&a.c_ispeed - (unsigned int)&a);
	printf("c_ospeed : %i\n", (unsigned int)&a.c_ospeed - (unsigned int)&a);

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
