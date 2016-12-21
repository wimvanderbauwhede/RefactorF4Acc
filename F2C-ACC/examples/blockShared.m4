#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

//! Unit test to demonstrate threading over multiple array dimensions.
//!
//! Designed for GPU translation
//! Mark Govett
//!
void FUNCTION(blockshared) ARGS(`FortranReal *rd__G,FortranReal *t3d,FortranInt *ims__G,FortranInt *ime__G,FortranInt *kms__G,FortranInt *kme__G') {

  float rd=*rd__G;
  int ims=*ims__G;
  int ime=*ime__G;
  int kms=*kms__G;
  int kme=*kme__G;
  int k;
  int i;
//!ACC$DATA(<t3d:none,shared(100)>)
//!ACC$REGION(<ime-ims+1:block=2>,<kme-kms+1>,<kms,kme,ims,ime,rd:in>,<t3d:inout>,<t3d:inout,shared,demote(2)>) BEGIN
//! standard loop test with simple array indices
//!ACC$DO PARALLEL(1)
  for (k=kms;k<=kme;k++) {
//!ACC$DO VECTOR(1)
    for (i=ims;i<=ime;i++) {
      t3d[FTNREF2D(i,k,ime-ims+1,ims,kms)] = t3d[FTNREF2D(i,k,ime-ims+1,ims,kms)] * rd;
    }
//! test to handle multiple terms in the affected index "i"
//! note how the base thread is 2, so data access by each thread is consistent
//!ACC$DO VECTOR(1,1:ime-1)
    for (i=ims;i<=ime - 1;i++) {
      t3d[FTNREF2D(i,k,ime-ims+1,ims,kms)] = t3d[FTNREF2D(i,k,ime-ims+1,ims,kms)] * rd;
    }
//!ACC$THREAD(ime-1)
    t3d[FTNREF2D(ime,k,ime-ims+1,ims,kms)] = 0.F;
  }
//!ACC$REGION END

  return;
}
