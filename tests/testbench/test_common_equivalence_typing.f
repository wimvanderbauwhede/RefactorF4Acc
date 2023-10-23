! gfortran -Wall test_common_equivalence.f  -o test_common_equivalence
! test for common and equiv with incorrect types
      program test_common_equivalence
        implicit integer (i,v)
        integer i, ivb3
        dimension  v1(0:7)
        dimension  v2(4),v3(4)
        dimension vb2(8)
        common v1
        common /b2/ vb2
        common ivb3(8)
        real r1, r2
        integer i1, i2
        logical l1,l2
        common r1,i1
        equivalence (v1,v2),(v1(4),v3)  ! v1 is the same as v1(0)
        equivalence (r1,i2),(i1,r2)  
        equivalence (l1,i2),(i1,l2)  
        i1 = 42
        r1 = .42e17
        print *, 'i1',i1,'r1',r1
        print *, 'i2',i2,'r2',r2
        print *, 'l1',l1,'l2',l2
        i1=0
        i2=0
        print *, 'i1',i1,'r1',r1
        print *, 'i2',i2,'r2',r2
        print *, 'l1',l1,'l2',l2

        do i=1,8
            v1(i-1)=i
            vb2(i)=11*i
!            print *,'pp ','v1',i,'vb2',11*i
        end do  

!        do i=1,4
!            print *,'p ','v2',v2(i),'v3',v3(i)
!        end do  
        i1 = 42
        r1 = .42e17

        call s1

!       do i=1,8      
!            print *,'p ','ivb3',ivb3(i)
!        end do

        call s2

      end program test_common_equivalence
      
      subroutine s1
        implicit integer (i,v)
        integer  i, ivb3
        dimension  vs1(4),vs2(4)
        dimension vs4(4)
        dimension  vs6(2)
        integer  vs3,vs5
        common vs1,vs2
        common /b2/ vs3,vs4,vs5,vs6
        common ivb3(8) 
        common i1,r1
        real r2
        integer i2
        equivalence(r2,i1)
        equivalence(i2,r1)
        ! i1 and r1 are swapped and both wrong
        print *, 'i1',i1,'r1',r1
        ! r2 is correct
        print *, 'i1',i1,'r2',r2
        ! i2 is correct
        print *, 'r1',r1,'i2',i2
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
        integer  i, ivb3
        common ivb3(24) ! the extended portion can be accessed here
!        do i=1,24
!            print *,'s2',ivb3(i)
!        end do  

      end subroutine s2    
