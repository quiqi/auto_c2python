#include "fdlibm.h"
#include <stdio.h>

int main(){
    double a = 1;
    double b = log1p(a);
    printf("%lf", b);
    return 0;
}