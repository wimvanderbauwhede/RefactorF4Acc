module singleton_module_sor_superkernel

contains

subroutine sor_superkernel(global_id_0,p0_0,rhs_0,p4_1,state_ptr)
use singleton_module_stage_kernel_1, only: stage_kernel_1
 implicit none
 real, dimension(1:*), intent(in) :: p0_0
 real, dimension(1:*), intent(in) :: rhs_0
 real, dimension(1:*), intent(out) :: p4_1
 integer, intent(in) :: global_id_0
 integer(kind=4), parameter :: st_stage_kernel_1=1
 integer :: state
 integer, intent(In) :: state_ptr
 state = state_ptr 
!  SUPERKERNEL BODY
 select case(state)
 case (st_stage_kernel_1)
 call stage_kernel_1(global_id_0, p0_0, rhs_0, p4_1)
 end select
end subroutine sor_superkernel

end module singleton_module_sor_superkernel

