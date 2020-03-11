subroutine predict_loc(un,vn,x,xn,y,yn)
      integer, parameter :: dmax = 1000 
      real, parameter :: dt = 432.000000 
      integer, parameter :: im = 10 
      integer, parameter :: jm = 10 
      integer, parameter :: km = 5 
      real, dimension(1:10,1:10,1:5), intent(Out) :: yn
      real, dimension(1:10,1:10,1:5), intent(In) :: y
      real, dimension(1:10,1:10,1:5), intent(Out) :: xn
      real, dimension(1:10,1:10,1:5), intent(In) :: x
      real, dimension(1:10,1:10,1:5), intent(In) :: vn
      real, dimension(1:10,1:10,1:5), intent(In) :: un
      integer :: k
      integer :: j
      integer :: i
    do i = 1, 10, 1
        do j = 1, 10, 1
            do k = 1, 5, 1
                xn(i,j,k) = x(i,j,k)+432.0*un(i,j,k)/1000
                yn(i,j,k) = y(i,j,k)+432.0*vn(i,j,k)/1000
            end do
        end do
    end do
end subroutine predict_loc
