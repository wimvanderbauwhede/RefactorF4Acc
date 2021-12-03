module singleton_module_init

contains

subroutine init(hmin,dx,dy,dt,g,j,k,hzero,eta,etan,h,wet,u,un,v,vn)
      implicit none
      integer, parameter :: nx=500
      integer, parameter :: ny=500
! BEGIN new declarations
      real, intent(InOut) :: hmin
      real, intent(Out) :: dx
      real, intent(Out) :: dy
      real, intent(Out) :: dt
      real, intent(Out) :: g
      integer, intent(InOut) :: j
      integer, intent(InOut) :: k
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: hzero
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: eta
      real, dimension(0:ny + 1,0:nx + 1), intent(Out) :: etan
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: h
      integer, dimension(0:ny + 1,0:nx + 1), intent(Out) :: wet
      real, dimension(0:ny + 1,0:nx + 1), intent(Out) :: u
      real, dimension(0:ny + 1,0:nx + 1), intent(Out) :: un
      real, dimension(0:ny + 1,0:nx + 1), intent(Out) :: v
      real, dimension(0:ny + 1,0:nx + 1), intent(Out) :: vn
! END new declarations
hmin = 0.05
!  grid parameters
dx = 10.0
dy = 10.0
dt = 0.1
!  physical parameters
g = 9.81
!  initial conditions
do j = 0,ny+1
do k = 0,nx+1
  hzero(j,k) = 10.0 
end do
end do
!  land boundaries with 10 m elevation
do k = 0,nx+1
 hzero(0,k) = -10.0
!  hzero(1,k) = -0.0
 hzero(ny+1,k) = -10.0
!  hzero(ny,k) = -0.0
end do
! DO j = 39,41
! DO k = 39,41
! hzero(j,k) = 0.0
! END DO
! END DO
do j = 0,ny+1
 hzero(j,0) = -10.0
 hzero(j,nx+1) = -10.0
end do
do j = 0,ny+1
do k = 0,nx+1
  eta(j,k) = -min(0.0,hzero(j,k))
  etan(j,k) = eta(j,k)
end do
end do
! XXXXXXXXXXXXXXXXXXX
do j = 0,ny+1
do k = 0,nx+1
  h(j,k) = hzero(j,k)+eta(j,k)
!  wet = 1 defines "wet" grid cells
!  wet = 0 defines "dry" grid cells
  wet(j,k) = 1
  if(h(j,k) < hmin)wet(j,k) = 0
  u(j,k) = 0.
  un(j,k) = 0.
  v(j,k) = 0.
  vn(j,k) = 0.
end do
end do
end subroutine init

end module singleton_module_init

