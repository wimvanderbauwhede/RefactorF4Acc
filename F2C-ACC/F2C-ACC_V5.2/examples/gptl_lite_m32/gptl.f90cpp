! gptlinitialize: initialize timing library
integer function gptlinitialize ()
  implicit none

#include "gptl_private.inc"

! Initialize private data
  gptl_nregions = 0           ! number of active regions
  gptl_name(:)   = ' '        ! names of regions
  gptl_last(:)   = 0.         ! last timestamp
  gptl_total(:)  = 0.         ! total accumulated time 
  gptl_ncalls(:) = 0.         ! number of calls
  gptl_initialized = .true.   ! initialization has been done
  gptl_isrunning(:) = .false. ! flag indicates if timer is on

  call system_clock (count_rate=gptl_count_rate)

  gptlinitialize = 0
  return
end function gptlinitialize

! gptlstart: start a timer
integer function gptlstart (name)
  implicit none

  character(len=*), intent(in) :: name
  integer :: idx                          ! region index
  integer, external :: gptlget_regionidx  ! local function returns region index

#include "gptl_private.inc"

  gptlstart = -1                   ! initialize return code to bad
  if (.not. gptl_initialized) then
    write(6,*)'gptlstart: gptlinitialize has not yet been called'
    return
  end if
  idx = gptlget_regionidx (name)

! If returned idx is < 0 we have a new region
  if (idx < 0) then
    if (gptl_nregions >= gptl_max_regions) then
      write(6,*) 'gptlstart: too many regions: gptl_max_regions=', gptl_max_regions
      return
    end if
    gptl_name(gptl_nregions) = name
    idx = gptl_nregions
    gptl_nregions = gptl_nregions + 1
  else if (gptl_isrunning(idx)) then
    write(6,*) 'gptlstart: timer ', name, ' is already running'
    return
  end if

  call system_clock (count=gptl_last(idx))
  gptl_isrunning(idx) = .true.

  gptlstart = 0
  return
end function gptlstart

! gptlstop: stop a timer
integer function gptlstop (name)
  implicit none

  character(len=*), intent(in) :: name
  integer :: idx       ! region index
  integer(8) :: count  ! returned from system_clock

  integer, external :: gptlget_regionidx

#include "gptl_private.inc"
 
  gptlstop = -1
  if (.not. gptl_initialized) then
    write(6,*)'gptlstop: gptlinitialize has not yet been called'
    return
  end if
  idx = gptlget_regionidx (name)

  if (idx < 0) then
    write(6,*) 'gptlstop: timer not found:', name
    return
  end if
  
  if (.not. gptl_isrunning(idx)) then
    write(6,*) 'gptlstop: timer ', name,' is not running'
    return
  end if

  call system_clock (count=count)

  if (count < gptl_last(idx)) then
    write(6,*) 'gptlstop: count rolled over so timing no longer possible'
    return
  end if

  gptl_total(idx) = gptl_total(idx) + (count - gptl_last(idx))
  gptl_isrunning(idx) = .false.
  gptl_ncalls(idx) = gptl_ncalls(idx) + 1

  gptlstop = 0
  return
end function gptlstop

! gptlget_nregions: number of regions being timed
integer function gptlget_nregions (t, nregions)
  implicit none  

  integer, intent(in) :: t          ! normally the thread number but unused here
  integer, intent(out) :: nregions  ! number of regions
#include "gptl_private.inc"

  gptlget_nregions = -1
  if (.not. gptl_initialized) then
    write(6,*)'gptlget_nregions: gptlinitialize has not yet been called'
    return
  end if
  nregions = gptl_nregions

  gptlget_nregions = 0
  return
end function gptlget_nregions

! gptlget_regionname: name of region n
integer function gptlget_regionname (t, n, name)
  implicit none

  integer, intent(in) :: t              ! normally the thread number but unused here
  integer, intent(in) :: n              ! region index to get the name of
  character(len=*), intent(out) :: name ! name of region returned to user

#include "gptl_private.inc"

  gptlget_regionname = -1

  if (.not. gptl_initialized) then
    write(6,*)'gptlget_regionname: gptlinitialize has not yet been called'
    return
  end if

  if (n < 0) then
    write(6,*) 'gptlget_regionname: input n must be between 0 and ', gptl_max_regions-1
    return
  end if

  if (n > gptl_nregions-1) then
    write(6,*) 'gptlget_regionname: region ', n, ' does not exist'
    return
  end if

  name = gptl_name(n)

  gptlget_regionname = 0
  return
end function gptlget_regionname

! gptlget_wallclock: current wallclock time for region 
integer function gptlget_wallclock (name, t, value)
  implicit none

  character(len=*), intent(in) :: name ! region name to get the timing for
  integer, intent(in) :: t             ! normally the thread number but unused here
  real(8), intent(out) :: value        ! seconds elapsed for region 'name'
  integer :: idx                       ! region index
  integer, external :: gptlget_regionidx

#include "gptl_private.inc"

  gptlget_wallclock = -1
  if (.not. gptl_initialized) then
    write(6,*)'gptlget_wallclock: gptlinitialize has not yet been called'
    return
  end if
  idx = gptlget_regionidx (name)

  if (idx < 0) then
    write(6,*) 'gptlget_wallclock: region ', name, ' does not exist'
    return
  end if

  value = gptl_total(idx) / (1._8 * gptl_count_rate)   ! 1._8 is to cast to double

  gptlget_wallclock = 0
  return
end function gptlget_wallclock

! gptlpr: print timings for all regions to stdout
integer function gptlpr (mype)
  implicit none

  integer, intent(in) :: mype  ! normally the MPI rank but ignored here
  integer :: i                 ! index
  real(8) :: value             ! wallclock time
#include "gptl_private.inc"

  do i=0,gptl_nregions-1
    value = gptl_total(i) / (1._8 * gptl_count_rate)   ! 1._8 is to cast to double
    write(6,100) gptl_name(i), value, gptl_ncalls(i)
100 format ('name=',a16,' took ',1p,e9.3,' seconds over ', i6, ' invocations')
  end do

  gptlpr = 0
  return
end function gptlpr

! gptlpr: print timings for all regions to stdout
integer function gptlfinalize ()
  implicit none

#include "gptl_private.inc"

  gptl_initialized = .false.
  gptlfinalize = 0
  return
end function gptlfinalize

! gptlpr_file: not available just return 0
integer function gptlpr_file (file)
  implicit none

  character(len=*), intent(in) :: file

  gptlpr_file = 0
  return
end function gptlpr_file

! gptlprint_memusage: not available just return 0
integer function gptlprint_memusage (string)
  implicit none

  character(len=*), intent(in) :: string
  gptlprint_memusage = 0
  return
end function gptlprint_memusage

! gptlget_memusage: not available just put zeros in output variables
integer function gptlget_memusage (size, rss, share, text, datastack)
  implicit none

  integer, intent(out) :: size, rss, share, text, datastack
  size = 0
  rss = 0
  share = 0
  text = 0
  datastack = 0
  gptlget_memusage = 0
  return
end function gptlget_memusage

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! End of user-callable functions
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
integer function gptlget_regionidx (name)
  implicit none

  character(len=*), intent(in) :: name
  integer :: i

#include "gptl_private.inc"

  gptlget_regionidx = -1
  do i=0,gptl_nregions-1
    if (name == gptl_name(i)) then
      gptlget_regionidx = i
      exit
    end if
  end do

  return
end function gptlget_regionidx
