module predict_update_device_code
      integer :: predict_vel_predict_loc_un_i_j_k_pipe !$OCL pipe real
      integer :: predict_vel_predict_loc_vn_i_j_k_pipe !$OCL pipe real
      integer :: predict_vel_u_i_j_k_reader_predict_vel_u_i_j_k_pipe !$OCL pipe real
      integer :: predict_vel_un_i_j_k_reader_predict_vel_un_i_j_k_pipe !$OCL pipe real
      integer :: predict_vel_v_i_j_k_reader_predict_vel_v_i_j_k_pipe !$OCL pipe real
      integer :: predict_vel_vn_i_j_k_reader_predict_vel_vn_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_update_loc_vel_un_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_update_loc_vel_vn_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_update_loc_vel_xn_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_update_loc_vel_yn_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_x_i_j_k_reader_predict_loc_x_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_xn_i_j_k_reader_predict_loc_xn_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_y_i_j_k_reader_predict_loc_y_i_j_k_pipe !$OCL pipe real
      integer :: predict_loc_yn_i_j_k_reader_predict_loc_yn_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_update_loc_vel_output_writer_u_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_update_loc_vel_output_writer_v_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_update_loc_vel_output_writer_x_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_update_loc_vel_output_writer_y_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_u_i_j_k_reader_update_loc_vel_u_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_v_i_j_k_reader_update_loc_vel_v_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_x_i_j_k_reader_update_loc_vel_x_i_j_k_pipe !$OCL pipe real
      integer :: update_loc_vel_y_i_j_k_reader_update_loc_vel_y_i_j_k_pipe !$OCL pipe real
contains

subroutine predict_vel_u_i_j_k_reader(u)
      real, dimension(1:10,1:10,1:5) :: u
      real :: u_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                u_i_j_k = u(i,j,k)
                call write_pipe(predict_vel_u_i_j_k_reader_predict_vel_u_i_j_k_pipe, u_i_j_k)
            end do
        end do
    end do
end subroutine predict_vel_u_i_j_k_reader

subroutine predict_vel_un_i_j_k_reader(un)
      real, dimension(1:10,1:10,1:5) :: un
      real :: un_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                un_i_j_k = un(i,j,k)
                call write_pipe(predict_vel_un_i_j_k_reader_predict_vel_un_i_j_k_pipe, un_i_j_k)
            end do
        end do
    end do
end subroutine predict_vel_un_i_j_k_reader

subroutine predict_vel_v_i_j_k_reader(v)
      real, dimension(1:10,1:10,1:5) :: v
      real :: v_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                v_i_j_k = v(i,j,k)
                call write_pipe(predict_vel_v_i_j_k_reader_predict_vel_v_i_j_k_pipe, v_i_j_k)
            end do
        end do
    end do
end subroutine predict_vel_v_i_j_k_reader

subroutine predict_vel_vn_i_j_k_reader(vn)
      real, dimension(1:10,1:10,1:5) :: vn
      real :: vn_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                vn_i_j_k = vn(i,j,k)
                call write_pipe(predict_vel_vn_i_j_k_reader_predict_vel_vn_i_j_k_pipe, vn_i_j_k)
            end do
        end do
    end do
end subroutine predict_vel_vn_i_j_k_reader

subroutine predict_vel
      integer, parameter :: nloop = 499 
      integer :: idx
      integer :: i
      integer :: j
      integer :: k
      real :: u_i_j_k
      real :: un_i_j_k
      real :: v_i_j_k
      real :: vn_i_j_k
    do idx = 0, nloop, 1
        call read_pipe(predict_vel_u_i_j_k_reader_predict_vel_u_i_j_k_pipe, u_i_j_k)
        call read_pipe(predict_vel_un_i_j_k_reader_predict_vel_un_i_j_k_pipe, un_i_j_k)
        call read_pipe(predict_vel_v_i_j_k_reader_predict_vel_v_i_j_k_pipe, v_i_j_k)
        call read_pipe(predict_vel_vn_i_j_k_reader_predict_vel_vn_i_j_k_pipe, vn_i_j_k)
        i = idx/50
        j = mod(idx/5, 10)
        k = mod(idx, 5)
        if ((i>=1) .and. (i<=10) .and. (j>=1) .and. (j<=10) .and. (k>=1) .and. (k<=5)) then
            un_i_j_k = (u_i_j_k*(0.99901307)+-6.283186e-2*v_i_j_k)/(1.0009869)
            vn_i_j_k = (v_i_j_k*(0.99901307)--6.283186e-2*u_i_j_k)/(1.0009869)
        end if
        call write_pipe(predict_vel_predict_loc_un_i_j_k_pipe, un_i_j_k)
        call write_pipe(predict_vel_predict_loc_vn_i_j_k_pipe, vn_i_j_k)
    end do
end subroutine predict_vel

subroutine predict_loc_x_i_j_k_reader(x)
      real, dimension(1:10,1:10,1:5) :: x
      real :: x_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                x_i_j_k = x(i,j,k)
                call write_pipe(predict_loc_x_i_j_k_reader_predict_loc_x_i_j_k_pipe, x_i_j_k)
            end do
        end do
    end do
end subroutine predict_loc_x_i_j_k_reader

subroutine predict_loc_xn_i_j_k_reader(xn)
      real, dimension(1:10,1:10,1:5) :: xn
      real :: xn_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                xn_i_j_k = xn(i,j,k)
                call write_pipe(predict_loc_xn_i_j_k_reader_predict_loc_xn_i_j_k_pipe, xn_i_j_k)
            end do
        end do
    end do
end subroutine predict_loc_xn_i_j_k_reader

subroutine predict_loc_y_i_j_k_reader(y)
      real, dimension(1:10,1:10,1:5) :: y
      real :: y_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                y_i_j_k = y(i,j,k)
                call write_pipe(predict_loc_y_i_j_k_reader_predict_loc_y_i_j_k_pipe, y_i_j_k)
            end do
        end do
    end do
end subroutine predict_loc_y_i_j_k_reader

subroutine predict_loc_yn_i_j_k_reader(yn)
      real, dimension(1:10,1:10,1:5) :: yn
      real :: yn_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                yn_i_j_k = yn(i,j,k)
                call write_pipe(predict_loc_yn_i_j_k_reader_predict_loc_yn_i_j_k_pipe, yn_i_j_k)
            end do
        end do
    end do
end subroutine predict_loc_yn_i_j_k_reader

subroutine predict_loc
      integer, parameter :: nloop = 499 
      integer :: idx
      integer :: i
      integer :: j
      integer :: k
      real :: un_i_j_k
      real :: vn_i_j_k
      real :: x_i_j_k
      real :: xn_i_j_k
      real :: y_i_j_k
      real :: yn_i_j_k
    do idx = 0, nloop, 1
        call read_pipe(predict_vel_predict_loc_un_i_j_k_pipe, un_i_j_k)
        call read_pipe(predict_vel_predict_loc_vn_i_j_k_pipe, vn_i_j_k)
        call read_pipe(predict_loc_x_i_j_k_reader_predict_loc_x_i_j_k_pipe, x_i_j_k)
        call read_pipe(predict_loc_xn_i_j_k_reader_predict_loc_xn_i_j_k_pipe, xn_i_j_k)
        call read_pipe(predict_loc_y_i_j_k_reader_predict_loc_y_i_j_k_pipe, y_i_j_k)
        call read_pipe(predict_loc_yn_i_j_k_reader_predict_loc_yn_i_j_k_pipe, yn_i_j_k)
        i = idx/50
        j = mod(idx/5, 10)
        k = mod(idx, 5)
        if ((i>=1) .and. (i<=10) .and. (j>=1) .and. (j<=10) .and. (k>=1) .and. (k<=5)) then
            xn_i_j_k = x_i_j_k+432.0*un_i_j_k/1000
            yn_i_j_k = y_i_j_k+432.0*vn_i_j_k/1000
        end if
        call write_pipe(predict_loc_update_loc_vel_un_i_j_k_pipe, un_i_j_k)
        call write_pipe(predict_loc_update_loc_vel_vn_i_j_k_pipe, vn_i_j_k)
        call write_pipe(predict_loc_update_loc_vel_xn_i_j_k_pipe, xn_i_j_k)
        call write_pipe(predict_loc_update_loc_vel_yn_i_j_k_pipe, yn_i_j_k)
    end do
end subroutine predict_loc

subroutine update_loc_vel_u_i_j_k_reader(u)
      real, dimension(1:10,1:10,1:5) :: u
      real :: u_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                u_i_j_k = u(i,j,k)
                call write_pipe(update_loc_vel_u_i_j_k_reader_update_loc_vel_u_i_j_k_pipe, u_i_j_k)
            end do
        end do
    end do
end subroutine update_loc_vel_u_i_j_k_reader

subroutine update_loc_vel_v_i_j_k_reader(v)
      real, dimension(1:10,1:10,1:5) :: v
      real :: v_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                v_i_j_k = v(i,j,k)
                call write_pipe(update_loc_vel_v_i_j_k_reader_update_loc_vel_v_i_j_k_pipe, v_i_j_k)
            end do
        end do
    end do
end subroutine update_loc_vel_v_i_j_k_reader

subroutine update_loc_vel_x_i_j_k_reader(x)
      real, dimension(1:10,1:10,1:5) :: x
      real :: x_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                x_i_j_k = x(i,j,k)
                call write_pipe(update_loc_vel_x_i_j_k_reader_update_loc_vel_x_i_j_k_pipe, x_i_j_k)
            end do
        end do
    end do
end subroutine update_loc_vel_x_i_j_k_reader

subroutine update_loc_vel_y_i_j_k_reader(y)
      real, dimension(1:10,1:10,1:5) :: y
      real :: y_i_j_k
      integer :: i
      integer :: j
      integer :: k
    do i = 1, 5, 1
        do j = 1, 10, 1
            do k = 1, 10, 1
                y_i_j_k = y(i,j,k)
                call write_pipe(update_loc_vel_y_i_j_k_reader_update_loc_vel_y_i_j_k_pipe, y_i_j_k)
            end do
        end do
    end do
end subroutine update_loc_vel_y_i_j_k_reader

subroutine update_loc_vel
      integer, parameter :: nloop = 499 
      integer :: idx
      integer :: i
      integer :: j
      integer :: k
      real :: u_i_j_k
      real :: un_i_j_k
      real :: v_i_j_k
      real :: vn_i_j_k
      real :: x_i_j_k
      real :: xn_i_j_k
      real :: y_i_j_k
      real :: yn_i_j_k
    do idx = 0, nloop, 1
        call read_pipe(update_loc_vel_u_i_j_k_reader_update_loc_vel_u_i_j_k_pipe, u_i_j_k)
        call read_pipe(predict_loc_update_loc_vel_un_i_j_k_pipe, un_i_j_k)
        call read_pipe(update_loc_vel_v_i_j_k_reader_update_loc_vel_v_i_j_k_pipe, v_i_j_k)
        call read_pipe(predict_loc_update_loc_vel_vn_i_j_k_pipe, vn_i_j_k)
        call read_pipe(update_loc_vel_x_i_j_k_reader_update_loc_vel_x_i_j_k_pipe, x_i_j_k)
        call read_pipe(predict_loc_update_loc_vel_xn_i_j_k_pipe, xn_i_j_k)
        call read_pipe(update_loc_vel_y_i_j_k_reader_update_loc_vel_y_i_j_k_pipe, y_i_j_k)
        call read_pipe(predict_loc_update_loc_vel_yn_i_j_k_pipe, yn_i_j_k)
        i = idx/50
        j = mod(idx/5, 10)
        k = mod(idx, 5)
        if ((i>=1) .and. (i<=10) .and. (j>=1) .and. (j<=10) .and. (k>=1) .and. (k<=5)) then
            u_i_j_k = un_i_j_k
            v_i_j_k = vn_i_j_k
            x_i_j_k = xn_i_j_k
            y_i_j_k = yn_i_j_k
        end if
        call write_pipe(update_loc_vel_update_loc_vel_output_writer_u_i_j_k_pipe, u_i_j_k)
        call write_pipe(update_loc_vel_update_loc_vel_output_writer_v_i_j_k_pipe, v_i_j_k)
        call write_pipe(update_loc_vel_update_loc_vel_output_writer_x_i_j_k_pipe, x_i_j_k)
        call write_pipe(update_loc_vel_update_loc_vel_output_writer_y_i_j_k_pipe, y_i_j_k)
    end do
end subroutine update_loc_vel

subroutine update_loc_vel_output_writer(u,v,x,y)
      real :: u_i_j_k_read_in
      real, dimension(1:10,1:10,1:5) :: u
      real :: v_i_j_k_read_in
      real, dimension(1:10,1:10,1:5) :: v
      real :: x_i_j_k_read_in
      real, dimension(1:10,1:10,1:5) :: x
      real :: y_i_j_k_read_in
      real, dimension(1:10,1:10,1:5) :: y
      integer :: a
      integer :: b
      integer :: c
    do a = 1, 5, 1
        do b = 1, 10, 1
            do c = 1, 10, 1
                call read_pipe(update_loc_vel_update_loc_vel_output_writer_u_i_j_k_pipe, u_i_j_k_read_in)
                u(a,b,c) = u_i_j_k_read_in
                call read_pipe(update_loc_vel_update_loc_vel_output_writer_v_i_j_k_pipe, v_i_j_k_read_in)
                v(a,b,c) = v_i_j_k_read_in
                call read_pipe(update_loc_vel_update_loc_vel_output_writer_x_i_j_k_pipe, x_i_j_k_read_in)
                x(a,b,c) = x_i_j_k_read_in
                call read_pipe(update_loc_vel_update_loc_vel_output_writer_y_i_j_k_pipe, y_i_j_k_read_in)
                y(a,b,c) = y_i_j_k_read_in
            end do
        end do
    end do
end subroutine update_loc_vel_output_writer

end module predict_update_device_code
