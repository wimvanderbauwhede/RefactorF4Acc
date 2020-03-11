        program corio
      use singleton_module_src_corio_core
      implicit none
      integer, parameter :: im=10
      integer, parameter :: jm=10
      integer, parameter :: km=5
      integer, parameter :: dmax=1000
      integer :: k
        real, dimension(1:im,1:jm,1:km) :: u
        real, dimension(1:im,1:jm,1:km) :: v
        real, dimension(1:im,1:jm,1:km) :: un
        real, dimension(1:im,1:jm,1:km) :: vn
        real, dimension(1:im,1:jm,1:km) :: x
        real, dimension(1:im,1:jm,1:km) :: y
        real, dimension(1:im,1:jm,1:km) :: xn
        real, dimension(1:im,1:jm,1:km) :: yn
        integer :: n
        integer :: i
        integer :: j
      real, parameter :: pi=4.*atan(1.)
      real, parameter :: freq=-2.*pi/(24.*3600.)
      real, parameter :: f=2*freq
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
      call corio_core(u,v,x,y)

        end do
        end program corio
