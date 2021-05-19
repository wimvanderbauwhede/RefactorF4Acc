module module_test_superkernel


    contains


subroutine f1(acc,v)

    integer(4), parameter :: nx=500
    real, dimension(2:nx+1), intent(In) :: v
    real, intent(InOut) :: acc
! globalIdDeclaration
    integer :: global_id, i, i_rel, i_range
! globalIdInitialisation
    call get_global_id(global_id,0)
    ! The compiler needs this at the moment
    i_range = 500
    i_rel = global_id
    i = i_rel + 1

    acc = acc + v(i)/nx

end subroutine f1


subroutine f2(acc,v)

    integer(4), parameter :: nx=500
    real, dimension(nx), intent(InOut) :: v
    real, intent(In) :: acc
! globalIdDeclaration
    real, dimension(2) :: w
    integer :: global_id, i, i_rel
! globalIdInitialisation
    call get_global_id(global_id,0)
    i_rel = global_id
    i = i_rel + 1
    w(1) = 0.25
    w(2) = 0.75
    v(i) = v(i)*w(1) + acc*w(2)

end subroutine f2

subroutine test_superkernel(v,acc,state_ptr)
  integer(4), parameter :: nx=500
  real, dimension(nx), intent(InOut) :: v
  real, intent(In) :: acc
  integer :: state
  integer, dimension(1):: state_ptr
  state = state_ptr(1) ! state 
  !acc = 0; ! This does not happen with the superkernel approach
! SUPERKERNEL BODY
  select case(state)
    case (1)
      call f1(acc,v)
    case (2)
      call f2(acc,v)
  end select
end subroutine test_superkernel
end module module_test_superkernel
