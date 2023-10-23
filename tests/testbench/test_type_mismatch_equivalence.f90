! gfortran-mp-8 -Wall test_type_mismatch_equivalence.f90.f90  -o test_type_mismatch_equivalence
      program test_type_mismatch_equivalence
        implicit none
        integer :: v1
        logical :: l1
        real, dimension(5) :: ra1
        integer, dimension(5) :: ia1
        common v1,l1
        v1=42
        l1 = .true.
        ra1(1)=1.1
        ra1(2)=2.2
        ra1(3)=3.3
        ra1(4)=4.4
        ra1(5)=5.5

        ia1(1)=11
        ia1(2)=22
        ia1(3)=33
        ia1(4)=44
        ia1(5)=55
        print *,'p1 v1',v1,'l1',l1
        call s1
        print *,'p1 v1',v1,'l1',l1
        call s2(v1,l1,ra1,ia1)
        print *,'p1 v1',v1,'l1',l1
        
      end program test_type_mismatch_equivalence
      
      subroutine s1
        implicit none
        integer :: vl1
        logical :: lv1
        common lv1,vl1

        print *,'s1 lv1',lv1,'vl1',vl1
        vl1=0
        lv1=.false.

      end subroutine s1      

      subroutine s2(v1,l1,ra1,ia1)
        implicit none
        integer, intent(InOut) :: v1
        logical, intent(InOut) :: l1
        integer :: vl1
        logical :: lv1
        real, dimension(5) :: ra1
        integer, dimension(5) :: ia1
        real, dimension(3) :: ral1
        integer, dimension(3) :: ial1

        ial1 = int(ra1(2:4))
        ral1 = real(ia1(3:5))/10

        print *,'s1 ial1 ',ial1,'ra1',ra1
        print *,'s1 ral1 ',ral1,'ia1',ia1
        
        if (l1) then 
            vl1=1 
        else 
            vl1=0 
        end if        
        lv1 = ( v1 /= 0)

        print *,'s1 lv1',lv1,'vl1',vl1
        vl1=0
        lv1=.false.

        l1 = (vl1 /= 0)
!        v1 = lv1
        if (lv1) then 
            v1=1 
        else 
            v1=0 
        end if  
      end subroutine s2    
