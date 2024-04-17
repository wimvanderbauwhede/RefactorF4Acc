program test
	use TestRecursion
    integer :: nfib
    nfib = 0
    call fib(5,nfib)
    print *, nfib
    nfib = 0
    call fib_mutual(5,nfib)
    print *, nfib

end program test
