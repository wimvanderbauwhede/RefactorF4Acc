! Unit tests for DATA_MOVEMENT
!
! Designed for GPU translation and execution
! Mark Govett 	Nov 2010
! NOAA/ESRL

! ACC$REGION
!   Variables must be defined either as input arguments, or as constants. 
!
subroutine accdata(vol,flx,factor)

implicit none
integer k,ipn
integer nz,nip
parameter (nz=5,nip=10)
real   ,intent (IN)    :: vol  (nz,nip)
real   ,intent (INOUT) :: flx(nz,nip)
real   ,intent (IN) :: factor

! GPU constants scope is restricted to all routines within a single file. A
! namespace conflict will occur If multiple routines declare the same constant 
! variable.  Since the fermi architecture which supports cache, there appears to
! be little benefit to using constant memory.  Constant variable are always 
! define with intent "in"; anything else is an error

!! MWG: error noted in F2C-ACC_V4.8 
!!ACC$DATA(<factor:in,constant>)

! All variables used in the GPU region must be listed as arguments in the 
! accelerated region (ACC$REGION directive). The F2C-ACC option --Analysis=1
! will analyze each region and determine a recommended (and conservative) list
! of intents for each variable in the region.
!
! In this region, nz and nip are scalars that are copied to the GPU.
!
! vol was copied to the GPU in copyIn and defined with global scope.  Therefore
! it an be referenced as an externally defined GPU resident variable.
!
! flux was defined with "in" scope so it will be copied to gpu prior to
! execution of hte kernel.  It will remain GPU resident until this routine
! is complete.  

!ACC$REGION(<nz>,<nip>,<flx:in>,<nz,nip:in>,<vol:none,extern>) BEGIN
!acc$do parallel
do ipn=1,nip
!acc$do vector
  do k=1,nz
    flx(k,ipn) = flx(k,ipn)/vol(k,ipn)
  end do
end do
!ACC$REGION END

!flx is defined with intent out so it is copied to the CPU when the GPU region
! has completed.  Based on the intent of the previous region (intent "in"), the
! variable is resident on the GPU.
!ACC$REGION(<nz>,<nip>,<flx:out>,<nz,nip:in>,<vol:none,extern>) BEGIN
!acc$do parallel
do ipn=1,nip
!acc$do vector
  do k=1,nz
    flx(k,ipn) = flx(k,ipn)/(factor*vol(k,ipn))
  end do
end do
!ACC$REGION END

end subroutine accdata
