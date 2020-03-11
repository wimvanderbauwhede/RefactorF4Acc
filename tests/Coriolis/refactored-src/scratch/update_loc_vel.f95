subroutine update_loc_vel(u,un,v,vn,x,xn,y,yn)
      integer, parameter :: im = 10 
      integer, parameter :: jm = 10 
      integer, parameter :: km = 5 
      real, dimension(1:10,1:10,1:5), intent(In) :: yn
      real, dimension(1:10,1:10,1:5), intent(Out) :: y
      real, dimension(1:10,1:10,1:5), intent(In) :: xn
      real, dimension(1:10,1:10,1:5), intent(Out) :: x
      real, dimension(1:10,1:10,1:5), intent(In) :: vn
      real, dimension(1:10,1:10,1:5), intent(Out) :: v
      real, dimension(1:10,1:10,1:5), intent(In) :: un
      real, dimension(1:10,1:10,1:5), intent(Out) :: u
      integer :: k
      integer :: j
      integer :: i
    do i = 1, 10, 1
        do j = 1, 10, 1
            do k = 1, 5, 1
                u(i,j,k) = un(i,j,k)
                v(i,j,k) = vn(i,j,k)
                x(i,j,k) = xn(i,j,k)
                y(i,j,k) = yn(i,j,k)
            end do
        end do
    end do
end subroutine update_loc_vel
