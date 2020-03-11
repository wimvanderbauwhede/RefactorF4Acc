      program test_argmap
      integer(256) ia
      integer is
      parameter ip=42
      integer i
      i=0
      call test(ia,ia(i),2*is+1,is,ip,43)
      end program test_argmap

      subroutine test(a1,a2,a3,a4,a5,a6)
      integer(256) a1
      integer a2,a3,a4,a5,a6
      end subroutine test
