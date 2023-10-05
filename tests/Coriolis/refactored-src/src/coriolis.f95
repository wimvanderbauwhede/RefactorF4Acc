        program corio
      use singleton_module_src_predict_loc ! _create_module_src
      use singleton_module_src_predict_vel ! _create_module_src
      use singleton_module_src_update_loc_vel ! _create_module_src
!        !*************************************
!        !* Simulation of the Coriolis force 
!        !*
!        !* Author: J. Kaempf, 2008
!        !*************************************
!        !integer im,jm,km
      implicit none
      integer, parameter :: im=100
      integer, parameter :: jm=100
      integer, parameter :: km=50
      integer, parameter :: dmax=1000
                    real, dimension(1:im,1:jm,1:km) :: u
                    real, dimension(1:im,1:jm,1:km) :: v
                          real, dimension(1:im,1:jm,1:km) :: un
                          real, dimension(1:im,1:jm,1:km) :: vn
!        ! dimension 
!        ! dimension 
                    real, dimension(1:im,1:jm,1:km) :: x
                    real, dimension(1:im,1:jm,1:km) :: y
                    real, dimension(1:im,1:jm,1:km) :: xn
                    real, dimension(1:im,1:jm,1:km) :: yn
!        ! REAL :: dt,fre,f,pi,alpha,beta
        integer :: n
        integer :: i
        integer :: j
!        ! parameter(pi = 3.14159)          ! this calculates Pi
      real, parameter :: pi=4. * atan(1.)
      real, parameter :: freq=-2. * pi / (24. * 3600.)
      integer, parameter :: f=2 * freq
      real, parameter :: dt=24. * 3600. / 200.
!        ! parameters for semi-implicit scheme
      real, parameter :: alpha=f * dt
      real, parameter :: beta=0.25 * alpha * alpha
      integer, parameter :: ntot=200
!        ! initial speed and location
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
!        ! mode = 1   ! choose between mode 1 and mode 2
!        ! IF(mode == 1)THEN
        open(10,file='output1.txt',form='formatted')
!        ! ELSE
!        !   OPEN(10,FILE='output2.txt',FORM='formatted')
!        ! END IF
        write(10,*)freq,dt,ntot
!        !**** start of iteration loop ****
        do n = 1,ntot
!        !*********************************
!        ! time = REAL(n)*dt
!        ! velocity predictor
      call predict_vel(u,un,v,vn)
!        ! predictor of new location
      call predict_loc(un,vn,x,xn,y,yn)
!        ! updates for next time step 
      call update_loc_vel(u,un,v,vn,x,xn,y,yn)
!        ! data output
!        ! WRITE(10,*)x,y,time
!        ! print *, x(im/2,ij/2,1),y(im/2,jm/2,1),time
!        !**** end of iteration loop ****
        end do
!        !*******************************
        end program corio
