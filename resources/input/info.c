#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
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

	printf("\ntermios Memory Layout\n");
	printf("c_iflag  : %i\n", (unsigned int)&a.c_iflag - (unsigned int)&a);
	printf("c_oflag  : %i\n", (unsigned int)&a.c_oflag - (unsigned int)&a);
	printf("c_cflag  : %i\n", (unsigned int)&a.c_cflag - (unsigned int)&a);
	printf("c_lflag  : %i\n", (unsigned int)&a.c_lflag - (unsigned int)&a);
	printf("c_cc     : %i\n", (unsigned int)&a.c_cc - (unsigned int)&a);
	printf("c_ispeed : %i\n", (unsigned int)&a.c_ispeed - (unsigned int)&a);
	printf("c_ospeed : %i\n", (unsigned int)&a.c_ospeed - (unsigned int)&a);

	return 0;
}
