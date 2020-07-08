module OPCTR

      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      real(kind=8), dimension(1:maxrts) :: rct
      real(kind=8) :: dcount
      integer, dimension(1:maxrts) :: ncall
      integer :: nrout
      integer :: myrout
      integer :: isclld
      save    myrout,isclld
      data myrout / 0 / 
      data isclld / 0 / 

end module OPCTR
