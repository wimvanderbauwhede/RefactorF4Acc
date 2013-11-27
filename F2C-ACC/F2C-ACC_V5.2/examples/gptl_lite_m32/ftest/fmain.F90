program fmain
  implicit none
#include "../gptl.inc"

  integer :: ret                   ! return code from GPTL routines
  integer :: nfail = 0             ! number of failed tests
  integer :: nregions = -1         ! number of regions returned by gptlget_nregions
  real(8) :: value                 ! wallclock returned by gptlget_wallclock
  character(len=32) :: name = ' '  ! region name returned by gptlget_regionname
  integer :: i                     ! index

  write(6,*) 'testing initialize...'
  if (gptlinitialize () == 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing start...'
  if (gptlstart ('main') == 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing nested start...'
  if (gptlstart ('sub') == 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing stop...'
  if (gptlstop ('sub') == 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing get_nregions...'
  if (gptlget_nregions (0, nregions) == 0) then
    write(6,*) 'function success'
    if (nregions == 2) then
      write(6,*) 'nregions = 2: success'
    else
      write(6,*) 'nregions not = 2: failure'
      nfail = nfail + 1
    end if
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing get_regionname...'
  if (gptlget_regionname (0, 1, name) == 0) then
    write(6,*) 'function success'
    if (trim (name) == 'sub') then
      write(6,*) 'name="sub": success'
    else
      write(6,*) 'failure'
      nfail = nfail + 1
    end if
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing get_wallclock after sleeping 1 second...'
  call mysleep (1)
  ret = gptlstop ('main')

  if (gptlget_wallclock ('main', 0, value) == 0) then
    write(6,*) 'function success'
    if (value > 0.9 .and. value < 1.1) then
      write(6,*) 'value is around 1: success'
    else
      write(6,*) 'failure'
      nfail = nfail + 1
    end if
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing gptlpr: you should see 2 calls with 1 invocation each:'
  if (gptlpr (0) == 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  ret = gptlfinalize (0)
  write(6,*) 'testing failure modes: you should see some failure prints'

  write(6,*) 'testing start w/o initialize...'
  if (gptlstart ('zzz') < 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  ret = gptlinitialize ()

  write(6,*) 'testing stop of non-existent region...'
  if (gptlstop ('main') < 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  ret = gptlstart ('main')
  ret = gptlstop ('main')

  write(6,*) 'testing stop w/o starting...'
  if (gptlstop ('main') < 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing get_regionname for a non-existent region...'
  if (gptlget_regionname (0, 1, name) < 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing get_wallclock for a non-existent region...'
  if (gptlget_wallclock ('xyz', 0, value) < 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
    nfail = nfail + 1
  end if

  write(6,*) 'testing too many timers...'
  do i=1,10000
    write(name,'(a5)') i
    ret = gptlstart (name)
    if (ret < 0) then
      exit
    end if
  end do

  if (ret < 0) then
    write(6,*) 'success'
  else
    write(6,*) 'failure'
  end if

  if (nfail == 0) then
    write(6,*) 'ALL TESTS PASSED!!!'
  else
    write(6,*) 'Total test failures=', nfail
    write(6,*) 'See above for details'
  end if

  stop 0
end program fmain
