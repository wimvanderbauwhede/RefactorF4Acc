module singleton_module_stage_kernel_1

contains

subroutine stage_kernel_1(global_id_0,p0_0,rhs_0,p4_1)
 implicit none
 real(kind=4), parameter :: cn1___sor_map_23_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_23_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_23_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_23_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_23_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_23_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_23_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_23_scal=1
 real(kind=4), parameter :: cn1___sor_map_47_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_47_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_47_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_47_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_47_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_47_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_47_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_47_scal=1
 real(kind=4), parameter :: cn1___sor_map_71_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_71_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_71_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_71_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_71_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_71_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_71_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_71_scal=1
 real(kind=4), parameter :: cn1___sor_map_95_scal=0.333333333333333
 real(kind=4), parameter :: cn2l___sor_map_95_scal=0.5
 real(kind=4), parameter :: cn2s___sor_map_95_scal=0.5
 real(kind=4), parameter :: cn3l___sor_map_95_scal=0.5
 real(kind=4), parameter :: cn3s___sor_map_95_scal=0.5
 real(kind=4), parameter :: cn4l___sor_map_95_scal=0.5
 real(kind=4), parameter :: cn4s___sor_map_95_scal=0.5
 integer(kind=4), parameter :: omega___sor_map_95_scal=1
 integer :: i___sor_map_95_scal
 integer :: j___sor_map_95_scal
 integer :: k___sor_map_95_scal
 real :: reltmp___sor_map_95_scal
 integer :: i_range___sor_map_95_scal
 integer :: j_range___sor_map_95_scal
 integer :: k_range___sor_map_95_scal
 integer :: i_rel___sor_map_95_scal
 integer :: j_rel___sor_map_95_scal
 integer :: k_rel___sor_map_95_scal
 integer :: i___sor_map_71_scal
 integer :: j___sor_map_71_scal
 integer :: k___sor_map_71_scal
 real :: reltmp___sor_map_71_scal
 integer :: i_range___sor_map_71_scal
 integer :: j_range___sor_map_71_scal
 integer :: k_range___sor_map_71_scal
 integer :: i_rel___sor_map_71_scal
 integer :: j_rel___sor_map_71_scal
 integer :: k_rel___sor_map_71_scal
 integer :: i___f_maps_p4_1_0
 integer :: i___sor_map_47_scal
 integer :: j___sor_map_47_scal
 integer :: k___sor_map_47_scal
 real :: reltmp___sor_map_47_scal
 integer :: i_range___sor_map_47_scal
 integer :: j_range___sor_map_47_scal
 integer :: k_range___sor_map_47_scal
 integer :: i_rel___sor_map_47_scal
 integer :: j_rel___sor_map_47_scal
 integer :: k_rel___sor_map_47_scal
 integer :: i___f_maps_p4_1_1
 integer :: i___sor_map_23_scal
 integer :: j___sor_map_23_scal
 integer :: k___sor_map_23_scal
 real :: reltmp___sor_map_23_scal
 integer :: i_range___sor_map_23_scal
 integer :: j_range___sor_map_23_scal
 integer :: k_range___sor_map_23_scal
 integer :: i_rel___sor_map_23_scal
 integer :: j_rel___sor_map_23_scal
 integer :: k_rel___sor_map_23_scal
 integer :: i___f_maps_p4_1_2
 integer :: i___f_maps_p4_1_4
 real, dimension(9 , 9) :: sv_p1_s_0_in___f_comp_p4_1_5
 real, dimension(9) :: sv_rhs_0_in___f_comp_p4_1_5
 integer :: i___f_maps_p4_1_7
 real, dimension(9 , 9) :: sv_p2_s_0_in___f_comp_p4_1_8
 real, dimension(9) :: sv_rhs_0_in___f_comp_p4_1_8
 real, dimension(9) :: p3_s_0___f_comp_p4_1_10
 real :: rhs_0___f_comp_p4_1_10
 real, dimension(1:2125568) :: p0_0
 real, dimension(1:2125568) :: rhs_0
 real, dimension(1:2125568) :: p4_1
 integer, dimension(1:9), parameter :: s1=(/ 153, 23105, 23107, 23256, 23257, 23258, 23407, 23409, &
       46361 /)
 real, dimension(1:9,1:9,1:9,1:9) :: svec_p4_1_11
 integer :: s_idx_1
 integer :: s_idx_2
 integer :: s_idx_3
 integer :: s_idx_4
 real, dimension(1:9,1:9,1:9) :: svec_p4_1_12
 real, dimension(1:9,1:9) :: svec_p4_1_13
 real, dimension(1:9) :: svec_p4_1_14
 integer :: global_id_0
 integer :: idx
 idx = global_id_0
!RF4A Begin Inline
 do s_idx_1 = 1,9
 do s_idx_2 = 1,9
 do s_idx_3 = 1,9
 do s_idx_4 = 1,9
 if (idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)+s1(s_idx_4)>=1 .and.  &
      idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)+s1(s_idx_4)<=2125568) then
 svec_p4_1_11(s_idx_1, s_idx_2, s_idx_3, &
       s_idx_4) = p0_0(idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)+s1(s_idx_4))
 else
 svec_p4_1_11(s_idx_1, s_idx_2, s_idx_3, s_idx_4) = p0_0(idx)
 end if
 end do
 end do
 end do
 end do
 do s_idx_1 = 1,9
 do s_idx_2 = 1,9
 do s_idx_3 = 1,9
 if (idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)>=1 .and.  &
      idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3)<=2125568) then
 svec_p4_1_12(s_idx_1, s_idx_2, s_idx_3) = rhs_0(idx+s1(s_idx_1)+s1(s_idx_2)+s1(s_idx_3))
 else
 svec_p4_1_12(s_idx_1, s_idx_2, s_idx_3) = rhs_0(idx)
 end if
 end do
 end do
 end do
 do s_idx_1 = 1,9
 do s_idx_2 = 1,9
 if (idx+s1(s_idx_1)+s1(s_idx_2)>=1 .and. idx+s1(s_idx_1)+s1(s_idx_2)<=2125568) then
 svec_p4_1_13(s_idx_1, s_idx_2) = rhs_0(idx+s1(s_idx_1)+s1(s_idx_2))
 else
 svec_p4_1_13(s_idx_1, s_idx_2) = rhs_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,9
 if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=2125568) then
 svec_p4_1_14(s_idx_1) = rhs_0(idx+s1(s_idx_1))
 else
 svec_p4_1_14(s_idx_1) = rhs_0(idx)
 end if
 end do
 do i___f_maps_p4_1_7=1,9
 do i___f_maps_p4_1_4=1,9
 do i___f_maps_p4_1_2=1,9
 i_range___sor_map_23_scal = ((151 - 0) + 1)
 j_range___sor_map_23_scal = ((151 - 0) + 1)
 k_range___sor_map_23_scal = ((91 - 0) + 1)
 i_rel___sor_map_23_scal = (global_id_0 / (j_range___sor_map_23_scal * k_range___sor_map_23_scal))
 i___sor_map_23_scal = (i_rel___sor_map_23_scal + 0)
 j_rel___sor_map_23_scal = ((global_id_0 - (i_rel___sor_map_23_scal * (j_range___sor_map_23_scal *  &
      k_range___sor_map_23_scal))) / k_range___sor_map_23_scal)
 j___sor_map_23_scal = (j_rel___sor_map_23_scal + 0)
 k_rel___sor_map_23_scal = ((global_id_0 - (i_rel___sor_map_23_scal * (j_range___sor_map_23_scal *  &
      k_range___sor_map_23_scal))) - (j_rel___sor_map_23_scal * k_range___sor_map_23_scal))
 k___sor_map_23_scal = (k_rel___sor_map_23_scal + 0)
 if (i___sor_map_23_scal == 150 * 1 + 1) then
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,3)
else if ( i___sor_map_23_scal == 0 ) then
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,7)
else if ( j___sor_map_23_scal == 150 * 1 + 1 ) then
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,4)
else if ( j___sor_map_23_scal == 0 ) then
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,5)
 else if ( k___sor_map_23_scal == 0 ) then
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,5)
 else if ( k___sor_map_23_scal == 90 + 1 ) then
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,5)
 else
 reltmp___sor_map_23_scal = 1.0 * (1.0 / 3.0 * (0.5 * svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,6) + 0.5 * svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,4) + 0.5 * svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,8) + 0.5 * svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,2) + 0.5 * svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,9) + 0.5 * svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,1) - svec_p4_1_12(i___f_maps_p4_1_7,i___f_maps_p4_1_4, &
      i___f_maps_p4_1_2)) - svec_p4_1_11(i___f_maps_p4_1_7,i___f_maps_p4_1_4,i___f_maps_p4_1_2, &
      5))
 sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4,i___f_maps_p4_1_2) = svec_p4_1_11(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_4,i___f_maps_p4_1_2,5) + reltmp___sor_map_23_scal
 end if
 end do
 sv_rhs_0_in___f_comp_p4_1_5(i___f_maps_p4_1_4) = svec_p4_1_13(i___f_maps_p4_1_7,i___f_maps_p4_1_4) 
 end do
 do i___f_maps_p4_1_1=1,9
 i_range___sor_map_47_scal = ((151 - 0) + 1)
 j_range___sor_map_47_scal = ((151 - 0) + 1)
 k_range___sor_map_47_scal = ((91 - 0) + 1)
 i_rel___sor_map_47_scal = (global_id_0 / (j_range___sor_map_47_scal * k_range___sor_map_47_scal))
 i___sor_map_47_scal = (i_rel___sor_map_47_scal + 0)
 j_rel___sor_map_47_scal = ((global_id_0 - (i_rel___sor_map_47_scal * (j_range___sor_map_47_scal *  &
      k_range___sor_map_47_scal))) / k_range___sor_map_47_scal)
 j___sor_map_47_scal = (j_rel___sor_map_47_scal + 0)
 k_rel___sor_map_47_scal = ((global_id_0 - (i_rel___sor_map_47_scal * (j_range___sor_map_47_scal *  &
      k_range___sor_map_47_scal))) - (j_rel___sor_map_47_scal * k_range___sor_map_47_scal))
 k___sor_map_47_scal = (k_rel___sor_map_47_scal + 0)
 if (i___sor_map_47_scal == 150 * 1 + 1) then
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,3)
else if ( i___sor_map_47_scal == 0 ) then
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,7)
else if ( j___sor_map_47_scal == 150 * 1 + 1 ) then
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,4)
else if ( j___sor_map_47_scal == 0 ) then
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,5)
 else if ( k___sor_map_47_scal == 0 ) then
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,5)
 else if ( k___sor_map_47_scal == 90 + 1 ) then
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,5)
 else
 reltmp___sor_map_47_scal = 1.0 * (1.0 / 3.0 * (0.5 *  &
      sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      6) + 0.5 * sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      4) + 0.5 * sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      8) + 0.5 * sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      2) + 0.5 * sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      9) + 0.5 * sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      1) - sv_rhs_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1)) -  &
      sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1,5))
 sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7, &
      i___f_maps_p4_1_1) = sv_p1_s_0_in___f_comp_p4_1_5(i___f_maps_p4_1_1, &
      5) + reltmp___sor_map_47_scal
 end if
 end do
 sv_rhs_0_in___f_comp_p4_1_8(i___f_maps_p4_1_7) = svec_p4_1_14(i___f_maps_p4_1_7)
 end do
 do i___f_maps_p4_1_0=1,9
 i_range___sor_map_71_scal = ((151 - 0) + 1)
 j_range___sor_map_71_scal = ((151 - 0) + 1)
 k_range___sor_map_71_scal = ((91 - 0) + 1)
 i_rel___sor_map_71_scal = (global_id_0 / (j_range___sor_map_71_scal * k_range___sor_map_71_scal))
 i___sor_map_71_scal = (i_rel___sor_map_71_scal + 0)
 j_rel___sor_map_71_scal = ((global_id_0 - (i_rel___sor_map_71_scal * (j_range___sor_map_71_scal *  &
      k_range___sor_map_71_scal))) / k_range___sor_map_71_scal)
 j___sor_map_71_scal = (j_rel___sor_map_71_scal + 0)
 k_rel___sor_map_71_scal = ((global_id_0 - (i_rel___sor_map_71_scal * (j_range___sor_map_71_scal *  &
      k_range___sor_map_71_scal))) - (j_rel___sor_map_71_scal * k_range___sor_map_71_scal))
 k___sor_map_71_scal = (k_rel___sor_map_71_scal + 0)
 if (i___sor_map_71_scal == 150 * 1 + 1) then
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,3) 
else if ( i___sor_map_71_scal == 0 ) then
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,7) 
else if ( j___sor_map_71_scal == 150 * 1 + 1 ) then
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,4) 
else if ( j___sor_map_71_scal == 0 ) then
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,5) 
 else if ( k___sor_map_71_scal == 0 ) then
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,5) 
 else if ( k___sor_map_71_scal == 90 + 1 ) then
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,5) 
 else
 reltmp___sor_map_71_scal = 1.0 * (1.0 / 3.0 * (0.5 *  &
      sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      6) + 0.5 * sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      4) + 0.5 * sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      8) + 0.5 * sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      2) + 0.5 * sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      9) + 0.5 * sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      1) - sv_rhs_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0)) -  &
      sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0,5))
 p3_s_0___f_comp_p4_1_10(i___f_maps_p4_1_0) = sv_p2_s_0_in___f_comp_p4_1_8(i___f_maps_p4_1_0, &
      5) + reltmp___sor_map_71_scal
 end if
 end do
 rhs_0___f_comp_p4_1_10 = rhs_0(idx)
 i_range___sor_map_95_scal = ((151 - 0) + 1)
 j_range___sor_map_95_scal = ((151 - 0) + 1)
 k_range___sor_map_95_scal = ((91 - 0) + 1)
 i_rel___sor_map_95_scal = (global_id_0 / (j_range___sor_map_95_scal * k_range___sor_map_95_scal))
 i___sor_map_95_scal = (i_rel___sor_map_95_scal + 0)
 j_rel___sor_map_95_scal = ((global_id_0 - (i_rel___sor_map_95_scal * (j_range___sor_map_95_scal *  &
      k_range___sor_map_95_scal))) / k_range___sor_map_95_scal)
 j___sor_map_95_scal = (j_rel___sor_map_95_scal + 0)
 k_rel___sor_map_95_scal = ((global_id_0 - (i_rel___sor_map_95_scal * (j_range___sor_map_95_scal *  &
      k_range___sor_map_95_scal))) - (j_rel___sor_map_95_scal * k_range___sor_map_95_scal))
 k___sor_map_95_scal = (k_rel___sor_map_95_scal + 0)
 if (i___sor_map_95_scal == 150 * 1 + 1) then
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(3)
else if ( i___sor_map_95_scal == 0 ) then
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(7)
else if ( j___sor_map_95_scal == 150 * 1 + 1 ) then
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(4)
else if ( j___sor_map_95_scal == 0 ) then
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(5)
 else if ( k___sor_map_95_scal == 0 ) then
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(5)
 else if ( k___sor_map_95_scal == 90 + 1 ) then
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(5)
 else
 reltmp___sor_map_95_scal = 1.0 * (1.0 / 3.0 * (0.5 * p3_s_0___f_comp_p4_1_10(6) + 0.5 *  &
      p3_s_0___f_comp_p4_1_10(4) + 0.5 * p3_s_0___f_comp_p4_1_10(8) + 0.5 *  &
      p3_s_0___f_comp_p4_1_10(2) + 0.5 * p3_s_0___f_comp_p4_1_10(9) + 0.5 *  &
      p3_s_0___f_comp_p4_1_10(1) - rhs_0___f_comp_p4_1_10) - p3_s_0___f_comp_p4_1_10(5))
 p4_1(idx) = p3_s_0___f_comp_p4_1_10(5) + reltmp___sor_map_95_scal
 end if
!RF4A End Inline
end subroutine stage_kernel_1

end module singleton_module_stage_kernel_1

