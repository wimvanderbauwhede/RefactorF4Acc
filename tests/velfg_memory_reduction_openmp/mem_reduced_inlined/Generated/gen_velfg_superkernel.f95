program main
use module_velfg_superkernel, only : velfg_superkernel
! Grouped Parameter Declarations
      implicit none
      integer, parameter :: st_stage_kernel_1=1
      integer, parameter :: niters=5
! BEGIN new declarations
! END new declarations
    integer :: global_id
!    ! common /ocl/ global_id
!    ! Declarations
    real, dimension(1:8418552) :: u_0
    real, dimension(1:8418552) :: v_0
    real, dimension(1:8510058) :: w_0
    real, dimension(1:8244691) :: f_1
    real, dimension(1:8244691) :: g_1
    real, dimension(1:8244691) :: h_1
    integer :: global_id_0
! Moved param decl for st_stage_kernel_1 in main to top of code unit
    integer :: state_ptr
! Moved param decl for niters in main to top of code unit
    integer :: iter
!    ! Loops over stage calls
    real, dimension(1:8244691) :: f_1_velfg_superkernel_cr
    real, dimension(1:8418552) :: global_id_0_velfg_superkernel_cr
    real, dimension(1:8418552) :: h_1_velfg_superkernel_cr
    real, dimension(1:8510058) :: state_ptr_velfg_superkernel_cr
    real, dimension(1:8418552) :: u_0_velfg_superkernel_cr
    real, dimension(1:8418552) :: v_0_velfg_superkernel_cr
    real, dimension(1:8510058) :: w_0_velfg_superkernel_cr
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    print *, iter
    do global_id = 1, 8510058
      u_0_velfg_superkernel_cr = reshape(u_0,shape(u_0_velfg_superkernel_cr))
      v_0_velfg_superkernel_cr = reshape(v_0,shape(v_0_velfg_superkernel_cr))
      w_0_velfg_superkernel_cr = reshape(w_0,shape(w_0_velfg_superkernel_cr))
      f_1_velfg_superkernel_cr = reshape(f_1,shape(f_1_velfg_superkernel_cr))
      h_1_velfg_superkernel_cr = reshape(h_1,shape(h_1_velfg_superkernel_cr))
      global_id_0_velfg_superkernel_cr = real(global_id_0,4)
      state_ptr_velfg_superkernel_cr = real(state_ptr,4)
      call velfg_superkernel(u_0_velfg_superkernel_cr,v_0_velfg_superkernel_cr,w_0_velfg_superkernel_cr,f_1_velfg_superkernel_cr,g_1,h_1_velfg_superkernel_cr,global_id_0_velfg_superkernel_cr,state_ptr_velfg_superkernel_cr,global_id)

      u_0 = reshape(u_0_velfg_superkernel_cr, shape(u_0))
      v_0 = reshape(v_0_velfg_superkernel_cr, shape(v_0))
      w_0 = reshape(w_0_velfg_superkernel_cr, shape(w_0))
      f_1 = reshape(f_1_velfg_superkernel_cr, shape(f_1))
      h_1 = reshape(h_1_velfg_superkernel_cr, shape(h_1))
      global_id_0 = int(global_id_0_velfg_superkernel_cr, 4)
      state_ptr = int(state_ptr_velfg_superkernel_cr, 4)
    end do
    end do
end program main  
