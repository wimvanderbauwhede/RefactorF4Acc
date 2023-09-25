module singleton_module_stage_kernel_1

contains

subroutine stage_kernel_1(global_id_0,p0_0,rhs_0,p3_1)
 implicit none
 real(kind=4), parameter :: cn1___sor_map_22_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_22_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_22_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_22_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_22_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_22_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_22_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_22_scal=1
 real(kind=4), parameter :: cn1___sor_map_46_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_46_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_46_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_46_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_46_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_46_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_46_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_46_scal=1
 real(kind=4), parameter :: cn1___sor_map_70_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_70_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_70_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_70_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_70_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_70_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_70_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_70_scal=1
 integer :: i___sor_map_70_scal
 integer :: j___sor_map_70_scal
 integer :: k___sor_map_70_scal
 real :: reltmp___sor_map_70_scal
 integer :: i_range___sor_map_70_scal
 integer :: j_range___sor_map_70_scal
 integer :: k_range___sor_map_70_scal
 integer :: i_rel___sor_map_70_scal
 integer :: j_rel___sor_map_70_scal
 integer :: k_rel___sor_map_70_scal
 integer :: i___sor_map_46_scal
 integer :: j___sor_map_46_scal
 integer :: k___sor_map_46_scal
 real :: reltmp___sor_map_46_scal
 integer :: i_range___sor_map_46_scal
 integer :: j_range___sor_map_46_scal
 integer :: k_range___sor_map_46_scal
 integer :: i_rel___sor_map_46_scal
 integer :: j_rel___sor_map_46_scal
 integer :: k_rel___sor_map_46_scal
 integer :: i___f_maps_p3_1_0
 integer :: i___sor_map_22_scal
 integer :: j___sor_map_22_scal
 integer :: k___sor_map_22_scal
 real :: reltmp___sor_map_22_scal
 integer :: i_range___sor_map_22_scal
 integer :: j_range___sor_map_22_scal
 integer :: k_range___sor_map_22_scal
 integer :: i_rel___sor_map_22_scal
 integer :: j_rel___sor_map_22_scal
 integer :: k_rel___sor_map_22_scal
 integer :: i___f_maps_p3_1_1
 integer :: i___f_maps_p3_1_3
 real, dimension(9 , 9) :: sv_p1_s_0_in___f_comp_p3_1_4
 real, dimension(9) :: sv_rhs_0_in___f_comp_p3_1_4
 real, dimension(9) :: p2_s_0___f_comp_p3_1_6
 real :: rhs_0___f_comp_p3_1_6
 real, dimension(1:2125568) :: p0_0
 real, dimension(1:2125568) :: rhs_0
 real, dimension(1:2125568) :: p3_1
 integer, dimension(1:9), parameter :: s1=(/ 153, 23105, 23107, 23256, 23257, 23258, 23407, 23409, &
       46361 /)
 real, dimension(1:9,1:9,1:9) :: svec_p3_1_7
 integer :: s_idx_1
 integer :: s_idx_2
 integer :: s_idx_3
 real, dimension(1:9,1:9) :: svec_p3_1_8
 real, dimension(1:9) :: svec_p3_1_9
 integer :: global_id_0
 integer :: idx
 idx = global_id_0
!RF4A Begin Inline
 do s_idx_1 = 1,9
 do s_idx_2 = 1,9
 do s_idx_3 = 1,9
 if (idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)>=1 .and.  &
      idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)<=2125568) then
 svec_p3_1_7(s_idx_1, s_idx_2, s_idx_3) = p0_0(idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3))
 else
 svec_p3_1_7(s_idx_1, s_idx_2, s_idx_3) = p0_0(idx)
 end if
 end do
 end do
 end do
 do s_idx_1 = 1,9
 do s_idx_2 = 1,9
 if (idx+s1(s_idx_1)+s1(s_idx_2)>=1 .and. idx+s1(s_idx_1)+s1(s_idx_2)<=2125568) then
 svec_p3_1_8(s_idx_1, s_idx_2) = rhs_0(idx+s1(s_idx_1)+s1(s_idx_2))
 else
 svec_p3_1_8(s_idx_1, s_idx_2) = rhs_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,9
 if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=2125568) then
 svec_p3_1_9(s_idx_1) = rhs_0(idx+s1(s_idx_1))
 else
 svec_p3_1_9(s_idx_1) = rhs_0(idx)
 end if
 end do
 do i___f_maps_p3_1_3=1,9
 do i___f_maps_p3_1_1=1,9
 i_range___sor_map_22_scal = ((151 - 0) + 1)
 j_range___sor_map_22_scal = ((151 - 0) + 1)
 k_range___sor_map_22_scal = ((91 - 0) + 1)
 i_rel___sor_map_22_scal = (global_id_0 / (j_range___sor_map_22_scal * k_range___sor_map_22_scal))
 i___sor_map_22_scal = (i_rel___sor_map_22_scal + 0)
 j_rel___sor_map_22_scal = ((global_id_0 - (i_rel___sor_map_22_scal * (j_range___sor_map_22_scal *  &
      k_range___sor_map_22_scal))) / k_range___sor_map_22_scal)
 j___sor_map_22_scal = (j_rel___sor_map_22_scal + 0)
 k_rel___sor_map_22_scal = ((global_id_0 - (i_rel___sor_map_22_scal * (j_range___sor_map_22_scal *  &
      k_range___sor_map_22_scal))) - (j_rel___sor_map_22_scal * k_range___sor_map_22_scal))
 k___sor_map_22_scal = (k_rel___sor_map_22_scal + 0)
 if (i___sor_map_22_scal == 150 * 1 + 1) then
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,3)
else if ( i___sor_map_22_scal == 0 ) then
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,7)
else if ( j___sor_map_22_scal == 150 * 1 + 1 ) then
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,4)
else if ( j___sor_map_22_scal == 0 ) then
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,5)
 else if ( k___sor_map_22_scal == 0 ) then
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,5)
 else if ( k___sor_map_22_scal == 90 + 1 ) then
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,5)
 else
 reltmp___sor_map_22_scal = 1.0 * (1.0 / 3.0 * (0.5 * svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,6) + 0.5 * svec_p3_1_7(i___f_maps_p3_1_3,i___f_maps_p3_1_1, &
      4) + 0.5 * svec_p3_1_7(i___f_maps_p3_1_3,i___f_maps_p3_1_1, &
      8) + 0.5 * svec_p3_1_7(i___f_maps_p3_1_3,i___f_maps_p3_1_1, &
      2) + 0.5 * svec_p3_1_7(i___f_maps_p3_1_3,i___f_maps_p3_1_1, &
      9) + 0.5 * svec_p3_1_7(i___f_maps_p3_1_3,i___f_maps_p3_1_1, &
      1) - svec_p3_1_8(i___f_maps_p3_1_3,i___f_maps_p3_1_1)) - svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,5))
 sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3,i___f_maps_p3_1_1) = svec_p3_1_7(i___f_maps_p3_1_3, &
      i___f_maps_p3_1_1,5) + reltmp___sor_map_22_scal
 end if
 end do
 sv_rhs_0_in___f_comp_p3_1_4(i___f_maps_p3_1_3) = svec_p3_1_9(i___f_maps_p3_1_3)
 end do
 do i___f_maps_p3_1_0=1,9
 i_range___sor_map_46_scal = ((151 - 0) + 1)
 j_range___sor_map_46_scal = ((151 - 0) + 1)
 k_range___sor_map_46_scal = ((91 - 0) + 1)
 i_rel___sor_map_46_scal = (global_id_0 / (j_range___sor_map_46_scal * k_range___sor_map_46_scal))
 i___sor_map_46_scal = (i_rel___sor_map_46_scal + 0)
 j_rel___sor_map_46_scal = ((global_id_0 - (i_rel___sor_map_46_scal * (j_range___sor_map_46_scal *  &
      k_range___sor_map_46_scal))) / k_range___sor_map_46_scal)
 j___sor_map_46_scal = (j_rel___sor_map_46_scal + 0)
 k_rel___sor_map_46_scal = ((global_id_0 - (i_rel___sor_map_46_scal * (j_range___sor_map_46_scal *  &
      k_range___sor_map_46_scal))) - (j_rel___sor_map_46_scal * k_range___sor_map_46_scal))
 k___sor_map_46_scal = (k_rel___sor_map_46_scal + 0)
 if (i___sor_map_46_scal == 150 * 1 + 1) then
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,3) 
else if ( i___sor_map_46_scal == 0 ) then
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,7) 
else if ( j___sor_map_46_scal == 150 * 1 + 1 ) then
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,4) 
else if ( j___sor_map_46_scal == 0 ) then
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,5) 
 else if ( k___sor_map_46_scal == 0 ) then
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,5) 
 else if ( k___sor_map_46_scal == 90 + 1 ) then
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,5) 
 else
 reltmp___sor_map_46_scal = 1.0 * (1.0 / 3.0 * (0.5 *  &
      sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      6) + 0.5 * sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      4) + 0.5 * sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      8) + 0.5 * sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      2) + 0.5 * sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      9) + 0.5 * sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      1) - sv_rhs_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0)) -  &
      sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0,5))
 p2_s_0___f_comp_p3_1_6(i___f_maps_p3_1_0) = sv_p1_s_0_in___f_comp_p3_1_4(i___f_maps_p3_1_0, &
      5) + reltmp___sor_map_46_scal
 end if
 end do
 rhs_0___f_comp_p3_1_6 = rhs_0(idx)
 i_range___sor_map_70_scal = ((151 - 0) + 1)
 j_range___sor_map_70_scal = ((151 - 0) + 1)
 k_range___sor_map_70_scal = ((91 - 0) + 1)
 i_rel___sor_map_70_scal = (global_id_0 / (j_range___sor_map_70_scal * k_range___sor_map_70_scal))
 i___sor_map_70_scal = (i_rel___sor_map_70_scal + 0)
 j_rel___sor_map_70_scal = ((global_id_0 - (i_rel___sor_map_70_scal * (j_range___sor_map_70_scal *  &
      k_range___sor_map_70_scal))) / k_range___sor_map_70_scal)
 j___sor_map_70_scal = (j_rel___sor_map_70_scal + 0)
 k_rel___sor_map_70_scal = ((global_id_0 - (i_rel___sor_map_70_scal * (j_range___sor_map_70_scal *  &
      k_range___sor_map_70_scal))) - (j_rel___sor_map_70_scal * k_range___sor_map_70_scal))
 k___sor_map_70_scal = (k_rel___sor_map_70_scal + 0)
 if (i___sor_map_70_scal == 150 * 1 + 1) then
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(3)
else if ( i___sor_map_70_scal == 0 ) then
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(7)
else if ( j___sor_map_70_scal == 150 * 1 + 1 ) then
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(4)
else if ( j___sor_map_70_scal == 0 ) then
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(5)
 else if ( k___sor_map_70_scal == 0 ) then
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(5)
 else if ( k___sor_map_70_scal == 90 + 1 ) then
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(5)
 else
 reltmp___sor_map_70_scal = 1.0 * (1.0 / 3.0 * (0.5 * p2_s_0___f_comp_p3_1_6(6) + 0.5 *  &
      p2_s_0___f_comp_p3_1_6(4) + 0.5 * p2_s_0___f_comp_p3_1_6(8) + 0.5 *  &
      p2_s_0___f_comp_p3_1_6(2) + 0.5 * p2_s_0___f_comp_p3_1_6(9) + 0.5 *  &
      p2_s_0___f_comp_p3_1_6(1) - rhs_0___f_comp_p3_1_6) - p2_s_0___f_comp_p3_1_6(5))
 p3_1(idx) = p2_s_0___f_comp_p3_1_6(5) + reltmp___sor_map_70_scal
 end if
!RF4A End Inline
end subroutine stage_kernel_1

end module singleton_module_stage_kernel_1

