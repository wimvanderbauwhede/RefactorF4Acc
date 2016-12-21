
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

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
void scalar_ (float *vol,int *counter__G,int *ims__G,int *ime__G,int *kms__G,int *kme__G) {

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

  int k;
  counter = 0;
  for (ipn=ims;ipn<=ime;ipn++) {
    counter_gpu[FTNREF1D(ipn,ims)] = counter;
  }
//!ACC$REGION(<kme-kms+1>,<ime-ims+1>,<ims,ime,kms,kme,vol:in>,<counter_gpu,counter:inout>) BEGIN
//!acc$do parallel
  for (ipn=ims;ipn<=ime;ipn++) {
//!acc$thread(1) begin
    for (k=kms;k<=kme;k++) {
      if ( vol[FTNREF2D(k,ipn,kme-kms+1,kms,ims)] == 2.0F ) {
        counter_gpu[FTNREF1D(ipn,ims)] = counter_gpu[FTNREF1D(ipn,ims)] + 1;
      }
    }
//!acc$thread end
  }
//!ACC$REGION END
  for (ipn=ims;ipn<=ime;ipn++) {
    counter = counter + counter_gpu[FTNREF1D(ipn,ims)];
  }
  free(counter_gpu);
  *counter__G = counter;

  return;
}
