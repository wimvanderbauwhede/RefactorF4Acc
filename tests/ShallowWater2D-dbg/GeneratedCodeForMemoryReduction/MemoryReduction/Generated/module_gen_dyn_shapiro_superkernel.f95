module module_dyn_shapiro_superkernel
    contains
subroutine dyn_shapiro_superkernel(eta_0, wet_0, u_0, v_0, un_1, vn_1,state_ptr)
    real, dimension(1:252004), intent(In) :: eta_0
    integer, dimension(1:252004), intent(In) :: wet_0
    real, dimension(1:252004), intent(In) :: u_0
    real, dimension(1:252004), intent(In) :: v_0
    real, dimension(1:252004), intent(Out) :: un_1
    real, dimension(1:252004), intent(Out) :: vn_1
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer :: state
    integer :: state_ptr
    state = state_ptr ! state
! SUPERKERNEL BODY
    select case(state)
      case (ST_STAGE_KERNEL_1)
      call stage_kernel_1(eta_0, wet_0, u_0, v_0, un_1, vn_1)
    end select
end subroutine dyn_shapiro_superkernel

subroutine stage_kernel_1(eta_0, wet_0, u_0, v_0, un_1, vn_1)
! arg_decls
    real, dimension(1:252004), intent(In) :: eta_0
    integer, dimension(1:252004), intent(In) :: wet_0
    real, dimension(1:252004), intent(In) :: u_0
    real, dimension(1:252004), intent(In) :: v_0
    real, dimension(1:252004), intent(Out) :: un_1
    real, dimension(1:252004), intent(Out) :: vn_1
! uniqueGeneratedDecls'
    integer, parameter, dimension(1:3) :: s1 = [503,504,1005]
    real, dimension(1:3) :: eta_s_0
    integer :: s_idx_1
    integer, dimension(1:3) :: wet_s_0

    integer :: idx
    call get_global_id(idx,0)
!$RF4A Begin Inline
! Stencil s1
    do s_idx_1 = 1,3
        if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=252004) then
            eta_s_0(s_idx_1) = eta_0(idx+s1(s_idx_1))
        else
            eta_s_0(s_idx_1) = eta_0(idx)
        end if
    end do

! Stencil s1
    do s_idx_1 = 1,3
        if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=252004) then
            wet_s_0(s_idx_1) = wet_0(idx+s1(s_idx_1))
        else
            wet_s_0(s_idx_1) = wet_0(idx)
        end if
    end do

! Map
    call f_pelts_un_1_vn_1_3(u_0(idx), eta_s_0, wet_s_0, v_0(idx), un_1(idx), vn_1(idx))


!$RF4A End Inline
end subroutine stage_kernel_1



subroutine dyn_shapiro_map_49(eta_s_0, du___dyn_1, dv___dyn_1)
    use singleton_module_dyn_shapiro_map_49, only : dyn_shapiro_map_49_scal
    real, dimension(1:3), intent(In) :: eta_s_0
    real, intent(Out) :: du___dyn_1
    real, intent(Out) :: dv___dyn_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_map_49_scal(eta_s_0(1), eta_s_0(2), eta_s_0(3), du___dyn_1, dv___dyn_1)

end subroutine dyn_shapiro_map_49


subroutine dyn_shapiro_map_55(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, un_1, vn_1)
    use singleton_module_dyn_shapiro_map_55, only : dyn_shapiro_map_55_scal
    real, intent(In) :: u_0
    real, intent(In) :: du___dyn_1
    integer, dimension(1:3), intent(In) :: wet_s_0
    real, intent(In) :: v_0
    real, intent(In) :: dv___dyn_1
    real, intent(Out) :: un_1
    real, intent(Out) :: vn_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_map_55_scal(u_0, du___dyn_1, wet_s_0(1), wet_s_0(2), wet_s_0(3), v_0, dv___dyn_1, un_1, vn_1)

end subroutine dyn_shapiro_map_55



subroutine f_rapplyt_un_1_vn_1_1(u_0_in, eta_s_0, wet_0_in, v_0_in, u_0_out, du___dyn_1, wet_0_out, v_0_out, dv___dyn_1)

    real :: u_0_in
    real, dimension(3) :: eta_s_0
    integer, dimension(3) :: wet_0_in
    real :: v_0_in
    real :: u_0_out
    real :: du___dyn_1
    integer, dimension(3) :: wet_0_out
    real :: v_0_out
    real :: dv___dyn_1

    u_0_out = u_0_in

    call f_pelts_un_1_vn_1_0(eta_s_0, du___dyn_1, wet_0_out)
    v_0_out = wet_0_in

    dv___dyn_1 = v_0_in

end subroutine f_rapplyt_un_1_vn_1_1




subroutine f_pelts_un_1_vn_1_0(eta_s_0, du___dyn_1, dv___dyn_1)

    real, dimension(3) :: eta_s_0
    real :: du___dyn_1
    real :: dv___dyn_1

    call dyn_shapiro_map_49(eta_s_0, du___dyn_1, dv___dyn_1)
end subroutine f_pelts_un_1_vn_1_0



subroutine f_comp_un_1_vn_1_2(u_0_in, eta_s_0, wet_0_in, v_0_in, un_1, vn_1)

    real :: u_0_in
    real, dimension(3) :: eta_s_0
    integer, dimension(3) :: wet_0_in
    real :: v_0_in
    real :: un_1
    real :: vn_1
    real :: u_0
    real :: du___dyn_1
    integer, dimension(3) :: wet_s_0
    real :: v_0
    real :: dv___dyn_1

    call f_rapplyt_un_1_vn_1_1(u_0_in, eta_s_0, wet_0_in, v_0_in, u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1)
    call dyn_shapiro_map_55(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, un_1, vn_1)
end subroutine f_comp_un_1_vn_1_2


subroutine f_pelts_un_1_vn_1_3(u_0_in, eta_s_0, wet_0_in, v_0_in, un_1, vn_1)

    real :: u_0_in
    real, dimension(3) :: eta_s_0
    integer, dimension(3) :: wet_0_in
    real :: v_0_in
    real :: un_1
    real :: vn_1

    call f_comp_un_1_vn_1_2(u_0_in, eta_s_0, wet_0_in, v_0_in, un_1, vn_1)
end subroutine f_pelts_un_1_vn_1_3


end module module_dyn_shapiro_superkernel
