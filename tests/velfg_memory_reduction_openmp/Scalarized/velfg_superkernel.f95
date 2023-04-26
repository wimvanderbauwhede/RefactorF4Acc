module singleton_module_velfg_superkernel

contains

subroutine velfg_superkernel_scal(f,g,h,dzn,u,v,w,dx1,dy1,dzs,state_ptr,global_id)
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov1
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov1
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov1
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov4
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov4
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov4
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov5
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov5
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov5
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: cov7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: cov8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov9
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: cov9
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: cov9
 real, dimension(0:ip,1:jp,1:kp), intent(out) :: dfu1
 real, dimension(1:ip,0:jp,1:kp), intent(out) :: dfv1
 real, dimension(1:ip,1:jp,1:kp), intent(out) :: dfw1
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu1
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: diu1
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu1
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu4
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu4
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu4
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu5
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu5
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu5
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu9
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(in) :: diu9
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: diu9
 real, dimension(0:ip,0:jp,0:kp), intent(out) :: f
 real, dimension(0:ip,0:jp,0:kp), intent(out) :: g
 real, dimension(0:ip,0:jp,0:kp), intent(out) :: h
 integer :: i
 integer :: i_range
 integer :: i_rel
 integer :: i_vel2
 integer :: i_vel2_range
 integer :: i_vel2_rel
 integer :: j
 integer :: j_range
 integer :: j_rel
 integer :: j_vel2
 integer :: j_vel2_range
 integer :: j_vel2_rel
 integer :: k
 integer :: k_rel
 integer :: k_vel2
 integer :: k_vel2_rel
 real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: nou1
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou2
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou3
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou4
 real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(out) :: nou5
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou6
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou7
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou8
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(out):: nou9
 integer :: th_idx
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: u
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: u
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: u
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: u
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: u
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: u
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: v
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: v
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: v
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: v
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: v
 real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(in) :: v
 real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(in) :: w
 real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(in) :: w
 real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(in) :: w
 real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(in) :: w
 real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(in) :: w
 real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(in) :: w
 integer, parameter :: ip=300
 integer, parameter :: jp=300
 integer, parameter :: kp=90
 real, dimension((-1):(kp+2)), intent(in) :: dzn
 real, dimension((-1):(kp+2)), intent(in) :: dzs
 real, dimension((-1):(ip+1)), intent(in) :: dx1
!    real, dimension((-1):(ip + 1)), intent(In) :: delx1
 real, dimension(0:(jp+1)), intent(in) :: dy1
 real, dimension(0:(ip+1),(-1):(jp+1),0:(kp+1)), intent(in) :: u
 real, dimension(0:(ip+1),(-1):(jp+1),0:(kp+1)), intent(in) :: v
 real, dimension(0:(ip+1),(-1):(jp+1),(-1):(kp+1)), intent(in) :: w
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu1
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu4
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu5
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu9
 real, dimension(0:ip,0:jp,0:kp), intent(out) :: f
 real, dimension(0:ip,0:jp,0:kp), intent(out) :: g
 real, dimension(0:ip,0:jp,0:kp), intent(out) :: h
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov1
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov2
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov3
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov4
 real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov5
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov6
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov7
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov8
 real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: cov9
 real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou1
 real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou5
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou9
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou2
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou3
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou4
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou6
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou7
 real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: nou8
 real, dimension(0:ip,1:jp,1:kp) :: dfu1
 real, dimension(1:ip,0:jp,1:kp) :: dfv1
 real, dimension(1:ip,1:jp,1:kp) :: dfw1
 real, dimension((-1):(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: sm
 integer :: state
 integer, intent(in) :: state_ptr
 integer, intent(in) :: global_id
 integer, parameter :: st_adam_map_22=0
 integer, parameter :: st_les_map_87=10
 integer, parameter :: st_les_map_107=11
 integer, parameter :: st_velfg_map_76=18
 integer, parameter :: st_velfg_map_133=19
 integer, parameter :: st_velfg_map_155=20
 integer, parameter :: st_velfg_map_162=21
 integer, parameter :: st_velfg_map_172=22
 integer, parameter :: st_velfg_map_179=23
 integer, parameter :: st_velfg_map_189=24
 integer, parameter :: st_velfg_map_196=25
 integer, parameter :: st_velfg_map_206=26
 integer, parameter :: st_velfg_map_212=27
 integer, parameter :: st_velfg_map_218=28
 state = state_ptr 
 select case(state)
 case (st_velfg_map_76§)
 th_idx = global_id
 j_vel2_range = ((300 - 1) + 1)
 i_vel2_range = ((300 - 1) + 1)
 k_vel2_rel = (th_idx / (j_vel2_range * i_vel2_range))
 k_vel2 = (k_vel2_rel + 1)
 j_vel2_rel = ((th_idx - (k_vel2_rel * (j_vel2_range * i_vel2_range))) / i_vel2_range)
 j_vel2 = (j_vel2_rel + 1)
 i_vel2_rel = ((th_idx - (k_vel2_rel * (j_vel2_range * i_vel2_range))) - (j_vel2_rel *  &
      i_vel2_range))
 i_vel2 = (i_vel2_rel + 1)
call velfg_map_76(u_i_vel2_j_vel2_k_vel2m1,u_i_vel2_j_vel2m1_k_vel2,u_i_vel2m1_j_vel2_k_vel2, &
      u_i_vel2_j_vel2_k_vel2,u_i_vel2m1_j_vel2p1_k_vel2,dx1,v_i_vel2_j_vel2_k_vel2m1, &
      v_i_vel2_j_vel2m1_k_vel2,v_i_vel2p1_j_vel2m1_k_vel2,v_i_vel2m1_j_vel2_k_vel2, &
      v_i_vel2_j_vel2_k_vel2,dy1,w_i_vel2_j_vel2_k_vel2m1,w_i_vel2p1_j_vel2_k_vel2m1, &
      w_i_vel2_j_vel2p1_k_vel2m1,w_i_vel2_j_vel2_k_vel2,dzn,nou1_i_vel2_j_vel2_k_vel2, &
      diu1_i_vel2_j_vel2_k_vel2,nou5_i_vel2_j_vel2_k_vel2,diu5_i_vel2_j_vel2_k_vel2, &
      nou9_i_vel2_j_vel2_k_vel2,diu9_i_vel2_j_vel2_k_vel2,nou2_i_vel2_j_vel2_k_vel2, &
      diu2_i_vel2_j_vel2_k_vel2,dzs,nou3_i_vel2_j_vel2_k_vel2,diu3_i_vel2_j_vel2_k_vel2, &
      nou4_i_vel2_j_vel2_k_vel2,diu4_i_vel2_j_vel2_k_vel2,nou6_i_vel2_j_vel2_k_vel2, &
      diu6_i_vel2_j_vel2_k_vel2,cov1_i_vel2_j_vel2_k_vel2,cov5_i_vel2_j_vel2_k_vel2, &
      cov9_i_vel2_j_vel2_k_vel2,cov2_i_vel2_j_vel2_k_vel2,cov3_i_vel2_j_vel2_k_vel2, &
      cov4_i_vel2_j_vel2_k_vel2,cov6_i_vel2_j_vel2_k_vel2)
 case (st_velfg_map_13§3)
 j_vel2_range = ((300 - 1) + 1)
 i_vel2_range = ((300 - 1) + 1)
 k_vel2_rel = (global_id / (j_vel2_range * i_vel2_range))
 k_vel2 = (k_vel2_rel + 1)
 j_vel2_rel = ((global_id - (k_vel2_rel * (j_vel2_range * i_vel2_range))) / i_vel2_range)
 j_vel2 = (j_vel2_rel + 1)
 i_vel2_rel = ((global_id - (k_vel2_rel * (j_vel2_range * i_vel2_range))) - (j_vel2_rel *  &
      i_vel2_range))
 i_vel2 = (i_vel2_rel + 1)
call velfg_map_133(dzn,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2m1_j_vel2_k_vel2p1,w_i_vel2_j_vel2m1_k_vel2, &
      w_i_vel2m1_j_vel2_k_vel2,w_i_vel2_j_vel2_k_vel2,dx1,nou7_i_vel2_j_vel2_k_vel2, &
      diu7_i_vel2_j_vel2_k_vel2,v_i_vel2_j_vel2m1_k_vel2,v_i_vel2_j_vel2m1_k_vel2p1,dy1, &
      nou8_i_vel2_j_vel2_k_vel2,diu8_i_vel2_j_vel2_k_vel2,cov7_i_vel2_j_vel2_k_vel2, &
      cov8_i_vel2_j_vel2_k_vel2)
 case (st_velfg_map_218)
 j_range = ((300 - 1) + 1)
 i_range = ((300 - 1) + 1)
 k_rel = (global_id / (j_range * i_range))
 k = (k_rel + 1)
 j_rel = ((global_id - (k_rel * (j_range * i_range))) / i_range)
 j = (j_rel + 1)
 i_rel = ((global_id - (k_rel * (j_range * i_range))) - (j_rel * i_range))
 i = (i_rel + 1)
call velfg_map_218(dx1,cov1_i_j_k,cov1_ip1_j_k,cov2_i_j_k,cov2_i_jp1_k,cov3_i_j_k,cov3_i_j_kp1, &
      diu1_i_j_k,diu1_ip1_j_k,diu2_i_j_k,diu2_i_jp1_k,dy1,diu3_i_j_k,diu3_i_j_kp1,dzn,dfu1_i_j_k, &
      cov4_i_j_k,cov4_ip1_j_k,cov5_i_j_k,cov5_i_jp1_k,cov6_i_j_k,cov6_i_j_kp1,diu4_i_j_k, &
      diu4_ip1_j_k,diu5_i_j_k,diu5_i_jp1_k,diu6_i_j_k,diu6_i_j_kp1,dfv1_i_j_k,cov7_i_j_k, &
      cov7_ip1_j_k,cov8_i_j_k,cov8_i_jp1_k,cov9_i_j_k,cov9_i_j_kp1,diu7_i_j_k,diu7_ip1_j_k, &
      diu8_i_j_k,diu8_i_jp1_k,diu9_i_j_k,diu9_i_j_kp1,dzs,dfw1_i_j_k,f_i_j_k,g_i_j_k,h_i_j_k)
 end select
end subroutine velfg_superkernel

end module singleton_module_velfg_superkernel

