#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

void FUNCTION(sharedchunk) ARGS(`FortranInt *nx__G,FortranInt *nz__G,FortranInt *phys2d') {

  int nx=*nx__G;
  int nz=*nz__G;
  int *operand = (int*) malloc((nx)*(nz)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int k;
  int i;
//!ACC$DATA(<operand:none,shared(50,50)>)
//!MWG: F2C-ACC V4.7, 4.8 bug which requires <operand:none> appear before the
//!MWG: tuple does.
//!ACC$REGION(<50:chunk>,<nx/50>,<nz,nx:in>,<operand:none>,<phys2d:inout>,<operand:none,shared>) BEGIN
  for (iter=1;iter<=200;iter++) {
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      for (i=1;i<=nx;i++) {
        operand[FTNREF2D(i,k,nx,1,1)] = (i - 1) * nz + k;
      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      for (i=1;i<=nx;i++) {
        operand[FTNREF2D(i,k,nx,1,1)] = operand[FTNREF2D(i,k,nx,1,1)] * 2;
      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      for (i=1;i<=nx;i++) {
        operand[FTNREF2D(i,k,nx,1,1)] = operand[FTNREF2D(i,k,nx,1,1)] * 2;
      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      for (i=1;i<=nx;i++) {
        operand[FTNREF2D(i,k,nx,1,1)] = operand[FTNREF2D(i,k,nx,1,1)] / 2;
      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      for (i=1;i<=nx;i++) {
        operand[FTNREF2D(i,k,nx,1,1)] = operand[FTNREF2D(i,k,nx,1,1)] / 2;
      }
    }
    for (k=1;k<=nz;k++) {
//!ACC$DO PARALLEL(1)
      for (i=1;i<=nx;i++) {
        phys2d[FTNREF2D(i,k,nx,1,1)] = operand[FTNREF2D(i,k,nx,1,1)];
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
//! Routine to test the F2C-ACC ability to assign multiple columns to a thread block.
void FUNCTION(numblocks) ARGS(`FortranInt *nx__G,FortranInt *nz__G,FortranInt *phys2d') {

  int nx=*nx__G;
  int nz=*nz__G;
  int k;
  int i;
//!ACC$REGION(<nx:block=2>,<nz/2>,<nz,nx:in>,<phys2d:out>) BEGIN
//!ACC$DO PARALLEL (1)
  for (k=1;k<=nz;k++) {
//!ACC$DO VECTOR (1)
    for (i=1;i<=nx;i++) {
      phys2d[FTNREF2D(i,k,nx,1,1)] = k * nx + nz;
    }
  }
//!ACC$REGION END

  return;
}
