
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
typedef struct {
  int ims,ime,kms,kme;
} scalar_s1;
//!ACC$REGION(<kme-kms+1>,<ime-ims+1>,<ims,ime,kms,kme,vol:in>,<counter_gpu,counter:inout>) BEGIN
__global__ void scalar_Kernel1(scalar_s1 scalar_k1,float *vol,int *counter_gpu,int *D_counter) {
  int ims = scalar_k1.ims;
  int ime = scalar_k1.ime;
  int kms = scalar_k1.kms;
  int kme = scalar_k1.kme;
  int counter = *D_counter;

  int ipn;
  int k;
//!acc$do parallel
  ipn = blockIdx.x+ims;
//  for (ipn=ims;ipn<=ime;ipn++) {
//!acc$thread(1) begin
if (threadIdx.x == 1) {
    for (k=kms;k<=kme;k++) {
      if ( vol[FTNREF2D(k,ipn,kme-kms+1,kms,ims)] == 2.0F ) {
        counter_gpu[FTNREF1D(ipn,ims)] = counter_gpu[FTNREF1D(ipn,ims)] + 1;
      }
    }
}
//!acc$thread end
//  }
  *D_counter = counter;

  return;
}
//!ACC$REGION END
//! Scalar Values Test:
//! Designed for 1 translation and execution
//! Mark Govett       July 2011
//! NOAA/ESRL
//!
//! Unit tests for handling of scalar values thru subroutine interfaces and
//! between kernels.  The C language is pass-by value for scalars, and pass-by
//! reference for arrays.  This test insures scalars can be passed by reference
//! and updated if necessary.
//!
//! The intent attribute is used in subroutine declarations, and used to 
//! indicate if an update of the scalar is needed.  By default, scalars are
//! pass-by-value (intent IN) to avoid problems when contants are passed into
//! the subroutine.  Users must explicitly state when intent is IN or INOUT.
//!
//! To communicate scalar results between CPU and 1, intent must be
//! specified in the ACC$REGION data section.
//!
extern "C" void scalar_ (float *vol,int *counter__G,int *ims__G,int *ime__G,int *kms__G,int *kme__G) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int counter=*counter__G;
  int ims=*ims__G;
  int ime=*ime__G;
  int kms=*kms__G;
  int kme=*kme__G;
  int ipn;
  int *counter_gpu = (int*) malloc((ime-ims+1)*sizeof(int));
  if (counter_gpu == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

cudaError_t cudaError;
  float *D_vol;
  cudaError = cudaMalloc((void **) &D_vol,((kme-kms+1)*(ime-ims+1))*sizeof(float));
  cudaErrorChk("scalar.f90.ACC.1",30,"vol",cudaError);
  int *D_counter_gpu;
  cudaError = cudaMalloc((void **) &D_counter_gpu,((ime-ims+1))*sizeof(int));
  cudaErrorChk("scalar.f90.ACC.1",30,"counter_gpu",cudaError);
  int *D_counter;
  cudaError = cudaMalloc((void **) &D_counter,(1)*sizeof(int));
  cudaErrorChk("scalar.f90.ACC.1",30,"counter",cudaError);
  counter = 0;
  for (ipn=ims;ipn<=ime;ipn++) {
    counter_gpu[FTNREF1D(ipn,ims)] = counter;
  }

  dim3 cuda_threads1(kme-kms+1);
  dim3 cuda_grids1(ime-ims+1);

  unsigned int timer = 0;

  scalar_s1 scalar_k1;
  scalar_k1.ims = ims;
  scalar_k1.ime = ime;
  scalar_k1.kms = kms;
  scalar_k1.kme = kme;
  cudaError = cudaMemcpy(D_vol,vol,((kme-kms+1)*(ime-ims+1))*sizeof(float),cudaMemcpyHostToDevice);
  cudaErrorChk("scalar.f90.ACC.1",30,"vol",cudaError);
  cudaError = cudaMemcpy(D_counter_gpu,counter_gpu,((ime-ims+1))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("scalar.f90.ACC.1",30,"counter_gpu",cudaError);
  cudaError = cudaMemcpy(D_counter,&counter,(1)*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("scalar.f90.ACC.1",30,"counter",cudaError);
  cudaError = cudaMemcpy(D_counter,&counter,(1)*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("scalar.f90.ACC.1",30,"counter",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  scalar_Kernel1<<< cuda_grids1, cuda_threads1 >>>(scalar_k1,D_vol,D_counter_gpu,D_counter);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("scalar kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(counter_gpu,D_counter_gpu,((ime-ims+1))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("scalar.f90.ACC.1",41,"counter_gpu",cudaError);
  cudaError = cudaMemcpy(&counter,D_counter,(1)*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("scalar.f90.ACC.1",41,"counter",cudaError);
  for (ipn=ims;ipn<=ime;ipn++) {
    counter = counter + counter_gpu[FTNREF1D(ipn,ims)];
  }
  cudaError = cudaFree(D_vol);
  cudaErrorChk("scalar.f90.ACC.1",45,"vol",cudaError);
  free(counter_gpu);
  cudaError = cudaFree(D_counter_gpu);
  cudaErrorChk("scalar.f90.ACC.1",45,"counter_gpu",cudaError);
  *counter__G = counter;
  cudaError = cudaFree(D_counter);
  cudaErrorChk("scalar.f90.ACC.1",45,"counter",cudaError);

  return;
}
