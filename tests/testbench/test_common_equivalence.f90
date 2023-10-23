! gfortran -Wall test_common_equivalence.f90  -o test_common_equivalence
      program test_common_equivalence
        implicit none
        integer i, ivb3
        integer, dimension(0:7) :: v1
        integer, dimension(1:4) :: v2,v3
        integer, dimension(1:8) :: vb2
        common v1
        common /b2/ vb2
        common ivb3(8)

        equivalence (v1,v2),(v1(4),v3)  ! v1 is the same as v1(0)

        do i=1,8
            v1(i-1)=i
            vb2(i)=11*i
            print *,'pp ','v1',i,'vb2',11*i
        end do  

        do i=1,4
            print *,'p ','v2',v2(i),'v3',v3(i)
        end do  

        call s1

        do i=1,8      
            print *,'p ','ivb3',ivb3(i)
        end do

        do i=1,8      
            print *,'p ','ivb3',ivb3(i+8)
        end do

        call s2

      end program test_common_equivalence
      
      subroutine s1
        implicit none
        integer :: i, ivb3
        integer, dimension(1:4) :: vs1,vs2
        integer, dimension(1:4) :: vs4
        integer, dimension(1:2) :: vs6
        integer :: vs3,vs5
        common vs1,vs2
        common /b2/ vs3,vs4,vs5,vs6
        common ivb3(16) ! This does extend the blank block 
        ! the extended portion can be accessed in the program
        ! even though there is an out-of-bounds warning 

        print *,'s',vs3,vs5,vs6
        do i=1,4
            print *,'s',vs1(i),vs2(i),vs4(i)
        end do  
        do i=1,16
            ivb3(17-i)=i
        end do  
        print *,'s',ivb3(16)

      end subroutine s1      

      subroutine s2
        implicit none
        integer :: i, ivb3
        common ivb3(24) ! the extended portion can be accessed here
        do i=1,24
            print *,'s2',ivb3(i)
        end do  

      end subroutine s2    
