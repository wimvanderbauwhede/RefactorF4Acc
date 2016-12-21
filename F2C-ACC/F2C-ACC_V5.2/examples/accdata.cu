
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
typedef struct {
  int nz,nip;
} accdata_s1;
typedef struct {
  float factor;
  int nz,nip;
} accdata_s2;
//!ACC$REGION(<nz>,<nip>,<flx:in>,<nz,nip:in>,<vol:none,extern>) BEGIN
__global__ void accdata_Kernel1(float *flx,accdata_s1 accdata_k1,float *vol) {
  int nz = accdata_k1.nz;
  int nip = accdata_k1.nip;

  int ipn;
  int k;
//!acc$do parallel
  ipn = blockIdx.x+1;
//  for (ipn=1;ipn<=nip;ipn++) {
//!acc$do vector
    k = threadIdx.x+1;
//    for (k=1;k<=nz;k++) {
      flx[FTNREF2D(k,ipn,nz,1,1)] = flx[FTNREF2D(k,ipn,nz,1,1)] / vol[FTNREF2D(k,ipn,nz,1,1)];
//    }
//  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz>,<nip>,<flx:out>,<nz,nip:in>,<vol:none,extern>,<factor:in>) BEGIN
__global__ void accdata_Kernel2(float *flx,accdata_s2 accdata_k2,float *vol) {
  int nz = accdata_k2.nz;
  int nip = accdata_k2.nip;
  float factor = accdata_k2.factor;

  int ipn;
  int k;
//!acc$do parallel
  ipn = blockIdx.x+1;
//  for (ipn=1;ipn<=nip;ipn++) {
//!acc$do vector
    k = threadIdx.x+1;
//    for (k=1;k<=nz;k++) {
      flx[FTNREF2D(k,ipn,nz,1,1)] = flx[FTNREF2D(k,ipn,nz,1,1)] / (factor * vol[FTNREF2D(k,ipn,nz,1,1)]);
//    }
//  }

  return;
}
//!ACC$REGION END
//! Unit tests for DATA_MOVEMENT
//!
//! Designed for GPU translation and execution
//! Mark Govett       Nov 2010
//! NOAA/ESRL
//! ACC$REGION
//!   Variables must be defined either as input arguments, or as constants. 
//!
extern "C" void accdata_ (float *vol,float *flx,float *factor__G) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  float factor=*factor__G;
int nz=5;

int nip=10;
cudaError_t cudaError;
  float *D_flx;
  cudaError = cudaMalloc((void **) &D_flx,((nz)*(nip))*sizeof(float));
  cudaErrorChk("accdata.f90.ACC.1",37,"flx",cudaError);
  extern float *D_vol;
//! GPU constants scope is restricted to all routines within a single file. A
//! namespace conflict will occur If multiple routines declare the same constant 
//! variable.  Since the fermi architecture which supports cache, there appears to
//! be little benefit to using constant memory.  Constant variable are always 
//! define with intent "in"; anything else is an error
//!! MWG: error noted in F2C-ACC_V4.8 
//!!ACC$DATA(<factor:in,constant>)
//! All variables used in the GPU region must be listed as arguments in the 
//! accelerated region (ACC$REGION directive). The F2C-ACC option --Analysis=1
//! will analyze each region and determine a recommended (and conservative) list
//! of intents for each variable in the region.
//!
//! In this region, nz and nip are scalars that are copied to the GPU.
//!
//! vol was copied to the GPU in copyIn and defined with global scope.  Therefore
//! it an be referenced as an externally defined GPU resident variable.
//!
//! flux was defined with "in" scope so it will be copied to gpu prior to
//! execution of hte kernel.  It will remain GPU resident until this routine
//! is complete.  

  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nip);

  unsigned int timer = 0;

  cudaError = cudaMemcpy(D_flx,flx,((nz)*(nip))*sizeof(float),cudaMemcpyHostToDevice);
  cudaErrorChk("accdata.f90.ACC.1",37,"flx",cudaError);
  accdata_s1 accdata_k1;
  accdata_k1.nz = nz;
  accdata_k1.nip = nip;

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  accdata_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_flx,accdata_k1,D_vol);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("accdata kernel execution time: %.2f ms\n",runtime);
//!flx is defined with intent out so it is copied to the CPU when the GPU region
//! has completed.  Based on the intent of the previous region (intent "in"), the
//! variable is resident on the GPU.

  dim3 cuda_threads2(nz);
  dim3 cuda_grids2(nip);


  accdata_s2 accdata_k2;
  accdata_k2.nz = nz;
  accdata_k2.nip = nip;
  accdata_k2.factor = factor;
  accdata_k2.factor = factor;

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  accdata_Kernel2<<< cuda_grids2, cuda_threads2 >>>(D_flx,accdata_k2,D_vol);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("accdata kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(flx,D_flx,((nz)*(nip))*sizeof(float),cudaMemcpyDeviceToHost);
  cudaErrorChk("accdata.f90.ACC.1",57,"flx",cudaError);
  cudaError = cudaFree(D_flx);
  cudaErrorChk("accdata.f90.ACC.1",58,"flx",cudaError);

}
