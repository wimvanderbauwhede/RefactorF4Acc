program corio
      use singleton_module_src_corio_core
      implicit none
      integer, parameter :: im=100
      integer, parameter :: jm=100
      integer, parameter :: km=50
      integer, parameter :: dmax=1000
      integer :: k
      real :: time
real, dimension(im,jm,km) :: u
real, dimension(im,jm,km) :: v
real, dimension(im,jm,km) :: un
real, dimension(im,jm,km) :: vn
real, dimension(im,jm,km) :: x
real, dimension(im,jm,km) :: y
real, dimension(im,jm,km) :: xn
real, dimension(im,jm,km) :: yn
  integer :: n
  integer :: i
  integer :: j
      real, parameter :: pi=4.*atan(1.)
      real, parameter :: freq=-2.*pi/(24.*3600.)
      integer, parameter :: f=2*freq
      real, parameter :: dt=24.*3600./200.
      real, parameter :: alpha=f*dt
      real, parameter :: beta=0.25*alpha*alpha
      integer, parameter :: ntot=200
do i=1,im
  do j=1,jm
    do k=1,km
      u(i,j,k) = 0.5
      v(i,j,k) = 0.5
      x(i,j,k) = 0.
      y(i,j,k) = 5.
    end do
  end do
end do
  open(10,file='output1.txt',form='formatted')
write(10,*)freq,dt,ntot
do n = 1,ntot
time = real(n)*dt
      call corio_core(u,v,x,y)

end do
end program corio
