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
    !    print *, nfib
    end subroutine

    !recursive
    subroutine fib_mutual(n,nfib)
        integer, intent(in) :: n
        integer, intent(out) :: nfib
        if (n<1) then
            nfib = 1
        else
            call fib_rec(n,nfib)
        end if
    !    print *, nfib
    end subroutine

    subroutine fib_rec(n,nfib)
        integer, intent(in) :: n
        integer, intent(out) :: nfib
        integer :: nm1, nm2
            call fib_mutual(n-1,nm1)
            call fib_mutual(n-2,nm2)
            nfib = nm1+nm2
    end subroutine

    recursive subroutine loop(idx,hb,in_array,max)
        integer, intent(in) :: idx, hb
        integer, intent(in),dimension(0:9) :: in_array
        integer, intent(inout) :: max
        print *, idx,in_array(idx)
        if (in_array(idx)>max) then
            max = in_array(idx)
        end if
        if (idx<hb) then
            call loop(idx+1,hb,in_array,max)
        end if
        print *, idx, max ! this is a read to max
    end subroutine

end module TestRecursion