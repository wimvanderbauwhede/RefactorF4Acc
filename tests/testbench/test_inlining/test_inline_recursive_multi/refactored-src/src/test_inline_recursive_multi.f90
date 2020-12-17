      program test_inline_single
      use singleton_module_src_s1
      implicit none
        integer :: v
        integer :: i
!          BEGIN ex-sub decls s1
        integer :: i_s1
!          BEGIN ex-sub decls s2
        integer :: x_s2_s1
!          BEGIN ex-sub decls s3
        integer :: v_n_s3_s2_s1
!          END ex-sub decls s1
!          BEGIN ex-sub decls s1b
        ! integer v_in, v_out
        integer :: v_s1b
        integer :: i_s1b
!          BEGIN ex-sub decls s2b
        integer :: x_s2b_s1b
!          BEGIN ex-sub decls s3b
        integer :: v_n_s3b_s2b_s1b
!          END ex-sub decls s1b
        v=42
        do i=1,4
!ACC Inline
!              BEGIN inlined call to s1
!          END ex-sub decls s2
!         v = v
        do i_s1 = 1,3          
        v = v*2
!          BEGIN inlined call to s2
!          END ex-sub decls s3
        x_s2_s1 = v*v
        v = x_s2_s1/10
!          BEGIN inlined call to s3
        v_n_s3_s2_s1 = 2*42
        v = v_n_s3_s2_s1 + v
        print *,v
!          END inlined call to s3
        print *,v
!          END inlined call to s2
        print *,v
        end do
!              END inlined call to s1
!              BEGIN inlined call to s1b
!          END ex-sub decls s2b
        v_s1b = v
        do i_s1b = 1,3          
        v_s1b = v_s1b*2+i
!          BEGIN inlined call to s2b
!          END ex-sub decls s3b
        x_s2b_s1b = v_s1b*v_s1b
        v_s1b = x_s2b_s1b/10
!          BEGIN inlined call to s3b
        v_n_s3b_s2b_s1b = 2*42
        v_s1b = v_n_s3b_s2b_s1b + v_s1b
        print *,v_s1b
!          END inlined call to s3b
        print *,v_s1b
!          END inlined call to s2b
        print *,v_s1b
        v = v_s1b
        end do
!              END inlined call to s1b
!              BEGIN inlined call to s1
!          END ex-sub decls s2
!         v = v
        do i_s1 = 1,3          
        v = v*2
!          BEGIN inlined call to s2
!          END ex-sub decls s3
        x_s2_s1 = v*v
        v = x_s2_s1/10
!          BEGIN inlined call to s3
        v_n_s3_s2_s1 = 2*42
        v = v_n_s3_s2_s1 + v
        print *,v
!          END inlined call to s3
        print *,v
!          END inlined call to s2
        print *,v
        end do
!              END inlined call to s1
!ACC End Inline
        end do
        print *,v
      end program test_inline_single
