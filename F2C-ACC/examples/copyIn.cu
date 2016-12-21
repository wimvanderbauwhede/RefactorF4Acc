
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
int *D_nz, *H_nz;
int *D_nip, *H_nip;
float *D_vol, *H_vol;
//! Unit tests for ACC$REGION Data handling
//! Designed for GPU translation and execution
//! Mark Govett       Nov 2010
//! NOAA/ESRL
//!
//! ACC$DATA is used to copy data between GPU and CPU, and permit other
//! routines to access that data (without requiring a copy)
//!
//! this is a no-op routine for the CPU
//!
extern "C" void copyin_ (int *nz__G,int *nip__G,float *vol,float *factor__G) {

  int nz=*nz__G;
  int nip=*nip__G;
  float factor=*factor__G;
cudaError_t cudaError;
//! "in" specifies data will be copied to the GPU
//! "global" specifies the pointer defined to access the data will have global scope
//!
//!ACC$DATA(<nz,nip,vol:in,global>)
  cudaError = cudaMalloc((void **) &D_nz,(1)*sizeof(int));
  cudaErrorChk("copyIn.f90.ACC.1",19,"nz",cudaError);
  cudaError = cudaMemcpy(D_nz,&nz,(1)*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("copyIn.f90.ACC.1",19,"nz",cudaError);
  H_nz = nz__G;
  cudaError = cudaMalloc((void **) &D_nip,(1)*sizeof(int));
  cudaErrorChk("copyIn.f90.ACC.1",19,"nip",cudaError);
  cudaError = cudaMemcpy(D_nip,&nip,(1)*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("copyIn.f90.ACC.1",19,"nip",cudaError);
  H_nip = nip__G;
  cudaError = cudaMalloc((void **) &D_vol,((nz)*(nip))*sizeof(float));
  cudaErrorChk("copyIn.f90.ACC.1",19,"vol",cudaError);
  cudaError = cudaMemcpy(D_vol,vol,((nz)*(nip))*sizeof(float),cudaMemcpyHostToDevice);
  cudaErrorChk("copyIn.f90.ACC.1",19,"vol",cudaError);
  H_vol = vol;

}
