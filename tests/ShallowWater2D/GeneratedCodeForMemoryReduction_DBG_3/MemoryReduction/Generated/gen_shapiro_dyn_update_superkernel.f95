! AST STAGES:
! [(Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1"),Vec VO (Scalar VDC DFloat "v_1"),Vec VO (Scalar VDC DInt "wet_1")],UnzipT (Map (Function "update_map_24" []) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VI (Scalar VDC DFloat "eta_0"),Vec VI (Scalar VDC DFloat "un_0"),Vec VI (Scalar VDC DFloat "vn_0")])))]

program main
integer :: global_id
common /ocl/ global_id
! Declarations
real, dimension(1:252004) :: hzero_0
real, dimension(1:252004) :: eta_0
real, dimension(1:252004) :: un_0
real, dimension(1:252004) :: vn_0
real, dimension(1:252004) :: h_1
real, dimension(1:252004) :: u_1
real, dimension(1:252004) :: v_1
integer, dimension(1:252004) :: wet_1
! Loops over stage calls

do global_id=1,252004
  call stage_kernel_1(hzero_0, eta_0, un_0, vn_0, h_1, u_1, v_1, wet_1)
end do

end program main  

subroutine get_global_id(idx,dim)
    integer, intent(out) :: idx
    integer, intent(in) :: dim
    integer :: global_id
    common /ocl/ global_id
    idx = global_id
end subroutine get_global_id

subroutine stage_kernel_1(hzero_0, eta_0, un_0, vn_0, h_1, u_1, v_1, wet_1)
! arg_decls
    real, dimension(1:252004), intent(In) :: hzero_0
    real, dimension(1:252004), intent(In) :: eta_0
    real, dimension(1:252004), intent(In) :: un_0
    real, dimension(1:252004), intent(In) :: vn_0
    real, dimension(1:252004), intent(Out) :: h_1
    real, dimension(1:252004), intent(Out) :: u_1
    real, dimension(1:252004), intent(Out) :: v_1
    integer, dimension(1:252004), intent(Out) :: wet_1
! uniqueGeneratedDecls'

    integer :: idx
    call get_global_id(idx,0)
! Map
    call update_map_24(hzero_0(idx), eta_0(idx), un_0(idx), vn_0(idx), h_1(idx), u_1(idx), v_1(idx), wet_1(idx))


end subroutine stage_kernel_1




subroutine update_map_24(hzero_0, eta_0, un_0, vn_0, h_1, u_1, v_1, wet_1)
    use singleton_module_update_map_24, only : update_map_24_scal
    real, intent(In) :: hzero_0
    real, intent(In) :: eta_0
    real, intent(In) :: un_0
    real, intent(In) :: vn_0
    real, intent(Out) :: h_1
    real, intent(Out) :: u_1
    real, intent(Out) :: v_1
    integer, intent(Out) :: wet_1

    ! Temp vars
    real :: h

    ! Call to the original scalarised subroutine

    call update_map_24_scal(hzero_0, eta_0, h, un_0, vn_0, wet_1, u_1, v_1)
    h_1 = h

end subroutine update_map_24



