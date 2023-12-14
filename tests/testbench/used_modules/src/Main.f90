module Main
    use Helper
    implicit none
    contains
    subroutine mainSub
        rv=rv*rb
        call helperSub
    end subroutine mainSub
end module Main
