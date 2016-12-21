! Unit test to demonstrate threading over multiple array dimensions.
!
! Designed for GPU translation
! Mark Govett
!
subroutine blockShared(rd,t3d,ims,ime,kms,kme)

implicit none
integer i,j,k
integer, intent (IN) :: ims,ime,kms,kme
real   ,intent (INOUT) :: t3d(ims:ime,kms:kme)
real   ,intent (IN) :: rd	! gas constant

!ACC$DATA(<t3d:none,shared(100)>)
!ACC$REGION(<ime-ims+1:block=2>,<kme-kms+1>,<kms,kme,ims,ime,rd:in>,<t3d:inout>,<t3d:inout,shared,demote(2)>) BEGIN

! standard loop test with simple array indices
!ACC$DO PARALLEL(1)
  do k=kms,kme
!ACC$DO VECTOR(1)
    do i=ims,ime
      t3d(i,k) = t3d(i,k) * rd
    enddo

! test to handle multiple terms in the affected index "i"
! note how the base thread is 2, so data access by each thread is consistent
!ACC$DO VECTOR(1,1:ime-1)
    do i=ims,ime-1
      t3d(i,k) = t3d(i,k) * rd
    enddo
!ACC$THREAD(ime-1)
    t3d(ime,k) = 0.
  enddo
!ACC$REGION END

return
end subroutine blockShared

