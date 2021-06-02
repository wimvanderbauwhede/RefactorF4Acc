! AST STAGES:
! [(Vec VS (SVec 2 (Scalar VDC DFloat "etan_s_0")),Stencil (SVec 2 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "etan_0"))),(Scalar VO DFloat "acc_1",Fold (Function "reduce_18" []) (Scalar VI DFloat "acc_0") (Vec VS (SVec 2 (Scalar VDC DFloat "etan_s_0"))))]
! [(Scalar VO DFloat "etan_avg_1",Fold (Function "shapiro_reduce_19" [Scalar VI DFloat "acc_1"]) (Scalar VI DFloat "etan_avg_0") (Vec VI (Scalar VDC DFloat "etan_0")))]
! [(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0"))),(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_1")),Stencil (SVec 5 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "etan_0"))),(Vec VO (Scalar VDC DFloat "eta_1"),Map (Function "shapiro_map_24" [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_1")),Vec VI (Scalar VDC DFloat "eta_0")])),(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0"))),(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_1")),Stencil (SVec 5 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "etan_0"))),(Vec VO (Scalar VDC DFloat "etan_1"),Map (Function "f_comp_etan_1_1" [Scalar VT DFloat "acc_1",Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_1")),Vec VI (Scalar VDC DFloat "eta_0")],Vec VI (Scalar VDC DInt "wet_0")]))]

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
real, dimension(1:252004) :: eta_0
real, dimension(1:252004) :: eta_1
real, dimension(1:252004) :: etan_1
! Loops over stage calls

do global_id=1,250998
  call stage_kernel_1(etan_0, acc_0, acc_1)
end do


do global_id=1,252004
  call stage_kernel_2(acc_1, etan_avg_0, etan_0, etan_avg_1)
end do


do global_id=1,250999
  call stage_kernel_3(wet_0, etan_0, eps_0, etan_avg_1, eta_0, acc_1, eta_1, etan_1)
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
        etan_s_0(s_idx_1) = etan_0(idx+s1(s_idx_1))
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

subroutine stage_kernel_3(wet_0, etan_0, eps_0, etan_avg_1, eta_0, acc_1, eta_1, etan_1)
! arg_decls
    integer, dimension(1:252004), intent(In) :: wet_0
    real, dimension(1:252004), intent(In) :: etan_0
    real, intent(In) :: eps_0
    real, dimension(1:252004), intent(In) :: eta_0
    real, dimension(1:252004), intent(Out) :: eta_1
    real, dimension(1:252004), intent(Out) :: etan_1
! uniqueGeneratedDecls'
    integer, parameter, dimension(1:5) :: s2 = [1,502,503,504,1005]
    integer, dimension(1:5) :: wet_s_0
    integer :: s_idx_1
    integer, parameter, dimension(1:5) :: s3 = [1,502,503,504,1005]
    real, dimension(1:5) :: etan_s_1
    real, intent(In) :: etan_avg_1
    real, intent(In) :: acc_1

    integer :: idx
    call get_global_id(idx)
! Stencil s2
    do s_idx_1 = 1,5
        wet_s_0(s_idx_1) = wet_0(idx+s2(s_idx_1))
    end do

! Stencil s3
    do s_idx_1 = 1,5
        etan_s_1(s_idx_1) = etan_0(idx+s3(s_idx_1))
    end do

! Map
    call shapiro_map_24(eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0(idx), eta_1(idx))


! Stencil s2
    do s_idx_1 = 1,5
        wet_s_0(s_idx_1) = wet_0(idx+s2(s_idx_1))
    end do

! Stencil s3
    do s_idx_1 = 1,5
        etan_s_1(s_idx_1) = etan_0(idx+s3(s_idx_1))
    end do

! Map
    call f_comp_etan_1_1(acc_1, eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0(idx), wet_0(idx), etan_1(idx))


end subroutine stage_kernel_3




subroutine dyn_map_39(acc_1, eta_1, wet_0, etan_1)
    use singleton_module_dyn_map_39, only : dyn_map_39_scal
    real, intent(In) :: acc_1
    real, intent(In) :: eta_1
    integer, intent(In) :: wet_0
    real, intent(Out) :: etan_1

    ! Temp vars

    ! Call to the original scalarised subroutine

    call dyn_map_39_scal(eta_1, wet_0, etan_1, acc_1)

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


subroutine shapiro_map_24(eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0, eta_1)
    use singleton_module_shapiro_map_24, only : shapiro_map_24_scal
    real, intent(In) :: eps_0
    real, intent(In) :: etan_avg_1
    integer, dimension(1:5), intent(In) :: wet_s_0
    real, dimension(1:5), intent(In) :: etan_s_1
    real, intent(In) :: eta_0
    real, intent(Out) :: eta_1

    ! Temp vars
    real :: eta

    ! Call to the original scalarised subroutine
    eta = eta_0

    call shapiro_map_24_scal(wet_s_0(1), wet_s_0(2), wet_s_0(3), wet_s_0(4), wet_s_0(5), eps_0, etan_s_1(1), etan_s_1(2), etan_s_1(3), etan_s_1(4), etan_s_1(5), eta, etan_avg_1)
    eta_1 = eta

end subroutine shapiro_map_24


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



subroutine f_applyt_etan_1_0(eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0, wet_0_in, eta_1, wet_0_out)

    real :: eps_0
    real :: etan_avg_1
    integer, dimension(5) :: wet_s_0
    real, dimension(5) :: etan_s_1
    real :: eta_0
    integer :: wet_0_in
    real :: eta_1
    integer :: wet_0_out

    call shapiro_map_24(eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0, eta_1)
    wet_0_out = wet_0_in

end subroutine f_applyt_etan_1_0


subroutine f_comp_etan_1_1(acc_1, eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0, wet_0_in, etan_1)

    real :: acc_1
    real :: eps_0
    real :: etan_avg_1
    integer, dimension(5) :: wet_s_0
    real, dimension(5) :: etan_s_1
    real :: eta_0
    integer :: wet_0_in
    real :: etan_1
    real :: eta_1
    integer :: wet_0

    call f_applyt_etan_1_0(eps_0, etan_avg_1, wet_s_0, etan_s_1, eta_0, wet_0_in, eta_1, wet_0)
    call dyn_map_39(acc_1, eta_1, wet_0, etan_1)
end subroutine f_comp_etan_1_1


