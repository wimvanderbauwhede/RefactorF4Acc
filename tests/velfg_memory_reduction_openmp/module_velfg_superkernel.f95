module module_velfg_superkernel
    contains
subroutine velfg_map_76(u,dx1,v,dy1,w,dzn,nou1,diu1,nou5,diu5,nou9,diu9,nou2,diu2,dzs,nou3,diu3,nou4,diu4,nou6,diu6,cov1,cov5,cov9,cov2,cov3,cov4,cov6,global_id)
     integer, parameter :: ip=300
     integer, parameter :: jp=300
     integer, parameter :: kp=90
     integer, parameter :: im=300
     integer, parameter :: jm=300
     integer, parameter :: km=90
     integer, parameter :: ifbf=1
     integer, parameter :: ianime=1
     integer, parameter :: ical=0
     integer, parameter :: n0=1
     integer, parameter :: n1=10001
     integer, parameter :: nmax=20000
     real, parameter :: dt=0.2
     real, parameter :: ro=1.1763
     real, parameter :: vn=15.83 * 10. ** (-6.)
     real, parameter :: alpha=-10.
     real, parameter :: beta=-1.
     integer, parameter :: u0=0
    integer :: i_vel2
    integer :: j_vel2
    integer :: k_vel2
    integer :: k_vel2_range
    integer :: j_vel2_range
    integer :: i_vel2_range
    integer :: k_vel2_rel
    integer :: j_vel2_rel
    integer :: i_vel2_rel
    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(In) :: u
    real, dimension((-1):(ip + 1)), intent(In) :: dx1
    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(In) :: v
    real, dimension(0:(jp + 1)), intent(In) :: dy1
    real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(In) :: w
    real, dimension((-1):(kp + 2)), intent(In) :: dzn
    real, dimension((-1):(kp + 2)), intent(In) :: dzs
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov1
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov5
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov9
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov2
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov3
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov4
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: cov6
    real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: nou1
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: diu1
    real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(Out) :: nou5
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu5
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou9
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu9
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou2
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu2
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou3
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu3
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou4
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu4
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou6
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu6
    integer, intent(In) :: global_id
    integer :: th_idx
    th_idx = global_id
!     call get_global_id(th_idx,0)
    k_vel2_range = (((90 + 1) - 1) + 1)
    j_vel2_range = ((300 - 1) + 1)
    i_vel2_range = ((300 - 1) + 1)
    k_vel2_rel = (th_idx / (j_vel2_range * i_vel2_range))
    k_vel2 = (k_vel2_rel + 1)
    j_vel2_rel = ((th_idx - (k_vel2_rel * (j_vel2_range * i_vel2_range))) / i_vel2_range)
    j_vel2 = (j_vel2_rel + 1)
    i_vel2_rel = ((th_idx - (k_vel2_rel * (j_vel2_range * i_vel2_range))) - (j_vel2_rel * i_vel2_range))
    i_vel2 = (i_vel2_rel + 1)
    if ((k_vel2 < 90)) then
 nou1(i_vel2,j_vel2,k_vel2) = (u(i_vel2-1,j_vel2,k_vel2)+u(i_vel2,j_vel2,k_vel2))/2.
 diu1(i_vel2,j_vel2,k_vel2) = (-u(i_vel2-1,j_vel2,k_vel2)+u(i_vel2,j_vel2,k_vel2))/dx1(i_vel2)
 nou5(i_vel2,j_vel2,k_vel2) = (v(i_vel2,j_vel2-1,k_vel2)+v(i_vel2,j_vel2,k_vel2))/2.
 diu5(i_vel2,j_vel2,k_vel2) = (-v(i_vel2,j_vel2-1,k_vel2)+v(i_vel2,j_vel2,k_vel2))/dy1(j_vel2)
 nou9(i_vel2,j_vel2,k_vel2) = (w(i_vel2,j_vel2,k_vel2-1)+w(i_vel2,j_vel2,k_vel2))/2.
 diu9(i_vel2,j_vel2,k_vel2) = (-w(i_vel2,j_vel2,k_vel2-1)+w(i_vel2,j_vel2,k_vel2))/dzn(k_vel2)
 cov1(i_vel2,j_vel2,k_vel2) = nou1(i_vel2,j_vel2,k_vel2)*diu1(i_vel2,j_vel2,k_vel2)
 cov5(i_vel2,j_vel2,k_vel2) = nou5(i_vel2,j_vel2,k_vel2)*diu5(i_vel2,j_vel2,k_vel2)
 cov9(i_vel2,j_vel2,k_vel2) = nou9(i_vel2,j_vel2,k_vel2)*diu9(i_vel2,j_vel2,k_vel2)
    end if
    if ((k_vel2 < 90)) then
 nou2(i_vel2,j_vel2,k_vel2) = (dx1(i_vel2+1)*v(i_vel2,j_vel2-1,k_vel2)+dx1(i_vel2)*v(i_vel2+1, &
      j_vel2-1,k_vel2)) /(dx1(i_vel2)+dx1(i_vel2+1))
 diu2(i_vel2,j_vel2,k_vel2)=2.*(-u(i_vel2,j_vel2-1,k_vel2)+u(i_vel2,j_vel2, &
      k_vel2))/(dy1(j_vel2-1)+dy1(j_vel2))
 cov2(i_vel2,j_vel2,k_vel2)=nou2(i_vel2,j_vel2,k_vel2)*diu2(i_vel2,j_vel2,k_vel2)
    end if
 nou3(i_vel2,j_vel2,k_vel2) = (dx1(i_vel2+1)*w(i_vel2,j_vel2,k_vel2-1)+dx1(i_vel2)*w(i_vel2+1, &
      j_vel2,k_vel2-1)) /(dx1(i_vel2)+dx1(i_vel2+1))
 diu3(i_vel2,j_vel2,k_vel2) = (-u(i_vel2,j_vel2,k_vel2-1)+u(i_vel2,j_vel2,k_vel2))/dzs(k_vel2-1)
 cov3(i_vel2,j_vel2,k_vel2) = nou3(i_vel2,j_vel2,k_vel2)*diu3(i_vel2,j_vel2,k_vel2)
    if ((k_vel2 < 90)) then
 nou4(i_vel2,j_vel2,k_vel2) = (dy1(j_vel2+1)*u(i_vel2-1,j_vel2,k_vel2)+dy1(j_vel2)*u(i_vel2-1, &
      j_vel2+1,k_vel2)) /(dy1(j_vel2)+dy1(j_vel2+1))
 diu4(i_vel2,j_vel2,k_vel2) = 2.*(-v(i_vel2-1,j_vel2,k_vel2)+v(i_vel2,j_vel2, &
      k_vel2))/(dx1(i_vel2-1)+dx1(i_vel2))
 cov4(i_vel2,j_vel2,k_vel2) = (nou4(i_vel2,j_vel2,k_vel2)-u0)*diu4(i_vel2,j_vel2,k_vel2)
    end if
 nou6(i_vel2,j_vel2,k_vel2) = (dy1(j_vel2+1)*w(i_vel2,j_vel2,k_vel2-1)+dy1(j_vel2)*w(i_vel2, &
      j_vel2+1,k_vel2-1)) /(dy1(j_vel2)+dy1(j_vel2+1))
 diu6(i_vel2,j_vel2,k_vel2) = (-v(i_vel2,j_vel2,k_vel2-1)+v(i_vel2,j_vel2,k_vel2))/dzs(k_vel2-1)
 cov6(i_vel2,j_vel2,k_vel2) = nou6(i_vel2,j_vel2,k_vel2)*diu6(i_vel2,j_vel2,k_vel2)
end subroutine velfg_map_76

subroutine velfg_map_133(dzn,u,w,dx1,nou7,diu7,v,dy1,nou8,diu8,cov7,cov8,global_id)
     integer, parameter :: ip=300
     integer, parameter :: jp=300
     integer, parameter :: kp=90
     integer, parameter :: im=300
     integer, parameter :: jm=300
     integer, parameter :: km=90
     integer, parameter :: ifbf=1
     integer, parameter :: ianime=1
     integer, parameter :: ical=0
     integer, parameter :: n0=1
     integer, parameter :: n1=10001
     integer, parameter :: nmax=20000
     real, parameter :: dt=0.2
     real, parameter :: ro=1.1763
     real, parameter :: vn=15.83 * 10. ** (-6.)
     real, parameter :: alpha=-10.
     real, parameter :: beta=-1.
     integer, parameter :: u0=0
    integer :: i_vel2
    integer :: j_vel2
    integer :: k_vel2
    integer :: k_vel2_range
    integer :: j_vel2_range
    integer :: i_vel2_range
    integer :: k_vel2_rel
    integer :: j_vel2_rel
    integer :: i_vel2_rel
    real, dimension((-1):(kp + 2)), intent(In) :: dzn
    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(In) :: u
    real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(In) :: w
    real, dimension((-1):(ip + 1)), intent(In) :: dx1
    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(In) :: v
    real, dimension(0:(jp + 1)), intent(In) :: dy1
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: cov7
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: cov8
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou7
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu7
    real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: nou8
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) , intent(Out):: diu8
    integer, intent(In) :: global_id

!     call get_global_id(global_id,0)
    k_vel2_range = (((90 - 1) - 1) + 1)
    j_vel2_range = ((300 - 1) + 1)
    i_vel2_range = ((300 - 1) + 1)
    k_vel2_rel = (global_id / (j_vel2_range * i_vel2_range))
    k_vel2 = (k_vel2_rel + 1)
    j_vel2_rel = ((global_id - (k_vel2_rel * (j_vel2_range * i_vel2_range))) / i_vel2_range)
    j_vel2 = (j_vel2_rel + 1)
    i_vel2_rel = ((global_id - (k_vel2_rel * (j_vel2_range * i_vel2_range))) - (j_vel2_rel * i_vel2_range))
    i_vel2 = (i_vel2_rel + 1)
 nou7(i_vel2,j_vel2,k_vel2) = (dzn(k_vel2+1)*u(i_vel2-1,j_vel2,k_vel2)+dzn(k_vel2)*u(i_vel2-1, &
      j_vel2,k_vel2+1)) /(dzn(k_vel2)+dzn(k_vel2+1))
 diu7(i_vel2,j_vel2,k_vel2) = 2.*(-w(i_vel2-1,j_vel2,k_vel2)+w(i_vel2,j_vel2, &
      k_vel2))/(dx1(i_vel2-1)+dx1(i_vel2))
 cov7(i_vel2,j_vel2,k_vel2) = (nou7(i_vel2,j_vel2,k_vel2)-u0)*diu7(i_vel2,j_vel2,k_vel2)
 nou8(i_vel2,j_vel2,k_vel2) = (dzn(k_vel2+1)*v(i_vel2,j_vel2-1,k_vel2)+dzn(k_vel2)*v(i_vel2, &
      j_vel2-1,k_vel2+1)) /(dzn(k_vel2)+dzn(k_vel2+1))
 diu8(i_vel2,j_vel2,k_vel2) = 2.*(-w(i_vel2,j_vel2-1,k_vel2)+w(i_vel2,j_vel2, &
      k_vel2))/(dy1(j_vel2-1)+dy1(j_vel2))
 cov8(i_vel2,j_vel2,k_vel2) = nou8(i_vel2,j_vel2,k_vel2)*diu8(i_vel2,j_vel2,k_vel2)
end subroutine velfg_map_133

subroutine velfg_map_218(dx1,cov1,cov2,cov3,diu1,diu2,dy1,diu3,dzn,dfu1,cov4,cov5,cov6,diu4,diu5,diu6,dfv1,cov7,cov8,cov9,diu7,diu8,diu9,dzs,dfw1,f,g,h,global_id)
     integer, parameter :: ip=300
     integer, parameter :: jp=300
     integer, parameter :: kp=90
     integer, parameter :: im=300
     integer, parameter :: jm=300
     integer, parameter :: km=90
     integer, parameter :: ifbf=1
     integer, parameter :: ianime=1
     integer, parameter :: ical=0
     integer, parameter :: n0=1
     integer, parameter :: n1=10001
     integer, parameter :: nmax=20000
     real, parameter :: dt=0.2
     real, parameter :: ro=1.1763
     real, parameter :: vn=15.83 * 10. ** (-6.)
     real, parameter :: alpha=-10.
     real, parameter :: beta=-1.
     integer, parameter :: u0=0
    real :: covx1
    integer :: i
    integer :: j
    integer :: k
    real :: covy1
    real :: covz1
    real :: covc
    real :: df
    integer :: k_range
    integer :: j_range
    integer :: i_range
    integer :: k_rel
    integer :: j_rel
    integer :: i_rel
    real, dimension((-1):(ip + 1)), intent(In) :: dx1
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov1
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov2
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov3
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu1
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu2
    real, dimension(0:(jp + 1)), intent(In) :: dy1
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu3
    real, dimension((-1):(kp + 2)), intent(In) :: dzn
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov4
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov5
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov6
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu4
    real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu5
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu6
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov7
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov8
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: cov9
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu7
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu8
    real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(In) :: diu9
    real, dimension((-1):(kp + 2)), intent(In) :: dzs
    real, dimension(0:ip,0:jp,0:kp), intent(Out) :: f
    real, dimension(0:ip,0:jp,0:kp), intent(Out) :: g
    real, dimension(0:ip,0:jp,0:kp), intent(Out) :: h
    real, dimension(0:ip,1:jp,1:kp), intent(Out) :: dfu1
    real, dimension(1:ip,0:jp,1:kp), intent(Out) :: dfv1
    real, dimension(1:ip,1:jp,1:kp), intent(Out) :: dfw1
    integer, intent(In) :: global_id

!     call get_global_id(global_id,0)
    k_range = ((90 - 1) + 1)
    j_range = ((300 - 1) + 1)
    i_range = ((300 - 1) + 1)
    k_rel = (global_id / (j_range * i_range))
    k = (k_rel + 1)
    j_rel = ((global_id - (k_rel * (j_range * i_range))) / i_range)
    j = (j_rel + 1)
    i_rel = ((global_id - (k_rel * (j_range * i_range))) - (j_rel * i_range))
    i = (i_rel + 1)
 covx1 = (dx1(i+1)*cov1(i,j,k)+dx1(i)*cov1(i+1,j,k)) /(dx1(i)+dx1(i+1))
 covy1 = (cov2(i,j,k)+cov2(i,j+1,k))/2.
 covz1 = (cov3(i,j,k)+cov3(i,j,k+1))/2.
 covc = covx1+covy1+covz1
 dfu1(i,j,k)=2.*(-diu1(i,j,k)+diu1(i+1,j,k))/(dx1(i)+dx1(i+1)) + (-diu2(i,j,k)+diu2(i,j+1, &
      k))/dy1(j) + (-diu3(i,j,k)+diu3(i,j,k+1))/dzn(k)
 df = vn*dfu1(i,j,k)
 f(i,j,k)=(-covc+df)
 covx1=(cov4(i,j,k)+cov4(i+1,j,k))/2.
 covy1=(dy1(j+1)*cov5(i,j,k)+dy1(j)*cov5(i,j+1,k)) /(dy1(j)+dy1(j+1))
 covz1=(cov6(i,j,k)+cov6(i,j,k+1))/2.
 covc = covx1+covy1+covz1
 dfv1(i,j,k)=(-diu4(i,j,k)+diu4(i+1,j,k))/dx1(i) +2.*(-diu5(i,j,k)+diu5(i,j+1, &
      k))/(dy1(j)+dy1(j+1)) +(-diu6(i,j,k)+diu6(i,j,k+1))/dzn(k)
     df = vn*dfv1(i,j,k)
 g(i,j,k)=(-covc+df)
    if ((k < (90 - 1))) then
 covx1=(cov7(i,j,k)+cov7(i+1,j,k))/2.
 covy1=(cov8(i,j,k)+cov8(i,j+1,k))/2.
 covz1=(dzn(k+1)*cov9(i,j,k)+dzn(k)*cov9(i,j,k+1)) /(dzn(k)+dzn(k+1))
 covc = covx1+covy1+covz1
 dfw1(i,j,k)=(-diu7(i,j,k)+diu7(i+1,j,k))/dx1(i) +(-diu8(i,j,k)+diu8(i,j+1,k))/dy1(j) +(-diu9(i,j, &
      k)+diu9(i,j,k+1))/dzs(k)
 df = vn*dfw1(i,j,k)
 h(i,j,k)=(-covc+df)
    end if
end subroutine velfg_map_218

subroutine velfg_superkernel(f,g,h,dzn,u,v,w,dx1,dy1,dzs,state_ptr,global_id)

    integer, parameter :: ip=300
    integer, parameter :: jp=300
    integer, parameter :: kp=90

  real, dimension((-1):(kp + 2)), intent(In) :: dzn
  real, dimension((-1):(kp + 2)), intent(In) :: dzs
  real, dimension((-1):(ip + 1)), intent(In) :: dx1
!   real, dimension((-1):(ip + 1)), intent(In) :: delx1
  real, dimension(0:(jp + 1)), intent(In) :: dy1
  real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(InOut) :: u
  real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)), intent(InOut) :: v
  real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)), intent(InOut) :: w
  real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu1
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu2
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu3
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu4
  real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu5
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu6
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu7
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu8
  real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)) :: diu9
  real, dimension(0:ip,0:jp,0:kp), intent(InOut) :: f
  real, dimension(0:ip,0:jp,0:kp), intent(InOut) :: g
  real, dimension(0:ip,0:jp,0:kp), intent(InOut) :: h
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
  integer, intent(In) :: state_ptr
  integer, intent(In) :: global_id
integer, parameter :: ST_ADAM_MAP_22 = 0 !  adam_map_22
integer, parameter :: ST_LES_MAP_87 = 10 !  les_map_87
integer, parameter :: ST_LES_MAP_107 = 11 !  les_map_107
integer, parameter :: ST_velfg_MAP_76 = 18 !  velfg_map_76
integer, parameter :: ST_velfg_MAP_133 = 19 !  velfg_map_133
integer, parameter :: ST_velfg_MAP_155 = 20 !  velfg_map_155
integer, parameter :: ST_velfg_MAP_162 = 21 !  velfg_map_162
integer, parameter :: ST_velfg_MAP_172 = 22 !  velfg_map_172
integer, parameter :: ST_velfg_MAP_179 = 23 !  velfg_map_179
integer, parameter :: ST_velfg_MAP_189 = 24 !  velfg_map_189
integer, parameter :: ST_velfg_MAP_196 = 25 !  velfg_map_196
integer, parameter :: ST_velfg_MAP_206 = 26 !  velfg_map_206
integer, parameter :: ST_velfg_MAP_212 = 27 !  velfg_map_212
integer, parameter :: ST_velfg_MAP_218 = 28 !  velfg_map_218
  state = state_ptr ! state
  select case(state)
    case (ST_velfg_MAP_76§)
      call velfg_map_76(u,dx1,v,dy1,w,dzn,nou1,diu1,nou5,diu5,nou9,diu9,nou2,diu2,dzs,nou3,diu3,nou4,diu4,nou6,diu6,cov1,cov5,cov9,cov2,cov3,cov4,cov6,global_id)
    case (ST_velfg_MAP_13§3)
      call velfg_map_133(dzn,u,w,dx1,nou7,diu7,v,dy1,nou8,diu8,cov7,cov8,global_id)
    case (ST_velfg_MAP_218)
      call velfg_map_218(dx1,cov1,cov2,cov3,diu1,diu2,dy1,diu3,dzn,dfu1,cov4,cov5,cov6,diu4,diu5,diu6,dfv1,cov7,cov8,cov9,diu7,diu8,diu9,dzs,dfw1,f,g,h,global_id)
  end select
end subroutine velfg_superkernel
end module module_velfg_superkernel
