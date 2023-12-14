module Helper
    use Constants
    use State
    implicit none

    contains
    subroutine helperSub
        print *, 'helper', ia, rv
    end subroutine helperSub
end module Helper
