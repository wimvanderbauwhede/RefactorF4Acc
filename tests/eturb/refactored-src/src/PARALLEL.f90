module PARALLEL
      use params_PARALLEL, only : lx1, lelt, lelg, ldimt3, ldimt1, ldim, lz1
      integer :: node
      integer :: pid
      integer :: np
      integer :: nullpid
      integer :: node0

      integer(kind=8) :: nvtot
      integer, dimension(0:ldimt1) :: nelg
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer :: nelgv
      integer :: nelgt

      logical :: ifgprnt

      integer :: wdsize
      integer :: isize
      integer :: lsize
      integer :: csize
      integer :: wdsizi

      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth

      logical :: ifgsh_fld_same

      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face

      integer :: dg_hndlx
      integer :: ndg_facex

end module PARALLEL
