! gfortran-mp-8 -Wall test_common_equivalence.f  -o test_common_equivalence
      program test_common_equivalence
        implicit integer (i,v)
        integer i, ivb3
        dimension  v1(0:7)
        dimension  v2(4),v3(4)
        dimension vb2(8)
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
        common ivb3(16) ! This does extend the blank block 
        ! but the extended portion can't be accessed in the program

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
        do i=1,24
            print *,'s2',ivb3(i)
        end do  

      end subroutine s2    
