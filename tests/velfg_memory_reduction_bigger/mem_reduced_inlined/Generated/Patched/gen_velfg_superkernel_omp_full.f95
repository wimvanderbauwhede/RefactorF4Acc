program main
#ifdef WITH_OPENMP    
     use omp_lib
#endif    
 
use singleton_module_velfg_superkernel, only : velfg_superkernel
! Grouped Parameter Declarations
      implicit none
      integer, parameter :: st_stage_kernel_1=1
      integer, parameter :: niters=50
! BEGIN new declarations
! END new declarations
    integer :: global_id
!    ! Declarations
    real, dimension(1:2139552) :: u_0
    real, dimension(1:2139552) :: v_0
    real, dimension(1:2162808) :: w_0
    real, dimension(1:2074891) :: f_1
    real, dimension(1:2074891) :: g_1
    real, dimension(1:2074891) :: h_1

    integer, parameter :: u0___velfg_map_76_scal=0
    integer, parameter :: u0___velfg_map_133_scal=0
    real, parameter :: vn___velfg_map_218_scal=15.83 * 10. ** (-6.)
    
    real :: covx1___velfg_map_218_scal
    integer :: i___velfg_map_218_scal
    integer :: j___velfg_map_218_scal
    integer :: k___velfg_map_218_scal
    real :: covy1___velfg_map_218_scal
    real :: covz1___velfg_map_218_scal
    real :: covc___velfg_map_218_scal
    real :: df___velfg_map_218_scal
    integer :: j_range___velfg_map_218_scal
    integer :: i_range___velfg_map_218_scal
    integer :: i_rel___velfg_map_218_scal
    integer :: j_rel___velfg_map_218_scal
    integer :: k_rel___velfg_map_218_scal
    real :: dfu1___velfg_map_218
    real :: dfv1___velfg_map_218
    real :: dfw1___velfg_map_218
    integer :: i_vel2___velfg_map_133_scal
    integer :: j_vel2___velfg_map_133_scal
    integer :: k_vel2___velfg_map_133_scal
    integer :: j_vel2_range___velfg_m___9675913f
    integer :: i_vel2_range___velfg_m___a1f7aab8
    integer :: k_vel2_rel___velfg_map_133_scal
    integer :: j_vel2_rel___velfg_map_133_scal
    integer :: i_vel2_rel___velfg_map_133_scal
    real :: nou7___velfg_map_133
    real :: diu7___velfg_map_133
    real :: nou8___velfg_map_133
    real :: diu8___velfg_map_133
    real :: nou7_1___f_pelts_f_1_g_1_h_1_2
    real :: nou8_1___f_pelts_f_1_g_1_h_1_2
    integer :: i___f_maps_f_1_g_1_h_1_3
    integer :: i_vel2___velfg_map_76_scal
    integer :: j_vel2___velfg_map_76_scal
    integer :: k_vel2___velfg_map_76_scal
    integer :: j_vel2_range___velfg_m___4b6e60e4
    integer :: i_vel2_range___velfg_m___ea66ec4a
    integer :: i_vel2_rel___velfg_map_76_scal
    integer :: j_vel2_rel___velfg_map_76_scal
    integer :: k_vel2_rel___velfg_map_76_scal
    real :: nou1___velfg_map_76
    real :: diu1___velfg_map_76
    real :: nou5___velfg_map_76
    real :: diu5___velfg_map_76
    real :: nou9___velfg_map_76
    real :: diu9___velfg_map_76
    real :: nou2___velfg_map_76
    real :: diu2___velfg_map_76
    real :: nou3___velfg_map_76
    real :: diu3___velfg_map_76
    real :: nou4___velfg_map_76
    real :: diu4___velfg_map_76
    real :: nou6___velfg_map_76
    real :: diu6___velfg_map_76
    real :: nou1_1___f_pelts_f_1_g_1_h_1_0
    real :: nou2_1___f_pelts_f_1_g_1_h_1_0
    real :: nou3_1___f_pelts_f_1_g_1_h_1_0
    real :: nou4_1___f_pelts_f_1_g_1_h_1_0
    real :: nou5_1___f_pelts_f_1_g_1_h_1_0
    real :: nou6_1___f_pelts_f_1_g_1_h_1_0
    real :: nou9_1___f_pelts_f_1_g_1_h_1_0
    integer :: i___f_maps_f_1_g_1_h_1_1
    real, dimension(2) :: cov1_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov2_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov3_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu1_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu2_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu3_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov4_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov5_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov6_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu4_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu5_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu6_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov7_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov8_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: cov9_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu7_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu8_s_0___f_comp_f_1_g_1_h_1_5
    real, dimension(2) :: diu9_s_0___f_comp_f_1_g_1_h_1_5
    real :: dfu1_1___f_pelts_f_1_g_1_h_1_6
    real :: dfv1_1___f_pelts_f_1_g_1_h_1_6
    real :: dfw1_1___f_pelts_f_1_g_1_h_1_6
!     real, dimension(1:2139552), intent(in) :: u_0
!     real, dimension(1:2139552), intent(in) :: v_0
!     real, dimension(1:2162808), intent(in) :: w_0
!     real, dimension(1:2074891), intent(out) :: f_1
!     real, dimension(1:2074891), intent(out) :: g_1
!     real, dimension(1:2074891), intent(out) :: h_1
    integer, dimension(1:2), parameter :: s8=(/ 23718 , 23719 /)
    integer, dimension(1:5), parameter :: s2=(/ 305, 23409, 23560, 23561, 23712 /)
    real, dimension(1:2,1:5) :: svec_f_1_g_1_h_1_7
    integer :: s_idx_1
    integer :: s_idx_2
    integer, dimension(1:5), parameter :: s3=(/ 305, 23409, 23410, 23560, 23561 /)
    real, dimension(1:2,1:5) :: svec_f_1_g_1_h_1_8
    integer, dimension(1:4), parameter :: s1=(/ 23561, 23562, 23713, 46817 /)
    real, dimension(1:2,1:4) :: svec_f_1_g_1_h_1_9
    integer, dimension(1:2), parameter :: s12=(/ 23563 , 23564 /)
    integer, dimension(1:2), parameter :: s6=(/ 23560 , 46816 /)
    real, dimension(1:2,1:2) :: svec_f_1_g_1_h_1_10
    integer, dimension(1:3), parameter :: s5=(/ 46665, 46816, 46817 /)
    real, dimension(1:2,1:3) :: svec_f_1_g_1_h_1_11
    integer, dimension(1:2), parameter :: s4=(/ 23409 , 46665 /)
    real, dimension(1:2,1:2) :: svec_f_1_g_1_h_1_12
    real, dimension(1:153) :: dx1_0
    real, dimension(1:152) :: dy1_0
    real, dimension(1:94) :: dzn_0
    real, dimension(1:94) :: dzs_0
    integer :: idx
!    integer, intent(In) :: global_id    
! Moved param decl for st_stage_kernel_1 in main to top of code unit
    integer :: state_ptr
! Moved param decl for niters in main to top of code unit
    integer :: iter
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    !print *, iter
#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif       
    do global_id = 1, 2025000
!       call velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr,global_id)
! subroutine stage_kernel_1(u_0,v_0,w_0,f_1,g_1,h_1,global_id)
!  implicit none

idx = global_id
!RF4A Begin Inline
 do s_idx_1 = 1,2
 do s_idx_2 = 1,5
 if (idx+s8(s_idx_1)+s2(s_idx_2)>=1 .and. idx+s8(s_idx_1)+s2(s_idx_2)<=2139552) then
 svec_f_1_g_1_h_1_7(s_idx_1, s_idx_2) = u_0(idx+s8(s_idx_1)+s2(s_idx_2))
 else
 svec_f_1_g_1_h_1_7(s_idx_1, s_idx_2) = u_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,2
 do s_idx_2 = 1,5
 if (idx+s8(s_idx_1)+s3(s_idx_2)>=1 .and. idx+s8(s_idx_1)+s3(s_idx_2)<=2139552) then
 svec_f_1_g_1_h_1_8(s_idx_1, s_idx_2) = v_0(idx+s8(s_idx_1)+s3(s_idx_2))
 else
 svec_f_1_g_1_h_1_8(s_idx_1, s_idx_2) = v_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,2
 do s_idx_2 = 1,4
 if (idx+s8(s_idx_1)+s1(s_idx_2)>=1 .and. idx+s8(s_idx_1)+s1(s_idx_2)<=2162808) then
 svec_f_1_g_1_h_1_9(s_idx_1, s_idx_2) = w_0(idx+s8(s_idx_1)+s1(s_idx_2))
 else
 svec_f_1_g_1_h_1_9(s_idx_1, s_idx_2) = w_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,2
 do s_idx_2 = 1,2
 if (idx+s12(s_idx_1)+s6(s_idx_2)>=1 .and. idx+s12(s_idx_1)+s6(s_idx_2)<=2139552) then
 svec_f_1_g_1_h_1_10(s_idx_1, s_idx_2) = u_0(idx+s12(s_idx_1)+s6(s_idx_2))
 else
 svec_f_1_g_1_h_1_10(s_idx_1, s_idx_2) = u_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,2
 do s_idx_2 = 1,3
 if (idx+s12(s_idx_1)+s5(s_idx_2)>=1 .and. idx+s12(s_idx_1)+s5(s_idx_2)<=2162808) then
 svec_f_1_g_1_h_1_11(s_idx_1, s_idx_2) = w_0(idx+s12(s_idx_1)+s5(s_idx_2))
 else
 svec_f_1_g_1_h_1_11(s_idx_1, s_idx_2) = w_0(idx)
 end if
 end do
 end do
 do s_idx_1 = 1,2
 do s_idx_2 = 1,2
 if (idx+s12(s_idx_1)+s4(s_idx_2)>=1 .and. idx+s12(s_idx_1)+s4(s_idx_2)<=2139552) then
 svec_f_1_g_1_h_1_12(s_idx_1, s_idx_2) = v_0(idx+s12(s_idx_1)+s4(s_idx_2))
 else
 svec_f_1_g_1_h_1_12(s_idx_1, s_idx_2) = v_0(idx)
 end if
 end do
 end do
 do i___f_maps_f_1_g_1_h_1_1=1,2
 j_vel2_range___velfg_m___4b6e60e4 = ((150 - 1) + 1)
 i_vel2_range___velfg_m___ea66ec4a = ((150 - 1) + 1)
 k_vel2_rel___velfg_map_76_scal = (global_id /  &
      (j_vel2_range___velfg_m___4b6e60e4 * i_vel2_range___velfg_m___ea66ec4a))
 k_vel2___velfg_map_76_scal = (k_vel2_rel___velfg_map_76_scal + 1)
j_vel2_rel___velfg_map_76_scal = ((global_id - (k_vel2_rel___velfg_map_76_scal  &
      * (j_vel2_range___velfg_m___4b6e60e4 * i_vel2_range___velfg_m___ea66ec4a))) /  &
      i_vel2_range___velfg_m___ea66ec4a)
j_vel2___velfg_map_76_scal = (j_vel2_rel___velfg_map_76_scal + 1)
i_vel2_rel___velfg_map_76_scal = ((global_id - (k_vel2_rel___velfg_map_76_scal  &
      * (j_vel2_range___velfg_m___4b6e60e4 * i_vel2_range___velfg_m___ea66ec4a))) -  &
      (j_vel2_rel___velfg_map_76_scal * i_vel2_range___velfg_m___ea66ec4a))
i_vel2___velfg_map_76_scal = (i_vel2_rel___velfg_map_76_scal + 1)
 if ((k_vel2___velfg_map_76_scal < 90)) then
 nou1___velfg_map_76 = (svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      3) + svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1,4)) / 2.
 diu1___velfg_map_76 = (-svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      3) + svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1,4)) / dx1_0(i_vel2___velfg_map_76_scal)
 nou5___velfg_map_76 = (svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      2) + svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1,5)) / 2.
 diu5___velfg_map_76 = (-svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      2) + svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1,5)) / dy1_0(j_vel2___velfg_map_76_scal)
 nou9___velfg_map_76 = (svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1, &
      1) + svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1,4)) / 2.
 diu9___velfg_map_76 = (-svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1, &
      1) + svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1,4)) / dzn_0(k_vel2___velfg_map_76_scal)
 cov1_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = nou1___velfg_map_76 *  &
      diu1___velfg_map_76
 cov5_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = nou5___velfg_map_76 *  &
      diu5___velfg_map_76
 cov7_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = nou9___velfg_map_76 *  &
      diu9___velfg_map_76
 end if
 if ((k_vel2___velfg_map_76_scal < 90)) then
 nou2___velfg_map_76 = (dx1_0(i_vel2___velfg_map_76_scal + 1) *  &
      svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      2) + dx1_0(i_vel2___velfg_map_76_scal) * svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      3)) / (dx1_0(i_vel2___velfg_map_76_scal) + dx1_0(i_vel2___velfg_map_76_scal + 1))
 diu2___velfg_map_76 = 2. * (-svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      2) + svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      4)) / (dy1_0(j_vel2___velfg_map_76_scal - 1) + dy1_0(j_vel2___velfg_map_76_scal))
 cov2_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = nou2___velfg_map_76 *  &
      diu2___velfg_map_76
 end if
 nou3___velfg_map_76 = (dx1_0(i_vel2___velfg_map_76_scal + 1) *  &
      svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1, &
      1) + dx1_0(i_vel2___velfg_map_76_scal) * svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1, &
      2)) / (dx1_0(i_vel2___velfg_map_76_scal) + dx1_0(i_vel2___velfg_map_76_scal + 1))
 diu3___velfg_map_76 = (-svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      1) + svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1,4)) / dzs_0(k_vel2___velfg_map_76_scal - 1)
 cov3_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = nou3___velfg_map_76 *  &
      diu3___velfg_map_76
 if ((k_vel2___velfg_map_76_scal < 90)) then
 nou4___velfg_map_76 = (dy1_0(j_vel2___velfg_map_76_scal + 1) *  &
      svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      3) + dy1_0(j_vel2___velfg_map_76_scal) * svec_f_1_g_1_h_1_7(i___f_maps_f_1_g_1_h_1_1, &
      5)) / (dy1_0(j_vel2___velfg_map_76_scal) + dy1_0(j_vel2___velfg_map_76_scal + 1))
 diu4___velfg_map_76 = 2. * (-svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      4) + svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      5)) / (dx1_0(i_vel2___velfg_map_76_scal - 1) + dx1_0(i_vel2___velfg_map_76_scal))
 cov4_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = (nou4___velfg_map_76 -  &
      u0___velfg_map_76_scal) * diu4___velfg_map_76
 end if
 nou6___velfg_map_76 = (dy1_0(j_vel2___velfg_map_76_scal + 1) *  &
      svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1, &
      1) + dy1_0(j_vel2___velfg_map_76_scal) * svec_f_1_g_1_h_1_9(i___f_maps_f_1_g_1_h_1_1, &
      3)) / (dy1_0(j_vel2___velfg_map_76_scal) + dy1_0(j_vel2___velfg_map_76_scal + 1))
 diu6___velfg_map_76 = (-svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1, &
      1) + svec_f_1_g_1_h_1_8(i___f_maps_f_1_g_1_h_1_1,5)) / dzs_0(k_vel2___velfg_map_76_scal - 1)
 cov6_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = nou6___velfg_map_76 *  &
      diu6___velfg_map_76
 nou1_1___f_pelts_f_1_g_1_h_1_0 = nou1___velfg_map_76
 diu1_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu1___velfg_map_76
 nou5_1___f_pelts_f_1_g_1_h_1_0 = nou5___velfg_map_76
 diu5_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu5___velfg_map_76
 nou9_1___f_pelts_f_1_g_1_h_1_0 = nou9___velfg_map_76
 cov8_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu9___velfg_map_76
 nou2_1___f_pelts_f_1_g_1_h_1_0 = nou2___velfg_map_76
 diu2_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu2___velfg_map_76
 nou3_1___f_pelts_f_1_g_1_h_1_0 = nou3___velfg_map_76
 diu3_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu3___velfg_map_76
 nou4_1___f_pelts_f_1_g_1_h_1_0 = nou4___velfg_map_76
 diu4_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu4___velfg_map_76
 nou6_1___f_pelts_f_1_g_1_h_1_0 = nou6___velfg_map_76
 diu6_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_1) = diu6___velfg_map_76
 end do
 do i___f_maps_f_1_g_1_h_1_3=1,2
j_vel2_range___velfg_m___9675913f = ((150 - 1) + 1)
i_vel2_range___velfg_m___a1f7aab8 = ((150 - 1) + 1)
k_vel2_rel___velfg_map_133_scal = (global_id /  &
      (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))
k_vel2___velfg_map_133_scal = (k_vel2_rel___velfg_map_133_scal + 1)
j_vel2_rel___velfg_map_133_scal = ((global_id -  &
      (k_vel2_rel___velfg_map_133_scal * (j_vel2_range___velfg_m___9675913f *  &
      i_vel2_range___velfg_m___a1f7aab8))) / i_vel2_range___velfg_m___a1f7aab8)
j_vel2___velfg_map_133_scal = (j_vel2_rel___velfg_map_133_scal + 1)
i_vel2_rel___velfg_map_133_scal = ((global_id -  &
      (k_vel2_rel___velfg_map_133_scal * (j_vel2_range___velfg_m___9675913f *  &
      i_vel2_range___velfg_m___a1f7aab8))) - (j_vel2_rel___velfg_map_133_scal *  &
      i_vel2_range___velfg_m___a1f7aab8))
i_vel2___velfg_map_133_scal = (i_vel2_rel___velfg_map_133_scal + 1)
 nou7___velfg_map_133 = (dzn_0(k_vel2___velfg_map_133_scal + 1) *  &
      svec_f_1_g_1_h_1_10(i___f_maps_f_1_g_1_h_1_3, &
      1) + dzn_0(k_vel2___velfg_map_133_scal) * svec_f_1_g_1_h_1_10(i___f_maps_f_1_g_1_h_1_3, &
      2)) / (dzn_0(k_vel2___velfg_map_133_scal) + dzn_0(k_vel2___velfg_map_133_scal + 1))
 diu7___velfg_map_133 = 2. * (-svec_f_1_g_1_h_1_11(i___f_maps_f_1_g_1_h_1_3, &
      2) + svec_f_1_g_1_h_1_11(i___f_maps_f_1_g_1_h_1_3, &
      3)) / (dx1_0(i_vel2___velfg_map_133_scal - 1) + dx1_0(i_vel2___velfg_map_133_scal))
 cov9_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_3) = (nou7___velfg_map_133 -  &
      u0___velfg_map_133_scal) * diu7___velfg_map_133
 nou8___velfg_map_133 = (dzn_0(k_vel2___velfg_map_133_scal + 1) *  &
      svec_f_1_g_1_h_1_12(i___f_maps_f_1_g_1_h_1_3, &
      1) + dzn_0(k_vel2___velfg_map_133_scal) * svec_f_1_g_1_h_1_12(i___f_maps_f_1_g_1_h_1_3, &
      2)) / (dzn_0(k_vel2___velfg_map_133_scal) + dzn_0(k_vel2___velfg_map_133_scal + 1))
 diu8___velfg_map_133 = 2. * (-svec_f_1_g_1_h_1_11(i___f_maps_f_1_g_1_h_1_3, &
      1) + svec_f_1_g_1_h_1_11(i___f_maps_f_1_g_1_h_1_3, &
      3)) / (dy1_0(j_vel2___velfg_map_133_scal - 1) + dy1_0(j_vel2___velfg_map_133_scal))
 diu9_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_3) = nou8___velfg_map_133 *  &
      diu8___velfg_map_133
 nou7_1___f_pelts_f_1_g_1_h_1_2 = nou7___velfg_map_133
 diu9_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_3) = diu7___velfg_map_133
 nou8_1___f_pelts_f_1_g_1_h_1_2 = nou8___velfg_map_133
 diu9_s_0___f_comp_f_1_g_1_h_1_5(i___f_maps_f_1_g_1_h_1_3) = diu8___velfg_map_133
 end do
 j_range___velfg_map_218_scal = ((150 - 1) + 1)
 i_range___velfg_map_218_scal = ((150 - 1) + 1)
 k_rel___velfg_map_218_scal = (global_id / (j_range___velfg_map_218_scal *  &
      i_range___velfg_map_218_scal))
 k___velfg_map_218_scal = (k_rel___velfg_map_218_scal + 1)
 j_rel___velfg_map_218_scal = ((global_id - (k_rel___velfg_map_218_scal *  &
      (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))) /  &
      i_range___velfg_map_218_scal)
 j___velfg_map_218_scal = (j_rel___velfg_map_218_scal + 1)
 i_rel___velfg_map_218_scal = ((global_id - (k_rel___velfg_map_218_scal *  &
      (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))) -  &
      (j_rel___velfg_map_218_scal * i_range___velfg_map_218_scal))
 i___velfg_map_218_scal = (i_rel___velfg_map_218_scal + 1)
 covx1___velfg_map_218_scal = (dx1_0(i___velfg_map_218_scal + 1) *  &
      cov1_s_0___f_comp_f_1_g_1_h_1_5(1) + dx1_0(i___velfg_map_218_scal) *  &
      cov1_s_0___f_comp_f_1_g_1_h_1_5(2)) / (dx1_0(i___velfg_map_218_scal) +  &
      dx1_0(i___velfg_map_218_scal + 1))
 covy1___velfg_map_218_scal = (cov2_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      cov2_s_0___f_comp_f_1_g_1_h_1_5(2)) / 2.
 covz1___velfg_map_218_scal = (cov3_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      cov3_s_0___f_comp_f_1_g_1_h_1_5(2)) / 2.
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal +  &
      covz1___velfg_map_218_scal
 dfu1___velfg_map_218 = 2. * (-diu1_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      diu1_s_0___f_comp_f_1_g_1_h_1_5(2)) / (dx1_0(i___velfg_map_218_scal) +  &
      dx1_0(i___velfg_map_218_scal + 1)) + (-diu2_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      diu2_s_0___f_comp_f_1_g_1_h_1_5(2)) / dy1_0(j___velfg_map_218_scal) +  &
      (-diu3_s_0___f_comp_f_1_g_1_h_1_5(1) + diu3_s_0___f_comp_f_1_g_1_h_1_5(2)) /  &
      dzn_0(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfu1___velfg_map_218
 f_1(idx) = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 covx1___velfg_map_218_scal = (cov4_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      cov4_s_0___f_comp_f_1_g_1_h_1_5(2)) / 2.
 covy1___velfg_map_218_scal = (dy1_0(j___velfg_map_218_scal + 1) *  &
      cov5_s_0___f_comp_f_1_g_1_h_1_5(1) + dy1_0(j___velfg_map_218_scal) *  &
      cov5_s_0___f_comp_f_1_g_1_h_1_5(2)) / (dy1_0(j___velfg_map_218_scal) +  &
      dy1_0(j___velfg_map_218_scal + 1))
 covz1___velfg_map_218_scal = (cov6_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      cov6_s_0___f_comp_f_1_g_1_h_1_5(2)) / 2.
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal +  &
      covz1___velfg_map_218_scal
 dfv1___velfg_map_218 = (-diu4_s_0___f_comp_f_1_g_1_h_1_5(1) + diu4_s_0___f_comp_f_1_g_1_h_1_5(2))  &
      / dx1_0(i___velfg_map_218_scal) + 2. * (-diu5_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      diu5_s_0___f_comp_f_1_g_1_h_1_5(2)) / (dy1_0(j___velfg_map_218_scal) +  &
      dy1_0(j___velfg_map_218_scal + 1)) + (-diu6_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      diu6_s_0___f_comp_f_1_g_1_h_1_5(2)) / dzn_0(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfv1___velfg_map_218
 g_1(idx) = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 if ((k___velfg_map_218_scal < (90 - 1))) then
 covx1___velfg_map_218_scal = (cov7_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      cov7_s_0___f_comp_f_1_g_1_h_1_5(2)) / 2.
 covy1___velfg_map_218_scal = (cov8_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      cov8_s_0___f_comp_f_1_g_1_h_1_5(2)) / 2.
 covz1___velfg_map_218_scal = (dzn_0(k___velfg_map_218_scal + 1) *  &
      cov9_s_0___f_comp_f_1_g_1_h_1_5(1) + dzn_0(k___velfg_map_218_scal) *  &
      cov9_s_0___f_comp_f_1_g_1_h_1_5(2)) / (dzn_0(k___velfg_map_218_scal) +  &
      dzn_0(k___velfg_map_218_scal + 1))
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal +  &
      covz1___velfg_map_218_scal
 dfw1___velfg_map_218 = (-diu7_s_0___f_comp_f_1_g_1_h_1_5(1) + diu7_s_0___f_comp_f_1_g_1_h_1_5(2))  &
      / dx1_0(i___velfg_map_218_scal) + (-diu8_s_0___f_comp_f_1_g_1_h_1_5(1) +  &
      diu8_s_0___f_comp_f_1_g_1_h_1_5(2)) / dy1_0(j___velfg_map_218_scal) +  &
      (-diu9_s_0___f_comp_f_1_g_1_h_1_5(1) + diu9_s_0___f_comp_f_1_g_1_h_1_5(2)) /  &
      dzs_0(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfw1___velfg_map_218
 h_1(idx) = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 end if
 dfu1_1___f_pelts_f_1_g_1_h_1_6 = dfu1___velfg_map_218
 dfv1_1___f_pelts_f_1_g_1_h_1_6 = dfv1___velfg_map_218
 dfw1_1___f_pelts_f_1_g_1_h_1_6 = dfw1___velfg_map_218
!RF4A End Inline

    end do
#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif  
    end do
    print *,f_1(1)
end program main  
