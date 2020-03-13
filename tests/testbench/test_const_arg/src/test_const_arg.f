	program test_const_args
		real dragpx, w1
		parameter(maxobj=41)
		dragpx=1.1
		w1=22
		call f1
		call gop(dragpx,w1,'+  ',maxobj+1)

	end program test_const_args

	subroutine f1
		real av(256)
		integer asz
		parameter(nelts=257)
		av(1)=33
		av(256)=44
		asz = nelts -1 
		call f2(av, asz)
	end subroutine f1

	subroutine f2(av, asz)
		integer asz
		real av(asz)
		print *, av(1),av(256)
	end subroutine f2

	subroutine gop( x, w, op, n)
		real x,w
		character(3) op
		integer n
		print *, x, w, op, n
	end subroutine gop
