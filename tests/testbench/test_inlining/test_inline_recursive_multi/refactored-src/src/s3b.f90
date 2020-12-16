module singleton_module_src_s3b

contains

      subroutine s3b(n,v_inout)
      implicit none
        integer, intent(In) :: n
        integer :: v_inout
        integer :: v_n_s3b
        v_n_s3b = 2*n
        v_inout = v_n_s3b + v_inout
        print *,v_inout
      end subroutine s3b

end module singleton_module_src_s3b

