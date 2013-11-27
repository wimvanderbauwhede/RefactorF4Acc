! Performance and unit tests for the F2C-ACC compiler
! Written by:	Mark Govett
! Date:		February 2012
!
! These tests compare performance using GPU global memory and shared memory
! for a variety of cases as follows:
!   global2D:		baseline test using full 2D arrays for storage
!   global2Dshared1D:	same as global2D but uses shared memory for "operand"
!   global2Dloops:	same as baseline but each update appears in its own loop
!   global2Dshared1Dloops:	shared memory test

!global2D demonstrates repeated use of a single variable used to update another
! variable within a single loop

subroutine global2D(nx,nz,dyn2D)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: dyn2D(nz,nx);

integer :: operand(nz,nx)
integer :: i,k
integer :: iter

!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2D:inout>) BEGIN
do iter = 1, 200
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = (i-1)*nx + k
    operand(k,i) = operand(k,i)*2
    operand(k,i) = operand(k,i)*2
    operand(k,i) = operand(k,i)/2
    operand(k,i) = operand(k,i)/2
    dyn2D(k,i) = operand(k,i)
  enddo
enddo
enddo
!ACC$REGION END

return
end

subroutine global2DShared1D(nx,nz,dyn2D)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: dyn2D(nz,nx);

integer :: operand(nz)
integer :: i,k
integer :: iter

!ACC$DATA(<operand:none,shared(50)>)

!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2D:inout>,<operand:none,shared>) BEGIN
do iter = 1, 200
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k) = (i-1)*nx + k
    operand(k) = operand(k)*2
    operand(k) = operand(k)*2
    operand(k) = operand(k)/2
    operand(k) = operand(k)/2
    dyn2D(k,i) = operand(k)
  enddo
enddo
enddo
!ACC$REGION END

return
end

subroutine global2Dloops(nx,nz,dyn2D)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: dyn2D(nz,nx);

integer :: operand(nz,nx)
integer :: i,k
integer :: iter

!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2D:inout>) BEGIN
do iter = 1, 200
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = (i-1)*nx + k
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)*2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)*2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)/2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)/2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    dyn2D(k,i) = operand(k,i)
  enddo
enddo
enddo
!ACC$REGION END

return
end

subroutine global2Dshared1Dloops(nx,nz,dyn2D)

implicit none
integer,intent(IN)  :: nx,nz
integer,intent(OUT) :: dyn2D(nz,nx);

integer :: operand(nz,nx)
integer :: i,k
integer :: iter

! MWG: this declaration is not needed because shared memory variables are
! MWG: filebased declarations.  Since an ACC$DATA already declared this 
! MWG: variable in an earlier routine, it is omitted here.
!!ACC$DATA(<operand:none,shared(50)>)

!ACC$REGION(<nz>,<nx>,<operand:none>,<nz,nx:in>,<dyn2D:inout>,<operand:none,shared,demote(2)>) BEGIN
do iter = 1, 200
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = (i-1)*nx + k
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)*2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)*2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)/2
  enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i) = operand(k,i)/2
  enddo
enddo

!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO VECTOR(1)
  do k = 1, nz
    dyn2D(k,i) = operand(k,i)
  enddo
enddo
enddo
!ACC$REGION END

return
end

subroutine global3D(nz,nx,ny,dyn3D)

implicit none
integer,intent(IN)  :: nx,ny,nz
integer,intent(OUT) :: dyn3D(nz,nx,ny);

integer :: operand(nz,nx,ny)
integer :: i,j,k
integer :: iter

!ACC$REGION(<nz>,<nx,ny>,<operand:none>,<nz,nx,ny:in>,<dyn3D:out>) BEGIN
do iter = 1, 200
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i,j) = ((i-1)*nx+j) * k
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i,j) = operand(k,i,j)*2
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i,j) = operand(k,i,j)*2
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i,j) = operand(k,i,j)/2
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand(k,i,j) = operand(k,i,j)/2
  enddo
enddo
enddo

!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    dyn3D(k,i,j) = operand(k,i,j)
  enddo
enddo
enddo

enddo
!ACC$REGION END

return
end

subroutine global3Dshared1D(nz,nx,ny,dyn3D)

implicit none
integer,intent(IN)  :: nx,ny,nz
integer,intent(OUT) :: dyn3D(nz,nx,ny);

integer :: operand3D(nz,nx,ny)
integer :: i,j,k
integer :: iter

!ACC$DATA(<operand3D:none,shared(50)>)

!ACC$REGION(<nz>,<nx,ny>,<operand3D:none>,<nz,nx,ny:in>,<dyn3D:out>,<operand3D:none,shared,demote(2,3)>) BEGIN
do iter = 1, 200
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand3D(k,i,j) = ((i-1)*nx+j) * k
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand3D(k,i,j) = operand3D(k,i,j)*2
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand3D(k,i,j) = operand3D(k,i,j)*2
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand3D(k,i,j) = operand3D(k,i,j)/2
  enddo
enddo
enddo
!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    operand3D(k,i,j) = operand3D(k,i,j)/2
  enddo
enddo
enddo

!ACC$DO PARALLEL(1)
do i = 1, nx
!ACC$DO PARALLEL(2)
do j = 1, ny
!ACC$DO VECTOR(1)
  do k = 1, nz
    dyn3D(k,i,j) = operand3D(k,i,j)
  enddo
enddo
enddo

enddo
!ACC$REGION END

return
end
