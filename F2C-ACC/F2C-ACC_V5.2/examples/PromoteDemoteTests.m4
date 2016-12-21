#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

//! Unit test for GPU execution
//! Written by:      	Mark Govett
//! Date:      		February 2012
//!
//!Unit tests to demonstrate the ability to promote and demote variables
//!which may be required for correctness (promote) or performance (shared)
//!   global1Dpromote2Dblock:      routine to promote the block dimension
//!   global1Dpromote2Dthread:      routine to promote the thread dimension
//!
void FUNCTION(global1dpromote2dblock) ARGS(`FortranInt *nx__G,FortranInt *nz__G,FortranInt *bigarray') {

  int nx=*nx__G;
  int nz=*nz__G;
  int *operand = (int*) malloc((nz)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int k;
//!ACC$REGION(<nz>,<nx>,<nz,nx:in>,<bigarray:inout>,<operand:none,global,promote(1:block)>) BEGIN
  for (iter=1;iter<=500;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF1D(k,1)] = i;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] * 2;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] * 2;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] / 2;
        bigarray[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF1D(k,1)] / 2;
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
//! routine to promote the thread dimension
void FUNCTION(global1dpromote2dthread) ARGS(`FortranInt *nx__G,FortranInt *nz__G,FortranInt *bigarray') {

  int nx=*nx__G;
  int nz=*nz__G;
  int *operandt = (int*) malloc((nx)*sizeof(int));
  if (operandt == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int k;
//!ACC$REGION(<nz:block=2>,<nx>,<nz,nx:in>,<bigarray:inout>,<operandt:none,global,promote(1:block)>) BEGIN
  for (iter=1;iter<=500;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
      operandt[FTNREF1D(i,1)] = i;
      operandt[FTNREF1D(i,1)] = operandt[FTNREF1D(i,1)] * 2;
      operandt[FTNREF1D(i,1)] = operandt[FTNREF1D(i,1)] * 2;
      operandt[FTNREF1D(i,1)] = operandt[FTNREF1D(i,1)] / 2;
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        bigarray[FTNREF2D(k,i,nz,1,1)] = operandt[FTNREF1D(i,1)] / 2;
      }
    }
  }
//!ACC$REGION END
  free(operandt);

  return;
}
