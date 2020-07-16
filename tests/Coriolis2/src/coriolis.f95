PROGRAM corio

!*************************************
!* Simulation of the Coriolis force 
!*
!* Author: J. Kaempf, 2008
!*************************************

  integer, parameter :: im=100
  integer, parameter :: jm=100
  integer, parameter :: km=50
  integer, parameter :: dmax=1000
  
REAL, dimension(im,jm,km) :: u
REAL, dimension(im,jm,km) :: v
REAL, dimension(im,jm,km) :: un
REAL, dimension(im,jm,km) :: vn
! ,v,un,vn
! REAL, dimension(im,jm,km) :: x,y,xn,yn
REAL, dimension(im,jm,km) :: x
REAL, dimension(im,jm,km) :: y
REAL, dimension(im,jm,km) :: xn
REAL, dimension(im,jm,km) :: yn
! REAL :: dt,fre,f,pi,alpha,beta
INTEGER :: n !,ntot,mode
INTEGER :: i,j


real, parameter :: pi = 4.*atan(1.)          ! this calculates Pi
real, parameter :: freq = -2.*pi/(24.*3600.)
real, parameter :: f = 2*freq                ! Coriolis parameter
real, parameter :: dt = 24.*3600./200.       ! time step

! parameters for semi-implicit scheme
real, parameter :: alpha = f*dt
real, parameter :: beta = 0.25*alpha*alpha

integer, parameter :: ntot = 200; ! total number of interation steps


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

! IF(mode == 1)THEN
  OPEN(10,FILE='output1.txt',FORM='formatted')
! ELSE
!   OPEN(10,FILE='output2.txt',FORM='formatted')
! END IF

WRITE(10,*)freq,dt,ntot

!**** start of iteration loop ****
DO n = 1,ntot
!*********************************

time = REAL(n)*dt

!$ACC Subroutine corio_core

! velocity predictor
do i=1,im
  do j=1,jm
    do k=1,km
!IF (mode == 1) THEN      
    un(i,j,k) = (u(i,j,k)*(1-beta)+alpha*v(i,j,k))/(1+beta)
    vn(i,j,k) = (v(i,j,k)*(1-beta)-alpha*u(i,j,k))/(1+beta)
! ELSE
!   un = cos(alpha)*u+sin(alpha)*v
!   vn = cos(alpha)*v-sin(alpha)*u
! END IF
    end do
  end do
end do

! predictor of new location
do i=1,im
  do j=1,jm
      do k=1,km        
          xn(i,j,k) = x(i,j,k) + dt*un(i,j,k)/dmax
          yn(i,j,k) = y(i,j,k) + dt*vn(i,j,k)/dmax
      end do
  end do
end do

! updates for next time step 
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
!$ACC End Subroutine corio_core

! data output
!WRITE(10,*)x,y,time

!**** end of iteration loop ****
END DO
!*******************************

END PROGRAM corio


