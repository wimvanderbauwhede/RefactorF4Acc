module singleton_module_stage_kernel_1

contains

subroutine stage_kernel_1(global_id_0,p0_0,rhs_0,p2_1)
 implicit none
 real(kind=4), parameter :: cn1___sor_map_21_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_21_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_21_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_21_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_21_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_21_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_21_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_21_scal=1
 real(kind=4), parameter :: cn1___sor_map_45_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_45_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_45_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_45_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_45_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_45_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_45_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_45_scal=1
 integer :: i___sor_map_45_scal
 integer :: j___sor_map_45_scal
 integer :: k___sor_map_45_scal
 real :: reltmp___sor_map_45_scal
 integer :: i_range___sor_map_45_scal
 integer :: j_range___sor_map_45_scal
 integer :: k_range___sor_map_45_scal
 integer :: i_rel___sor_map_45_scal
 integer :: j_rel___sor_map_45_scal
 integer :: k_rel___sor_map_45_scal
 integer :: i___sor_map_21_scal
 integer :: j___sor_map_21_scal
 integer :: k___sor_map_21_scal
 real :: reltmp___sor_map_21_scal
 integer :: i_range___sor_map_21_scal
 integer :: j_range___sor_map_21_scal
 integer :: k_range___sor_map_21_scal
 integer :: i_rel___sor_map_21_scal
 integer :: j_rel___sor_map_21_scal
 integer :: k_rel___sor_map_21_scal
 integer :: i___f_maps_p2_1_0
 real, dimension(9) :: p1_s_0___f_comp_p2_1_2
 real :: rhs_0___f_comp_p2_1_2
 real, dimension(1:829104368) :: p0_0
 real, dimension(1:829104368) :: rhs_0
 real, dimension(1:829104368) :: p2_1
 integer, dimension(1:9), parameter :: s1=(/ 3003, 9012005, 9012007, 9015006, 9015007, 9015008, &
       9018007, 9018009, 18027011 /)
 real, dimension(1:9,1:9) :: svec_p2_1_3
 integer :: s_idx_1
 integer :: s_idx_2
 real, dimension(1:9) :: svec_p2_1_4
 integer :: global_id_0
 integer :: idx
 idx = global_id_0
!RF4A Begin Inline
 do s_idx_1 = 1,9
 do s_idx_2 = 1,9
 if (idx+s1(s_idx_1)+s1(s_idx_2)>=1 .and. idx+s1(s_idx_1)+s1(s_idx_2)<=829104368) then
 svec_p2_1_3(s_idx_1, s_idx_2) = p0_0(idx+s1(s_idx_1)+s1(s_idx_2))
 else
 svec_p2_1_3(s_idx_1, s_idx_2) = p0_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,9
 if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=829104368) then
 svec_p2_1_4(s_idx_1) = rhs_0(idx+s1(s_idx_1))
 else
 svec_p2_1_4(s_idx_1) = rhs_0(idx)
 end if
 end do
 do i___f_maps_p2_1_0=1,9
 i_range___sor_map_21_scal = ((3001 - 0) + 1)
 j_range___sor_map_21_scal = ((3001 - 0) + 1)
 k_range___sor_map_21_scal = ((91 - 0) + 1)
 i_rel___sor_map_21_scal = (global_id_0 / (j_range___sor_map_21_scal * k_range___sor_map_21_scal))
 i___sor_map_21_scal = (i_rel___sor_map_21_scal + 0)
 j_rel___sor_map_21_scal = ((global_id_0 - (i_rel___sor_map_21_scal * (j_range___sor_map_21_scal *  &
      k_range___sor_map_21_scal))) / k_range___sor_map_21_scal)
 j___sor_map_21_scal = (j_rel___sor_map_21_scal + 0)
 k_rel___sor_map_21_scal = ((global_id_0 - (i_rel___sor_map_21_scal * (j_range___sor_map_21_scal *  &
      k_range___sor_map_21_scal))) - (j_rel___sor_map_21_scal * k_range___sor_map_21_scal))
 k___sor_map_21_scal = (k_rel___sor_map_21_scal + 0)
 if (i___sor_map_21_scal == 150 * 20 + 1) then
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0,3) 
else if ( i___sor_map_21_scal == 0 ) then
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0,7) 
else if ( j___sor_map_21_scal == 150 * 20 + 1 ) then
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0,4) 
else if ( j___sor_map_21_scal == 0 ) then
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0,5) 
 else if ( k___sor_map_21_scal == 0 ) then
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0,5) 
 else if ( k___sor_map_21_scal == 90 + 1 ) then
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0,5) 
 else
 reltmp___sor_map_21_scal = 1.0 * (1.0 / 3.0 * (0.5 * svec_p2_1_3(i___f_maps_p2_1_0, &
      6) + 0.5 * svec_p2_1_3(i___f_maps_p2_1_0,4) + 0.5 * svec_p2_1_3(i___f_maps_p2_1_0, &
      8) + 0.5 * svec_p2_1_3(i___f_maps_p2_1_0,2) + 0.5 * svec_p2_1_3(i___f_maps_p2_1_0, &
      9) + 0.5 * svec_p2_1_3(i___f_maps_p2_1_0, &
      1) - svec_p2_1_4(i___f_maps_p2_1_0)) - svec_p2_1_3(i___f_maps_p2_1_0,5))
 p1_s_0___f_comp_p2_1_2(i___f_maps_p2_1_0) = svec_p2_1_3(i___f_maps_p2_1_0, &
      5) + reltmp___sor_map_21_scal
 end if
 end do
 rhs_0___f_comp_p2_1_2 = rhs_0(idx)
 i_range___sor_map_45_scal = ((3001 - 0) + 1)
 j_range___sor_map_45_scal = ((3001 - 0) + 1)
 k_range___sor_map_45_scal = ((91 - 0) + 1)
 i_rel___sor_map_45_scal = (global_id_0 / (j_range___sor_map_45_scal * k_range___sor_map_45_scal))
 i___sor_map_45_scal = (i_rel___sor_map_45_scal + 0)
 j_rel___sor_map_45_scal = ((global_id_0 - (i_rel___sor_map_45_scal * (j_range___sor_map_45_scal *  &
      k_range___sor_map_45_scal))) / k_range___sor_map_45_scal)
 j___sor_map_45_scal = (j_rel___sor_map_45_scal + 0)
 k_rel___sor_map_45_scal = ((global_id_0 - (i_rel___sor_map_45_scal * (j_range___sor_map_45_scal *  &
      k_range___sor_map_45_scal))) - (j_rel___sor_map_45_scal * k_range___sor_map_45_scal))
 k___sor_map_45_scal = (k_rel___sor_map_45_scal + 0)
 if (i___sor_map_45_scal == 150 * 20 + 1) then
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(3)
else if ( i___sor_map_45_scal == 0 ) then
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(7)
else if ( j___sor_map_45_scal == 150 * 20 + 1 ) then
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(4)
else if ( j___sor_map_45_scal == 0 ) then
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(5)
 else if ( k___sor_map_45_scal == 0 ) then
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(5)
 else if ( k___sor_map_45_scal == 90 + 1 ) then
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(5)
 else
 reltmp___sor_map_45_scal = 1.0 * (1.0 / 3.0 * (0.5 * p1_s_0___f_comp_p2_1_2(6) + 0.5 *  &
      p1_s_0___f_comp_p2_1_2(4) + 0.5 * p1_s_0___f_comp_p2_1_2(8) + 0.5 *  &
      p1_s_0___f_comp_p2_1_2(2) + 0.5 * p1_s_0___f_comp_p2_1_2(9) + 0.5 *  &
      p1_s_0___f_comp_p2_1_2(1) - rhs_0___f_comp_p2_1_2) - p1_s_0___f_comp_p2_1_2(5))
 p2_1(idx) = p1_s_0___f_comp_p2_1_2(5) + reltmp___sor_map_45_scal
 end if
!RF4A End Inline
end subroutine stage_kernel_1

end module singleton_module_stage_kernel_1

