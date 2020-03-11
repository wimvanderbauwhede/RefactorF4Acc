module TOPOL
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1

      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm

      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg

end module TOPOL
