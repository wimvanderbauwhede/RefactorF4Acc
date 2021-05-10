      program test_loop_nature
        integer sz
        parameter( sz = 1024 )
        integer, parameter :: wx = sz*4, wy = sz*3, kp = 64
        ! integer, parameter :: wy = sz*3
        real, dimension(-1:wx+2,-1:wy+2,-1:kp+2) :: p1,p2,rhs !$RF4A Halos((2,2),(2,2),(2,2)),Partitions(4,3,1)
        real, dimension(-1:wx+2,-1:wy+2,-1:kp+2) :: p3
        real dummy(-1:wx+2,-1:wy+2)
        
        ! test for DSM
        p3(0,0)=p2(0,0)
        p1(1,1)=p3(1,1)
        p1(2,3)=p2(3,4)
        
        call sub0(p1,p2,dummy(3,4))

        call sub1(p1,p2)

        call sub2(p1,p2)

        call sor(p1,p2,rhs)

7188    print *, p1(wx/2,wy/2)

      end program

      subroutine sub0(p1,p2,dummy)      
        integer, parameter :: sz = 1024
        integer, parameter :: wx = sz*4
        integer, parameter :: wy = sz*3
        real p1(-1:wx+2,-1:wy+2,-1:66)
        real p2
        dimension p2(-1:wx+2,-1:wy+2,-1:66)
!        integer dummy
        real, dimension(-1:wx+2,-1:wy+2,-1:66) :: p12
        integer :: i,j,k,k1  
        do i = -1, wx+2
            do j = -1, wy+2
                p1(i,j) = (i+j*(wx+4))*0.1
                p2(i,j) = -p1(i,j)
            end do
        end do
        
        do i = -1, wx+2
            do j = -1, wy+2
                do k1 =1,2
                    p12(i,j) = k1
                end do 
            end do
        end do        
      end subroutine
      
      subroutine sub1(p1,p2)      
        integer, parameter :: sz = 1024
        integer, parameter :: wx = sz*4
        integer, parameter :: wy = sz*3
        real, dimension(-1:wx+2,-1:wy+2,-1:66) :: p1, p2       
        real ptmp 
        integer :: i,j,k

        do i = -1, wx+2
            do j = -1, wy+2
                p1(i,j) = (p1(i,j) - p2(i,j))/2.0
            end do
        end do
        
        do i = -1, wx+2
            do j = -1, wy+2
                ptmp = 2.0*p1(i,j)
                p2(i,j) = ptmp
            end do
        end do

      end subroutine

      subroutine sub2(p1,p2)      
        integer, parameter :: sz = 1024
        integer, parameter :: wx = sz*4
        integer, parameter :: wy = sz*3
        real, dimension(-1:wx+2,-1:wy+2,-1:66) :: p1, p2        
        integer :: i1,i2,i,j,k
        real :: acc

        do i = 1, wx
            do j = 1, wy
                p2(i,j) = (p1(i+1,j)+p1(i-1,j)+ p1(i,j+1)+p1(i,j-1))/4.0
            end do
        end do

        acc=0
        do i1 = -1, wx+2
            do j = -1, wy+2
                acc =  acc + p1(i1,j) 
            end do
        end do
        acc = acc / ((wx+4)*(wy+4))

        do i2 = -1, wx+2
            do j = -1, wy+2
                p1(i2,j) = p2(i2,j)+acc
            end do
        end do
      end subroutine        

      subroutine sor(p0,p1)      
        integer, parameter :: sz = 1024
        integer, parameter :: wx = sz*4
        integer, parameter :: wy = sz*3
        integer, parameter :: ip = wx
        integer, parameter :: jp = wy
        integer, parameter :: kp = 64

        real, dimension(-1:wx+2,-1:wy+2,-1:kp+2) :: p0, p1
        real, dimension(-1:wx+2,-1:wy+2,-1:kp+2) :: rhs

        ! real(kind=4), dimension(0:ip) , intent(In) :: dxs
        ! real(kind=4), dimension(0:jp) , intent(In) :: dys
        ! real(kind=4), dimension(-1:kp+2) , intent(In) :: dzs
        ! real(kind=4), dimension(-1:ip+1) , intent(In) :: dx1
        ! real(kind=4), dimension(0:jp+1) , intent(In) :: dy1
        ! real(kind=4), dimension(-1:kp+2) , intent(In) :: dzn        
        real(kind=4) :: dz1,dz2
        real :: rhsav, area, reltmp        
        
        integer :: l,nrd,i,j,k
        real :: sor
        real, parameter :: nmaxp = 50
        real, parameter :: omega = 1.0
        real, parameter :: cn1 = 0.15
        real, parameter :: cn2l = 1.0
        real, parameter :: cn2s = 1.0
        real, parameter :: cn3l = 1.0
        real, parameter :: cn3s = 1.0
        real, parameter :: cn4l = 1.0
        real, parameter :: cn4s = 1.0

        real, parameter :: dx1 = 1.0
        real, parameter :: dy1 = 1.0
        real, parameter :: dzn = 1.0


        rhsav = 0.0
        area = 0.0
        do k = 1,kp !$RF4A Reduce, Accs(rhsav,area), Arrays(rhs)
            do j = 1,jp !$RF4A Reduce, Accs(rhsav,area), Arrays(rhs)
                do i = 1,ip !$RF4A Reduce, Accs(rhsav,area), Arrays(rhs)
                    rhsav = rhsav+dx1*dy1*dzn*rhs(i,j,k)
                    area = area +dx1*dy1*dzn
                end do
            end do
        end do
    
        rhsav = rhsav/area
        do k = 1,kp !$RF4A Map, Arrays(rhs)
            do j = 1,jp !$RF4A Map, Arrays(rhs)
                do i = 1,ip !$RF4A Map, Arrays(rhs)
                    rhs(i,j,k) = rhs(i,j,k)-rhsav
                end do
            end do
        end do
! --SOR
        do l = 1,nmaxp !$RF4A Iter
    ! #ifndef NO_GLOBAL_SOR            
            ! sor = 0.0
    ! #endif             
            do nrd = 0,1 !$RF4A Iter
                do k = 1,kp !$RF4A Map, Arrays(p1,p2,rhs)
                    ! dz1 = dzs(k-1)
                    ! dz2 = dzs(k)
                    ! cn4s = 2./(dz1*(dz1+dz2))
                    ! cn4l = 2./(dz2*(dz1+dz2))
                    do j = 1,jp !$RF4A Map, Arrays(p1,p2,rhs)
                        ! cn3s = 2./(dys(j-1)*(dys(j-1)+dys(j)))
                        ! cn3l = 2./(dys(j)*(dys(j-1)+dys(j)))
                        do i=1,ip !$RF4A Map, Arrays(p1,p2,rhs)
                            ! cn2s = 2./(dxs(i-1)*(dxs(i-1)+dxs(i)))
                            ! cn2l = 2./(dxs(i)*(dxs(i-1)+dxs(i)))    
                            ! cn1 = 1./ (2./(dxs(i-1)*dxs(i))  + 2./(dys(j-1)*dys(j)) + 2./(dz1*dz2))
                          if (nrd==0) then
                            ! buffer 0
                            reltmp = omega*(cn1 *(cn2l*p0(i+1,j,k) + &
                                     cn2s*p0(i-1,j,k) +cn3l*p0(i,j+1,k) + &
                                     cn3s*p0(i,j-1,k) +cn4l*p0(i,j,k+1) + &
                                     cn4s*p0(i,j,k-1) -rhs(i,j,k))-p0(i,j,k))
                            p1(i,j,k) = p0(i,j,k) +reltmp
                          else
                              ! buffer 1
                            reltmp = omega*(cn1 *(cn2l*p1(i+1,j,k) + &
                                     cn2s*p1(i-1,j,k) +cn3l*p1(i,j+1,k) + &
                                     cn3s*p1(i,j-1,k) +cn4l*p1(i,j,k+1) + &
                                     cn4s*p1(i,j,k-1) -rhs(i,j,k))-p1(i,j,k))
                            p0(i,j,k) = p1(i,j,k) +reltmp
                          end if

    ! #ifndef NO_GLOBAL_SOR
    !                         sor = sor+reltmp*reltmp
    ! #endif
                        end do
                    end do
                end do
    ! #ifndef NO_BOUNDS_CALCS
    !       ! --computational boundary(neumann condition)
    !           do k=0,kp+1
    !           do j=0,jp+1
    !             p0(0,j,k) = p0(1 ,j,k)
    !             p0(ip+1,j,k) = p0(ip,j,k)
    !           end do
    !           end do
    !           do k=0,kp+1
    !           do i=0,ip+1
    !             p0(i,   0,k) = p0(i,jp,k)
    !             p0(i,jp+1,k) = p0(i, 1,k)
    !           end do
    !           end do
    ! #endif
            end do  ! nrd
    ! #ifndef NO_BOUNDS_CALCS
    ! ! --computational boundary(neumann condition)
    !       do j=0,jp+1
    !       do i=0,ip+1
    !         p0(i,j,   0) = p0(i,j,1)
    !         p0(i,j,kp+1) = p0(i,j,kp)
    !       end do
    !       end do
    ! #endif

    ! #ifndef NO_IO
    ! #ifdef VERBOSE
    ! ! --check
    !         if ((mod(n-1,10) == 0).and.(mod(l,20) == 0)) then
    ! !        if ((mod(n-1,10) == 0)) then
    !             print *, 'time step, iteration step, conv =',n,l,sor
    !         end if
    ! #endif
    ! #endif
    
    ! #ifndef NO_GLOBAL_SOR
    !         if (sor < pjuge) goto 510
    ! #endif
        end do ! l
    ! #ifndef NO_GLOBAL_SOR
    !     510 continue
    ! #endif
    
      end subroutine   