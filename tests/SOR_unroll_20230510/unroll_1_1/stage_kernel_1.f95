module singleton_module_stage_kernel_1

contains

subroutine stage_kernel_1(global_id_0,p0_0,rhs_0,p1_1)
 implicit none
 real(kind=4), parameter :: cn1___sor_map_20_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_20_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_20_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_20_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_20_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_20_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_20_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_20_scal=1
 integer :: i___sor_map_20_scal
 integer :: j___sor_map_20_scal
 integer :: k___sor_map_20_scal
 real :: reltmp___sor_map_20_scal
 integer :: i_range___sor_map_20_scal
 integer :: j_range___sor_map_20_scal
 integer :: k_range___sor_map_20_scal
 integer :: i_rel___sor_map_20_scal
 integer :: j_rel___sor_map_20_scal
 integer :: k_rel___sor_map_20_scal
 real, dimension(1:2125568) :: p0_0
 real, dimension(1:2125568) :: rhs_0
 real, dimension(1:2125568) :: p1_1
 integer, dimension(1:9), parameter :: s1=(/ 153, 23105, 23107, 23256, 23257, 23258, 23407, 23409, &
       46361 /)
 real, dimension(1:9) :: p0_s_0
 integer :: s_idx_1
 integer :: global_id_0
 integer :: idx
 idx = global_id_0
!RF4A Begin Inline
 do s_idx_1 = 1,9
 if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=2125568) then
 p0_s_0(s_idx_1) = p0_0(idx+s1(s_idx_1))
 else
 p0_s_0(s_idx_1) = p0_0(idx)
 end if
 end do
 i_range___sor_map_20_scal = ((151 - 0) + 1)
 j_range___sor_map_20_scal = ((151 - 0) + 1)
 k_range___sor_map_20_scal = ((91 - 0) + 1)
 i_rel___sor_map_20_scal = (global_id_0 / (j_range___sor_map_20_scal * k_range___sor_map_20_scal))
 i___sor_map_20_scal = (i_rel___sor_map_20_scal + 0)
 j_rel___sor_map_20_scal = ((global_id_0 - (i_rel___sor_map_20_scal * (j_range___sor_map_20_scal *  &
      k_range___sor_map_20_scal))) / k_range___sor_map_20_scal)
 j___sor_map_20_scal = (j_rel___sor_map_20_scal + 0)
 k_rel___sor_map_20_scal = ((global_id_0 - (i_rel___sor_map_20_scal * (j_range___sor_map_20_scal *  &
      k_range___sor_map_20_scal))) - (j_rel___sor_map_20_scal * k_range___sor_map_20_scal))
 k___sor_map_20_scal = (k_rel___sor_map_20_scal + 0)
 if (i___sor_map_20_scal == 150 * 1 + 1) then
 p1_1(idx) = p0_s_0(3)
else if ( i___sor_map_20_scal == 0 ) then
 p1_1(idx) = p0_s_0(7)
else if ( j___sor_map_20_scal == 150 * 1 + 1 ) then
 p1_1(idx) = p0_s_0(4)
else if ( j___sor_map_20_scal == 0 ) then
 p1_1(idx) = p0_s_0(5)
 else if ( k___sor_map_20_scal == 0 ) then
 p1_1(idx) = p0_s_0(5)
 else if ( k___sor_map_20_scal == 90 + 1 ) then
 p1_1(idx) = p0_s_0(5)
 else
 reltmp___sor_map_20_scal = 1.0 * (1.0 / 3.0 * (0.5 * p0_s_0(6) + 0.5 * p0_s_0(4) + 0.5 * p0_s_0(8)  &
      + 0.5 * p0_s_0(2) + 0.5 * p0_s_0(9) + 0.5 * p0_s_0(1) - rhs_0(idx)) - p0_s_0(5))
 p1_1(idx) = p0_s_0(5) + reltmp___sor_map_20_scal
 end if
!RF4A End Inline
end subroutine stage_kernel_1

end module singleton_module_stage_kernel_1

