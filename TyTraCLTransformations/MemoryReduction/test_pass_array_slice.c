#include <stdio.h>

void f(int[4],int*);

int main() {
int v_s_i[4][4];
int v_o[4];
int i,j;

    int  n;
    for (i=0;i<4;++i) {
    for (j=0;j<4;++j) {
        v_s_i[i][j]=i+4*j;
        printf("%d ",v_s_i[i][j]);
    }
    printf("\n");
    }
    n=1;


    for (i=0;i<4;++i) {
      f(v_s_i[i],&v_o[i]);
    }



    for (i=0;i<4;++i) {
        printf("%d\n",v_o[i]);
    }
    return 0;
}

void f(int x_in[4],int* x_out) {
    int res=0;
    for (int i=0;i<4;++i) {
         res +=   x_in[i];// * x_in[i];
    }
    *x_out = res;
}    
