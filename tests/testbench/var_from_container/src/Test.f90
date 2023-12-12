module Test
    implicit none
    integer(kind=2), parameter :: p0=1122
    real(kind=8) :: d0=0.9,d1=1.1
    real(kind=8) :: dd0,dd1(:), dd2(:,:), dd3
    real, parameter :: p1=11.1,p2=22.2
    integer :: w1=3, w2=5, w3, w4=55
    integer :: test_var=43
    integer ::  v1(4,5), v2=5, v3, v4(5)
    character :: ccc
    character(len=8) :: cstr
    contains
    subroutine var_from_container
        test_var = 42
        print *, test_var
    end subroutine var_from_container
end module Test

