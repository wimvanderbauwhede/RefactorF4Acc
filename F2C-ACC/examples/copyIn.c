
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

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
void copyin_ (int *nz__G,int *nip__G,float *vol,float *factor__G) {

  int nz=*nz__G;
  int nip=*nip__G;
  float factor=*factor__G;
//! "in" specifies data will be copied to the GPU
//! "global" specifies the pointer defined to access the data will have global scope
//!
//!ACC$DATA(<nz,nip,vol:in,global>)

}
