! Unit test for GPU execution
! Written by:		Mark Govett
! Date:			February 2012
!
!Unit tests to demonstrate the ability to promote and demote variables
!which may be required for correctness (promote) or performance (shared)
!   global1Dpromote2Dblock:	routine to promote the block dimension
!   global1Dpromote2Dthread:	routine to promote the thread dimension
!
subroutine global1Dpromote2Dblock(nx,nz,bigArray)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: bigArray(nz,nx);

integer :: operand(nz)
integer :: i,k
integer :: iter

!ACC$REGION(<nz>,<nx>,<nz,nx:in>,<bigarray:inout>,<operand:none,global,promote(1:block)>) BEGIN
do iter = 1, 500
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k) = i	! always even values
    operand(k) = operand(k)*2
    operand(k) = operand(k)*2
    operand(k) = operand(k)/2
    bigArray(k,i) = operand(k)/2
  enddo
enddo
enddo
!ACC$REGION END

return
end

! routine to promote the thread dimension
subroutine global1Dpromote2Dthread(nx,nz,bigArray)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: bigArray(nz,nx);

integer :: operandT(nx)
integer :: i,k
integer :: iter

!ACC$REGION(<nz:block=2>,<nx>,<nz,nx:in>,<bigarray:inout>,<operandT:none,global,promote(1:block)>) BEGIN
do iter = 1, 500
!ACC$DO PARALLEL(1)
do i = 1, nx
  operandT(i) = i	! always even values
  operandT(i) = operandT(i)*2
  operandT(i) = operandT(i)*2
  operandT(i) = operandT(i)/2
!ACC$DO VECTOR(1)
  do k = 1, nz
    bigArray(k,i) = operandT(i)/2
  enddo
enddo
enddo
!ACC$REGION END

return
end
