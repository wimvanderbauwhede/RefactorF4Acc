module singleton_module_velfg_map_133
contains

pure subroutine velfg_map_133_scal(dzn,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2m1_j_vel2_k_vel2p1,w_i_vel2_j_vel2m1_k_vel2,w_i_vel2m1_j_vel2_k_vel2,w_i_vel2_j_vel2_k_vel2,dx1,nou7_i_vel2_j_vel2_k_vel2,diu7_i_vel2_j_vel2_k_vel2,v_i_vel2_j_vel2m1_k_vel2,v_i_vel2_j_vel2m1_k_vel2p1,dy1,nou8_i_vel2_j_vel2_k_vel2,diu8_i_vel2_j_vel2_k_vel2,cov7_i_vel2_j_vel2_k_vel2,cov8_i_vel2_j_vel2_k_vel2,global_id)
      implicit none
      integer, parameter :: ip___velfg_map_133_scal=300
      integer, parameter :: jp___velfg_map_133_scal=300
      integer, parameter :: kp___velfg_map_133_scal=90
      integer, parameter :: im___velfg_map_133_scal=300
      integer, parameter :: jm___velfg_map_133_scal=300
      integer, parameter :: km___velfg_map_133_scal=90
      integer, parameter :: ifbf___velfg_map_133_scal=1
      integer, parameter :: ianime___velfg_map_133_scal=1
      integer, parameter :: ical___velfg_map_133_scal=0
      integer, parameter :: n0___velfg_map_133_scal=1
      integer, parameter :: n1___velfg_map_133_scal=10001
      integer, parameter :: nmax___velfg_map_133_scal=20000
      real, parameter :: dt___velfg_map_133_scal=0.2
      real, parameter :: ro___velfg_map_133_scal=1.1763
      real, parameter :: vn___velfg_map_133_scal=15.83 * 10. ** (-6.)
      real, parameter :: alpha___velfg_map_133_scal=-10.
      real, parameter :: beta___velfg_map_133_scal=-1.
      integer, parameter :: u0___velfg_map_133_scal=0
 integer :: i_vel2___velfg_map_133_scal
 integer :: j_vel2___velfg_map_133_scal
 integer :: k_vel2___velfg_map_133_scal
 integer :: k_vel2_range___velfg_m___a725d29e
 integer :: j_vel2_range___velfg_m___9675913f
 integer :: i_vel2_range___velfg_m___a1f7aab8
 integer :: k_vel2_rel___velfg_map_133_scal
 integer :: j_vel2_rel___velfg_map_133_scal
 integer :: i_vel2_rel___velfg_map_133_scal
 real, dimension((-1):(90+2)), intent(in) :: dzn
 real, intent(in) :: u_i_vel2m1_j_vel2_k_vel2
 real, intent(in) :: u_i_vel2m1_j_vel2_k_vel2p1
 real, intent(in) :: w_i_vel2_j_vel2_k_vel2
 real, intent(in) :: w_i_vel2_j_vel2m1_k_vel2
 real, intent(in) :: w_i_vel2m1_j_vel2_k_vel2
 real, dimension((-1):(300+1)), intent(in) :: dx1
 real, intent(in) :: v_i_vel2_j_vel2m1_k_vel2
 real, intent(in) :: v_i_vel2_j_vel2m1_k_vel2p1
 real, dimension(0:(300+1)), intent(in) :: dy1
 real, intent(out) :: cov7_i_vel2_j_vel2_k_vel2
 real, intent(out) :: cov8_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou7_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu7_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: nou8_i_vel2_j_vel2_k_vel2
 real, intent(inout) :: diu8_i_vel2_j_vel2_k_vel2
 integer, intent(in) :: global_id
!       call get_global_id(global_id,0)
 k_vel2_range___velfg_m___a725d29e = (((90 - 1) - 1) + 1)
 j_vel2_range___velfg_m___9675913f = ((300 - 1) + 1)
 i_vel2_range___velfg_m___a1f7aab8 = ((300 - 1) + 1)
 k_vel2_rel___velfg_map_133_scal = (global_id / (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))
 k_vel2___velfg_map_133_scal = (k_vel2_rel___velfg_map_133_scal + 1)
 j_vel2_rel___velfg_map_133_scal = ((global_id - (k_vel2_rel___velfg_map_133_scal * (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))) / i_vel2_range___velfg_m___a1f7aab8)
 j_vel2___velfg_map_133_scal = (j_vel2_rel___velfg_map_133_scal + 1)
 i_vel2_rel___velfg_map_133_scal = ((global_id - (k_vel2_rel___velfg_map_133_scal * (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))) - (j_vel2_rel___velfg_map_133_scal *        i_vel2_range___velfg_m___a1f7aab8))
 i_vel2___velfg_map_133_scal = (i_vel2_rel___velfg_map_133_scal + 1)
 nou7_i_vel2_j_vel2_k_vel2 = (dzn(k_vel2___velfg_map_133_scal + 1) * u_i_vel2m1_j_vel2_k_vel2 + dzn(k_vel2___velfg_map_133_scal) *        u_i_vel2m1_j_vel2_k_vel2p1) / (dzn(k_vel2___velfg_map_133_scal) + dzn(k_vel2___velfg_map_133_scal + 1))
 diu7_i_vel2_j_vel2_k_vel2 = 2. * (-w_i_vel2m1_j_vel2_k_vel2 + w_i_vel2_j_vel2_k_vel2) /        (dx1(i_vel2___velfg_map_133_scal - 1) + dx1(i_vel2___velfg_map_133_scal))
 cov7_i_vel2_j_vel2_k_vel2 = (nou7_i_vel2_j_vel2_k_vel2 - u0___velfg_map_133_scal) * diu7_i_vel2_j_vel2_k_vel2
 nou8_i_vel2_j_vel2_k_vel2 = (dzn(k_vel2___velfg_map_133_scal + 1) * v_i_vel2_j_vel2m1_k_vel2 + dzn(k_vel2___velfg_map_133_scal) *        v_i_vel2_j_vel2m1_k_vel2p1) / (dzn(k_vel2___velfg_map_133_scal) + dzn(k_vel2___velfg_map_133_scal + 1))
 diu8_i_vel2_j_vel2_k_vel2 = 2. * (-w_i_vel2_j_vel2m1_k_vel2 + w_i_vel2_j_vel2_k_vel2) /        (dy1(j_vel2___velfg_map_133_scal - 1) + dy1(j_vel2___velfg_map_133_scal))
 cov8_i_vel2_j_vel2_k_vel2 = nou8_i_vel2_j_vel2_k_vel2 * diu8_i_vel2_j_vel2_k_vel2
end subroutine velfg_map_133_scal
end module singleton_module_velfg_map_133
