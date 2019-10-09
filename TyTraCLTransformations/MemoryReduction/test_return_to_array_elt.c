#include <stdio.h>

void square(int,int*);

int main() {
    int v[16];
    int i, n;
    for (i=0;i<16;++i) {
        v[i]=0;
    }
    n=1;
    for ( i=0;i<4; ++i) {
        square(n,&v[n-1]);
        square(n,&v[i]);
        n=n*2;
    }
    for (i=0;i<16;++i) {
        printf("%d\n",v[i]);
    }
    return 0;
}

void square(int x_in,int* x_out) {
    *x_out = x_in * x_in;
}    
