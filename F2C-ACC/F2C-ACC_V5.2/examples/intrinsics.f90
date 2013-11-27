!unit test for Fortran intrinsic functions (procedures)
!Written by:	Mark Govett
!Date:		September 2011
!
! Designed for CPU and GPU runtime tests
! CPU to test correctness
! GPU to test function accuracy
!
subroutine intrinsics(val,rval)

integer i,j,k,val
real r,s,t,rval,fval

rval = 4.0
if (i .eq. 1) then
fval = rval**2.0
else
fval = rval**2.0
endif

!ACC$REGION(<1>,<1>,<val,rval:out>) BEGIN
i=3
j=4
k=5

! returns an integer
val=max(i,j,k)

! returns a float from integer arguments
rval=amax0(i,j,k)

!returns a float from float arguments
fval=amax1(rval,1e8)

!ACC$REGION END


return

end subroutine intrinsics
