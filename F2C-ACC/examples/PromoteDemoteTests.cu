
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
#define NZ 50
#define NX 5000
#define NZ 50
#define NX 5000
   __device__ int operandP[(NZ)*(NX)];
typedef struct {
  int nz,nx;
} global1dpromote2dblock_s1;

   __device__ int operandtP[(NX)*(NX)];
typedef struct {
  int nz,nx;
} global1dpromote2dthread_s1;
//!ACC$REGION(<nz>,<nx>,<nz,nx:in>,<bigarray:inout>,<operand:none,global,promote(1:block)>) BEGIN
__global__ void global1dpromote2dblock_Kernel1(global1dpromote2dblock_s1 global1dpromote2dblock_k1,int *bigarray,int *operand) {
  int nz = global1dpromote2dblock_k1.nz;
  int nx = global1dpromote2dblock_k1.nx;

  int iter;
  int i;
  int k;
  for (iter=1;iter<=500;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] = i;
        operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] = operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] * 2;
        operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] = operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] * 2;
        operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] = operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] / 2;
        bigarray[FTNREF2D(k,i,nz,1,1)] = operandP[FTNREF2D(k,blockIdx.x,nz,1,0)] / 2;
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz:block=2>,<nx>,<nz,nx:in>,<bigarray:inout>,<operandt:none,global,promote(1:block)>) BEGIN
__global__ void global1dpromote2dthread_Kernel1(global1dpromote2dthread_s1 global1dpromote2dthread_k1,int *bigarray,int *operandt) {
  int nz = global1dpromote2dthread_k1.nz;
  int nx = global1dpromote2dthread_k1.nx;

  int iter;
  int i;
  int k;
  for (iter=1;iter<=500;iter++) {
//!ACC$DO PARALLEL(1)
    i = (blockIdx.x*2)+(threadIdx.x/(blockDim.x/2))+1;
//    for (i=1;i<=nx;i++) {
      operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] = i;
      operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] = operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] * 2;
      operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] = operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] * 2;
      operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] = operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] / 2;
//!ACC$DO VECTOR(1)
      k = threadIdx.x%(blockDim.x/2)+1;
//      for (k=1;k<=nz;k++) {
        bigarray[FTNREF2D(k,i,nz,1,1)] = operandtP[FTNREF2D(i,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2)),nx,1,0)] / 2;
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//! Unit test for GPU execution
//! Written by:      	Mark Govett
//! Date:      		February 2012
//!
//!Unit tests to demonstrate the ability to promote and demote variables
//!which may be required for correctness (promote) or performance (shared)
//!   global1Dpromote2Dblock:      routine to promote the block dimension
//!   global1Dpromote2Dthread:      routine to promote the thread dimension
//!
extern "C" void global1dpromote2dblock_ (int *nx__G,int *nz__G,int *bigarray) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_bigarray;
  cudaError = cudaMalloc((void **) &D_bigarray,((nz)*(nx))*sizeof(int));
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",17,"bigarray",cudaError);
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nz))*sizeof(int));
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",17,"operand",cudaError);

  int *operand = (int*) malloc((nz)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }


  dim3 cuda_threads1(NZ);
  dim3 cuda_grids1(NX);

  unsigned int timer = 0;

  global1dpromote2dblock_s1 global1dpromote2dblock_k1;
  global1dpromote2dblock_k1.nz = nz;
  global1dpromote2dblock_k1.nx = nx;
  cudaError = cudaMemcpy(D_bigarray,bigarray,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",17,"bigarray",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global1dpromote2dblock_Kernel1<<< cuda_grids1, cuda_threads1 >>>(global1dpromote2dblock_k1,D_bigarray,D_operand);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global1dpromote2dblock kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(bigarray,D_bigarray,((nz)*(nx))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",31,"bigarray",cudaError);
  cudaError = cudaFree(D_bigarray);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",32,"bigarray",cudaError);
  free(operand);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",32,"operand",cudaError);

  return;
}
//! routine to promote the thread dimension
extern "C" void global1dpromote2dthread_ (int *nx__G,int *nz__G,int *bigarray) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_bigarray;
  cudaError = cudaMalloc((void **) &D_bigarray,((nz)*(nx))*sizeof(int));
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",42,"bigarray",cudaError);
  int *D_operandt;
  cudaError = cudaMalloc((void **) &D_operandt,((nx))*sizeof(int));
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",42,"operandt",cudaError);

  int *operandt = (int*) malloc((nx)*sizeof(int));
  if (operandt == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }


  dim3 cuda_threads1((NZ)*2);
  dim3 cuda_grids1((NX)/2);

  unsigned int timer = 0;

  global1dpromote2dthread_s1 global1dpromote2dthread_k1;
  global1dpromote2dthread_k1.nz = nz;
  global1dpromote2dthread_k1.nx = nx;
  cudaError = cudaMemcpy(D_bigarray,bigarray,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",42,"bigarray",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global1dpromote2dthread_Kernel1<<< cuda_grids1, cuda_threads1 >>>(global1dpromote2dthread_k1,D_bigarray,D_operandt);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global1dpromote2dthread kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(bigarray,D_bigarray,((nz)*(nx))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",56,"bigarray",cudaError);
  cudaError = cudaFree(D_bigarray);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",57,"bigarray",cudaError);
  free(operandt);
  cudaError = cudaFree(D_operandt);
  cudaErrorChk("PromoteDemoteTests.f90.ACC.1",57,"operandt",cudaError);

  return;
}
