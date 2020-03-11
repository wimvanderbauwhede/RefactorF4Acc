PROGRAM corio

!*************************************
!* Simulation of the Coriolis force 
!*
!* Author: J. Kaempf, 2008
!*************************************

REAL :: u,v,un,vn,x,y,xn,yn
REAL :: dt,fre,f,pi,alpha,beta
INTEGER :: n,ntot,mode

! initial speed and location

u = 0.5
v = 0.5
x = 0.
y = 5.

pi = 4.*atan(1.)          ! this calculates Pi
freq = -2.*pi/(24.*3600.)
f = 2*freq                ! Coriolis parameter
dt = 24.*3600./200.       ! time step

! parameters for semi-implicit scheme
alpha = f*dt
beta = 0.25*alpha*alpha

ntot = 200; ! total number of interation steps

mode = 1   ! choose between mode 1 and mode 2

IF(mode == 1)THEN
  OPEN(10,FILE='output1.txt',FORM='formatted')
ELSE
  OPEN(10,FILE='output2.txt',FORM='formatted')
END IF

WRITE(10,*)freq,dt,ntot

!**** start of iteration loop ****
DO n = 1,ntot
!*********************************

time = REAL(n)*dt

! velocity predictor
IF (mode == 1) THEN
  un = (u*(1-beta)+alpha*v)/(1+beta)
  vn = (v*(1-beta)-alpha*u)/(1+beta)
ELSE
  un = cos(alpha)*u+sin(alpha)*v
  vn = cos(alpha)*v-sin(alpha)*u
END IF

! predictor of new location
xn = x + dt*un/1000
yn = y + dt*vn/1000

! updates for next time step 
u = un
v = vn
x = xn
y = yn

! data output
WRITE(10,*)x,y,time

!**** end of iteration loop ****
END DO
!*******************************

END PROGRAM corio


