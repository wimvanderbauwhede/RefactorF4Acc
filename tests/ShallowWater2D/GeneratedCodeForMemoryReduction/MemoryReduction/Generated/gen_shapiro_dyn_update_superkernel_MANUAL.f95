! AST STAGES:
! [(Scalar VO DFloat "etan_avg_1",Fold (Function "shapiro_reduce_19" []) (Scalar VI DFloat "etan_avg_0") (Vec VI (Scalar VDC DFloat "etan_0")))]
! [(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DInt "wet_0"))),(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "etan_0"))),(Vec VO (Scalar VDC DFloat "eta_1"),Map (Function "shapiro_map_24" [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0")),Vec VI (Scalar VDC DFloat "eta_0")]))]

program main
use singleton_module_shapiro_map_24, only : shapiro_map_24_scal
use singleton_module_shapiro_reduce_19, only : shapiro_reduce_19_scal

integer :: global_id
common /ocl/ global_id
! Declarations

! Declarations
integer(4), parameter :: nx = 50 
integer(4), parameter :: ny = 50 
integer, dimension(1:(nx+2)*(ny+2)) :: wet_0
real, dimension(1:(nx+2)*(ny+2)) :: etan_0
real :: eps_0
real :: etan_avg_0
real, dimension(1:(nx+2)*(ny+2)) :: eta_0
real, dimension(1:(nx+2)*(ny+2)) :: eta_1
real :: etan_avg_1

integer :: j,k
real, dimension(0:ny+1,0:nx+1) :: hzero
! initial conditions
do j = 0,ny+1
do k = 0,nx+1
hzero(j,k) = 10.0 
end do
end do
! land boundaries with 10 m elevation
do k = 0,nx+1
hzero(0,k) = -10.0
hzero(ny+1,k) = -10.0
end do

do j = 0,ny+1
hzero(j,0) = -10.0
hzero(j,nx+1) = -10.0
end do

do j = 0,ny+1
do k = 0,nx+1
eta_0(1+j*(nx+2)+k) = -min(0.0,hzero(j,k))
etan_0(1+j*(nx+2)+k) = eta_0(1+j*(nx+2)+k)
end do
end do
do j=0,ny+1
    do k=0,nx+1
    if (k>nx/5 .and. k<2*nx/5 .and. j>ny/5 .and. j<2*ny/5 ) then
        wet_0(1+j*(nx+2)+k) = 1
        print *,j,k,1+j*(nx+2)+k,wet_0(1+j*(nx+2)+k)
    else
        wet_0(1+j*(nx+2)+k)=0
    end if    
end do
end do


! Loops over stage calls

do global_id=1,(nx+2)*(ny+2)
  call stage_kernel_1(etan_avg_0, etan_0, etan_avg_1)
end do


do global_id=1,(nx+2)*(ny+2)
  call stage_kernel_2(wet_0, etan_0, eps_0, eta_0, eta_1)
end do

end program main  

subroutine get_global_id(idx)
    integer, intent(out) :: idx
    integer :: global_id
    common /ocl/ global_id
    idx = global_id
end subroutine get_global_id

subroutine stage_kernel_1(etan_avg_0, etan_0, etan_avg_1)
! arg_decls
    integer(4), parameter :: nx = 50 
    integer(4), parameter :: ny = 50     
    real, intent(InOut) :: etan_avg_0
    real, dimension(1:(nx+2)*(ny+2)), intent(In) :: etan_0
! uniqueGeneratedDecls'
    real, intent(Out) :: etan_avg_1

    integer :: idx
    call get_global_id(idx)
! Fold
    call shapiro_reduce_19(etan_avg_0, etan_0(idx), etan_avg_1)
    etan_avg_0 = etan_avg_1
    print *,etan_avg_0
end subroutine stage_kernel_1

subroutine stage_kernel_2(wet_0, etan_0, eps_0, eta_0, eta_1)
! arg_decls
    integer(4), parameter :: nx = 50 
    integer(4), parameter :: ny = 50     
    integer, dimension(1:(nx+2)*(ny+2)), intent(In) :: wet_0
    real, dimension(1:(nx+2)*(ny+2)), intent(In) :: etan_0
    real, intent(In) :: eps_0
    real, dimension(1:(nx+2)*(ny+2)), intent(In) :: eta_0
    real, dimension(1:(nx+2)*(ny+2)), intent(Out) :: eta_1
! uniqueGeneratedDecls'
    integer, parameter, dimension(1:5) :: s1 = [1,502,503,504,1005]
    integer, dimension(1:5) :: wet_s_0
    integer :: s_idx_1
    integer, parameter, dimension(1:5) :: s2 = [1,502,503,504,1005]
    real, dimension(1:5) :: etan_s_0
    real, intent(In) :: etan_avg_1

    integer :: idx
    call get_global_id(idx)
! Stencil s1
    do s_idx_1 = 1,5
        wet_s_0(s_idx_1) = wet_0(idx+s1(s_idx_1))
    end do

! Stencil s2
    do s_idx_1 = 1,5
        etan_s_0(s_idx_1) = etan_0(idx+s2(s_idx_1))
    end do

! Map
    call shapiro_map_24(eps_0, etan_avg_1, wet_s_0, etan_s_0, eta_0(idx), eta_1(idx))


end subroutine stage_kernel_2



subroutine shapiro_map_24(eps_0, etan_avg_1, wet_s_0, etan_s_0, eta_0, eta_1)
    use singleton_module_shapiro_map_24, only : shapiro_map_24_scal
    use singleton_module_shapiro_reduce_19, only : shapiro_reduce_19_scal
    real, intent(In) :: eps_0
    real, intent(In) :: etan_avg_1
    integer, dimension(1:5), intent(In) :: wet_s_0
    real, dimension(1:5), intent(In) :: etan_s_0
    real, intent(In) :: eta_0
    real, intent(Out) :: eta_1

    ! Temp vars
    real :: eta

    ! Call to the original scalarised subroutine
    eta = eta_0

    call shapiro_map_24_scal(wet_s_0(1), wet_s_0(2), wet_s_0(3), wet_s_0(4), wet_s_0(5), eps_0, etan_s_0(1), etan_s_0(2), etan_s_0(3), etan_s_0(4), etan_s_0(5), eta, etan_avg_1)
    eta_1 = eta

end subroutine shapiro_map_24

subroutine shapiro_reduce_19(etan_avg_0, etan_0, etan_avg_1)
    real, intent(In) :: etan_avg_0
    real, intent(In) :: etan_0
    real, intent(Out) :: etan_avg_1

    ! Temp vars
    real :: etan_avg

    ! Call to the original scalarised subroutine
    etan_avg = etan_avg_0

    call shapiro_reduce_19_scal(etan_0, etan_avg)
    etan_avg_1 = etan_avg

end subroutine shapiro_reduce_19



