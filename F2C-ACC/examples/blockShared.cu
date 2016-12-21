
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
#define IMS 1
#define IME 50
#define KMS 1
#define KME 20
   __shared__ float t3dS[100];
typedef struct {
  float rd;
  int kms,kme,ims,ime;
} blockshared_s1;
//!ACC$REGION(<ime-ims+1:block=2>,<kme-kms+1>,<kms,kme,ims,ime,rd:in>,<t3d:inout>,<t3d:inout,shared,demote(2)>) BEGIN
__global__ void blockshared_Kernel1(blockshared_s1 blockshared_k1,float *t3d) {
  int kms = blockshared_k1.kms;
  int kme = blockshared_k1.kme;
  int ims = blockshared_k1.ims;
  int ime = blockshared_k1.ime;
  float rd = blockshared_k1.rd;
// Generated copy from GPU global to shared memory
  int iS1,iS2,iS3,iS4,iS5,iS6,iS7;
  t3dS[FTNREF1D(threadIdx.x,0)] = t3d[FTNREF2D(threadIdx.x%(ime-ims+1)+ims,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2))+kms,ime-ims+1,ims,kms)];

  int k;
  int i;
//! standard loop test with simple array indices
//!ACC$DO PARALLEL(1)
  k = (blockIdx.x*2)+(threadIdx.x/(blockDim.x/2))+kms;
//  for (k=kms;k<=kme;k++) {
//!ACC$DO VECTOR(1)
    i = threadIdx.x%(blockDim.x/2)+ims;
//    for (i=ims;i<=ime;i++) {
      t3dS[FTNREF1D(threadIdx.x,0)] = t3dS[FTNREF1D(threadIdx.x,0)] * rd;
//    }
//! test to handle multiple terms in the affected index "i"
//! note how the base thread is 2, so data access by each thread is consistent
//!ACC$DO VECTOR(1,1:ime-1)
    i = threadIdx.x%(blockDim.x/2)+1;
    if ((i >= 1) && (i <= ime-1)) {
//    for (i=ims;i<=ime - 1;i++) {
      t3dS[FTNREF1D(threadIdx.x,0)] = t3dS[FTNREF1D(threadIdx.x,0)] * rd;
//    }
    }
//!ACC$THREAD(ime-1)
if (threadIdx.x%(ime-ims+1) == ime-1) {
    t3dS[FTNREF1D((threadIdx.x/(ime-ims+1))*(ime-ims+1)+ime-1,0)] = 0.F;
}
//  }
// Generated copy from GPU shared to global memory
  t3d[FTNREF2D(threadIdx.x%(ime-ims+1)+ims,(blockIdx.x*2)+(threadIdx.x/(blockDim.x/2))+kms,ime-ims+1,ims,kms)] = t3dS[FTNREF1D(threadIdx.x,0)];

  return;
}
//!ACC$REGION END
//! Unit test to demonstrate threading over multiple array dimensions.
//!
//! Designed for GPU translation
//! Mark Govett
//!
extern "C" void blockshared_ (float *rd__G,float *t3d,int *ims__G,int *ime__G,int *kms__G,int *kme__G) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  float rd=*rd__G;
  int ims=*ims__G;
  int ime=*ime__G;
  int kms=*kms__G;
  int kme=*kme__G;
cudaError_t cudaError;
  float *D_t3d;
  cudaError = cudaMalloc((void **) &D_t3d,((ime-ims+1)*(kme-kms+1))*sizeof(float));
  cudaErrorChk("blockShared.f90.ACC.1",13,"t3d",cudaError);
//!ACC$DATA(<t3d:none,shared(100)>)


  dim3 cuda_threads1((ime-ims+1)*2);
  dim3 cuda_grids1((kme-kms+1)/2);

  unsigned int timer = 0;

  blockshared_s1 blockshared_k1;
  blockshared_k1.kms = kms;
  blockshared_k1.kme = kme;
  blockshared_k1.ims = ims;
  blockshared_k1.ime = ime;
  blockshared_k1.rd = rd;
  cudaError = cudaMemcpy(D_t3d,t3d,((ime-ims+1)*(kme-kms+1))*sizeof(float),cudaMemcpyHostToDevice);
  cudaErrorChk("blockShared.f90.ACC.1",13,"t3d",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  blockshared_Kernel1<<< cuda_grids1, cuda_threads1 >>>(blockshared_k1,D_t3d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("blockshared kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(t3d,D_t3d,((ime-ims+1)*(kme-kms+1))*sizeof(float),cudaMemcpyDeviceToHost);
  cudaErrorChk("blockShared.f90.ACC.1",30,"t3d",cudaError);
  cudaError = cudaFree(D_t3d);
  cudaErrorChk("blockShared.f90.ACC.1",31,"t3d",cudaError);

  return;
}
