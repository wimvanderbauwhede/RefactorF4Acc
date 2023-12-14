module State
    use Constants, only: ia
    implicit none
    logical, parameter :: hasState = .true.
    integer, dimension (1:ia) :: iarr
    real :: rv = 10.0
end module State
