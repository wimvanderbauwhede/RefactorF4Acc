! Unit tests to exercise copies between GPU global and shared memory
! as needed given by the intent of the variable as specified in the 
! ACC$REGION
! To copy from global to shared, an intent IN must be given in the shared
! memory variable entry (eg. <operand:in,shared> ).
!
subroutine Shared3Dout(nx,nz,iter,operand3d)

implicit none
integer,intent(IN)  :: nx,nz,iter
integer,intent(OUT) :: operand3d(nz,nx,iter)

integer :: i,k,it

!ACC$DATA(<operand3d:none,shared>)

!ACC$REGION(<nz>,<nx>,<operand3d:out>,<iter,nz,nx:in>,<operand3d:inout,shared>) BEGIN
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    do it = 1, iter
      operand3d(k,i,it) = (i-1)*nx + k
    enddo
  enddo
enddo
!ACC$REGION END

return
end

