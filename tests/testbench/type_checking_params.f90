      program tsp
      implicit none
      integer :: i1
      real :: ra1,r2
      logical :: l1,l2
      ! Even in F90 this is necessary!
      real :: rif,iif2
      integer :: iif, rif2
      logical :: lif, lif2

      integer, parameter :: i41 = 2147483647
      integer(kind=8), parameter :: i81 = 2147483647*2147483647
      real, parameter :: r1 = 1e-4
      double precision, parameter :: d1 = 1e-8

      integer, parameter :: ri41 = 2147483647
      integer(kind=8), parameter :: ri81 = 2147483647*2147483647
      real, parameter :: ir1 = 1e-4
      real (kind=8), parameter :: id1 = 1e-8
      ra1=3.1415e-6
      r2 = rif(ra1) ! type error unless it is a real
      i1 = iif(ra1) ! type error unless it is an integer, the 'i' seems to determine the type!
      i1 = rif2(ra1) ! type error unless it is a real
      r2 = iif2(ra1) ! type error unless it is an integer, the 'i' seems to determine the type!
      l1 = lif(ra1) ! type error
      l2 = lif2(ra1)


      end 

      real function rif(ia1)
         real, intent(in) :: ia1
         rif = ia1*ia1
      end
     
      integer function iif(ia1)
         real, intent(in) :: ia1
         iif = int(ia1*ia1)
      end
      
      real function iif2(ia1)
         real, intent(in) :: ia1
         iif2 = ia1*ia1
      end
     
      integer function rif2(ia1)
         real, intent(in) :: ia1
         rif2 = int(ia1*ia1)
      end
      
      logical function lif(ia1)
         real, intent(in) :: ia1
         if (ia1<0.0) then
         lif = .true.
         else
         lif = .false.
         end if
      end
      
      logical function lif2(ia1)
         real, intent(in) :: ia1
         if (ia1<0.0) then
         lif2 = .true.
         else
         lif2 = .false.
         end if
      end
      
