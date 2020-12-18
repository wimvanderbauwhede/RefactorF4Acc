module singleton_module_src_s3

contains

      subroutine s3(n,v_inout)
      implicit none
        integer, intent(In) :: n
        integer :: v_inout
        integer :: v_n_s3
        v_n_s3 = 2+n
        v_inout = v_n_s3 + v_inout
        print *,v_inout
      end subroutine s3

end module singleton_module_src_s3

