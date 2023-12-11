module Test
    implicit none
    integer :: test_var=43
    contains
    subroutine var_from_container
        test_var = 42
        print *, test_var
    end subroutine var_from_container
end module Test

