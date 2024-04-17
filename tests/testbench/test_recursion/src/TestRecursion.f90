module TestRecursion
	contains

	recursive subroutine fib(n,nfib)
		integer, intent(in) :: n
		integer, intent(out) :: nfib
		integer :: nm1, nm2
		if (n<1) then 
			nfib = 1
		else
			call fib(n-1,nm1)
			call fib(n-2,nm2)
			nfib = nm1+nm2
		end if
	!	print *, nfib
	end subroutine

	!recursive 
	subroutine fib_mutual(n,nfib)
		integer, intent(in) :: n
		integer, intent(out) :: nfib
		integer :: nm1, nm2
		if (n<1) then 
			nfib = 1
		else
			call fib_rec(n,nfib)
		end if
	!	print *, nfib
	end subroutine

	subroutine fib_rec(n,nfib)
		integer, intent(in) :: n
		integer, intent(out) :: nfib
		integer :: nm1, nm2
			call fib_mutual(n-1,nm1)
			call fib_mutual(n-2,nm2)
			nfib = nm1+nm2
	end subroutine

end module TestRecursion