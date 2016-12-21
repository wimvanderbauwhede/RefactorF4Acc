

! Driver routine for GPU runtime tests
! Designed for running on the CPU as Fortran code
! Mark Govett 	Nov 2010
! NOAA/ESRL
!
! subroutines tested:
!   copyIn:	copy data from CPU to GPU
!   accdata:	test data movement between CPU and GPU

program driver

use module_vars
use m1

implicit none
integer, external :: gptlinitialize
integer, external :: gptlfinalize
integer, external :: gptlstart
integer, external :: gptlstop
integer, external :: gptlget_nregions
integer, external :: gptlget_regionname
integer, external :: gptlget_wallclock
integer, external :: gptlpr
integer, external :: gptlprint_memusage
integer, external :: gptlget_memusage

external gptlprocess_namelist
integer iarg,nlen,ic,i
character(len=32) arg

real(8) :: value             ! returned from gptl
real :: valueGPU,valueCPU,valueFTN
integer :: nregions          ! number of regions being tracked by gptl
integer :: n                 ! index over regions
integer irk
integer :: ret
character(64) :: name        ! region name
integer :: size, rss, share, text, datastack ! returned by gptlget_memusage

real sArray(50,20)
integer k,ipn
integer counter
real   :: factor
real   :: rval
integer :: ival
logical passed
real,parameter :: epsilon=1e-4	!round-off error

if (iargc() .gt. 0) then
  call getarg(1,arg)
  nlen = len(arg)
  do i=1,nlen
    ic = ichar(arg(i:i))
    if (ic >= 65 .and. ic < 90) arg(i:i) = char(ic+32)
  end do 
  if ((arg .ne. 'cpu') .and. (arg .ne. 'gpu') .and. (arg .ne. 'ftn')) then
    print *,'ERROR: the only options permitted are \"gpu\", \"cpu\", and \"ftn\"'
    call exit(1)
  endif
  write(6,'(a40)') '----------------------------------------'
  write(6,'(a13,a8)') 'Running Test:',trim(arg)
endif

! timing routines
call gptlprocess_namelist ('GPTLnamelist', 77, ret)
ret = gptlinitialize ()

vol=2.0
vol(1,1) = 1.0
vol(2,1) = 1.0
flx=20.0
factor = 3.

allocate(bigArray(dim1,dim2))
allocate(bigArray3D(dim2,dim1a,dim1b))
allocate(bigArrayT(dim2,dim1))
allocate(sArray3D(dim1a,dim2,dim3a))

print *,'Data Movement Tests'
! make vol a GPU resident variable
call copyIn(nz,nip,vol,factor)
  
call accdata(vol, flx,factor)
passed = .true.
do ipn=1,nip
  do k=1, nz
    if ((k .le. 2) .and. (ipn .eq. 1)) then
      if ((flx(k,ipn)  - 20./3.) .gt. epsilon) then
	passed = .false.
      endif
    else
      if ((flx(k,ipn) - 20./12.) .gt. epsilon) then
        passed = .false.
      endif
    endif
  enddo
enddo
if (passed) then
  print *,'  ACC$DATA Test:        PASSED'
else
  print *,'  ACC$DATA Test:        FAILED'
endif

!intrinsic tests
print *,' '
print *,'Correctness and Accuracy Tests'
call intrinsics(ival,rval)
if (rval .eq. 5.) then
  print *,'  Intrinsics Test:      PASSED'
else
  print *,'  Intrinsics Test:      FAILED'
endif

call scalar(vol,counter,1,nip,1,nz)
if (counter .eq. 48) then
  print *,'  Scalar Test:          PASSED'
else
  print *,'  Scalar Test:          FAILED'
endif

call use_vars(rval)
if (rval .eq. 5.) then
  print *,'  Module Use Test:      PASSED'
else
  print *,'  Module Use Test:      FAILED'
endif

ret = gptlstart ('NumBlocks')
call NumBlocks(dim2,dim1,bigArray)
!print *,' Big Array(10,1) = ',BigArray(10,1)
ret = gptlstop ('NumBlocks')
if (bigArray(10,1) .eq. 5050) then
  print *,'  NumBlocks:            PASSED'
else
  print *,'  NumBlocks:            FAILED'
endif

print *,' '
print *,'Memory and Performance Tests'

bigArray = 0
ret = gptlstart ('global2D')
call global2D(dim1,dim2,bigArray)
ret = gptlstop ('global2D')
if (bigArray(10,1) .eq. 10) then
  print *,'  Global2D:              PASSED'
else
  print *,'  Global2D:              FAILED'
endif

bigArray = 0
ret = gptlstart ('global2Dshared1D')
call global2DShared1D(dim1,dim2,bigArray)
ret = gptlstop ('global2Dshared1D')
if (bigArray(10,1) .eq. 10) then
  print *,'  Global2DShared1D:      PASSED'
else
  print *,'  Global2DShared1D:      FAILED'
endif

bigArray = 0
ret = gptlstart ('global2Dloops')
call global2Dloops(dim1,dim2,bigArray)
ret = gptlstop ('global2Dloops')
if (bigArray(10,1) .eq. 10) then
  print *,'  Global2Dloops:         PASSED'
else
  print *,'  Global2Dloops:         FAILED'
endif

bigArray = 0
ret = gptlstart ('Global2DShared1Dloops')
call global2Dshared1Dloops(dim1,dim2,bigArray)
ret = gptlstop ('Global2DShared1Dloops')
if (bigArray(10,1) .eq. 10) then
  print *,'  Global2DShared1Dloops: PASSED'
else
  print *,'  Global2DShared1Dloops: FAILED'
endif


bigArray = 0
ret = gptlstart ('sharedChunk')
call sharedChunk(dim1,dim2,bigArray)
ret = gptlstop ('sharedChunk')
if (bigArray(10,1) .eq. 451) then
  print *,'  SharedChunk:           PASSED'
else
  print *,'  SharedChunk:           FAILED'
endif

bigArray3D = 0
ret = gptlstart ('global3D')
call global3D(dim2,dim1a,dim1b,bigArray3D)
ret = gptlstop ('global3D')
if (bigArray3D(1,10,1) .eq. 451) then
  print *,'  Global3D:              PASSED'
else
  print *,'  Global3D:              FAILED'
endif

bigArray3D = 0
ret = gptlstart ('global3Dshared1D')
call global3Dshared1D(dim2,dim1a,dim1b,bigArray3D)
ret = gptlstop ('global3Dshared1D')
if (bigArray3D(1,10,1) .eq. 451) then
  print *,'  Global3DShared1D:      PASSED'
else
  print *,'  Global3DShared1D:      FAILED'
endif

ret = gptlstart ('Promote2Dblock')
call global1Dpromote2Dblock(dim1,dim2,bigArrayT)
ret = gptlstop ('Promote2Dblock')
if (bigArrayT(1,10) .eq. 10) then
  print *,'  Promote2DBlock:        PASSED'
else
  print *,'  Promote2DBlock:        FAILED'
endif

ret = gptlstart ('Promote2Dthread')
call global1Dpromote2Dthread(dim1,dim2,bigArrayT)
ret = gptlstop ('Promote2Dthread')
if (bigArrayT(1,10) .eq. 10) then
  print *,'  Promote2DThread:       PASSED'
else
  print *,'  Promote2DThread:       FAILED'
endif

ret = gptlstart ('Shared3Dout')
call Shared3Dout(dim1a,dim2,dim3a,sArray3D)
ret = gptlstop ('Shared3Dout')
if (sArray3D(10,10,1) .eq. 460) then
  print *,'  Shared3Dout:           PASSED'
else
  print *,'  Shared3Dout:           FAILED'
  print *,'sArray3D(10,10,1) = 460:  ',sArray3D(10,10,1)
endif

sArray = 5.
ret = gptlstart ('blockShared')
call blockShared(rval,sArray,1,50,1,20)
ret = gptlstop ('blockShared')

if (sArray(10,10) .eq. 125.) then
  print *,'  blockShared:           PASSED'
else
  print *,'sArray(10,10) = ',sArray(10,10),sArray(50,1),sArray(50,2)
  print *,'  blockShared:           FAILED'
endif

ret = gptlget_nregions (0, nregions)
if (arg .eq. 'gpu') then

  print*,''
  print*,'PERFORMANCE TESTS' 
  print*,''
  print*,'  TARGET    	CODE			COMPILER	HARDWARE'
  print*,'---------------------------------------------------------------------'
  print*,'  FORTRAN	Fortran source		ifort -O2 	1 CPU core'
  print*,'  CPU-C	F2C-ACC generated C	icc -O2		1 CPU core'
  print*,'  GPU		F2C-ACC generated CUDA  nvcc 		1 GPU '
  print*,''
  print*,'             ROUTINE      FORTRAN       CPU-C      GPU-CUDA'

  open(2,file="cpu_results.lis",err=10,status='old')
  open(3,file="ftn_results.lis",err=10,status='old')
  do n=0,nregions-1
    read(2,'(1x,20x,13x,F13.3)') valueCPU
    read(3,'(1x,20x,13x,F13.3)') valueFTN
    name = ' '
    ret = gptlget_regionname (0, n, name)
!MWG: add other results by reading them in from a file ...
    ret = gptlget_wallclock (trim (name), 0, value)
    valueGPU = value
    print"(1x,A20,3F13.3)", trim (name), valueFTN,valueCPU,valueGPU
  end do
  close(2)
  close(3)
else
  if ((arg .eq. 'cpu') .or. (arg .eq. 'ftn')) then
    open(2,file=trim(arg)//"_results.lis",status='new')
    do n=0,nregions-1
      name = ' '
      ret = gptlget_regionname (0, n, name)
      ret = gptlget_wallclock (trim (name), 0, value)
      valueCPU = value
      write(2,'(1x,A20,13x,F13.3)') trim (name), valueCPU
    end do
    close(2)
  endif
endif
stop

10 print *,'ERROR: driver_cpu and driver_ftn must be run prior to the gpu run'
stop
end program driver
