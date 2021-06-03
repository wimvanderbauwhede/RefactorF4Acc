module singleton_module_dyn_map_39

contains

subroutine dyn_map_39_scal(eta_j_k,eta_jp1_k,eta_j_kp1,u_j_k,wet_j_k,wet_jp1_k,wet_j_kp1,v_j_k, &
      un_j_km1,un_j_k,h_j_km1,h_jm1_k,h_j_k,h_jp1_k,h_j_kp1,vn_jm1_k,vn_j_k,etan_j_k)
          parameter(nx=500)
          parameter(ny=500)
    ! local vars: j,k,uu,vv,dvv,hep,hen,hue,hwp,hwn,huw,hnp,hnn,hvn,hsp,hsn,hvs
    real :: uu
    real :: vv
    real :: dvv
    real :: hep
    real :: hen
    real :: hue
    real :: hwp
    real :: hwn
    real :: huw
    real :: hnp
    real :: hnn
    real :: hvn
    real :: hsp
    real :: hsn
    real :: hvs
    ! parallelfortran: synthesised loop variable decls
    integer :: j_range
! READ
    real, intent(In) :: eta_j_k
    real, intent(In) :: eta_j_kp1
    real, intent(In) :: eta_jp1_k
    real, intent(In) :: u_j_k
    integer, intent(In) :: wet_j_k
    integer, intent(In) :: wet_j_kp1
    integer, intent(In) :: wet_jp1_k
    real, intent(In) :: v_j_k
    real, intent(In) :: h_j_k
    real, intent(In) :: h_j_km1
    real, intent(In) :: h_j_kp1
    real, intent(In) :: h_jm1_k
    real, intent(In) :: h_jp1_k
    real :: dt
    real :: g
    real :: dx
    real :: dy
    real :: duu
! WRITTEN
    real, intent(Out) :: etan_j_k
! READ & WRITTEN
    real :: du_j_k
    real :: dv_j_k
    real, intent(InOut) :: un_j_k
    real, intent(In) :: un_j_km1
    real, intent(InOut) :: vn_j_k
    real, intent(In) :: vn_jm1_k
! globalIdDeclaration
! globalIdInitialisation
! ptrAssignments_fseq
    ! parallelfortran: synthesised loop variables
    j_range = ((500 - 1) + 1)
    ! parallelfortran: original code
  du_j_k = -dt * g * (eta_j_kp1 - eta_j_k) / dx
  dv_j_k = -dt * g * (eta_jp1_k - eta_j_k) / dy
  un_j_k = 0.0
  uu = u_j_k
  duu = du_j_k
  if (wet_j_k == 1) then
  if ((wet_j_kp1 == 1) .or. (duu > 0.0))    un_j_k = uu + duu
else
  if ((wet_j_kp1 == 1) .and. (duu < 0.0))    un_j_k = uu + duu
end if
  vv = v_j_k
  dvv = dv_j_k
  vn_j_k = 0.0
  if (wet_j_k == 1) then
  if ((wet_jp1_k == 1) .or. (dv_j_k > 0.0))    vn_j_k = vv + dvv
else
  if ((wet_jp1_k == 1) .and. (dv_j_k < 0.0))    vn_j_k = vv + dvv
end if
  hep = 0.5 * (un_j_k + abs(un_j_k)) * h_j_k
  hen = 0.5 * (un_j_k - abs(un_j_k)) * h_j_kp1
  hue = hep + hen
  hwp = 0.5 * (un_j_km1 + abs(un_j_km1)) * h_j_km1
  hwn = 0.5 * (un_j_km1 - abs(un_j_km1)) * h_j_k
  huw = hwp + hwn
  hnp = 0.5 * (vn_j_k + abs(vn_j_k)) * h_j_k
  hnn = 0.5 * (vn_j_k - abs(vn_j_k)) * h_jp1_k
  hvn = hnp + hnn
  hsp = 0.5 * (vn_jm1_k + abs(vn_jm1_k)) * h_jm1_k
  hsn = 0.5 * (vn_jm1_k - abs(vn_jm1_k)) * h_j_k
  hvs = hsp + hsn
  etan_j_k = eta_j_k - dt * (hue - huw) / dx - dt * (hvn - hvs) / dy
end subroutine dyn_map_39_scal
! returns wet, u,v,h

end module singleton_module_dyn_map_39

