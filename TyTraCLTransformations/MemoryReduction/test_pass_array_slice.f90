! $gfortran-mp-10 -L/usr/lib test_pass_array_slice.f90
program testPassArraySlice
integer, dimension(4,4) :: v_s_i
integer, dimension(4) :: v_o
integer :: i,j, n

    do i=1,4
    do j=1,4
        v_s_i(i,j)=i-1+4*(j-1)
!        print *,v_s_i(i,j)a
    end do
        print *,v_s_i(i,:)
    end do
    
    n=1

    do i=1,4
      call f(v_s_i(i,:),v_o(i))
    end do


    print *, v_o;
end program testPassArraySlice

subroutine f(x_in, x_out) 
    integer, dimension(4) :: x_in
    integer :: x_out, res, i
    res=0
    do i=1,4
         res = res +  x_in(i)
    end do
    x_out = res;
end subroutine f 
