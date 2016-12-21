
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

//! Unit tests for DATA_MOVEMENT
//!
//! Designed for GPU translation and execution
//! Mark Govett       Nov 2010
//! NOAA/ESRL
//! ACC$REGION
//!   Variables must be defined either as input arguments, or as constants. 
//!
void accdata_ (float *vol,float *flx,float *factor__G) {

  float factor=*factor__G;
int nz=5;

int nip=10;
  int ipn;
  int k;
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
//!ACC$REGION(<nz>,<nip>,<flx:in>,<nz,nip:in>,<vol:none,extern>) BEGIN
//!acc$do parallel
  for (ipn=1;ipn<=nip;ipn++) {
//!acc$do vector
    for (k=1;k<=nz;k++) {
      flx[FTNREF2D(k,ipn,nz,1,1)] = flx[FTNREF2D(k,ipn,nz,1,1)] / vol[FTNREF2D(k,ipn,nz,1,1)];
    }
  }
//!ACC$REGION END
//!flx is defined with intent out so it is copied to the CPU when the GPU region
//! has completed.  Based on the intent of the previous region (intent "in"), the
//! variable is resident on the GPU.
//!ACC$REGION(<nz>,<nip>,<flx:out>,<nz,nip:in>,<vol:none,extern>,<factor:in>) BEGIN
//!acc$do parallel
  for (ipn=1;ipn<=nip;ipn++) {
//!acc$do vector
    for (k=1;k<=nz;k++) {
      flx[FTNREF2D(k,ipn,nz,1,1)] = flx[FTNREF2D(k,ipn,nz,1,1)] / (factor * vol[FTNREF2D(k,ipn,nz,1,1)]);
    }
  }
//!ACC$REGION END

}
