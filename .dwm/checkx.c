#include <X11/Xlib.h>
#include <stdlib.h>
#include <stdio.h>
int main()
    { printf("%d\n", XOpenDisplay(NULL) ? 0 : 1);  } 