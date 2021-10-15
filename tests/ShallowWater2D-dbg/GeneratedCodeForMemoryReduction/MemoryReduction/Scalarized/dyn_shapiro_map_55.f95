module singleton_module_dyn_shapiro_map_55

contains

subroutine dyn_shapiro_map_55_scal(u_j_k,du___dyn_j_k,wet_j_k,wet_jp1_k,wet_j_kp1,v_j_k, &
      dv___dyn_j_k,un_j_k,vn_j_k)
!    ! Local vars: j,k,uu___dyn,vv___dyn,dvv___dyn
 integer :: j
 integer :: k
 real :: uu___dyn
 real :: vv___dyn
 real :: dvv___dyn
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, intent(In) :: u_j_k
 real, intent(In) :: du___dyn_j_k
 integer, intent(In) :: wet_j_k
 integer, intent(In) :: wet_j_kp1
 integer, intent(In) :: wet_jp1_k
 real, intent(In) :: v_j_k
 real, intent(In) :: dv___dyn_j_k
 real :: duu___dyn
!  WRITTEN
 real, intent(Out) :: un_j_k
 real, intent(Out) :: vn_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 un_j_k = 0.0
 uu___dyn = u_j_k
 duu___dyn = du___dyn_j_k
 if (wet_j_k == 1) then
 if ((wet_j_kp1 == 1) .or. (duu___dyn > 0.0)) un_j_k = uu___dyn + duu___dyn
else
 if ((wet_j_kp1 == 1) .and. (duu___dyn < 0.0)) un_j_k = uu___dyn + duu___dyn
end if
 vv___dyn = v_j_k
 dvv___dyn = dv___dyn_j_k
 vn_j_k = 0.0
 if (wet_j_k == 1) then
 if ((wet_jp1_k == 1) .or. (dv___dyn_j_k > 0.0)) vn_j_k = vv___dyn + dvv___dyn
else
 if ((wet_jp1_k == 1) .and. (dv___dyn_j_k < 0.0)) vn_j_k = vv___dyn + dvv___dyn
end if
end subroutine dyn_shapiro_map_55_scal

end module singleton_module_dyn_shapiro_map_55

