module module_vars

implicit none
integer, parameter :: nz=5
integer, parameter :: nip=10
integer, parameter :: dim1=5000,dim2=50,dim3a=2
integer, parameter :: dim1a=50,dim1b=100
integer, allocatable :: bigArray(:,:),bigArray3D(:,:,:)
integer, allocatable :: bigArrayT(:,:),bigArray3DT(:,:,:)
integer, allocatable :: sArray3D(:,:,:)

real   :: vol  (nz,nip)
real   :: flx(nz,nip)

end module module_vars
