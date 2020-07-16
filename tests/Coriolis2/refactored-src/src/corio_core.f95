module singleton_module_src_corio_core

contains

      subroutine corio_core(u,v,x,y)
! === Original code from corio starts here ===
      implicit none
      real, parameter :: dt=24.*3600./200.
      real, parameter :: pi=4.*atan(1.)
      real, parameter :: freq=-2.*pi/(24.*3600.)
      integer, parameter :: f=2*freq
      real, parameter :: alpha=f*dt
      real, parameter :: beta=0.25*alpha*alpha
      integer, parameter :: dmax=1000
      integer, parameter :: im=100
      integer, parameter :: jm=100
      integer, parameter :: km=50
        real, dimension(1:im,1:jm,1:km), intent(InOut) :: y
        real, dimension(1:im,1:jm,1:km), intent(InOut) :: x
        real, dimension(1:im,1:jm,1:km), intent(InOut) :: v
        real, dimension(1:im,1:jm,1:km), intent(InOut) :: u
  real, dimension(1:im,1:jm,1:km) :: yn
  real, dimension(1:im,1:jm,1:km) :: xn
  real, dimension(1:im,1:jm,1:km) :: vn
  real, dimension(1:im,1:jm,1:km) :: un
      integer :: k
  integer :: j
  integer :: i
do i=1,im
  do j=1,jm
    do k=1,km
    un(i,j,k) = (u(i,j,k)*(1-beta)+alpha*v(i,j,k))/(1+beta)
    vn(i,j,k) = (v(i,j,k)*(1-beta)-alpha*u(i,j,k))/(1+beta)
    end do
  end do
end do
do i=1,im
  do j=1,jm
      do k=1,km        
          xn(i,j,k) = x(i,j,k) + dt*un(i,j,k)/dmax
          yn(i,j,k) = y(i,j,k) + dt*vn(i,j,k)/dmax
      end do
  end do
end do
do i=1,im
  do j=1,jm
    do k=1,km
      u(i,j,k) = un(i,j,k)
      v(i,j,k) = vn(i,j,k)
      x(i,j,k) = xn(i,j,k)
      y(i,j,k) = yn(i,j,k)
    end do
  end do
end do
      end subroutine corio_core

end module singleton_module_src_corio_core

