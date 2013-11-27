! Unit tests for ACC$REGION Data handling
! Designed for GPU translation and execution
! Mark Govett 	Nov 2010
! NOAA/ESRL
!
! ACC$DATA is used to copy data between GPU and CPU, and permit other
! routines to access that data (without requiring a copy)
!
! this is a no-op routine for the CPU
!
subroutine copyIn(nz,nip,vol,factor)

implicit none
integer,intent (IN)    ::nz,nip
real   ,intent (IN)    :: vol  (nz,nip)
real   ,intent (IN)	:: factor

! "in" specifies data will be copied to the GPU
! "global" specifies the pointer defined to access the data will have global scope
!
!ACC$DATA(<nz,nip,vol:in,global>)

end subroutine copyIn
