module params_ZPER
    use params_SIZE
      integer, parameter :: lfdm0=1-lfdm
      integer, parameter :: lelg_sm=lfdm0+lfdm*lelg
      integer, parameter :: ltfdm2=lfdm0+lfdm*2*lx2*ly2*lz2*lelt
      integer, parameter :: leig2=lfdm0+lfdm*2*lx2*lx2*(lelx*lelx+lely*lely+lelz*lelz)
      integer, parameter :: leig=lfdm0+lfdm*2*lx2*(lelx+lely+lelz)
      integer, parameter :: lp_small=256
      integer, parameter :: lfdx=lfdm0+lfdm*lx2*lelx
      integer, parameter :: lfdy=lfdm0+lfdm*ly2*lely
      integer, parameter :: lfdz=lfdm0+lfdm*lz2*lelz
end module params_ZPER
