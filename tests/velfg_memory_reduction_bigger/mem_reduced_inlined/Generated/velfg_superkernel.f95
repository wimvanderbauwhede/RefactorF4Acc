module singleton_module_velfg_superkernel

contains

subroutine velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr)
 implicit none
 real, dimension(1:2139552), intent(In) :: u_0
 real, dimension(1:2139552), intent(In) :: v_0
 real, dimension(1:2162808), intent(In) :: w_0
 real, dimension(1:2074891), intent(InOut) :: f_1
 real, dimension(1:2074891), intent(InOut) :: g_1
 real, dimension(1:2074891), intent(InOut) :: h_1
 integer, parameter :: st_stage_kernel_1=1
 integer :: state
 integer, intent(In) :: state_ptr
 state = state_ptr 
!  SUPERKERNEL BODY
 select case(state)
 case (st_stage_kernel_1)
 call stage_kernel_1(u_0, v_0, w_0, f_1, g_1, h_1)
 end select
end subroutine velfg_superkernel

end module singleton_module_velfg_superkernel

