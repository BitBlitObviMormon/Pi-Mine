#include <stdio.h>
#include <termios.h>
#include <unistd.h>

int main()
{
    struct termios oldt;

    if(tcgetattr(0, &oldt))
    {
        fprintf(stderr, "Error getting term attribs\n"); 
    }
    
    cfmakeraw(&oldt);

    if(tcsetattr(0, TCSANOW, &oldt)) 
    {
        fprintf(stderr, "Error setting term attribs\n");
    }

    char inp;
    char ans = 'O';
    while(1)
    {
        int bytesRead = read(0, &inp, 1);

        if(bytesRead <= 0)
        {
            fprintf(stderr, "oops, bytes read return val is %d\n", bytesRead);
        }
        else
        {
            write(2, &ans, 1);
        }
    }
}
