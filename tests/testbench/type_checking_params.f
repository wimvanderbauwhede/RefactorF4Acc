      program tsp
      
      integer i1
      real ra1,r2
      logical l1,l2
      real rif,iif2
      integer iif, rif2
      logical lif, lif2
      integer i41,ri41
      integer*8 i81,ri81
      real r1,ir1
      real*8 d1,id1

      integer ia1,ia2
      dimension ia1(2,2)
      dimension ia2(4)
      parameter(i41 = 2147483647)
      parameter(i81 = 2147483647*2147483647)
      parameter(r1 = 1e-4)
      parameter(d1 = 1e-8)

      parameter(ri41 = 2147483647)
      parameter(ri81 = 2147483647*2147483647)
      parameter(ir1 = 1e-4)
      parameter(id1 = 1e-8)
      ra1=3.1415e-6
      r2 = rif(ra1) ! type error unless it is a real
      i1 = iif(ra1) ! type error unless it is an integer, the 'i' seems to determine the type!
      i1 = rif2(ra1) ! type error unless it is a real
      r2 = iif2(ra1) ! type error unless it is an integer, the 'i' seems to determine the type!
      l1 = lif(ra1) ! type error
      l2 = lif2(ra1)
      !ia1 = ia2 ! type error 'incompatible ranks'
      ! test slicing
      end 

      function rif(ia1)
         real ia1
         !real iif
         rif = ia1*ia1
      end
     
      function iif(ia1)
         real ia1
         !real rif
         iif = int(ia1*ia1)
      end
      
      real function iif2(ia1)
         real ia1
         iif2 = ia1*ia1
      end
     
      integer function rif2(ia1)
         real ia1
         rif2 = int(ia1*ia1)
      end
      
      function lif(ia1)
         real ia1
         logical lif
         if (ia1<0.0) then
         lif = .true.
         else
         lif = .false.
         end if
      end
      
      logical function lif2(ia1)
         real ia1
         if (ia1<0.0) then
         lif2 = .true.
         else
         lif2 = .false.
         end if
         !return
      end
      
