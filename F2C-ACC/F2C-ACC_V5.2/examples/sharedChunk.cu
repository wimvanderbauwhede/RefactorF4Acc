
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
   __shared__ int operandS[50*50];
typedef struct {
  int nz,nx;
} sharedchunk_s1;

typedef struct {
  int nz,nx;
} numblocks_s1;
//!ACC$REGION(<50:chunk>,<nx/50>,<nz,nx:in>,<operand:none>,<phys2d:inout>,<operand:none,shared>) BEGIN
__global__ void sharedchunk_Kernel1(sharedchunk_s1 sharedchunk_k1,int *operand,int *phys2d) {
  int nz = sharedchunk_k1.nz;
  int nx = sharedchunk_k1.nx;

  int iter;
  int k;
  int i;
  for (iter=1;iter<=200;iter++) {
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      i = (blockIdx.x*blockDim.x)+threadIdx.x+1;
//      for (i=1;i<=nx;i++) {
        operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] = (i - 1) * nz + k;
//      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      i = (blockIdx.x*blockDim.x)+threadIdx.x+1;
//      for (i=1;i<=nx;i++) {
        operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] = operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] * 2;
//      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      i = (blockIdx.x*blockDim.x)+threadIdx.x+1;
//      for (i=1;i<=nx;i++) {
        operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] = operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] * 2;
//      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      i = (blockIdx.x*blockDim.x)+threadIdx.x+1;
//      for (i=1;i<=nx;i++) {
        operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] = operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] / 2;
//      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      i = (blockIdx.x*blockDim.x)+threadIdx.x+1;
//      for (i=1;i<=nx;i++) {
        operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] = operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)] / 2;
//      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      i = (blockIdx.x*blockDim.x)+threadIdx.x+1;
//      for (i=1;i<=nx;i++) {
        phys2d[FTNREF2D(i,k,nx,1,1)] = operandS[FTNREF2D(i,k,50,blockIdx.x*blockDim.x+1,1)];
//      }
    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nx:block=2>,<nz/2>,<nz,nx:in>,<phys2d:out>) BEGIN
__global__ void numblocks_Kernel1(numblocks_s1 numblocks_k1,int *phys2d) {
  int nz = numblocks_k1.nz;
  int nx = numblocks_k1.nx;

  int k;
  int i;
//!ACC$DO PARALLEL (1)
  k = (blockIdx.x*2)+(threadIdx.x/(blockDim.x/2))+1;
//  for (k=1;k<=nz;k++) {
//!ACC$DO VECTOR (1)
    i = threadIdx.x%(blockDim.x/2)+1;
//    for (i=1;i<=nx;i++) {
      phys2d[FTNREF2D(i,k,nx,1,1)] = k * nx + nz;
//    }
//  }

  return;
}
//!ACC$REGION END
extern "C" void sharedchunk_ (int *nx__G,int *nz__G,int *phys2d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nx)*(nz))*sizeof(int));
  cudaErrorChk("sharedChunk.f90.ACC.1",11,"operand",cudaError);
  int *D_phys2d;
  cudaError = cudaMalloc((void **) &D_phys2d,((nx)*(nz))*sizeof(int));
  cudaErrorChk("sharedChunk.f90.ACC.1",11,"phys2d",cudaError);
//!ACC$DATA(<operand:none,shared(50,50)>)
//!MWG: F2C-ACC V4.7, 4.8 bug which requires <operand:none> appear before the
//!MWG: tuple does.

  dim3 cuda_threads1(50);
  dim3 cuda_grids1(nx/50);

  unsigned int timer = 0;

  sharedchunk_s1 sharedchunk_k1;
  sharedchunk_k1.nz = nz;
  sharedchunk_k1.nx = nx;
  cudaError = cudaMemcpy(D_phys2d,phys2d,((nx)*(nz))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("sharedChunk.f90.ACC.1",11,"phys2d",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  sharedchunk_Kernel1<<< cuda_grids1, cuda_threads1 >>>(sharedchunk_k1,D_operand,D_phys2d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("sharedchunk kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(phys2d,D_phys2d,((nx)*(nz))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("sharedChunk.f90.ACC.1",50,"phys2d",cudaError);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("sharedChunk.f90.ACC.1",51,"operand",cudaError);
  cudaError = cudaFree(D_phys2d);
  cudaErrorChk("sharedChunk.f90.ACC.1",51,"phys2d",cudaError);

  return;
}
//! Routine to test the F2C-ACC ability to assign multiple columns to a thread block.
extern "C" void numblocks_ (int *nx__G,int *nz__G,int *phys2d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_phys2d;
  cudaError = cudaMalloc((void **) &D_phys2d,((nx)*(nz))*sizeof(int));
  cudaErrorChk("sharedChunk.f90.ACC.1",59,"phys2d",cudaError);


  dim3 cuda_threads1((nx)*2);
  dim3 cuda_grids1((nz/2)/2);

  unsigned int timer = 0;

  numblocks_s1 numblocks_k1;
  numblocks_k1.nz = nz;
  numblocks_k1.nx = nx;

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  numblocks_Kernel1<<< cuda_grids1, cuda_threads1 >>>(numblocks_k1,D_phys2d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("numblocks kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(phys2d,D_phys2d,((nx)*(nz))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("sharedChunk.f90.ACC.1",67,"phys2d",cudaError);
  cudaError = cudaFree(D_phys2d);
  cudaErrorChk("sharedChunk.f90.ACC.1",68,"phys2d",cudaError);

  return;
}
