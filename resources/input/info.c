#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/types.h>
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
