subroutine init_wind_profile(u,v,w)
    integer, parameter :: ip=450
    integer, parameter :: jp=450
    integer, parameter :: kp=90 

    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: u
    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: v
    real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)) :: w
    real, dimension(1:kp+2) :: z2
    real dimension(-1:kp+2) :: dzn

!--dz vertical direction
      do k=0,1
        z2(k)= 2.5
        dzn(k)= 2.5
      end do
      do k=2,15
        dzn(k)=dzn(k-1)*1.05
      end do
      do k=16,44
        dzn(k)=5.
      end do
      do k=45,km+1
        dzn(k)=dzn(k-1)*1.0459
      end do
      do k=2,km+1
        z2(k)=z2(k-1)+dzn(k)  !Height
      end do
!-- dzn boundary values
      dzn(km+1)=dzn(km)
      dzn(0)   =dzn(1)

!-- initial wind profile
       do i = 0,ip+1
            do k = 1,78 ! kp = 90 so OK
                do j = 1,jp
                    u(i,j,k) = 5.*((z2(k)+0.5*dzn(k))/600.)**0.2
                    v(i,j,k) = 0.0
                    w(i,j,k) = 0.0
                end do
            end do
        end do

        do i = 0,1
            do k = 79,kp
                do j = 1,jp
                    u(i,j,k) = u(i,j,77)
                    v(i,j,k) = 0.0
                    w(i,j,k) = 0.0
                end do
            end do
        end do

end subroutine init_wind_profile
