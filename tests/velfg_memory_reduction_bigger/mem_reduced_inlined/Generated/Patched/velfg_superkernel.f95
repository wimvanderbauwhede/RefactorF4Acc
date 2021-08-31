#define MM (WM*WM)
module singleton_module_velfg_superkernel

contains

pure subroutine velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr,global_id)
use singleton_module_stage_kernel_1, only: stage_kernel_1
 implicit none
 real, dimension(1:2139552*MM), intent(In) :: u_0
 real, dimension(1:2139552*MM), intent(In) :: v_0
 real, dimension(1:2162808*MM), intent(In) :: w_0
 real, dimension(1:2074891*MM), intent(InOut) :: f_1
 real, dimension(1:2074891*MM), intent(InOut) :: g_1
 real, dimension(1:2074891*MM), intent(InOut) :: h_1
 integer, parameter :: st_stage_kernel_1=1
 integer :: state
 integer, intent(In) :: state_ptr, global_id
 state = state_ptr 
!  SUPERKERNEL BODY
 select case(state)
 case (st_stage_kernel_1)
 call stage_kernel_1(u_0, v_0, w_0, f_1, g_1, h_1,global_id)
 end select
end subroutine velfg_superkernel

end module singleton_module_velfg_superkernel

