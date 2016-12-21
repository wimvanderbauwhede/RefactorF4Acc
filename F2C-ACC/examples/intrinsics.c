
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

//!unit test for Fortran intrinsic functions (procedures)
//!Written by:      Mark Govett
//!Date:      	September 2011
//!
//! Designed for CPU and GPU runtime tests
//! CPU to test correctness
//! GPU to test function accuracy
//!
void intrinsics_ (int *val__G,float *rval__G) {

  int val=*val__G;
  float rval=*rval__G;
  int i;
  float fval;
  int j;
  int k;
  rval = 4.0F;
  if ( i == 1 ) {
    fval = powf(rval,2.0F);
  } else {
    fval = powf(rval,2.0F);
  }
//!ACC$REGION(<1>,<1>,<val,rval:out>) BEGIN
  i = 3;
  j = 4;
  k = 5;
//! returns an integer
  val = MAX(fmaxf(i,j),k);
//! returns a float from integer arguments
  rval = MAX(fmaxf(i,j),k);
//!returns a float from float arguments
  fval = MAX(rval,1e8F);
//!ACC$REGION END
  *val__G = val;
  *rval__G = rval;

  return;
}
