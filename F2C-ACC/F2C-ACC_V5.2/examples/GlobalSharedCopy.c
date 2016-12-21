
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

//! Unit tests to exercise copies between GPU global and shared memory
//! as needed given by the intent of the variable as specified in the 
//! ACC$REGION
//! To copy from global to shared, an intent IN must be given in the shared
//! memory variable entry (eg. <operand:in,shared> ).
//!
void shared3dout_ (int *nx__G,int *nz__G,int *iter__G,int *operand3d) {

  int nx=*nx__G;
  int nz=*nz__G;
  int iter=*iter__G;
  int i;
  int k;
  int it;
//!ACC$DATA(<operand3d:none,shared>)
//!ACC$REGION(<nz>,<nx>,<operand3d:out>,<iter,nz,nx:in>,<operand3d:inout,shared>) BEGIN
//!ACC$DO PARALLEL(1)
  for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
    for (k=1;k<=nz;k++) {
      for (it=1;it<=iter;it++) {
        operand3d[FTNREF3D(k,i,it,nz,nx,1,1,1)] = (i - 1) * nx + k;
      }
    }
  }
//!ACC$REGION END

  return;
}
