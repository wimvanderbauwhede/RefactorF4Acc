
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
#define NZ 50
#define NX 50
#define ITER 2
   __shared__ int operand3dS[(NZ)*(NX)*(ITER)];
typedef struct {
  int iter,nz,nx;
} shared3dout_s1;
//!ACC$REGION(<nz>,<nx>,<operand3d:out>,<iter,nz,nx:in>,<operand3d:inout,shared>) BEGIN
__global__ void shared3dout_Kernel1(int *operand3d,shared3dout_s1 shared3dout_k1) {
// Generated copy from GPU global to shared memory
  int iter = shared3dout_k1.iter;
  int nz = shared3dout_k1.nz;
  int nx = shared3dout_k1.nx;

  int i;
  int k;
  int it;
//!ACC$DO PARALLEL(1)
  i = blockIdx.x+1;
//  for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
    k = threadIdx.x+1;
//    for (k=1;k<=nz;k++) {
      for (it=1;it<=iter;it++) {
        operand3dS[FTNREF3D(k,i,it,nz,nx,1,1,1)] = (i - 1) * nx + k;
      }
//    }
//  }
// Generated copy from GPU shared to global memory
  int iS1,iS2,iS3,iS4,iS5,iS6,iS7;
  for (iS3=1;iS3<=iter;iS3++) {
    operand3d[FTNREF3D(threadIdx.x+1,blockIdx.x+1,iS3,nz,nx,1,1,1)] = operand3dS[FTNREF3D(threadIdx.x,blockIdx.x+1,iS3,nz,nx,0,1,1)];
  }

  return;
}
//!ACC$REGION END
//! Unit tests to exercise copies between GPU global and shared memory
//! as needed given by the intent of the variable as specified in the 
//! ACC$REGION
//! To copy from global to shared, an intent IN must be given in the shared
//! memory variable entry (eg. <operand:in,shared> ).
//!
extern "C" void shared3dout_ (int *nx__G,int *nz__G,int *iter__G,int *operand3d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
  int iter=*iter__G;
cudaError_t cudaError;
  int *D_operand3d;
  cudaError = cudaMalloc((void **) &D_operand3d,((nz)*(nx)*(iter))*sizeof(int));
  cudaErrorChk("GlobalSharedCopy.f90.ACC.1",13,"operand3d",cudaError);
//!ACC$DATA(<operand3d:none,shared>)


  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx);

  unsigned int timer = 0;

  shared3dout_s1 shared3dout_k1;
  shared3dout_k1.iter = iter;
  shared3dout_k1.nz = nz;
  shared3dout_k1.nx = nx;

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  shared3dout_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand3d,shared3dout_k1);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("shared3dout kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(operand3d,D_operand3d,((nz)*(nx)*(iter))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedCopy.f90.ACC.1",23,"operand3d",cudaError);
  cudaError = cudaFree(D_operand3d);
  cudaErrorChk("GlobalSharedCopy.f90.ACC.1",24,"operand3d",cudaError);

  return;
}
