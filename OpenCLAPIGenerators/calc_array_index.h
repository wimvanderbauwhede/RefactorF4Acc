#ifndef _CALC_ARRAY_INDEX_H_
#define _CALC_ARRAY_INDEX_H_
inline unsigned int FTNREF3D(
                int ix, int jx, int kx,
                        unsigned int iz,unsigned int jz,
                                int i_lb, int j_lb, int k_lb
                                        ) {
        return (iz*jz*(kx-k_lb)+iz*(jx-j_lb)+ix-i_lb);
}

inline unsigned int FTNREF3D0(
                int ix, int jx, int kx,
                        unsigned int iz,unsigned int jz
                                ) {
        return iz*jz*kx+iz*jx+ix ;
}

inline unsigned int FTNREF1D(int ix,int i_lb) {
            return ix-i_lb;
}


// These functions take the lower and upper bounds, rather than the range and the lower bound
inline unsigned int FTNREF3Du(int ix,int jx,int kx,unsigned int i_ub,unsigned int j_ub,int i_lb,int j_lb,int k_lb) {
    return (i_ub - i_lb + 1)*(j_ub - j_lb + 1)*(kx - k_lb)+(i_ub - i_lb + 1)*(jx - j_lb)+(ix - i_lb);
}
// For lower bounds all 0
inline unsigned int FTNREF3Du0(int ix,int jx,int kx,unsigned int i_ub,unsigned int j_ub) {
    return (i_ub + 1)*(j_ub + 1)*kx+(i_ub + 1)*jx+ix;
}
#endif
