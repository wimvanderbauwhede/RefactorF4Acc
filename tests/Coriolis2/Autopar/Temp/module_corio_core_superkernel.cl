


#include "array_index_f2c1d.h"


void corio_core_map_26(float *u,float *v,float *x,float *un,float *y,float *vn,float *xn,float *yn) {

            const float dt = 432.000000;
            const float pi = 3.14159274;
            const float freq = -7.27220540e-05;
            const float f = -1.45444108e-04;
            const float alpha = -6.28318563e-02;
            const float beta = 9.86960484e-04;
            const int dmax = 1000;
            const int im = 10;
            const int jm = 10;
            const int km = 5;
        // local vars: i,j,k
    int i;
    int j;
    int k;
        // parallelfortran: synthesised loop variable decls
    int i_range;
    int j_range;
    int k_range;
    int i_rel;
    int j_rel;
    int k_rel;
    // READ
    // WRITTEN
    // READ & WRITTEN
    // globalIdDeclaration
    int global_id;
    // globalIdInitialisation
        global_id = get_global_id(0);
    // ptrAssignments_fseq
        // parallelfortran: synthesised loop variables
        i_range = ((10-1)+1);
        j_range = ((10-1)+1);
        k_range = ((5-1)+1);
        i_rel = (global_id/(j_range*k_range));
        i = i_rel+1;
        j_rel = ((global_id-(i_rel*(j_range*k_range)))/k_range);
        j = j_rel+1;
        k_rel = ((global_id-(i_rel*(j_range*k_range)))-(j_rel*k_range));
        k = k_rel+1;
        // parallelfortran: original code
                        un[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = (u[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)]*(beta)+alpha*v[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)])/(beta);
                        vn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = (v[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)]*(beta)-alpha*u[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)])/(beta);
                                        xn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = x[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)]+dt*un[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)]/dmax;
                                        yn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = y[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)]+dt*vn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)]/dmax;
                        u[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = un[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)];
                        v[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = vn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)];
                        x[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = xn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)];
                        y[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)] = yn[F3D2C(((im - 1 )+1),((jm - 1 )+1) , 1,1,1 , i,j,k)];
            }
void corio_core_superkernel(float *u,float *v,float *x,float *un,float *y,float *vn,float *xn,float *yn,int *state_ptr) {

  int state;
  const int st_corio_core_map_26 = 0;
    state = *state_ptr;
  // SUPERKERNEL BODY
  switch ( state ) {
        case (st_corio_core_map_26): {
            corio_core_map_26(u,v,x,un,y,vn,xn,yn);
      }
  }
  }
  
