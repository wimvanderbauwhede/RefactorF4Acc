        program corio
      use singleton_module_src_update_loc_vel
      use singleton_module_src_predict_vel
      use singleton_module_src_predict_loc
        !*************************************
        !* simulation of the coriolis force 
        !*
        !* author: j. kaempf, 2008
        !*************************************
        !integer im,jm,km
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
        ! dimension 
        ! dimension 
        real, dimension(1:im,1:jm,1:km) :: x
        real, dimension(1:im,1:jm,1:km) :: y
        real, dimension(1:im,1:jm,1:km) :: xn
        real, dimension(1:im,1:jm,1:km) :: yn
        ! real :: dt,fre,f,pi,alpha,beta
        integer :: n
        integer :: i
        integer :: j
        ! parameter(pi = 3.14159)          ! this calculates pi
      real, parameter :: pi=4.*atan(1.)
      real, parameter :: freq=-2.*pi/(24.*3600.)
      integer, parameter :: f=2*freq
      real, parameter :: dt=24.*3600./200.
        ! parameters for semi-implicit scheme
      real, parameter :: alpha=f*dt
      real, parameter :: beta=0.25*alpha*alpha
      integer, parameter :: ntot=200
        ! initial speed and location
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
        ! mode = 1   ! choose between mode 1 and mode 2
        ! if(mode == 1)then
        open(10,file='output1.txt',form='formatted')
        ! else
        !   open(10,file=__PH0__,form=__PH1__)
        ! end if
        write(10,*)freq,dt,ntot
        !**** start of iteration loop ****
        do n = 1,ntot
        !*********************************
        ! time = real(n)*dt
        ! velocity predictor
      call predict_vel(u,un,v,vn)

        ! predictor of new location
      call predict_loc(un,vn,x,xn,y,yn)

        ! updates for next time step 
      call update_loc_vel(u,un,v,vn,x,xn,y,yn)

        ! data output
        ! write(10,*)x,y,time
        ! print *, x(im/2,ij/2,1),y(im/2,jm/2,1),time
        !**** end of iteration loop ****
        end do
        !*******************************
        end program corio
