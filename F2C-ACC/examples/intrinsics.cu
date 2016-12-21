
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
//!ACC$REGION(<1>,<1>,<val,rval:out>) BEGIN
__global__ void intrinsics_Kernel1(int *D_val,float *D_rval) {
  int val = *D_val;
  float rval = *D_rval;

  int i;
  int j;
  int k;
  float fval;
  i = 3;
  j = 4;
  k = 5;
//! returns an integer
  val = MAX(fmaxf(i,j),k);
//! returns a float from integer arguments
  rval = MAX(fmaxf(i,j),k);
//!returns a float from float arguments
  fval = MAX(rval,1e8F);
  *D_val = val;
  *D_rval = rval;

  return;
}
//!ACC$REGION END
//!unit test for Fortran intrinsic functions (procedures)
//!Written by:      Mark Govett
//!Date:      	September 2011
//!
//! Designed for CPU and GPU runtime tests
//! CPU to test correctness
//! GPU to test function accuracy
//!
extern "C" void intrinsics_ (int *val__G,float *rval__G) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int val=*val__G;
  float rval=*rval__G;
  int i;
  float fval;
cudaError_t cudaError;
  int *D_val;
  cudaError = cudaMalloc((void **) &D_val,(1)*sizeof(int));
  cudaErrorChk("intrinsics.f90.ACC.1",18,"val",cudaError);
  float *D_rval;
  cudaError = cudaMalloc((void **) &D_rval,(1)*sizeof(float));
  cudaErrorChk("intrinsics.f90.ACC.1",18,"rval",cudaError);
  rval = 4.0F;
  if ( i == 1 ) {
    fval = powf(rval,2.0F);
  } else {
    fval = powf(rval,2.0F);
  }

  dim3 cuda_threads1(1);
  dim3 cuda_grids1(1);

  unsigned int timer = 0;


  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  intrinsics_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_val,D_rval);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("intrinsics kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(&val,D_val,(1)*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("intrinsics.f90.ACC.1",28,"val",cudaError);
  cudaError = cudaMemcpy(&rval,D_rval,(1)*sizeof(float),cudaMemcpyDeviceToHost);
  cudaErrorChk("intrinsics.f90.ACC.1",28,"rval",cudaError);
  *val__G = val;
  cudaError = cudaFree(D_val);
  cudaErrorChk("intrinsics.f90.ACC.1",29,"val",cudaError);
  *rval__G = rval;
  cudaError = cudaFree(D_rval);
  cudaErrorChk("intrinsics.f90.ACC.1",29,"rval",cudaError);

  return;
}
