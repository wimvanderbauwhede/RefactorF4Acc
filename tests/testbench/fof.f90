program fof
    external :: sqsum
    external :: f2
    integer :: z
    call ten_times(sqsum,3,4,z)
    print *,z
    
end program fof

subroutine ten_times(f3,x,y,z)
    integer :: f3 ! for a function
    !external :: f3 ! for a subroutine but not needed
    integer, intent(In) :: x,y
    integer, intent(Out) :: z
    
    !call f3(x,y,z)
    z = f3(x,y)
    !print *,z
end subroutine ten_times

subroutine f2(x,y,z)
    integer, intent(In) :: x,y
    integer, intent(Out) :: z
    z = x*x+y*y
end subroutine f2

integer function sqsum(x,y)
	integer, intent(In) :: x,y
	sqsum = x*x+y*y
	!print *,sqsum
end function sqsum

