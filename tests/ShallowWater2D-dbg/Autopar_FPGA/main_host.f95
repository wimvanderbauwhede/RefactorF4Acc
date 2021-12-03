program wave2d
use sub

use oclWrapper
use module_dyn_shapiro_superkernel_init
      implicit none

! Original declarations
      integer, parameter :: nx = 500  !!
      integer, parameter :: ny = 500  !!
      real :: dt !!
      real :: dx !!
      real :: dy !!
      real :: eps !!
      real, dimension(0:ny+1,0:nx+1) :: eta !!
      real, dimension(0:ny+1,0:nx+1) :: etan !!
      real :: g !!
      real, dimension(0:ny+1,0:nx+1) :: h !!
      real :: hmin !!
      real, dimension(0:ny+1,0:nx+1) :: hzero !!
      integer :: j !!
      integer :: k !!
      real, dimension(0:ny+1,0:nx+1) :: u !!
      real, dimension(0:ny+1,0:nx+1) :: un !!
      real, dimension(0:ny+1,0:nx+1) :: v !!
      real, dimension(0:ny+1,0:nx+1) :: vn !!
      integer, dimension(0:ny+1,0:nx+1) :: wet !!
      real :: hmax !!
      real :: time !!
      real :: dtmax !!
      real :: c !!
      real :: lambda !!
      integer :: n !!
      integer :: ntot !!
      integer :: nout !!
      integer :: dummy !!



!

! otherStatements

! remainingDecls

! Extra declarations
!NOTHING!
! Buffer declarations
      integer(8) :: state_ptr_buf
      integer(8) :: eps_buf

integer :: state_ptr

! Size declarations
      integer, dimension(1) :: state_ptr_sz
      integer, dimension(1) :: eps_ptr_sz
      real, dimension(1) :: eps_ptr

call dyn_shapiro_superkernel_init()

! Size assignments
      state_ptr_sz = shape(state_ptr)
      eps_ptr_sz = shape(eps_ptr)

! Buffer loads
      call oclLoadBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)
      call oclLoadBuffer(EPS_BUF_IDX, eps_buf)

! Original code with buffer writes and reads
ntot = 10000
eps = 0.05
call init(hmin,dx,dy,dt,g,j,k,hzero,eta,etan,h,wet,u,un,v,vn)
eps_ptr(1) = eps
call oclWrite1DFloatArrayBuffer(eps_buf,eps_ptr_sz,eps_ptr)! Automatic conversion to array
open(90,file ='debug.dat',form='formatted')
open(10,file ='eta0.dat',form='formatted')
  do j = 0,ny+1
    write(10,'(101F12.6)')(eta(j,k),k=0,nx+1)
  end do
close(10)
open(10,file ='h0.dat',form='formatted')
  do j = 0,ny+1
    write(10,'(101F12.6)')(hzero(j,k),k=0,nx+1)
  end do
close(10)
hmax = 0.
do j = 1,ny
do k = 1,nx
  hmax = max(hmax,h(j,k))
end do
end do
dummy = 0
c = sqrt(2*g*hmax)
write(6,*)"c = ",c
lambda = dt*sqrt(g*hmax)/min(dx,dy)
write(6,*)"lambda = ",lambda
if(lambda > 1)then
  write(6,*) "This will not work. Do you know why?"   
  stop
end if
open(10,file ='eta.dat',form='formatted')
open(20,file ='h.dat',form='formatted')
open(30,file ='u.dat',form='formatted')
open(40,file ='v.dat',form='formatted')
do j = 26,26
do k = 26,26
eta(j,k) = 1.0  
end do
end do
do n = 1,ntot
time = real(n)*dt
      call dyn_shapiro(dt,dx,dy,eps,eta,etan,g,h,hmin,hzero,j,k,u,un,v,vn,wet)
do j = 0,ny+1
  do k = 0,nx+1
    h(j,k) = hzero(j,k) + eta(j,k)
    wet(j,k) = 1
    if (h(j,k)<hmin) wet(j,k) = 0
    u(j,k) = un(j,k)
    v(j,k) = vn(j,k)
  end do
end do
end do 
do j = 0,ny+1
  write(10,'(101F12.6)')(eta(j,k),k=0,nx+1)
  write(20,'(101F12.6)')(h(j,k)  ,k=0,nx+1)
  write(30,'(101F12.6)')(u(j,k)  ,k=0,nx+1)
  write(40,'(101F12.6)')(v(j,k)  ,k=0,nx+1)
end do
write(6,*)"Data output at time = ",time/60.0," min"
end program wave2d
