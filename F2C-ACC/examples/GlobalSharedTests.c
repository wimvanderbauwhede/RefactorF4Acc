
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#define TRUE 1
#define FALSE 0

//! Performance and unit tests for the F2C-ACC compiler
//! Written by:      Mark Govett
//! Date:      	February 2012
//!
//! These tests compare performance using GPU global memory and shared memory
//! for a variety of cases as follows:
//!   global2D:      	baseline test using full 2D arrays for storage
//!   global2Dshared1D:      same as global2D but uses shared memory for "operand"
//!   global2Dloops:      same as baseline but each update appears in its own loop
//!   global2Dshared1Dloops:      shared memory test
//!global2D demonstrates repeated use of a single variable used to update another
//! variable within a single loop
void global2d_ (int *nx__G,int *nz__G,int *dyn2d) {

  int nx=*nx__G;
  int nz=*nz__G;
  int *operand = (int*) malloc((nz)*(nx)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int k;
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>) BEGIN
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = (i - 1) * nx + k;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)];
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
void global2dshared1d_ (int *nx__G,int *nz__G,int *dyn2d) {

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
//!ACC$DATA(<operand:none,shared(50)>)
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>,<operand:none,shared>) BEGIN
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF1D(k,1)] = (i - 1) * nx + k;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] * 2;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] * 2;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] / 2;
        operand[FTNREF1D(k,1)] = operand[FTNREF1D(k,1)] / 2;
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF1D(k,1)];
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
void global2dloops_ (int *nx__G,int *nz__G,int *dyn2d) {

  int nx=*nx__G;
  int nz=*nz__G;
  int *operand = (int*) malloc((nz)*(nx)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int k;
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>) BEGIN
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = (i - 1) * nx + k;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)];
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
void global2dshared1dloops_ (int *nx__G,int *nz__G,int *dyn2d) {

  int nx=*nx__G;
  int nz=*nz__G;
  int *operand = (int*) malloc((nz)*(nx)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int k;
//! MWG: this declaration is not needed because shared memory variables are
//! MWG: filebased declarations.  Since an ACC$DATA already declared this 
//! MWG: variable in an earlier routine, it is omitted here.
//!!ACC$DATA(<operand:none,shared(50)>)
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>,<operand:none,shared,demote(2)>) BEGIN
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = (i - 1) * nx + k;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      for (k=1;k<=nz;k++) {
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)];
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
void global3d_ (int *nz__G,int *nx__G,int *ny__G,int *dyn3d) {

  int nz=*nz__G;
  int nx=*nx__G;
  int ny=*ny__G;
  int *operand = (int*) malloc((nz)*(nx)*(ny)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int j;
  int k;
//!ACC$REGION(<nz>,<nx,ny>,<operand:none>,<nz,nx,ny:in>,<dyn3d:out>) BEGIN
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = ((i - 1) * nx + j) * k;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] * 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] * 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] / 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] / 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          dyn3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)];
        }
      }
    }
  }
//!ACC$REGION END
  free(operand);

  return;
}
void global3dshared1d_ (int *nz__G,int *nx__G,int *ny__G,int *dyn3d) {

  int nz=*nz__G;
  int nx=*nx__G;
  int ny=*ny__G;
  int *operand3d = (int*) malloc((nz)*(nx)*(ny)*sizeof(int));
  if (operand3d == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }

  int iter;
  int i;
  int j;
  int k;
//!ACC$DATA(<operand3D:none,shared(50)>)
//!ACC$REGION(<nz>,<nx,ny>,<operand3d:none>,<nz,nx,ny:in>,<dyn3d:out>,<operand3d:none,shared,demote(2,3)>) BEGIN
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = ((i - 1) * nx + j) * k;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] * 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] * 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] / 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] / 2;
        }
      }
    }
//!ACC$DO PARALLEL(1)
    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        for (k=1;k<=nz;k++) {
          dyn3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand3d[FTNREF3D(k,i,j,nz,nx,1,1,1)];
        }
      }
    }
  }
//!ACC$REGION END
  free(operand3d);

  return;
}
