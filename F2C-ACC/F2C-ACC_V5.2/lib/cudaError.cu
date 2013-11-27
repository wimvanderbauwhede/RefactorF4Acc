#include <stdio.h>

void cudaErrorChk(char *filename, int line, char *varname, cudaError_t cudaError) {
  if (cudaError != cudaSuccess) {
    printf("%s:%d variable: \"%s\" CUDA error: %s\n",filename,line,varname,cudaGetErrorString(cudaError));
    exit(-1);
  }
  return;
}


