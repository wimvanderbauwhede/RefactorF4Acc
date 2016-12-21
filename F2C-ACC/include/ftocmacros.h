/*
** Fortran to C index translation macros for Mark Govett's ctof for 
** GPU kernels.  
**
** Tom Henderson
** 9/25/08
**
** ix = i_index
** iz = i_size
*/

#ifndef _FTOC_MACROS_
#define _FTOC_MACROS_

#define FTNREF1D(ix,                                    i_lb)                                                                                                                                                                                                                ix-i_lb
#define FTNREF2D(ix,jx,               iz,               i_lb,j_lb)                                                                                                                                                                                          (iz)*(jx-(j_lb))+ix-i_lb
#define FTNREF3D(ix,jx,kx,            iz,jz,            i_lb,j_lb,k_lb)                                                                                                                                                               (iz)*(jz)*(kx-(k_lb))+(iz)*(jx-(j_lb))+ix-i_lb
#define FTNREF4D(ix,jx,kx,lx,         iz,jz,kz,         i_lb,j_lb,k_lb,l_lb)                                                                                                                               (iz)*(jz)*(kz)*(lx-(l_lb))+(iz)*(jz)*(kx-(k_lb))+(iz)*(jx-(j_lb))+ix-i_lb
#define FTNREF5D(ix,jx,kx,lx,mx,      iz,jz,kz,lz,      i_lb,j_lb,k_lb,l_lb,m_lb)                                                                                          (iz)*(jz)*(kz)*(lz)*(mx-(m_lb))+(iz)*(jz)*(kz)*(lx-(l_lb))+(iz)*(jz)*(kx-(k_lb))+(iz)*(jx-(j_lb))+ix-i_lb
#define FTNREF6D(ix,jx,kx,lx,mx,nx,   iz,jz,kz,lz,mz,   i_lb,j_lb,k_lb,l_lb,m_lb,n_lb)                                                (iz)*(jz)*(kz)*(lz)*(mz)*(nx-(n_lb))+(iz)*(jz)*(kz)*(lz)*(mx-(m_lb))+(iz)*(jz)*(kz)*(lx-(l_lb))+(iz)*(jz)*(kx-(k_lb))+(iz)*(jx-(j_lb))+ix-i_lb
#define FTNREF7D(ix,jx,kx,lx,mx,nx,ox,iz,jz,kz,lz,mz,nz,i_lb,j_lb,k_lb,l_lb,m_lb,n_lb,o_lb) (iz)*(jz)*(kz)*(lz)*(mz)*(nz)*(ox-(o_lb))+(iz)*(jz)*(kz)*(lz)*(mz)*(nx-(n_lb))+(iz)*(jz)*(kz)*(lz)*(mx-(m_lb))+(iz)*(jz)*(kz)*(lx-(l_lb))+(iz)*(jz)*(kx-(k_lb))+(iz)*(jx-(j_lb))+ix-i_lb

#define MAX(a, b) ((a) >= (b) ? (a) : (b))
#define MIN(a, b) ((a) >= (b) ? (b) : (a))
#define SIGN(a,b) (((b) <  (0) && (a > (0))||((b) > (0) && ((a)<(0)))) ? (-a) : (a))
#define SQR(a) ((a)*(a))
#endif /* _FTOC_MACROS_ */

