module singleton_module_velfg_map_76
contains

pure subroutine velfg_map_76_scal(u_i_vel2_j_vel2_k_vel2m1,u_i_vel2_j_vel2m1_k_vel2,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2_j_vel2_k_vel2,u_i_vel2m1_j_vel2p1_k_vel2,dx1,v_i_vel2_j_vel2_k_vel2m1,v_i_vel2_j_vel2m1_k_vel2,v_i_vel2p1_j_vel2m1_k_vel2,v_i_vel2m1_j_vel2_k_vel2,v_i_vel2_j_vel2_k_vel2,dy1,w_i_vel2_j_vel2_k_vel2m1,w_i_vel2p1_j_vel2_k_vel2m1,w_i_vel2_j_vel2p1_k_vel2m1,w_i_vel2_j_vel2_k_vel2,dzn,nou1_i_vel2_j_vel2_k_vel2,diu1_i_vel2_j_vel2_k_vel2,nou5_i_vel2_j_vel2_k_vel2,diu5_i_vel2_j_vel2_k_vel2,nou9_i_vel2_j_vel2_k_vel2,diu9_i_vel2_j_vel2_k_vel2,nou2_i_vel2_j_vel2_k_vel2,diu2_i_vel2_j_vel2_k_vel2,dzs,nou3_i_vel2_j_vel2_k_vel2,diu3_i_vel2_j_vel2_k_vel2,nou4_i_vel2_j_vel2_k_vel2,diu4_i_vel2_j_vel2_k_vel2,nou6_i_vel2_j_vel2_k_vel2,diu6_i_vel2_j_vel2_k_vel2,cov1_i_vel2_j_vel2_k_vel2,cov5_i_vel2_j_vel2_k_vel2,cov9_i_vel2_j_vel2_k_vel2,cov2_i_vel2_j_vel2_k_vel2,cov3_i_vel2_j_vel2_k_vel2,cov4_i_vel2_j_vel2_k_vel2,cov6_i_vel2_j_vel2_k_vel2,global_id)
      implicit none
      integer, parameter :: ip___velfg_map_76_scal=300
      integer, parameter :: jp___velfg_map_76_scal=300
      integer, parameter :: kp___velfg_map_76_scal=90
      integer, parameter :: im___velfg_map_76_scal=300
      integer, parameter :: jm___velfg_map_76_scal=300
      integer, parameter :: km___velfg_map_76_scal=90
      integer, parameter :: ifbf___velfg_map_76_scal=1
      integer, parameter :: ianime___velfg_map_76_scal=1
      integer, parameter :: ical___velfg_map_76_scal=0
      integer, parameter :: n0___velfg_map_76_scal=1
      integer, parameter :: n1___velfg_map_76_scal=10001
      integer, parameter :: nmax___velfg_map_76_scal=20000
      real, parameter :: dt___velfg_map_76_scal=0.2
      real, parameter :: ro___velfg_map_76_scal=1.1763
      real, parameter :: vn___velfg_map_76_scal=15.83 * 10. ** (-6.)
      real, parameter :: alpha___velfg_map_76_scal=-10.
      real, parameter :: beta___velfg_map_76_scal=-1.
      integer, parameter :: u0___velfg_map_76_scal=0
 integer :: i_vel2___velfg_map_76_scal
 integer :: j_vel2___velfg_map_76_scal
 integer :: k_vel2___velfg_map_76_scal
 integer :: k_vel2_range___velfg_m___9606c486
 integer :: j_vel2_range___velfg_m___4b6e60e4
 integer :: i_vel2_range___velfg_m___ea66ec4a
 integer :: k_vel2_rel___velfg_map_76_scal
 integer :: j_vel2_rel___velfg_map_76_scal
 integer :: i_vel2_rel___velfg_map_76_scal
 real, intent(in) :: u_i_vel2_j_vel2_k_vel2
 real, intent(in) :: u_i_vel2_j_vel2_k_vel2m1
 real, intent(in) :: u_i_vel2_j_vel2m1_k_vel2
 real, intent(in) :: u_i_vel2m1_j_vel2_k_vel2
 real, intent(in) :: u_i_vel2m1_j_vel2p1_k_vel2
 real, dimension((-1):(300+1)), intent(in) :: dx1
 real, intent(in) :: v_i_vel2_j_vel2_k_vel2
 real, intent(in) :: v_i_vel2_j_vel2_k_vel2m1
 real, intent(in) :: v_i_vel2_j_vel2m1_k_vel2
 real, intent(in) :: v_i_vel2m1_j_vel2_k_vel2
 real, intent(in) :: v_i_vel2p1_j_vel2m1_k_vel2
 real, dimension(0:(300+1)), intent(in) :: dy1
 real, intent(in) :: w_i_vel2_j_vel2_k_vel2
 real, intent(in) :: w_i_vel2_j_vel2_k_vel2m1
 real, intent(in) :: w_i_vel2_j_vel2p1_k_vel2m1
 real, intent(in) :: w_i_vel2p1_j_vel2_k_vel2m1
 real, dimension((-1):(90+2)), intent(in) :: dzn
 real, dimension((-1):(90+2)), intent(in) :: dzs
 real, intent(out) :: cov1_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov5_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov9_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov2_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov3_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov4_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov6_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou1_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu1_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou5_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu5_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou9_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu9_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou2_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu2_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou3_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu3_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou4_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu4_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou6_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu6_i_vel2_j_vel2_k_vel2
 integer, intent(in) :: global_id
 integer :: th_idx___velfg_map_76_scal
 th_idx___velfg_map_76_scal = global_id
!       call get_global_id(th_idx,0)
 k_vel2_range___velfg_m___9606c486 = (((90 + 1) - 1) + 1)
 j_vel2_range___velfg_m___4b6e60e4 = ((300 - 1) + 1)
 i_vel2_range___velfg_m___ea66ec4a = ((300 - 1) + 1)
 k_vel2_rel___velfg_map_76_scal = (th_idx___velfg_map_76_scal / (j_vel2_range___velfg_m___4b6e60e4 * i_vel2_range___velfg_m___ea66ec4a))
 k_vel2___velfg_map_76_scal = (k_vel2_rel___velfg_map_76_scal + 1)
 j_vel2_rel___velfg_map_76_scal = ((th_idx___velfg_map_76_scal - (k_vel2_rel___velfg_map_76_scal * (j_vel2_range___velfg_m___4b6e60e4 * i_vel2_range___velfg_m___ea66ec4a))) / i_vel2_range___velfg_m___ea66ec4a)
 j_vel2___velfg_map_76_scal = (j_vel2_rel___velfg_map_76_scal + 1)
 i_vel2_rel___velfg_map_76_scal = ((th_idx___velfg_map_76_scal - (k_vel2_rel___velfg_map_76_scal * (j_vel2_range___velfg_m___4b6e60e4 * i_vel2_range___velfg_m___ea66ec4a))) - (j_vel2_rel___velfg_map_76_scal *        i_vel2_range___velfg_m___ea66ec4a))
 i_vel2___velfg_map_76_scal = (i_vel2_rel___velfg_map_76_scal + 1)
 if ((k_vel2___velfg_map_76_scal < 90)) then
 nou1_i_vel2_j_vel2_k_vel2 = (u_i_vel2m1_j_vel2_k_vel2 + u_i_vel2_j_vel2_k_vel2) / 2.
 diu1_i_vel2_j_vel2_k_vel2 = (-u_i_vel2m1_j_vel2_k_vel2 + u_i_vel2_j_vel2_k_vel2) / dx1(i_vel2___velfg_map_76_scal)
 nou5_i_vel2_j_vel2_k_vel2 = (v_i_vel2_j_vel2m1_k_vel2 + v_i_vel2_j_vel2_k_vel2) / 2.
 diu5_i_vel2_j_vel2_k_vel2 = (-v_i_vel2_j_vel2m1_k_vel2 + v_i_vel2_j_vel2_k_vel2) / dy1(j_vel2___velfg_map_76_scal)
 nou9_i_vel2_j_vel2_k_vel2 = (w_i_vel2_j_vel2_k_vel2m1 + w_i_vel2_j_vel2_k_vel2) / 2.
 diu9_i_vel2_j_vel2_k_vel2 = (-w_i_vel2_j_vel2_k_vel2m1 + w_i_vel2_j_vel2_k_vel2) / dzn(k_vel2___velfg_map_76_scal)
 cov1_i_vel2_j_vel2_k_vel2 = nou1_i_vel2_j_vel2_k_vel2 * diu1_i_vel2_j_vel2_k_vel2
 cov5_i_vel2_j_vel2_k_vel2 = nou5_i_vel2_j_vel2_k_vel2 * diu5_i_vel2_j_vel2_k_vel2
 cov9_i_vel2_j_vel2_k_vel2 = nou9_i_vel2_j_vel2_k_vel2 * diu9_i_vel2_j_vel2_k_vel2
 end if
 if ((k_vel2___velfg_map_76_scal < 90)) then
 nou2_i_vel2_j_vel2_k_vel2 = (dx1(i_vel2___velfg_map_76_scal + 1) * v_i_vel2_j_vel2m1_k_vel2 + dx1(i_vel2___velfg_map_76_scal) *        v_i_vel2p1_j_vel2m1_k_vel2) / (dx1(i_vel2___velfg_map_76_scal) + dx1(i_vel2___velfg_map_76_scal + 1))
 diu2_i_vel2_j_vel2_k_vel2 = 2. * (-u_i_vel2_j_vel2m1_k_vel2 + u_i_vel2_j_vel2_k_vel2) /        (dy1(j_vel2___velfg_map_76_scal - 1) + dy1(j_vel2___velfg_map_76_scal))
 cov2_i_vel2_j_vel2_k_vel2 = nou2_i_vel2_j_vel2_k_vel2 * diu2_i_vel2_j_vel2_k_vel2
 end if
 nou3_i_vel2_j_vel2_k_vel2 = (dx1(i_vel2___velfg_map_76_scal + 1) * w_i_vel2_j_vel2_k_vel2m1 + dx1(i_vel2___velfg_map_76_scal) *        w_i_vel2p1_j_vel2_k_vel2m1) / (dx1(i_vel2___velfg_map_76_scal) + dx1(i_vel2___velfg_map_76_scal + 1))
 diu3_i_vel2_j_vel2_k_vel2 = (-u_i_vel2_j_vel2_k_vel2m1 + u_i_vel2_j_vel2_k_vel2) / dzs(k_vel2___velfg_map_76_scal - 1)
 cov3_i_vel2_j_vel2_k_vel2 = nou3_i_vel2_j_vel2_k_vel2 * diu3_i_vel2_j_vel2_k_vel2
 if ((k_vel2___velfg_map_76_scal < 90)) then
 nou4_i_vel2_j_vel2_k_vel2 = (dy1(j_vel2___velfg_map_76_scal + 1) * u_i_vel2m1_j_vel2_k_vel2 + dy1(j_vel2___velfg_map_76_scal) *        u_i_vel2m1_j_vel2p1_k_vel2) / (dy1(j_vel2___velfg_map_76_scal) + dy1(j_vel2___velfg_map_76_scal + 1))
 diu4_i_vel2_j_vel2_k_vel2 = 2. * (-v_i_vel2m1_j_vel2_k_vel2 + v_i_vel2_j_vel2_k_vel2) /        (dx1(i_vel2___velfg_map_76_scal - 1) + dx1(i_vel2___velfg_map_76_scal))
 cov4_i_vel2_j_vel2_k_vel2 = (nou4_i_vel2_j_vel2_k_vel2 - u0___velfg_map_76_scal) * diu4_i_vel2_j_vel2_k_vel2
 end if
 nou6_i_vel2_j_vel2_k_vel2 = (dy1(j_vel2___velfg_map_76_scal + 1) * w_i_vel2_j_vel2_k_vel2m1 + dy1(j_vel2___velfg_map_76_scal) *        w_i_vel2_j_vel2p1_k_vel2m1) / (dy1(j_vel2___velfg_map_76_scal) + dy1(j_vel2___velfg_map_76_scal + 1))
 diu6_i_vel2_j_vel2_k_vel2 = (-v_i_vel2_j_vel2_k_vel2m1 + v_i_vel2_j_vel2_k_vel2) / dzs(k_vel2___velfg_map_76_scal - 1)
 cov6_i_vel2_j_vel2_k_vel2 = nou6_i_vel2_j_vel2_k_vel2 * diu6_i_vel2_j_vel2_k_vel2
end subroutine velfg_map_76_scal
end module singleton_module_velfg_map_76
