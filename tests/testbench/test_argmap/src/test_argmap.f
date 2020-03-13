      program test_argmap
      integer ia(256) 
      integer is
      parameter(ip=42)
      integer i
      ia(1)=42
      i=1
      is=7
      call test(ia,ia(i),2*is+1,is,ip,43,int(is))
      end program test_argmap

      subroutine test(a1,a2,a3,a4,a5,a6,a7)
      integer a1(256) 
      integer a2,a3,a4,a5,a6,a7
      print *, a1(1),a2,a3,a4,a5,a6,a7
      end subroutine test
