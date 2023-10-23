      program test1
      include 'incl1.inc'

      integer vs
      dimension vs(nelts)

      integer t
      vs=0
      state=0
      call sub1(vs)
      
      print *, 'INIT DONE'
      print *,state
      
      do t=1,nsteps ! 8
          call sub2(vs)
          call sub3(vs)
      end do

      print *, sum(vs)

      end
