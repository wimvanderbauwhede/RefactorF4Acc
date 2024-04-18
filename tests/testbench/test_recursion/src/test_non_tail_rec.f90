program test
    use TestRecursion
    integer :: nfib, max, ii
    integer,dimension(0:9) :: in_array

    nfib = 0
    call fib(5,nfib)
    print *, nfib
    nfib = 0
    call fib_mutual(5,nfib)
    print *, nfib

    do ii = 0,9
        in_array(ii) = mod(100 - 2*ii,13)
    end do
    max=0
    call loop(0,9,in_array,max)
    print *, max
end program test
