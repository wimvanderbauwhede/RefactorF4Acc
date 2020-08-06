! gfortran -Wall test_equivalence.f  -o test_equivalence
! test for equivalence with incorrect types
      program test_equivalence
        implicit integer (i,v)
        dimension vb2(8)
        logical l2(8)
        double precision d1(4)

        real*4 r1(8)
        ! not type safe, in fact plain wrong
        equivalence (vb2,d1)
        equivalence (vb2,r1)
        ! This is OK
        equivalence (vb2,l2)
        equivalence (r1,l2)
        do i = 1,8
        vb2(i) = i-2
        end do

        do i = 1,4
        print *, d1(i)
        end do

        do i = 1,8
        print *, r1(i)
        r1(i) = i
        end do

        do i = 1,8
        print *, vb2(i)
        end do

        do i = 1,8
        vb2(i) = i-2
        print *, vb2(i),l2(i)
        end do

        do i = 1,8
        print *, r1(i)
        r1(i) = i
        end do

      end program test_equivalence
      
