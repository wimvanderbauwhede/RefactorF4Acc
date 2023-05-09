module singleton_module_velfg_superkernel

contains

subroutine velfg_superkernel(dx1_0,dy1_0,dzn_0,dzs_0,global_id_0,u_0,v_0,w_0,f_1,g_1,h_1,state_ptr)
use singleton_module_stage_kernel_1, only: stage_kernel_1
 implicit none
 real, dimension(1:8418552), intent(in) :: u_0
 real, dimension(1:8418552), intent(in) :: v_0
 real, dimension(1:8510058), intent(in) :: w_0
 real, dimension(1:8244691), intent(out) :: f_1
 real, dimension(1:8244691), intent(out) :: g_1
 real, dimension(1:8244691), intent(out) :: h_1
 real, dimension(-1:301), intent(in) :: dx1_0
 real, dimension(0:301), intent(in) :: dy1_0
 real, dimension(-1:92), intent(in) :: dzn_0
 real, dimension(-1:92), intent(in) :: dzs_0
 integer, intent(in) :: global_id_0
 integer, parameter :: st_stage_kernel_1=1
 integer :: state
 integer, intent(In) :: state_ptr
 state = state_ptr 
!  SUPERKERNEL BODY
 select case(state)
 case (st_stage_kernel_1)
 call stage_kernel_1(dx1_0, dy1_0, dzn_0, dzs_0, global_id_0, u_0, v_0, w_0, f_1, g_1, h_1)
 end select
end subroutine velfg_superkernel

end module singleton_module_velfg_superkernel

