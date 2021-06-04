! gfortran test_return_to_array_elt.f90
program testReturnToArrayElt
    integer, dimension(16) :: v
    integer i, n
    v=0
    n=1
    do i=1,4    
        call square(n,v(n))
        call square(n,v(i))
        n=n*2
    end do
    print *,v
end program testReturnToArrayElt

subroutine square(x_in,x_out)
    integer, intent(in) :: x_in
    integer, intent(out) :: x_out
    x_out = x_in*x_in
end subroutine square    
    
