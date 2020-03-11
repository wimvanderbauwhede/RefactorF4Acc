        PROGRAM corio

        !*************************************
        !* Simulation of the Coriolis force 
        !*
        !* Author: J. Kaempf, 2008
        !*************************************
        !integer im,jm,km
        parameter(im=10,jm=10,km=5)
        parameter(dmax=1000)
        
        REAL u,v,un,vn
        dimension u(im,jm,km), un(im,jm,km)
        ! dimension 
        dimension v(im,jm,km), vn(im,jm,km)
        ! dimension 
        REAL x,y,xn,yn
        dimension x(im,jm,km), y(im,jm,km), xn(im,jm,km), yn(im,jm,km)
        ! REAL :: dt,fre,f,pi,alpha,beta
        INTEGER n !,ntot,mode
        INTEGER i,j


        ! parameter(pi = 3.14159)          ! this calculates Pi
        parameter(pi = 4.*atan(1.))          ! this calculates Pi
        real freq, f, dt
        parameter(freq = -2.*pi/(24.*3600.))
        parameter(f = 2*freq)                ! Coriolis parameter
        parameter(dt = 24.*3600./200.)       ! time step

        ! parameters for semi-implicit scheme
        real alpha, beta
        parameter( alpha = f*dt)
        parameter(beta = 0.25*alpha*alpha)

        parameter(ntot = 200) ! total number of interation steps


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
        
        ! time = REAL(n)*dt

        ! velocity predictor
!$ACC Subroutine predict_vel
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
!$ACC End Subroutine predict_vel

        ! predictor of new location
!$ACC Subroutine predict_loc
        do i=1,im
            do j=1,jm
                do k=1,km        
                    xn(i,j,k) = x(i,j,k) + dt*un(i,j,k)/dmax
                    yn(i,j,k) = y(i,j,k) + dt*vn(i,j,k)/dmax
                end do
            end do
        end do
!$ACC End Subroutine predict_loc
        
        ! updates for next time step 
!$ACC Subroutine update_loc_vel
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
!$ACC End Subroutine update_loc_vel

        ! data output
        ! WRITE(10,*)x,y,time
        ! print *, x(im/2,ij/2,1),y(im/2,jm/2,1),time
        !**** end of iteration loop ****
        END DO
        !*******************************

        END PROGRAM corio


