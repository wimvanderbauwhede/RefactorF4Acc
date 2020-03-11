      program test1
      include 'incl1.inc'

      integer vs
      dimension vs(nelts)

      integer t

      call sub1(vs)
      print *, 'INIT DONE'
      do t=1,nsteps
          call sub2(vs)
          call sub3(vs)
      end do

      print *, sum(vs)

      end
