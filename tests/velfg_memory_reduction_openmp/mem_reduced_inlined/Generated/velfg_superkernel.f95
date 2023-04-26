module singleton_module_velfg_superkernel

contains

subroutine velfg_superkernel(dx1_0,dy1_0,dzn_0,dzs_0,th_idx_0,u_0,v_0,w_0,f_1,g_1,h_1,state_ptr)
 implicit none
 real, dimension(1:8418552), intent(In) :: u_0
 real, dimension(1:8418552), intent(In) :: v_0
 real, dimension(1:8510058), intent(In) :: w_0
 real, dimension(1:8244691), intent(InOut) :: f_1
 real, dimension(1:8244691), intent(InOut) :: g_1
 real, dimension(1:8244691), intent(InOut) :: h_1
 real, dimension(-1:301), intent(In) :: dx1_0
 real, dimension(0:301), intent(In) :: dy1_0
 real, dimension(-1:92), intent(In) :: dzn_0
 real, dimension(-1:92), intent(In) :: dzs_0
 integer, intent(In) :: th_idx_0
 integer, parameter :: st_stage_kernel_1=1
 integer :: state
 integer, intent(In) :: state_ptr
 state = state_ptr 
!  SUPERKERNEL BODY
 select case(state)
 case (st_stage_kernel_1)
 call stage_kernel_1(dx1_0, dy1_0, dzn_0, dzs_0, th_idx_0, u_0, v_0, w_0, f_1, g_1, h_1)
 end select
end subroutine velfg_superkernel

end module singleton_module_velfg_superkernel

