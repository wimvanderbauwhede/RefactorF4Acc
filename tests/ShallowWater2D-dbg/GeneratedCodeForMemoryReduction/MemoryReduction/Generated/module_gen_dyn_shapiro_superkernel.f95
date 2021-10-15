module module_dyn_shapiro_superkernel
    contains
subroutine dyn_shapiro_superkernel(wet_0, u_0, eta_0, v_0, h_0, eps_0, dt_0, dx_0, dy_0, g_0, etann_1, un_1, vn_1,state_ptr)
    integer, dimension(1:252004), intent(In) :: wet_0
    real, dimension(1:252004), intent(In) :: u_0
    real, dimension(1:252004), intent(In) :: eta_0
    real, dimension(1:252004), intent(In) :: v_0
    real, dimension(1:252004), intent(In) :: h_0
    real, intent(In) :: eps_0
    real, intent(In) :: dt_0
    real, intent(In) :: dx_0
    real, intent(In) :: dy_0
    real, intent(In) :: g_0
    real, dimension(1:252004), intent(Out) :: etann_1
    real, dimension(1:252004), intent(Out) :: un_1
    real, dimension(1:252004), intent(Out) :: vn_1
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer :: state
    integer :: state_ptr
    state = state_ptr ! state
! SUPERKERNEL BODY
    select case(state)
      case (ST_STAGE_KERNEL_1)
      call stage_kernel_1(wet_0, u_0, eta_0, v_0, h_0, eps_0, dt_0, dx_0, dy_0, g_0, etann_1, un_1, vn_1)
    end select
end subroutine dyn_shapiro_superkernel

subroutine stage_kernel_1(wet_0, u_0, eta_0, v_0, h_0, eps_0, dt_0, dx_0, dy_0, g_0, etann_1, un_1, vn_1)
! arg_decls
    integer, dimension(1:252004), intent(In) :: wet_0
    real, dimension(1:252004), intent(In) :: u_0
    real, dimension(1:252004), intent(In) :: eta_0
    real, dimension(1:252004), intent(In) :: v_0
    real, dimension(1:252004), intent(In) :: h_0
    real, intent(In) :: eps_0
    real, intent(In) :: dt_0
    real, intent(In) :: dx_0
    real, intent(In) :: dy_0
    real, intent(In) :: g_0
    real, dimension(1:252004), intent(Out) :: etann_1
    real, dimension(1:252004), intent(Out) :: un_1
    real, dimension(1:252004), intent(Out) :: vn_1
! uniqueGeneratedDecls'
    integer, parameter, dimension(1:5) :: s5 = [1,502,503,504,1005]
    integer, dimension(1:5) :: wet_s_1
    integer :: s_idx_1
    integer, parameter, dimension(1:2) :: s3 = [1,503]
    real, dimension(1:5,1:2) :: svec_etann_1_17
    integer :: s_idx_2
    integer, parameter, dimension(1:3) :: s1 = [503,504,1005]
    real, dimension(1:5,1:2,1:3) :: svec_etann_1_18
    integer :: s_idx_3
    integer, dimension(1:5,1:2,1:3) :: svec_etann_1_19
    real, dimension(1:5,1:2) :: svec_etann_1_20
    real, dimension(1:5,1:5) :: svec_etann_1_21
    real, dimension(1:5) :: svec_etann_1_22
    real, dimension(1:3) :: eta_s_0
    integer, dimension(1:3) :: wet_s_0

    integer :: idx
    call get_global_id(idx,0)
!$RF4A Begin Inline
! Stencil s5
    do s_idx_1 = 1,5
        if (idx+s5(s_idx_1)>=1 .and. idx+s5(s_idx_1)<=252004) then
            wet_s_1(s_idx_1) = wet_0(idx+s5(s_idx_1))
        else
            wet_s_1(s_idx_1) = wet_0(idx)
        end if
    end do

! Stencil s5, s3
    do s_idx_1 = 1,5
    do s_idx_2 = 1,2
        if (idx+s5(s_idx_1)+s3(s_idx_2)>=1 .and. idx+s5(s_idx_1)+s3(s_idx_2)<=252004) then
            svec_etann_1_17(s_idx_1, s_idx_2) = u_0(idx+s5(s_idx_1)+s3(s_idx_2))
        else
            svec_etann_1_17(s_idx_1, s_idx_2) = u_0(idx)
        end if
    end do
    end do

! Stencil s5, s3, s1
    do s_idx_1 = 1,5
    do s_idx_2 = 1,2
    do s_idx_3 = 1,3
        if (idx+s5(s_idx_1)+s3(s_idx_2)+s1(s_idx_3)>=1 .and. idx+s5(s_idx_1)+s3(s_idx_2)+s1(s_idx_3)<=252004) then
            svec_etann_1_18(s_idx_1, s_idx_2, s_idx_3) = eta_0(idx+s5(s_idx_1)+s3(s_idx_2)+s1(s_idx_3))
        else
            svec_etann_1_18(s_idx_1, s_idx_2, s_idx_3) = eta_0(idx)
        end if
    end do
    end do
    end do

! Stencil s5, s3, s1
    do s_idx_1 = 1,5
    do s_idx_2 = 1,2
    do s_idx_3 = 1,3
        if (idx+s5(s_idx_1)+s3(s_idx_2)+s1(s_idx_3)>=1 .and. idx+s5(s_idx_1)+s3(s_idx_2)+s1(s_idx_3)<=252004) then
            svec_etann_1_19(s_idx_1, s_idx_2, s_idx_3) = wet_0(idx+s5(s_idx_1)+s3(s_idx_2)+s1(s_idx_3))
        else
            svec_etann_1_19(s_idx_1, s_idx_2, s_idx_3) = wet_0(idx)
        end if
    end do
    end do
    end do

! Stencil s5, s3
    do s_idx_1 = 1,5
    do s_idx_2 = 1,2
        if (idx+s5(s_idx_1)+s3(s_idx_2)>=1 .and. idx+s5(s_idx_1)+s3(s_idx_2)<=252004) then
            svec_etann_1_20(s_idx_1, s_idx_2) = v_0(idx+s5(s_idx_1)+s3(s_idx_2))
        else
            svec_etann_1_20(s_idx_1, s_idx_2) = v_0(idx)
        end if
    end do
    end do

! Stencil s5, s5
    do s_idx_1 = 1,5
    do s_idx_2 = 1,5
        if (idx+s5(s_idx_1)+s5(s_idx_2)>=1 .and. idx+s5(s_idx_1)+s5(s_idx_2)<=252004) then
            svec_etann_1_21(s_idx_1, s_idx_2) = h_0(idx+s5(s_idx_1)+s5(s_idx_2))
        else
            svec_etann_1_21(s_idx_1, s_idx_2) = h_0(idx)
        end if
    end do
    end do

! Stencil s5
    do s_idx_1 = 1,5
        if (idx+s5(s_idx_1)>=1 .and. idx+s5(s_idx_1)<=252004) then
            svec_etann_1_22(s_idx_1) = eta_0(idx+s5(s_idx_1))
        else
            svec_etann_1_22(s_idx_1) = eta_0(idx)
        end if
    end do

! Map
    call f_comp_etann_1_16(eps_0, dt_0, dx_0, dy_0, g_0, wet_s_1, svec_etann_1_17, svec_etann_1_18, svec_etann_1_19, svec_etann_1_20, etann_1(idx))


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
    call f_pelts_un_1_vn_1_3(dt_0, g_0, dx_0, dy_0, u_0(idx), un_1(idx), vn_1(idx))


!$RF4A End Inline
end subroutine stage_kernel_1



subroutine dyn_shapiro_map_49(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, dv___dyn_1)
    use singleton_module_dyn_shapiro_map_49, only : dyn_shapiro_map_49_scal
    real, intent(In) :: dt_0
    real, intent(In) :: g_0
    real, intent(In) :: dx_0
    real, intent(In) :: dy_0
    real, dimension(1:3), intent(In) :: eta_s_0
    real, intent(Out) :: du___dyn_1
    real, intent(Out) :: dv___dyn_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_map_49_scal(dt_0, g_0, eta_s_0(1), eta_s_0(2), eta_s_0(3), dx_0, dy_0, du___dyn_1, dv___dyn_1)

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


subroutine dyn_shapiro_map_75(dt_0, dx_0, dy_0, un_s_0, h_s_0, vn_s_0, eta_0, etan_1)
    use singleton_module_dyn_shapiro_map_75, only : dyn_shapiro_map_75_scal
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

    call dyn_shapiro_map_75_scal(un_s_0(1), un_s_0(2), h_s_0(1), h_s_0(2), h_s_0(3), h_s_0(4), h_s_0(5), vn_s_0(1), vn_s_0(2), eta_0, dt_0, dx_0, dy_0, etan_1)

end subroutine dyn_shapiro_map_75


subroutine dyn_shapiro_map_92(eps_0, wet_s_1, etan_s_0, etann_1)
    use singleton_module_dyn_shapiro_map_92, only : dyn_shapiro_map_92_scal
    real, intent(In) :: eps_0
    integer, dimension(1:5), intent(In) :: wet_s_1
    real, dimension(1:5), intent(In) :: etan_s_0
    real, intent(Out) :: etann_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_shapiro_map_92_scal(wet_s_1(1), wet_s_1(2), wet_s_1(3), wet_s_1(4), wet_s_1(5), eps_0, etan_s_0(1), etan_s_0(2), etan_s_0(3), etan_s_0(4), etan_s_0(5), etann_1)

end subroutine dyn_shapiro_map_92



subroutine f_rapplyt_etann_1_4(dt_0, g_0, dx_0, dy_0, u_0_in, eta_s_0, wet_0_in, v_0_in, u_0_out, du___dyn_1, wet_0_out, v_0_out, dv___dyn_1)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
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

    call f_pelts_etann_1_3(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, wet_0_out)
    v_0_out = wet_0_in

    dv___dyn_1 = v_0_in

end subroutine f_rapplyt_etann_1_4


subroutine f_rapplyt_etann_1_9(dt_0, g_0, dx_0, dy_0, u_0_in, eta_s_0, wet_0_in, v_0_in, u_0_out, du___dyn_1, wet_0_out, v_0_out, dv___dyn_1)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
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

    call f_pelts_etann_1_3(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, wet_0_out)
    v_0_out = wet_0_in

    dv___dyn_1 = v_0_in

end subroutine f_rapplyt_etann_1_9


subroutine f_rapplyt_etann_1_12(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, h_0_in, eta_0_in, sv_un_1_out, h_0_out, sv_vn_1_out)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(2) :: sv_u_0_in_in
    real, dimension(2, 3) :: sv_eta_s_0_in
    integer, dimension(2, 3) :: sv_wet_0_in_in
    real, dimension(2) :: sv_v_0_in_in
    real, dimension(5) :: h_0_in
    real :: eta_0_in
    real, dimension(2) :: sv_un_1_out
    real, dimension(5) :: h_0_out
    real, dimension(2) :: sv_vn_1_out

    call f_comp_etann_1_6(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_un_1_out, h_0_out)
    call f_comp_etann_1_11(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_vn_1_out)

end subroutine f_rapplyt_etann_1_12


subroutine f_rapplyt_etann_1_15(dt_0, dx_0, dy_0, g_0, wet_0_in, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, wet_0_out, sv_etan_1_out)

    real :: dt_0
    real :: dx_0
    real :: dy_0
    real :: g_0
    integer, dimension(5) :: wet_0_in
    real, dimension(5, 2) :: sv_sv_u_0_in_in_in
    real, dimension(5, 2, 3) :: sv_sv_eta_s_0_in_in
    integer, dimension(5, 2, 3) :: sv_sv_wet_0_in_in_in
    real, dimension(5, 2) :: sv_sv_v_0_in_in_in
    real, dimension(5, 5) :: sv_h_0_in_in
    real, dimension(5) :: sv_eta_0_in_in
    integer, dimension(5) :: wet_0_out
    real, dimension(5) :: sv_etan_1_out

    wet_0_out = wet_0_in

    call f_comp_etann_1_14(dt_0, dx_0, dy_0, g_0, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, sv_etan_1_out)
end subroutine f_rapplyt_etann_1_15


subroutine f_rapplyt_un_1_vn_1_1(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, dv___dyn_1)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(3) :: eta_s_0
    real :: du___dyn_1
    real :: dv___dyn_1


    call f_pelts_etann_1_3(dt_0, g_0, dx_0, dy_0, eta_s_0, dv___dyn_1)


end subroutine f_rapplyt_un_1_vn_1_1




subroutine f_maps_etann_1_0(dt_0, dx_0, dy_0, sv_un_s_0_in, sv_h_s_0_in, sv_vn_s_0_in, sv_eta_0_in, sv_etan_1_out)

    real :: dt_0
    real :: dx_0
    real :: dy_0
    real, dimension(5, 2) :: sv_un_s_0_in
    real, dimension(5, 5) :: sv_h_s_0_in
    real, dimension(5, 2) :: sv_vn_s_0_in
    real, dimension(5) :: sv_eta_0_in
    real, dimension(5) :: sv_etan_1_out

    integer :: i
    do i=1,5
        call dyn_shapiro_map_75(dt_0, dx_0, dy_0, sv_un_s_0_in(i, :), sv_h_s_0_in(i, :), sv_vn_s_0_in(i, :), sv_eta_0_in(i), sv_etan_1_out(i))
    end do
end subroutine f_maps_etann_1_0


subroutine f_pelt_etann_1_1(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, un_1)

    real :: u_0
    real :: du___dyn_1
    integer, dimension(3) :: wet_s_0
    real :: v_0
    real :: dv___dyn_1
    real :: un_1
    real :: vn_1

    call dyn_shapiro_map_55(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, un_1, vn_1)
end subroutine f_pelt_etann_1_1


subroutine f_maps_etann_1_2(sv_u_0_in, sv_du___dyn_1_in, sv_wet_s_0_in, sv_v_0_in, sv_dv___dyn_1_in, sv_un_1_out)

    real, dimension(2) :: sv_u_0_in
    real, dimension(2) :: sv_du___dyn_1_in
    integer, dimension(2, 3) :: sv_wet_s_0_in
    real, dimension(2) :: sv_v_0_in
    real, dimension(2) :: sv_dv___dyn_1_in
    real, dimension(2) :: sv_un_1_out

    integer :: i
    do i=1,2
        call f_pelt_etann_1_1(sv_u_0_in(i), sv_du___dyn_1_in(i), sv_wet_s_0_in(i, :), sv_v_0_in(i), sv_dv___dyn_1_in(i), sv_un_1_out(i))
    end do
end subroutine f_maps_etann_1_2


subroutine f_pelts_etann_1_3(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, dv___dyn_1)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(3) :: eta_s_0
    real :: du___dyn_1
    real :: dv___dyn_1

    call dyn_shapiro_map_49(dt_0, g_0, dx_0, dy_0, eta_s_0, du___dyn_1, dv___dyn_1)
end subroutine f_pelts_etann_1_3



subroutine f_maps_etann_1_5(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_u_0_out_out, sv_du___dyn_1_out, sv_wet_0_out_out, sv_v_0_out_out, sv_dv___dyn_1_out)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(2) :: sv_u_0_in_in
    real, dimension(2, 3) :: sv_eta_s_0_in
    integer, dimension(2, 3) :: sv_wet_0_in_in
    real, dimension(2) :: sv_v_0_in_in
    real, dimension(2) :: sv_u_0_out_out
    real, dimension(2) :: sv_du___dyn_1_out
    integer, dimension(2, 3) :: sv_wet_0_out_out
    real, dimension(2) :: sv_v_0_out_out
    real, dimension(2) :: sv_dv___dyn_1_out

    integer :: i
    do i=1,2
        call f_rapplyt_etann_1_4(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in(i), sv_eta_s_0_in(i, :), sv_wet_0_in_in(i, :), sv_v_0_in_in(i), sv_u_0_out_out(i), sv_du___dyn_1_out(i), sv_wet_0_out_out(i, :), sv_v_0_out_out(i), sv_dv___dyn_1_out(i))
    end do
end subroutine f_maps_etann_1_5


subroutine f_comp_etann_1_6(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_un_1_out)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(2) :: sv_u_0_in_in
    real, dimension(2, 3) :: sv_eta_s_0_in
    integer, dimension(2, 3) :: sv_wet_0_in_in
    real, dimension(2) :: sv_v_0_in_in
    real, dimension(2) :: sv_un_1_out
    real, dimension(2) :: sv_u_0_in
    real, dimension(2) :: sv_du___dyn_1_in
    integer, dimension(2, 3) :: sv_wet_s_0_in
    real, dimension(2) :: sv_v_0_in
    real, dimension(2) :: sv_dv___dyn_1_in

    call f_maps_etann_1_5(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_u_0_in, sv_du___dyn_1_in, sv_wet_s_0_in, sv_v_0_in, sv_dv___dyn_1_in)
    call f_maps_etann_1_2(sv_u_0_in, sv_du___dyn_1_in, sv_wet_s_0_in, sv_v_0_in, sv_dv___dyn_1_in, sv_un_1_out)
end subroutine f_comp_etann_1_6


subroutine f_pelt_etann_1_7(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, vn_1)

    real :: u_0
    real :: du___dyn_1
    integer, dimension(3) :: wet_s_0
    real :: v_0
    real :: dv___dyn_1
    real :: un_1
    real :: vn_1

    call dyn_shapiro_map_55(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, un_1, vn_1)
end subroutine f_pelt_etann_1_7


subroutine f_maps_etann_1_8(sv_u_0_in, sv_du___dyn_1_in, sv_wet_s_0_in, sv_v_0_in, sv_dv___dyn_1_in, sv_vn_1_out)

    real, dimension(2) :: sv_u_0_in
    real, dimension(2) :: sv_du___dyn_1_in
    integer, dimension(2, 3) :: sv_wet_s_0_in
    real, dimension(2) :: sv_v_0_in
    real, dimension(2) :: sv_dv___dyn_1_in
    real, dimension(2) :: sv_vn_1_out

    integer :: i
    do i=1,2
        call f_pelt_etann_1_7(sv_u_0_in(i), sv_du___dyn_1_in(i), sv_wet_s_0_in(i, :), sv_v_0_in(i), sv_dv___dyn_1_in(i), sv_vn_1_out(i))
    end do
end subroutine f_maps_etann_1_8



subroutine f_maps_etann_1_10(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_u_0_out_out, sv_du___dyn_1_out, sv_wet_0_out_out, sv_v_0_out_out, sv_dv___dyn_1_out)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(2) :: sv_u_0_in_in
    real, dimension(2, 3) :: sv_eta_s_0_in
    integer, dimension(2, 3) :: sv_wet_0_in_in
    real, dimension(2) :: sv_v_0_in_in
    real, dimension(2) :: sv_u_0_out_out
    real, dimension(2) :: sv_du___dyn_1_out
    integer, dimension(2, 3) :: sv_wet_0_out_out
    real, dimension(2) :: sv_v_0_out_out
    real, dimension(2) :: sv_dv___dyn_1_out

    integer :: i
    do i=1,2
        call f_rapplyt_etann_1_9(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in(i), sv_eta_s_0_in(i, :), sv_wet_0_in_in(i, :), sv_v_0_in_in(i), sv_u_0_out_out(i), sv_du___dyn_1_out(i), sv_wet_0_out_out(i, :), sv_v_0_out_out(i), sv_dv___dyn_1_out(i))
    end do
end subroutine f_maps_etann_1_10


subroutine f_comp_etann_1_11(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_vn_1_out)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(2) :: sv_u_0_in_in
    real, dimension(2, 3) :: sv_eta_s_0_in
    integer, dimension(2, 3) :: sv_wet_0_in_in
    real, dimension(2) :: sv_v_0_in_in
    real, dimension(2) :: sv_vn_1_out
    real, dimension(2) :: sv_u_0_in
    real, dimension(2) :: sv_du___dyn_1_in
    integer, dimension(2, 3) :: sv_wet_s_0_in
    real, dimension(2) :: sv_v_0_in
    real, dimension(2) :: sv_dv___dyn_1_in

    call f_maps_etann_1_10(dt_0, g_0, dx_0, dy_0, sv_u_0_in_in, sv_eta_s_0_in, sv_wet_0_in_in, sv_v_0_in_in, sv_u_0_in, sv_du___dyn_1_in, sv_wet_s_0_in, sv_v_0_in, sv_dv___dyn_1_in)
    call f_maps_etann_1_8(sv_u_0_in, sv_du___dyn_1_in, sv_wet_s_0_in, sv_v_0_in, sv_dv___dyn_1_in, sv_vn_1_out)
end subroutine f_comp_etann_1_11



subroutine f_maps_etann_1_13(dt_0, g_0, dx_0, dy_0, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, sv_sv_un_1_out_out, sv_h_0_out_out, sv_sv_vn_1_out_out)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(5, 2) :: sv_sv_u_0_in_in_in
    real, dimension(5, 2, 3) :: sv_sv_eta_s_0_in_in
    integer, dimension(5, 2, 3) :: sv_sv_wet_0_in_in_in
    real, dimension(5, 2) :: sv_sv_v_0_in_in_in
    real, dimension(5, 5) :: sv_h_0_in_in
    real, dimension(5) :: sv_eta_0_in_in
    real, dimension(5, 2) :: sv_sv_un_1_out_out
    real, dimension(5, 5) :: sv_h_0_out_out
    real, dimension(5, 2) :: sv_sv_vn_1_out_out

    integer :: i
    do i=1,5
        call f_rapplyt_etann_1_12(dt_0, g_0, dx_0, dy_0, sv_sv_u_0_in_in_in(i, :), sv_sv_eta_s_0_in_in(i, :, :), sv_sv_wet_0_in_in_in(i, :, :), sv_sv_v_0_in_in_in(i, :), sv_h_0_in_in(i, :), sv_eta_0_in_in(i), sv_sv_un_1_out_out(i, :), sv_h_0_out_out(i, :), sv_sv_vn_1_out_out(i, :))
    end do
end subroutine f_maps_etann_1_13


subroutine f_comp_etann_1_14(dt_0, dx_0, dy_0, g_0, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, sv_etan_1_out)

    real :: dt_0
    real :: dx_0
    real :: dy_0
    real :: g_0
    real, dimension(5, 2) :: sv_sv_u_0_in_in_in
    real, dimension(5, 2, 3) :: sv_sv_eta_s_0_in_in
    integer, dimension(5, 2, 3) :: sv_sv_wet_0_in_in_in
    real, dimension(5, 2) :: sv_sv_v_0_in_in_in
    real, dimension(5, 5) :: sv_h_0_in_in
    real, dimension(5) :: sv_eta_0_in_in
    real, dimension(5) :: sv_etan_1_out
    real, dimension(5, 2) :: sv_un_s_0_in
    real, dimension(5, 5) :: sv_h_s_0_in
    real, dimension(5, 2) :: sv_vn_s_0_in
    real, dimension(5) :: sv_eta_0_in

    call f_maps_etann_1_13(dt_0, g_0, dx_0, dy_0, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, sv_un_s_0_in, sv_h_s_0_in, sv_vn_s_0_in, sv_eta_0_in)
    call f_maps_etann_1_0(dt_0, dx_0, dy_0, sv_un_s_0_in, sv_h_s_0_in, sv_vn_s_0_in, sv_eta_0_in, sv_etan_1_out)
end subroutine f_comp_etann_1_14



subroutine f_comp_etann_1_16(eps_0, dt_0, dx_0, dy_0, g_0, wet_0_in, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, etann_1)

    real :: eps_0
    real :: dt_0
    real :: dx_0
    real :: dy_0
    real :: g_0
    integer, dimension(5) :: wet_0_in
    real, dimension(5, 2) :: sv_sv_u_0_in_in_in
    real, dimension(5, 2, 3) :: sv_sv_eta_s_0_in_in
    integer, dimension(5, 2, 3) :: sv_sv_wet_0_in_in_in
    real, dimension(5, 2) :: sv_sv_v_0_in_in_in
    real, dimension(5, 5) :: sv_h_0_in_in
    real, dimension(5) :: sv_eta_0_in_in
    real :: etann_1
    integer, dimension(5) :: wet_s_1
    real, dimension(5) :: etan_s_0

    call f_rapplyt_etann_1_15(dt_0, dx_0, dy_0, g_0, wet_0_in, sv_sv_u_0_in_in_in, sv_sv_eta_s_0_in_in, sv_sv_wet_0_in_in_in, sv_sv_v_0_in_in_in, sv_h_0_in_in, sv_eta_0_in_in, wet_s_1, etan_s_0)
    call dyn_shapiro_map_92(eps_0, wet_s_1, etan_s_0, etann_1)
end subroutine f_comp_etann_1_16



subroutine f_comp_un_1_vn_1_2(dt_0, g_0, dx_0, dy_0, eta_s_0, un_1, vn_1)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(3) :: eta_s_0
    real :: un_1
    real :: vn_1
    real :: u_0
    real :: du___dyn_1
    integer, dimension(3) :: wet_s_0
    real :: v_0
    real :: dv___dyn_1

    call f_rapplyt_un_1_vn_1_1(dt_0, g_0, dx_0, dy_0, eta_s_0, u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1)
    call dyn_shapiro_map_55(u_0, du___dyn_1, wet_s_0, v_0, dv___dyn_1, un_1, vn_1)
end subroutine f_comp_un_1_vn_1_2


subroutine f_pelts_un_1_vn_1_3(dt_0, g_0, dx_0, dy_0, eta_s_0, un_1, vn_1)

    real :: dt_0
    real :: g_0
    real :: dx_0
    real :: dy_0
    real, dimension(3) :: eta_s_0
    real :: un_1
    real :: vn_1

    call f_comp_un_1_vn_1_2(dt_0, g_0, dx_0, dy_0, eta_s_0, un_1, vn_1)
end subroutine f_pelts_un_1_vn_1_3


end module module_dyn_shapiro_superkernel
