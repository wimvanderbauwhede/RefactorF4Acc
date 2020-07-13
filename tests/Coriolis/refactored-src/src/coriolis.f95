        program corio
      use singleton_module_src_predict_vel
      use singleton_module_src_update_loc_vel
      use singleton_module_src_predict_loc
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
      call predict_vel(u,un,v,vn)

      call predict_loc(un,vn,x,xn,y,yn)

      call update_loc_vel(u,un,v,vn,x,xn,y,yn)

        end do
        end program corio
