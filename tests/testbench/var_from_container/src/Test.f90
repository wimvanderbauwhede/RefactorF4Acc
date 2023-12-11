module Test
    implicit none
!    real(kind=8) :: dd0(:)
    real(kind=8) :: dd1(:), dd2(:,:), dd3
    integer, parameter :: p0=1122
    integer, parameter :: p1=11,p2=22
    integer :: test_var=43
    integer :: v1(4,5)=3, v2=5, v3, v4(5)
    integer :: w1=3, w2=5, w3, w4=55

    contains
    subroutine var_from_container
        test_var = 42
        print *, test_var
    end subroutine var_from_container
end module Test

