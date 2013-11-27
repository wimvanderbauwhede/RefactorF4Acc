subroutine sharedChunk(nx,nz,phys2D)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: phys2D(nx,nz);

integer :: operand(nx,nz)
integer :: i,k
integer :: iter


!ACC$DATA(<operand:none,shared(50,50)>)
!MWG: F2C-ACC V4.7, 4.8 bug which requires <operand:none> appear before the
!MWG: tuple does.
!ACC$REGION(<50:chunk>,<nx/50>,<nz,nx:in>,<operand:none>,<phys2D:inout>,<operand:none,shared>) BEGIN
do iter = 1, 200
do k = 1, nz
!ACC$DO PARALLEL(1)
  do i = 1, nx
    operand(i,k) = (i-1)*nz + k
  enddo
enddo
do k = 1, nz
!ACC$DO PARALLEL(1)
  do i = 1, nx
    operand(i,k) = operand(i,k)*2
  enddo
enddo
do k = 1, nz
!ACC$DO PARALLEL(1)
  do i = 1, nx
    operand(i,k) = operand(i,k)*2
  enddo
enddo
do k = 1, nz
!ACC$DO PARALLEL(1)
  do i = 1, nx
    operand(i,k) = operand(i,k)/2
  enddo
enddo
do k = 1, nz
!ACC$DO PARALLEL(1)
  do i = 1, nx
    operand(i,k) = operand(i,k)/2
  enddo
enddo

do k = 1, nz
!ACC$DO PARALLEL(1)
  do i = 1, nx
    phys2D(i,k) = operand(i,k)
  enddo
enddo
enddo
!ACC$REGION END

return
end

! Routine to test the F2C-ACC ability to assign multiple columns to a thread block.

subroutine NumBlocks(nx,nz,phys2D)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: phys2D(nx,nz);
integer :: i,k

!ACC$REGION(<nx:block=2>,<nz/2>,<nz,nx:in>,<phys2D:out>) BEGIN
!ACC$DO PARALLEL (1)
do k = 1, nz
!ACC$DO VECTOR (1)
  do i = 1, nx
    phys2D(i,k) = k*nx + nz
  enddo
enddo
!ACC$REGION END

return
end
