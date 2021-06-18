module singleton_module_velfg_map_133

contains

subroutine velfg_map_133_scal(dzn,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2m1_j_vel2_k_vel2p1, &
      w_i_vel2_j_vel2m1_k_vel2,w_i_vel2m1_j_vel2_k_vel2,w_i_vel2_j_vel2_k_vel2,dx1, &
      nou7_i_vel2_j_vel2_k_vel2,diu7_i_vel2_j_vel2_k_vel2,v_i_vel2_j_vel2m1_k_vel2, &
      v_i_vel2_j_vel2m1_k_vel2p1,dy1,nou8_i_vel2_j_vel2_k_vel2,diu8_i_vel2_j_vel2_k_vel2, &
      cov7_i_vel2_j_vel2_k_vel2,cov8_i_vel2_j_vel2_k_vel2)
 integer, parameter :: u0=0
!    ! Local vars: i_vel2,j_vel2,k_vel2
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, dimension((-1):(kp+2)), intent(in) :: dzn
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2p1
 real, intent(In) :: w_i_vel2_j_vel2_k_vel2
 real, intent(In) :: w_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: w_i_vel2m1_j_vel2_k_vel2
 real, dimension((-1):(ip+1)), intent(in) :: dx1
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2p1
 real, dimension(0:(jp+1)), intent(in) :: dy1
!  WRITTEN
 real, intent(Out) :: cov7_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov8_i_vel2_j_vel2_k_vel2
!  READ & WRITTEN
 real, intent(InOut) :: nou7_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu7_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou8_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu8_i_vel2_j_vel2_k_vel2
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 nou7_i_vel2_j_vel2_k_vel2 = (dzn(k_vel2 + 1) * u_i_vel2m1_j_vel2_k_vel2 + dzn(k_vel2) *  &
      u_i_vel2m1_j_vel2_k_vel2p1) / (dzn(k_vel2) + dzn(k_vel2 + 1))
 diu7_i_vel2_j_vel2_k_vel2 = 2. * (-w_i_vel2m1_j_vel2_k_vel2 + w_i_vel2_j_vel2_k_vel2) /  &
      (dx1(i_vel2 - 1) + dx1(i_vel2))
 cov7_i_vel2_j_vel2_k_vel2 = (nou7_i_vel2_j_vel2_k_vel2 - u0) * diu7_i_vel2_j_vel2_k_vel2
 nou8_i_vel2_j_vel2_k_vel2 = (dzn(k_vel2 + 1) * v_i_vel2_j_vel2m1_k_vel2 + dzn(k_vel2) *  &
      v_i_vel2_j_vel2m1_k_vel2p1) / (dzn(k_vel2) + dzn(k_vel2 + 1))
 diu8_i_vel2_j_vel2_k_vel2 = 2. * (-w_i_vel2_j_vel2m1_k_vel2 + w_i_vel2_j_vel2_k_vel2) /  &
      (dy1(j_vel2 - 1) + dy1(j_vel2))
 cov8_i_vel2_j_vel2_k_vel2 = nou8_i_vel2_j_vel2_k_vel2 * diu8_i_vel2_j_vel2_k_vel2
end subroutine velfg_map_133_scal
!  subroutine velfg_map_155(nou1,diu1,cov1)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: j_vel2,k_vel2
!      integer :: j_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: j_vel2_range
!      integer :: k_vel2_rel
!      integer :: j_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: nou1
!      real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu1
!      real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: cov1
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = ((90 - 1) + 1)
!      j_vel2_range = ((150 - 1) + 1)
!      k_vel2_rel = (global_id / j_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      j_vel2_rel = (global_id - (k_vel2_rel * j_vel2_range))
!      j_vel2 = (j_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   nou1(im+1,j_vel2,k_vel2)=nou1(im,j_vel2,k_vel2)
!   diu1(im+1,j_vel2,k_vel2)=diu1(im,j_vel2,k_vel2)
!   cov1(im+1,j_vel2,k_vel2)=cov1(im,j_vel2,k_vel2)
!  end subroutine velfg_map_155
!  subroutine velfg_map_162(nou2,diu2,cov2)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: i_vel2,k_vel2
!      integer :: i_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: i_vel2_range
!      integer :: k_vel2_rel
!      integer :: i_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: nou2
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu2
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: cov2
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = ((90 - 1) + 1)
!      i_vel2_range = ((150 - 1) + 1)
!      k_vel2_rel = (global_id / i_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      i_vel2_rel = (global_id - (k_vel2_rel * i_vel2_range))
!      i_vel2 = (i_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   nou2(i_vel2,0,k_vel2)=nou2(i_vel2,jm,k_vel2)
!   diu2(i_vel2,0,k_vel2)=diu2(i_vel2,jm,k_vel2)
!   cov2(i_vel2,0,k_vel2)=cov2(i_vel2,jm,k_vel2)
!   nou2(i_vel2,jm+1,k_vel2)=nou2(i_vel2,1,k_vel2)
!   diu2(i_vel2,jm+1,k_vel2)=diu2(i_vel2,1,k_vel2)
!   cov2(i_vel2,jm+1,k_vel2)=cov2(i_vel2,1,k_vel2)
!  end subroutine velfg_map_162
!  subroutine velfg_map_172(nou4,diu4,cov4)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: j_vel2,k_vel2
!      integer :: j_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: j_vel2_range
!      integer :: k_vel2_rel
!      integer :: j_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: nou4
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu4
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: cov4
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = ((90 - 1) + 1)
!      j_vel2_range = ((150 - 1) + 1)
!      k_vel2_rel = (global_id / j_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      j_vel2_rel = (global_id - (k_vel2_rel * j_vel2_range))
!      j_vel2 = (j_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   nou4(im+1,j_vel2,k_vel2)=nou4(im,j_vel2,k_vel2)
!   diu4(im+1,j_vel2,k_vel2)=diu4(im,j_vel2,k_vel2)
!   cov4(im+1,j_vel2,k_vel2)=cov4(im,j_vel2,k_vel2)
!  end subroutine velfg_map_172
!  subroutine velfg_map_179(nou5,diu5,cov5)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: i_vel2,k_vel2
!      integer :: i_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: i_vel2_range
!      integer :: k_vel2_rel
!      integer :: i_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real(kind=4), dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: nou5
!      real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu5
!      real, dimension((-1):(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: cov5
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = ((90 - 1) + 1)
!      i_vel2_range = ((150 - 1) + 1)
!      k_vel2_rel = (global_id / i_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      i_vel2_rel = (global_id - (k_vel2_rel * i_vel2_range))
!      i_vel2 = (i_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   nou5(i_vel2,0,k_vel2)=nou5(i_vel2,jm,k_vel2)
!   diu5(i_vel2,0,k_vel2)=diu5(i_vel2,jm,k_vel2)
!   cov5(i_vel2,0,k_vel2)=cov5(i_vel2,jm,k_vel2)
!   nou5(i_vel2,jm+1,k_vel2)=nou5(i_vel2,1,k_vel2)
!   diu5(i_vel2,jm+1,k_vel2)=diu5(i_vel2,1,k_vel2)
!   cov5(i_vel2,jm+1,k_vel2)=cov5(i_vel2,1,k_vel2)
!  end subroutine velfg_map_179
!  subroutine velfg_map_189(nou7,diu7,cov7)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: j_vel2,k_vel2
!      integer :: j_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: j_vel2_range
!      integer :: k_vel2_rel
!      integer :: j_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: nou7
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu7
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: cov7
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = (((90 - 1) - 1) + 1)
!      j_vel2_range = ((150 - 1) + 1)
!      k_vel2_rel = (global_id / j_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      j_vel2_rel = (global_id - (k_vel2_rel * j_vel2_range))
!      j_vel2 = (j_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   nou7(im+1,j_vel2,k_vel2)=nou7(im,j_vel2,k_vel2)
!   diu7(im+1,j_vel2,k_vel2)=diu7(im,j_vel2,k_vel2)
!   cov7(im+1,j_vel2,k_vel2)=cov7(im,j_vel2,k_vel2)
!  end subroutine velfg_map_189
!  subroutine velfg_map_196(nou8,diu8,cov8)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: i_vel2,k_vel2
!      integer :: i_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: i_vel2_range
!      integer :: k_vel2_rel
!      integer :: i_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real(kind=4), dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: nou8
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu8
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: cov8
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = (((90 - 1) - 1) + 1)
!      i_vel2_range = ((150 - 1) + 1)
!      k_vel2_rel = (global_id / i_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      i_vel2_rel = (global_id - (k_vel2_rel * i_vel2_range))
!      i_vel2 = (i_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   nou8(i_vel2,0,k_vel2)=nou8(i_vel2,jm,k_vel2)
!   diu8(i_vel2,0,k_vel2)=diu8(i_vel2,jm,k_vel2)
!   cov8(i_vel2,0,k_vel2)=cov8(i_vel2,jm,k_vel2)
!   nou8(i_vel2,jm+1,k_vel2)=nou8(i_vel2,1,k_vel2)
!   diu8(i_vel2,jm+1,k_vel2)=diu8(i_vel2,1,k_vel2)
!   cov8(i_vel2,jm+1,k_vel2)=cov8(i_vel2,1,k_vel2)
!  end subroutine velfg_map_196
!  subroutine velfg_map_206(diu2,diu3)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: j_vel2,k_vel2
!      integer :: j_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: j_vel2_range
!      integer :: k_vel2_rel
!      integer :: j_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu2
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu3
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = (((90 + 1) - 1) + 1)
!      j_vel2_range = (((150 + 1) - 1) + 1)
!      k_vel2_rel = (global_id / j_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      j_vel2_rel = (global_id - (k_vel2_rel * j_vel2_range))
!      j_vel2 = (j_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   diu2(im+1,j_vel2,k_vel2)=diu2(im,j_vel2,k_vel2)
!   diu3(im+1,j_vel2,k_vel2)=diu3(im,j_vel2,k_vel2)
!  end subroutine velfg_map_206
!  subroutine velfg_map_212(diu4,diu6)
!       integer, parameter :: ip=150
!       integer, parameter :: jp=150
!       integer, parameter :: kp=90
!       integer, parameter :: im=150
!       integer, parameter :: jm=150
!       integer, parameter :: km=90
!       integer, parameter :: ifbf=1
!       integer, parameter :: ianime=1
!       integer, parameter :: ical=0
!       integer, parameter :: n0=1
!       integer, parameter :: n1=10001
!       integer, parameter :: nmax=20000
!       real, parameter :: dt=0.2
!       real, parameter :: ro=1.1763
!       real, parameter :: vn=15.83 * 10. ** (-6.)
!       real, parameter :: alpha=-10.
!       real, parameter :: beta=-1.
!       integer, parameter :: u0=0
!      ! Local vars: i_vel2,k_vel2
!      integer :: i_vel2
!      integer :: k_vel2
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: k_vel2_range
!      integer :: i_vel2_range
!      integer :: k_vel2_rel
!      integer :: i_vel2_rel
!  ! READ
!  ! WRITTEN
!  ! READ & WRITTEN
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu4
!      real, dimension(0:(ip + 2),0:(jp + 2),0:(kp + 2)), intent(InOut) :: diu6
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      k_vel2_range = (((90 + 1) - 1) + 1)
!      i_vel2_range = (((150 + 1) - 1) + 1)
!      k_vel2_rel = (global_id / i_vel2_range)
!      k_vel2 = (k_vel2_rel + 1)
!      i_vel2_rel = (global_id - (k_vel2_rel * i_vel2_range))
!      i_vel2 = (i_vel2_rel + 1)
!      ! ParallelFortran: Original code
!   diu4(i_vel2,0,k_vel2)=diu4(i_vel2,jm,k_vel2)
!   diu6(i_vel2,0,k_vel2)=diu6(i_vel2,jm,k_vel2)
!  end subroutine velfg_map_212

end module singleton_module_velfg_map_133

