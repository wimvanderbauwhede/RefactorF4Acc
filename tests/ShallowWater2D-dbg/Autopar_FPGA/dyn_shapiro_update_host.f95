module singleton_module_dyn_shapiro_update
 contains 
      subroutine dyn_shapiro_update(dt,dx,dy,eps,eta,etan,g,h,hmin,hzero,j,k,u,un,v,vn,wet)

use module_dyn_shapiro_update_superkernel_init
use oclWrapper
!      implicit none

      implicit none

! otherStatements

! remainingDecls
      integer, parameter :: nx = 500  !!
      integer, parameter :: ny = 500  !!
      real, parameter :: alpha = 1e-9  !!
      real :: term1___shapiro !!
      real :: term2___shapiro !!
      real :: term3___shapiro !!
      real :: etan_avg___shapiro !!
      real, dimension(0:ny+1,0:nx+1) :: du___dyn !!
      real, dimension(0:ny+1,0:nx+1) :: dv___dyn !!
      real, dimension(0:ny+1,0:nx+1) :: du_f95___dyn !!
      real, dimension(0:ny+1,0:nx+1) :: dv_f77___dyn !!
      real :: uu___dyn !!
      real :: vv___dyn !!
      real :: duu___dyn !!
      real :: dvv___dyn !!
      real :: hue___dyn !!
      real :: huw___dyn !!
      real :: hwp___dyn !!
      real :: hwn___dyn !!
      real :: hen___dyn !!
      real :: hep___dyn !!
      real :: hvn___dyn !!
      real :: hvs___dyn !!
      real :: hsp___dyn !!
      real :: hsn___dyn !!
      real :: hnn___dyn !!
      real :: hnp___dyn !!
      real, intent(in) :: dt !!
      real, intent(in) :: dx !!
      real, intent(in) :: dy !!
      real, intent(in) :: eps !!
      real, dimension(0:ny+1,0:nx+1), intent(inout) :: eta !!
      real, dimension(0:ny+1,0:nx+1), intent(inout) :: etan !!
      real, intent(in) :: g !!
      real, dimension(0:ny+1,0:nx+1), intent(inout) :: h !!
      real :: hmin !!
      real, dimension(0:ny+1,0:nx+1), intent(in) :: u !!
      real, dimension(0:ny+1,0:nx+1), intent(inout) :: un !!
      real, dimension(0:ny+1,0:nx+1), intent(in) :: v !!
      real, dimension(0:ny+1,0:nx+1), intent(inout) :: vn !!
      integer, dimension(0:ny+1,0:nx+1), intent(in) :: wet !!
      real, dimension(0:ny+1,0:nx+1), intent(in) :: hzero !!
      integer, intent(inout) :: k !!
      integer, intent(inout) :: j !!

! Extra declarations
real (kind=4) :: exectime

! Buffer declarations
integer(8) :: state_ptr_buf

integer :: state_ptr

! Size declarations
integer, dimension(1) :: state_ptr_sz


! Size assignments
state_ptr_sz = shape(state_ptr)

! Buffer loads
call oclLoadBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)

! Original code with buffer writes and reads
! ---- BEGIN dyn_shapiro_update_map_49 ----------------------------------------------------------------------------------------
oclGlobalRange = (500 * 500)
oclLocalRange = 0
state_ptr(1) = ST_DYN_SHAPIRO_UPDATE_MAP_49

state_ptr_ptr(1) = state_ptr
call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_ptr_sz,state_ptr_ptr)! Automatic conversion to array
call runOcl(oclGlobalRange,oclLocalRange,exectime)
! call dyn_shapiro_update_map_49

! ---- END --------------------------------------------------------------------------------------------------------------------
! ---- BEGIN dyn_shapiro_update_map_55 ----------------------------------------------------------------------------------------
oclGlobalRange = (500 * 500)
oclLocalRange = 0
state_ptr(1) = ST_DYN_SHAPIRO_UPDATE_MAP_55

state_ptr_ptr(1) = state_ptr
call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_ptr_sz,state_ptr_ptr)! Automatic conversion to array
call runOcl(oclGlobalRange,oclLocalRange,exectime)
! call dyn_shapiro_update_map_55

! ---- END --------------------------------------------------------------------------------------------------------------------
! ---- BEGIN dyn_shapiro_update_map_75 ----------------------------------------------------------------------------------------
oclGlobalRange = (500 * 500)
oclLocalRange = 0
state_ptr(1) = ST_DYN_SHAPIRO_UPDATE_MAP_75

state_ptr_ptr(1) = state_ptr
call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_ptr_sz,state_ptr_ptr)! Automatic conversion to array
call runOcl(oclGlobalRange,oclLocalRange,exectime)
! call dyn_shapiro_update_map_75

! ---- END --------------------------------------------------------------------------------------------------------------------
! ---- BEGIN dyn_shapiro_update_map_92 ----------------------------------------------------------------------------------------
oclGlobalRange = (500 * 500)
oclLocalRange = 0
state_ptr(1) = ST_DYN_SHAPIRO_UPDATE_MAP_92

state_ptr_ptr(1) = state_ptr
call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_ptr_sz,state_ptr_ptr)! Automatic conversion to array
call runOcl(oclGlobalRange,oclLocalRange,exectime)
! call dyn_shapiro_update_map_92

! ---- END --------------------------------------------------------------------------------------------------------------------
! ---- BEGIN dyn_shapiro_update_map_104 ---------------------------------------------------------------------------------------
oclGlobalRange = ((((500 + 1) - 0) + 1) * (((500 + 1) - 0) + 1))
oclLocalRange = 0
state_ptr(1) = ST_DYN_SHAPIRO_UPDATE_MAP_104

state_ptr_ptr(1) = state_ptr
call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_ptr_sz,state_ptr_ptr)! Automatic conversion to array
call runOcl(oclGlobalRange,oclLocalRange,exectime)
! call dyn_shapiro_update_map_104

! ---- END --------------------------------------------------------------------------------------------------------------------
      end subroutine dyn_shapiro_update
! Footer (produceCode_progUnit c)
end module singleton_module_dyn_shapiro_update
