module singleton_module_update_map_24

contains

subroutine update_map_24_scal(hzero_j_k,eta_j_k,h_j_k,un_j_k,vn_j_k,wet_j_k,u_j_k,v_j_k)
    parameter(nx=500)
    parameter(ny=500)
    ! local vars: j,k
    ! parallelfortran: synthesised loop variable decls
    integer :: j_range
! READ
    real, intent(In) :: hzero_j_k
    real, intent(In) :: eta_j_k
    real, intent(In) :: un_j_k
    real, intent(In) :: vn_j_k
    parameter(hmin=0.05)
! WRITTEN
    integer, intent(Out) :: wet_j_k
    real, intent(Out) :: u_j_k
    real, intent(Out) :: v_j_k
! READ & WRITTEN
    real, intent(InOut) :: h_j_k
! globalIdDeclaration
! globalIdInitialisation
! ptrAssignments_fseq
    ! parallelfortran: synthesised loop variables
    j_range = (((500 + 1) - 0) + 1)
    ! parallelfortran: original code
  h_j_k = hzero_j_k + eta_j_k
  wet_j_k = 1
  if (h_j_k < hmin)    wet_j_k = 0
  u_j_k = un_j_k
  v_j_k = vn_j_k
end subroutine update_map_24_scal
! According to the original code, the toplevel arrays are
!
! real, dimension(0:ny+1,0:nx+1) :: eta
! real, dimension(0:ny+1,0:nx+1) :: etan
! real, dimension(0:ny+1,0:nx+1) :: h
! real, dimension(0:ny+1,0:nx+1) :: hzero
! real, dimension(0:ny+1,0:nx+1) :: u
! real, dimension(0:ny+1,0:nx+1) :: un
! real, dimension(0:ny+1,0:nx+1) :: v
! real, dimension(0:ny+1,0:nx+1) :: vn
! integer, dimension(0:ny+1,0:nx+1) :: wet
! 
! So any other array is def a local 
! The arrays that are initialised are the same ones:
! 
! eta,etan,h,hzero,u,un,v,vn,wet
!
! The arrays used for final output are
!
! eta,h,u,v
!

end module singleton_module_update_map_24

