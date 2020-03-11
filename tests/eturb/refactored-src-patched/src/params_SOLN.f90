module params_SOLN
    use params_SIZE
      integer, parameter :: lvt1=lx1*ly1*lz1*lelv
      integer, parameter :: lvt2=lx2*ly2*lz2*lelv
      integer, parameter :: lbt1=lbx1*lby1*lbz1*lbelv
      integer, parameter :: lbt2=lbx2*lby2*lbz2*lbelv
      integer, parameter :: lorder2=max(1,lorder-2)
end module params_SOLN
