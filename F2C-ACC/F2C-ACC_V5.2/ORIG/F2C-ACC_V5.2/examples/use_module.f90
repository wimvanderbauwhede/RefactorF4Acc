! Unit test for handling variables defined in a module.  In this case
! each variable will be generated with the "extern" qualifier preceeding
! the declaration.
!
! Currently GPU generated output, only defines those variables used in the
! said routine.  All other module variables are ommitted from the declarations
!
! CPU generation will add every module variable to the declaration.  This 
! ill be corrected in a future release.
!
module m1

  contains

subroutine use_vars(rstat)

use module_vars
implicit none
integer i,k
real,intent(OUT) :: rstat

rstat = 0.
!ACC$REGION(<nz>,<nip>,<nz,nip:none,extern>,<vol:none,extern>) BEGIN
!ACC$DO PARALLEL(1)
  do i=1,nip
!ACC$DO VECTOR (1)
    do k = 1, nz
      vol(k,i) = 5.
    enddo
  enddo
!ACC$REGION END

rstat = vol(1,1)

return
end subroutine use_vars

end module m1
