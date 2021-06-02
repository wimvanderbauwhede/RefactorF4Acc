! AST STAGES:
! [(Vec VS (SVec 2 (Scalar VDC DFloat "etan_s_0")),Stencil (SVec 2 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "etan_0"))),(Scalar VO DFloat "acc_1",Fold (Function "reduce_18" []) (Scalar VI DFloat "acc_0") (Vec VS (SVec 2 (Scalar VDC DFloat "etan_s_0"))))]
! [(Scalar VO DFloat "etan_avg_1",Fold (Function "shapiro_reduce_19" [Scalar VI DFloat "acc_1"]) (Scalar VI DFloat "etan_avg_0") (Vec VI (Scalar VDC DFloat "etan_0")))]
! [(Vec VS (Scalar VDC DInt "svec_eta_1_4"),Stencil (SComb (SVec 2 (Scalar VDC DInt "s6")) (SVec 5 (Scalar VDC DInt "s2"))) (Vec VI (Scalar VDC DInt "wet_0"))),(Vec VS (Scalar VDC DFloat "svec_eta_1_5"),Stencil (SComb (SVec 2 (Scalar VDC DInt "s6")) (SVec 5 (Scalar VDC DInt "s3"))) (Vec VI (Scalar VDC DFloat "etan_0"))),(Vec VS (Scalar VDC DInt "svec_eta_1_6"),Stencil (SComb (SVec 2 (Scalar VDC DInt "s7")) (SVec 5 (Scalar VDC DInt "s5"))) (Vec VI (Scalar VDC DInt "wet_0"))),(Vec VS (Scalar VDC DFloat "svec_eta_1_7"),Stencil (SComb (SVec 2 (Scalar VDC DInt "s7")) (SVec 5 (Scalar VDC DInt "s4"))) (Vec VI (Scalar VDC DFloat "etan_0"))),(Vec VO (Scalar VDC DFloat "eta_1"),Map (Function "f_comp_eta_1_3" [Scalar VT DFloat "acc_1",Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1",Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [ZipT [Vec VS (Scalar VDC DInt "svec_eta_1_4"),Vec VS (Scalar VDC DFloat "svec_eta_1_5")],ZipT [Vec VS (Scalar VDC DInt "svec_eta_1_6"),Vec VS (Scalar VDC DFloat "svec_eta_1_7")],Vec VI (Scalar VDC DInt "wet_0")]))]

program main
integer :: global_id
common /ocl/ global_id
! Declarations
real, dimension(1:252004) :: etan_0
real :: acc_0
real :: acc_1
real :: etan_avg_0
real :: etan_avg_1
integer, dimension(1:252004) :: wet_0
real :: eps_0
real, dimension(1:252004) :: eta_1
! Loops over stage calls

do global_id=1,250998
  call stage_kernel_1(etan_0, acc_0, acc_1)
end do


do global_id=1,252004
  call stage_kernel_2(acc_1, etan_avg_0, etan_0, etan_avg_1)
end do


do global_id=1,250998
  call stage_kernel_3(wet_0, etan_0, acc_1, eps_0, etan_avg_1, eta_1)
end do

end program main  

subroutine get_global_id(idx)
    integer, intent(out) :: idx
    integer :: global_id
    common /ocl/ global_id
    idx = global_id
end subroutine get_global_id

subroutine stage_kernel_1(etan_0, acc_0, acc_1)
! arg_decls
    real, dimension(1:252004), intent(In) :: etan_0
    real, intent(InOut) :: acc_0
! uniqueGeneratedDecls'
    integer, parameter, dimension(1:2) :: s1 = [0,1006]
    real, dimension(1:2) :: etan_s_0
    integer :: s_idx_1
    real, intent(Out) :: acc_1

    integer :: idx
    call get_global_id(idx)
! Stencil s1
    do s_idx_1 = 1,2
        if (idx+s1(s_idx_1)>=1 .and. idx+s1(s_idx_1)<=252004) then
            etan_s_0(s_idx_1) = etan_0(idx+s1(s_idx_1))
        else
            etan_s_0(s_idx_1) = etan_0(idx)
        end if
    end do

! Fold
    call reduce_18(acc_0, etan_s_0, acc_1)
    acc_0 = acc_1

end subroutine stage_kernel_1

subroutine stage_kernel_2(acc_1, etan_avg_0, etan_0, etan_avg_1)
! arg_decls
    real, intent(InOut) :: etan_avg_0
    real, dimension(1:252004), intent(In) :: etan_0
! uniqueGeneratedDecls'
    real, intent(Out) :: etan_avg_1
    real, intent(In) :: acc_1

    integer :: idx
    call get_global_id(idx)
! Fold
    call shapiro_reduce_19(acc_1, etan_avg_0, etan_0(idx), etan_avg_1)
    etan_avg_0 = etan_avg_1

end subroutine stage_kernel_2

subroutine stage_kernel_3(wet_0, etan_0, acc_1, eps_0, etan_avg_1, eta_1)
! arg_decls
    integer, dimension(1:252004), intent(In) :: wet_0
    real, dimension(1:252004), intent(In) :: etan_0
    real, intent(In) :: eps_0
    real, dimension(1:252004), intent(Out) :: eta_1
! uniqueGeneratedDecls'
    integer, parameter, dimension(1:2) :: s6 = [0,1006]
    integer, parameter, dimension(1:5) :: s2 = [1,502,503,504,1005]
    integer, dimension(1:2,1:5) :: svec_eta_1_4
    integer :: s_idx_1
    integer :: s_idx_2
    integer, parameter, dimension(1:5) :: s3 = [1,502,503,504,1005]
    real, dimension(1:2,1:5) :: svec_eta_1_5
    integer, parameter, dimension(1:2) :: s7 = [2,1004]
    integer, parameter, dimension(1:5) :: s5 = [1,502,503,504,1005]
    integer, dimension(1:2,1:5) :: svec_eta_1_6
    integer, parameter, dimension(1:5) :: s4 = [1,502,503,504,1005]
    real, dimension(1:2,1:5) :: svec_eta_1_7
    real, intent(In) :: acc_1
    real, intent(In) :: etan_avg_1

    integer :: idx
    call get_global_id(idx)
! Stencil s6, s2
    do s_idx_1 = 1,2
    do s_idx_2 = 1,5
        if (idx+s6(s_idx_1)+s2(s_idx_2)>=1 .and. idx+s6(s_idx_1)+s2(s_idx_2)<=252004) then
            svec_eta_1_4(s_idx_1, s_idx_2) = wet_0(idx+s6(s_idx_1)+s2(s_idx_2))
        else
            svec_eta_1_4(s_idx_1, s_idx_2) = wet_0(idx)
        end if
    end do
    end do

! Stencil s6, s3
    do s_idx_1 = 1,2
    do s_idx_2 = 1,5
        if (idx+s6(s_idx_1)+s3(s_idx_2)>=1 .and. idx+s6(s_idx_1)+s3(s_idx_2)<=252004) then
            svec_eta_1_5(s_idx_1, s_idx_2) = etan_0(idx+s6(s_idx_1)+s3(s_idx_2))
        else
            svec_eta_1_5(s_idx_1, s_idx_2) = etan_0(idx)
        end if
    end do
    end do

! Stencil s7, s5
    do s_idx_1 = 1,2
    do s_idx_2 = 1,5
        if (idx+s7(s_idx_1)+s5(s_idx_2)>=1 .and. idx+s7(s_idx_1)+s5(s_idx_2)<=252004) then
            svec_eta_1_6(s_idx_1, s_idx_2) = wet_0(idx+s7(s_idx_1)+s5(s_idx_2))
        else
            svec_eta_1_6(s_idx_1, s_idx_2) = wet_0(idx)
        end if
    end do
    end do

! Stencil s7, s4
    do s_idx_1 = 1,2
    do s_idx_2 = 1,5
        if (idx+s7(s_idx_1)+s4(s_idx_2)>=1 .and. idx+s7(s_idx_1)+s4(s_idx_2)<=252004) then
            svec_eta_1_7(s_idx_1, s_idx_2) = etan_0(idx+s7(s_idx_1)+s4(s_idx_2))
        else
            svec_eta_1_7(s_idx_1, s_idx_2) = etan_0(idx)
        end if
    end do
    end do

! Map
    call f_comp_eta_1_3(acc_1, eps_0, etan_avg_1, svec_eta_1_4, svec_eta_1_5, svec_eta_1_6, svec_eta_1_7, wet_0(idx), eta_1(idx))


end subroutine stage_kernel_3




subroutine dyn_map_39(acc_1, eta1_local_s_0, eta2_local_s_0, wet_0, eta_1)
    use singleton_module_dyn_map_39, only : dyn_map_39_scal
    real, intent(In) :: acc_1
    real, dimension(1:2), intent(In) :: eta1_local_s_0
    real, dimension(1:2), intent(In) :: eta2_local_s_0
    integer, intent(In) :: wet_0
    real, intent(Out) :: eta_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_map_39_scal(eta1_local_s_0(1), eta1_local_s_0(2), eta2_local_s_0(1), eta2_local_s_0(2), wet_0, eta_1, acc_1)

end subroutine dyn_map_39


subroutine reduce_18(acc_0, etan_s_0, acc_1)
    use singleton_module_reduce_18, only : reduce_18_scal
    real, intent(In) :: acc_0
    real, dimension(1:2), intent(In) :: etan_s_0
    real, intent(Out) :: acc_1

    ! Temp vars
    real :: acc

    ! Call to the original scalarised subroutine
    acc = acc_0

    call reduce_18_scal(etan_s_0(1), etan_s_0(2), acc)
    acc_1 = acc

end subroutine reduce_18


subroutine shapiro_map_24(eps_0, etan_avg_1, wet_s_0, etan_s_1, eta1_local_1)
    use singleton_module_shapiro_map_24, only : shapiro_map_24_scal
    real, intent(In) :: eps_0
    real, intent(In) :: etan_avg_1
    integer, dimension(1:5), intent(In) :: wet_s_0
    real, dimension(1:5), intent(In) :: etan_s_1
    real, intent(Out) :: eta1_local_1

    ! Temp vars
    real :: eta1_local

    ! Call to the original scalarised subroutine

    call shapiro_map_24_scal(wet_s_0(1), wet_s_0(2), wet_s_0(3), wet_s_0(4), wet_s_0(5), eps_0, etan_s_1(1), etan_s_1(2), etan_s_1(3), etan_s_1(4), etan_s_1(5), eta1_local, etan_avg_1)
    eta1_local_1 = eta1_local

end subroutine shapiro_map_24


subroutine shapiro_map_25(eps_0, etan_avg_1, wet_s_1, etan_s_2, eta2_local_1)
    use singleton_module_shapiro_map_25, only : shapiro_map_25_scal
    real, intent(In) :: eps_0
    real, intent(In) :: etan_avg_1
    integer, dimension(1:5), intent(In) :: wet_s_1
    real, dimension(1:5), intent(In) :: etan_s_2
    real, intent(Out) :: eta2_local_1

    ! Temp vars
    real :: eta2_local

    ! Call to the original scalarised subroutine

    call shapiro_map_25_scal(wet_s_1(1), wet_s_1(2), wet_s_1(3), wet_s_1(4), wet_s_1(5), eps_0, etan_s_2(1), etan_s_2(2), etan_s_2(3), etan_s_2(4), etan_s_2(5), eta2_local, etan_avg_1)
    eta2_local_1 = eta2_local

end subroutine shapiro_map_25


subroutine shapiro_reduce_19(acc_1, etan_avg_0, etan_0, etan_avg_1)
    use singleton_module_shapiro_reduce_19, only : shapiro_reduce_19_scal
    real, intent(In) :: acc_1
    real, intent(In) :: etan_avg_0
    real, intent(In) :: etan_0
    real, intent(Out) :: etan_avg_1

    ! Temp vars
    real :: etan_avg

    ! Call to the original scalarised subroutine
    etan_avg = etan_avg_0

    call shapiro_reduce_19_scal(acc_1, etan_0, etan_avg)
    etan_avg_1 = etan_avg

end subroutine shapiro_reduce_19



subroutine f_maps_eta_1_0(eps_0, etan_avg_1, sv_wet_s_0_in, sv_etan_s_1_in, sv_eta1_local_1_out)

    real :: eps_0
    real :: etan_avg_1
    integer, dimension(2, 5) :: sv_wet_s_0_in
    real, dimension(2, 5) :: sv_etan_s_1_in
    real, dimension(2) :: sv_eta1_local_1_out

    integer :: i
    do i=1,2
        call shapiro_map_24(eps_0, etan_avg_1, sv_wet_s_0_in(i, :), sv_etan_s_1_in(i, :), sv_eta1_local_1_out(i))
    end do
end subroutine f_maps_eta_1_0


subroutine f_maps_eta_1_1(eps_0, etan_avg_1, sv_wet_s_1_in, sv_etan_s_2_in, sv_eta2_local_1_out)

    real :: eps_0
    real :: etan_avg_1
    integer, dimension(2, 5) :: sv_wet_s_1_in
    real, dimension(2, 5) :: sv_etan_s_2_in
    real, dimension(2) :: sv_eta2_local_1_out

    integer :: i
    do i=1,2
        call shapiro_map_25(eps_0, etan_avg_1, sv_wet_s_1_in(i, :), sv_etan_s_2_in(i, :), sv_eta2_local_1_out(i))
    end do
end subroutine f_maps_eta_1_1


subroutine f_applyt_eta_1_2(eps_0, etan_avg_1, sv_wet_s_0_in, sv_etan_s_1_in, sv_wet_s_1_in, sv_etan_s_2_in, wet_0_in, sv_eta1_local_1_out, sv_eta2_local_1_out, wet_0_out)

    real :: eps_0
    real :: etan_avg_1
    integer, dimension(2, 5) :: sv_wet_s_0_in
    real, dimension(2, 5) :: sv_etan_s_1_in
    integer, dimension(2, 5) :: sv_wet_s_1_in
    real, dimension(2, 5) :: sv_etan_s_2_in
    integer :: wet_0_in
    real, dimension(2) :: sv_eta1_local_1_out
    real, dimension(2) :: sv_eta2_local_1_out
    integer :: wet_0_out

    call f_maps_eta_1_0(eps_0, etan_avg_1, sv_wet_s_0_in, sv_etan_s_1_in, sv_eta1_local_1_out)
    call f_maps_eta_1_1(eps_0, etan_avg_1, sv_wet_s_1_in, sv_etan_s_2_in, sv_eta2_local_1_out)
    wet_0_out = wet_0_in

end subroutine f_applyt_eta_1_2


subroutine f_comp_eta_1_3(acc_1, eps_0, etan_avg_1, sv_wet_s_0_in, sv_etan_s_1_in, sv_wet_s_1_in, sv_etan_s_2_in, wet_0_in, eta_1)

    real :: acc_1
    real :: eps_0
    real :: etan_avg_1
    integer, dimension(2, 5) :: sv_wet_s_0_in
    real, dimension(2, 5) :: sv_etan_s_1_in
    integer, dimension(2, 5) :: sv_wet_s_1_in
    real, dimension(2, 5) :: sv_etan_s_2_in
    integer :: wet_0_in
    real :: eta_1
    real, dimension(2) :: eta1_local_s_0
    real, dimension(2) :: eta2_local_s_0
    integer :: wet_0

    call f_applyt_eta_1_2(eps_0, etan_avg_1, sv_wet_s_0_in, sv_etan_s_1_in, sv_wet_s_1_in, sv_etan_s_2_in, wet_0_in, eta1_local_s_0, eta2_local_s_0, wet_0)
    call dyn_map_39(acc_1, eta1_local_s_0, eta2_local_s_0, wet_0, eta_1)
end subroutine f_comp_eta_1_3


