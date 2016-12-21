
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ftocmacros.h"
#include "F2Cinclude.h"
#define TRUE 1
#define FALSE 0
typedef struct {
  int nz,nx;
} global2d_s1;

   __shared__ int operandS[50];
typedef struct {
  int nz,nx;
} global2dshared1d_s1;

typedef struct {
  int nz,nx;
} global2dloops_s1;

typedef struct {
  int nz,nx;
} global2dshared1dloops_s1;

typedef struct {
  int nz,nx,ny;
} global3d_s1;

   __shared__ int operand3dS[50];
typedef struct {
  int nz,nx,ny;
} global3dshared1d_s1;
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>) BEGIN
__global__ void global2d_Kernel1(int *operand,global2d_s1 global2d_k1,int *dyn2d) {
  int nz = global2d_k1.nz;
  int nx = global2d_k1.nx;

  int iter;
  int i;
  int k;
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = (i - 1) * nx + k;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)];
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>,<operand:none,shared>) BEGIN
__global__ void global2dshared1d_Kernel1(int *operand,global2dshared1d_s1 global2dshared1d_k1,int *dyn2d) {
  int nz = global2dshared1d_k1.nz;
  int nx = global2dshared1d_k1.nx;

  int iter;
  int i;
  int k;
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandS[FTNREF1D(k,1)] = (i - 1) * nx + k;
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] * 2;
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] * 2;
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] / 2;
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] / 2;
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operandS[FTNREF1D(k,1)];
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>) BEGIN
__global__ void global2dloops_Kernel1(int *operand,global2dloops_s1 global2dloops_k1,int *dyn2d) {
  int nz = global2dloops_k1.nz;
  int nx = global2dloops_k1.nx;

  int iter;
  int i;
  int k;
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = (i - 1) * nx + k;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] * 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operand[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)] / 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operand[FTNREF2D(k,i,nz,1,1)];
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2d:inout>,<operand:none,shared,demote(2)>) BEGIN
__global__ void global2dshared1dloops_Kernel1(int *operand,global2dshared1dloops_s1 global2dshared1dloops_k1,int *dyn2d) {
  int nz = global2dshared1dloops_k1.nz;
  int nx = global2dshared1dloops_k1.nx;

  int iter;
  int i;
  int k;
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandS[FTNREF1D(k,1)] = (i - 1) * nx + k;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] * 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] * 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] / 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        operandS[FTNREF1D(k,1)] = operandS[FTNREF1D(k,1)] / 2;
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO VECTOR(1)
      k = threadIdx.x+1;
//      for (k=1;k<=nz;k++) {
        dyn2d[FTNREF2D(k,i,nz,1,1)] = operandS[FTNREF1D(k,1)];
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz>,<nx,ny>,<operand:none>,<nz,nx,ny:in>,<dyn3d:out>) BEGIN
__global__ void global3d_Kernel1(int *operand,global3d_s1 global3d_k1,int *dyn3d) {
  int nz = global3d_k1.nz;
  int nx = global3d_k1.nx;
  int ny = global3d_k1.ny;

  int iter;
  int i;
  int j;
  int k;
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = ((i - 1) * nx + j) * k;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] * 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] * 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] / 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)] / 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          dyn3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand[FTNREF3D(k,i,j,nz,nx,1,1,1)];
//        }
//      }
//    }
  }

  return;
}
//!ACC$REGION END
//!ACC$REGION(<nz>,<nx,ny>,<operand3d:none>,<nz,nx,ny:in>,<dyn3d:out>,<operand3d:none,shared,demote(2,3)>) BEGIN
__global__ void global3dshared1d_Kernel1(int *operand3d,global3dshared1d_s1 global3dshared1d_k1,int *dyn3d) {
  int nz = global3dshared1d_k1.nz;
  int nx = global3dshared1d_k1.nx;
  int ny = global3dshared1d_k1.ny;

  int iter;
  int i;
  int j;
  int k;
  for (iter=1;iter<=200;iter++) {
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand3dS[FTNREF1D(k,1)] = ((i - 1) * nx + j) * k;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand3dS[FTNREF1D(k,1)] = operand3dS[FTNREF1D(k,1)] * 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand3dS[FTNREF1D(k,1)] = operand3dS[FTNREF1D(k,1)] * 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand3dS[FTNREF1D(k,1)] = operand3dS[FTNREF1D(k,1)] / 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          operand3dS[FTNREF1D(k,1)] = operand3dS[FTNREF1D(k,1)] / 2;
//        }
//      }
//    }
//!ACC$DO PARALLEL(1)
    i = blockIdx.x+1;
//    for (i=1;i<=nx;i++) {
//!ACC$DO PARALLEL(2)
      j = blockIdx.y+1;
//      for (j=1;j<=ny;j++) {
//!ACC$DO VECTOR(1)
        k = threadIdx.x+1;
//        for (k=1;k<=nz;k++) {
          dyn3d[FTNREF3D(k,i,j,nz,nx,1,1,1)] = operand3dS[FTNREF1D(k,1)];
//        }
//      }
//    }
  }

  return;
}
//!ACC$REGION END
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
extern "C" void global2d_ (int *nx__G,int *nz__G,int *dyn2d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",20,"operand",cudaError);
  int *D_dyn2d;
  cudaError = cudaMalloc((void **) &D_dyn2d,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",20,"dyn2d",cudaError);

  int *operand = (int*) malloc((nz)*(nx)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }


  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx);

  unsigned int timer = 0;

  global2d_s1 global2d_k1;
  global2d_k1.nz = nz;
  global2d_k1.nx = nx;
  cudaError = cudaMemcpy(D_dyn2d,dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",20,"dyn2d",cudaError);
  cudaError = cudaMemcpy(D_dyn2d,dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",20,"dyn2d",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global2d_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand,global2d_k1,D_dyn2d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global2d kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(dyn2d,D_dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",35,"dyn2d",cudaError);
  free(operand);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",36,"operand",cudaError);
  cudaError = cudaFree(D_dyn2d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",36,"dyn2d",cudaError);

  return;
}
extern "C" void global2dshared1d_ (int *nx__G,int *nz__G,int *dyn2d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nz))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",46,"operand",cudaError);
  int *D_dyn2d;
  cudaError = cudaMalloc((void **) &D_dyn2d,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",46,"dyn2d",cudaError);
//!ACC$DATA(<operand:none,shared(50)>)


  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx);

  unsigned int timer = 0;

  global2dshared1d_s1 global2dshared1d_k1;
  global2dshared1d_k1.nz = nz;
  global2dshared1d_k1.nx = nx;
  cudaError = cudaMemcpy(D_dyn2d,dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",46,"dyn2d",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global2dshared1d_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand,global2dshared1d_k1,D_dyn2d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global2dshared1d kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(dyn2d,D_dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",61,"dyn2d",cudaError);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",62,"operand",cudaError);
  cudaError = cudaFree(D_dyn2d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",62,"dyn2d",cudaError);

  return;
}
extern "C" void global2dloops_ (int *nx__G,int *nz__G,int *dyn2d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",71,"operand",cudaError);
  int *D_dyn2d;
  cudaError = cudaMalloc((void **) &D_dyn2d,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",71,"dyn2d",cudaError);

  int *operand = (int*) malloc((nz)*(nx)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }


  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx);

  unsigned int timer = 0;

  global2dloops_s1 global2dloops_k1;
  global2dloops_k1.nz = nz;
  global2dloops_k1.nx = nx;
  cudaError = cudaMemcpy(D_dyn2d,dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",71,"dyn2d",cudaError);
  cudaError = cudaMemcpy(D_dyn2d,dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",71,"dyn2d",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global2dloops_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand,global2dloops_k1,D_dyn2d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global2dloops kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(dyn2d,D_dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",116,"dyn2d",cudaError);
  free(operand);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",117,"operand",cudaError);
  cudaError = cudaFree(D_dyn2d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",117,"dyn2d",cudaError);

  return;
}
extern "C" void global2dshared1dloops_ (int *nx__G,int *nz__G,int *dyn2d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nx=*nx__G;
  int nz=*nz__G;
cudaError_t cudaError;
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",130,"operand",cudaError);
  int *D_dyn2d;
  cudaError = cudaMalloc((void **) &D_dyn2d,((nz)*(nx))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",130,"dyn2d",cudaError);

  int *operand = (int*) malloc((nz)*(nx)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }
//! MWG: this declaration is not needed because shared memory variables are
//! MWG: filebased declarations.  Since an ACC$DATA already declared this 
//! MWG: variable in an earlier routine, it is omitted here.
//!!ACC$DATA(<operand:none,shared(50)>)

  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx);

  unsigned int timer = 0;

  global2dshared1dloops_s1 global2dshared1dloops_k1;
  global2dshared1dloops_k1.nz = nz;
  global2dshared1dloops_k1.nx = nx;
  cudaError = cudaMemcpy(D_dyn2d,dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyHostToDevice);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",130,"dyn2d",cudaError);

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global2dshared1dloops_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand,global2dshared1dloops_k1,D_dyn2d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global2dshared1dloops kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(dyn2d,D_dyn2d,((nz)*(nx))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",175,"dyn2d",cudaError);
  free(operand);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",176,"operand",cudaError);
  cudaError = cudaFree(D_dyn2d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",176,"dyn2d",cudaError);

  return;
}
extern "C" void global3d_ (int *nz__G,int *nx__G,int *ny__G,int *dyn3d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nz=*nz__G;
  int nx=*nx__G;
  int ny=*ny__G;
cudaError_t cudaError;
  int *D_operand;
  cudaError = cudaMalloc((void **) &D_operand,((nz)*(nx)*(ny))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",185,"operand",cudaError);
  int *D_dyn3d;
  cudaError = cudaMalloc((void **) &D_dyn3d,((nz)*(nx)*(ny))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",185,"dyn3d",cudaError);

  int *operand = (int*) malloc((nz)*(nx)*(ny)*sizeof(int));
  if (operand == NULL) {
    printf("ERROR: memory allocation error");
    exit(1);
  }


  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx,ny);

  unsigned int timer = 0;

  global3d_s1 global3d_k1;
  global3d_k1.nz = nz;
  global3d_k1.nx = nx;
  global3d_k1.ny = ny;

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global3d_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand,global3d_k1,D_dyn3d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global3d kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(dyn3d,D_dyn3d,((nz)*(nx)*(ny))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",248,"dyn3d",cudaError);
  free(operand);
  cudaError = cudaFree(D_operand);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",249,"operand",cudaError);
  cudaError = cudaFree(D_dyn3d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",249,"dyn3d",cudaError);

  return;
}
extern "C" void global3dshared1d_ (int *nz__G,int *nx__G,int *ny__G,int *dyn3d) {

  static float runtime = 0.0;
  float elapsed_time_ms = 0.f;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  int nz=*nz__G;
  int nx=*nx__G;
  int ny=*ny__G;
cudaError_t cudaError;
  int *D_operand3d;
  cudaError = cudaMalloc((void **) &D_operand3d,((nz)*(nx)*(ny))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",259,"operand3d",cudaError);
  int *D_dyn3d;
  cudaError = cudaMalloc((void **) &D_dyn3d,((nz)*(nx)*(ny))*sizeof(int));
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",259,"dyn3d",cudaError);
//!ACC$DATA(<operand3D:none,shared(50)>)


  dim3 cuda_threads1(nz);
  dim3 cuda_grids1(nx,ny);

  unsigned int timer = 0;

  global3dshared1d_s1 global3dshared1d_k1;
  global3dshared1d_k1.nz = nz;
  global3dshared1d_k1.nx = nx;
  global3dshared1d_k1.ny = ny;

  cudaEventRecord( start, 0 );
  cudaEventSynchronize(start);
  // setup execution parameters 
  // execute the kernel 
  global3dshared1d_Kernel1<<< cuda_grids1, cuda_threads1 >>>(D_operand3d,global3dshared1d_k1,D_dyn3d);
  cudaThreadSynchronize();

  cudaEventRecord( stop, 0);
  cudaEventSynchronize(stop);
  cudaEventElapsedTime( &elapsed_time_ms, start, stop );
  runtime += elapsed_time_ms;
  //  printf("global3dshared1d kernel execution time: %.2f ms\n",runtime);
  cudaError = cudaMemcpy(dyn3d,D_dyn3d,((nz)*(nx)*(ny))*sizeof(int),cudaMemcpyDeviceToHost);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",322,"dyn3d",cudaError);
  cudaError = cudaFree(D_operand3d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",323,"operand3d",cudaError);
  cudaError = cudaFree(D_dyn3d);
  cudaErrorChk("GlobalSharedTests.f90.ACC.1",323,"dyn3d",cudaError);

  return;
}
