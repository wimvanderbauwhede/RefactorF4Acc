module module_dyn_shapiro_update_superkernel
    contains
subroutine dyn_shapiro_update_superkernel(,state_ptr)
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer :: state
    integer :: state_ptr
    state = state_ptr ! state
! SUPERKERNEL BODY
    select case(state)
      case (ST_STAGE_KERNEL_1)
      call stage_kernel_1()
    end select
end subroutine dyn_shapiro_update_superkernel

subroutine stage_kernel_1()
! arg_decls
! uniqueGeneratedDecls'

    integer :: idx
    call get_global_id(idx,0)
!$RF4A Begin Inline
!$RF4A End Inline
end subroutine stage_kernel_1



subroutine dyn_shapiro_update_map_104(hzero_0, eta_1, h_1)
    use singleton_module_dyn_shapiro_update_map_104, only : dyn_shapiro_update_map_104_scal
    real, intent(In) :: hzero_0
    real, intent(In) :: eta_1
    real, intent(Out) :: h_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_update_map_104_scal(hzero_0, eta_1, h_1)

end subroutine dyn_shapiro_update_map_104


subroutine dyn_shapiro_update_map_49(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, dv___dyn_1)
    use singleton_module_dyn_shapiro_update_map_49, only : dyn_shapiro_update_map_49_scal
    real, intent(In) :: dt_0
    real, intent(In) :: g_0
    real, intent(In) :: dx_0
    real, intent(In) :: dy_0
    real, dimension(1:3), intent(In) :: eta_s_0
    real, intent(Out) :: du___dyn_1
    real, intent(Out) :: dv___dyn_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_update_map_49_scal(dt_0, g_0, eta_s_0(1), eta_s_0(2), eta_s_0(3), dx_0, dy_0, du___dyn_1, dv___dyn_1)

end subroutine dyn_shapiro_update_map_49


subroutine dyn_shapiro_update_map_55(duu___dyn_0, u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, duu___dyn_1, un_1, vn_1)
    use singleton_module_dyn_shapiro_update_map_55, only : dyn_shapiro_update_map_55_scal
    real, intent(In) :: duu___dyn_0
    real, intent(In) :: u_0
    real, intent(In) :: du___dyn_1
    integer, dimension(1:3), intent(In) :: wet_s_0
    real, intent(In) :: v_0
    real, intent(In) :: dv___dyn_1
    real, intent(Out) :: duu___dyn_1
    real, intent(Out) :: un_1
    real, intent(Out) :: vn_1

    ! Temp vars
    real :: duu___dyn

    ! Call to the original scalarised subroutine

    call dyn_shapiro_update_map_55_scal(u_0, du___dyn_1, wet_s_0(1), wet_s_0(2), wet_s_0(3), duu___dyn, v_0, dv___dyn_1, un_1, vn_1)
    duu___dyn_0 = duu___dyn

end subroutine dyn_shapiro_update_map_55


subroutine dyn_shapiro_update_map_75(dt_0, dx_0, dy_0, un_s_0, h_s_0, vn_s_0, eta_0, etan_1)
    use singleton_module_dyn_shapiro_update_map_75, only : dyn_shapiro_update_map_75_scal
    real, intent(In) :: dt_0
    real, intent(In) :: dx_0
    real, intent(In) :: dy_0
    real, dimension(1:2), intent(In) :: un_s_0
    real, dimension(1:5), intent(In) :: h_s_0
    real, dimension(1:2), intent(In) :: vn_s_0
    real, intent(In) :: eta_0
    real, intent(Out) :: etan_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_update_map_75_scal(un_s_0(1), un_s_0(2), h_s_0(1), h_s_0(2), h_s_0(3), h_s_0(4), h_s_0(5), vn_s_0(1), vn_s_0(2), eta_0, dt_0, dx_0, dy_0, etan_1)

end subroutine dyn_shapiro_update_map_75


subroutine dyn_shapiro_update_map_92(eps_0, wet_s_1, etan_s_0, eta_1)
    use singleton_module_dyn_shapiro_update_map_92, only : dyn_shapiro_update_map_92_scal
    real, intent(In) :: eps_0
    integer, dimension(1:5), intent(In) :: wet_s_1
    real, dimension(1:5), intent(In) :: etan_s_0
    real, intent(Out) :: eta_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_update_map_92_scal(wet_s_1(1), wet_s_1(2), wet_s_1(3), wet_s_1(4), wet_s_1(5), eps_0, etan_s_0(1), etan_s_0(2), etan_s_0(3), etan_s_0(4), etan_s_0(5), eta_1)

end subroutine dyn_shapiro_update_map_92





end module module_dyn_shapiro_update_superkernel
