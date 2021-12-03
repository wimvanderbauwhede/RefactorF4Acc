program wave2d
      use singleton_module_dyn_shapiro
! *****************************************!
! * 2d shallow-Water model                *!
! *                                       *!
! * including:                            *!
! * - horizontal pressure-gradient force  *!
! * - Shapiro filter                      *!
! * - flooding algorithm                  *!
! *                                       *!
! * Author: J. Kaempf, 2008               *!
! *****************************************!
use sub
!  local parameters
! BEGIN new declarations
      implicit none
integer, parameter :: nx=500
integer, parameter :: ny=500
      real :: dt
      real :: dx
      real :: dy
      real :: eps
      real, dimension(0:ny + 1,0:nx + 1) :: eta
      real, dimension(0:ny + 1,0:nx + 1) :: etan
      real :: g
      real, dimension(0:ny + 1,0:nx + 1) :: h
      real :: hmin
      real, dimension(0:ny + 1,0:nx + 1) :: hzero
      integer :: j
      integer :: k
      real, dimension(0:ny + 1,0:nx + 1) :: u
      real, dimension(0:ny + 1,0:nx + 1) :: un
      real, dimension(0:ny + 1,0:nx + 1) :: v
      real, dimension(0:ny + 1,0:nx + 1) :: vn
      integer, dimension(0:ny + 1,0:nx + 1) :: wet
! END new declarations
real :: hmax
real :: time
real :: dtmax
real :: c
real :: lambda
integer :: n
integer :: ntot
integer :: nout
integer :: dummy
!  set local parameters
!  runtime parameters
ntot = 10000
!  output parameter
! nout = 5
!  set epsilon for Shapiro filter
eps = 0.05
call init(hmin,dx,dy,dt,g,j,k,hzero,eta,etan,h,wet,u,un,v,vn)
! **********
! debug
open(90,file ='debug.dat',form='formatted')
!  output of initial eta distribution
open(10,file ='eta0.dat',form='formatted')
  do j = 0,ny+1
    write(10,'(101F12.6)')(eta(j,k),k=0,nx+1)
  end do
close(10)
!  output of initial layer thickness distribution
open(10,file ='h0.dat',form='formatted')
  do j = 0,ny+1
    write(10,'(101F12.6)')(hzero(j,k),k=0,nx+1)
  end do
close(10)
!  determine maximum water depth
hmax = 0.
do j = 1,ny
do k = 1,nx
  hmax = max(hmax,h(j,k))
end do
end do
!  maximum phase speed
dummy = 0
c = sqrt(2*g*hmax)
! 
write(6,*)"c = ",c
!  determine stability parameter
lambda = dt*sqrt(g*hmax)/min(dx,dy)
write(6,*)"lambda = ",lambda
if(lambda > 1)then
  write(6,*) "This will not work. Do you know why?"   
  stop
end if
!  open files for output
open(10,file ='eta.dat',form='formatted')
open(20,file ='h.dat',form='formatted')
open(30,file ='u.dat',form='formatted')
open(40,file ='v.dat',form='formatted')
do j = 26,26
do k = 26,26
eta(j,k) = 1.0  
end do
end do
! ---------------------------
!  simulation loop
! ---------------------------
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
!  data output
!  Only write once at the end
! IF(MOD(n,nout)==0)THEN
!   DO j = 1,ny
!     WRITE(10,'(101F12.6)')(eta(j,k),k=1,nx)
!     WRITE(20,'(101F12.6)')(h(j,k),k=1,nx)
!     WRITE(30,'(101F12.6)')(u(j,k),k=1,nx)
!     WRITE(40,'(101F12.6)')(v(j,k),k=1,nx)
!   END DO
!   WRITE(6,*)"Data output at time = ",time/60.0," min"
! ENDIF
end do 
! Write results only once at the end....
do j = 0,ny+1
  write(10,'(101F12.6)')(eta(j,k),k=0,nx+1)
  write(20,'(101F12.6)')(h(j,k)  ,k=0,nx+1)
  write(30,'(101F12.6)')(u(j,k)  ,k=0,nx+1)
  write(40,'(101F12.6)')(v(j,k)  ,k=0,nx+1)
end do
write(6,*)"Data output at time = ",time/60.0," min"
end program wave2d
