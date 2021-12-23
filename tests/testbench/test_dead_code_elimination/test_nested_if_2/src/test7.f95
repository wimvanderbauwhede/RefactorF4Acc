module module_test7

contains

   subroutine test7(u,f, global_id)
      implicit none
      real, dimension(1:9), intent(in) :: u
      real, dimension(1:9), intent(out) :: f
      integer, intent(in) :: global_id
      real :: v1
      real :: v2
      real :: v3
      real :: v4
      real :: v5
      real :: v6
      
     
      if (global_id>1) then
          if (u(0)>1.0) then
          else
              v1=1.
          end if
      else if (global_id>0) then
          v2=2.
          if (u(0)>1.0) then
          else if (u(0)>2.) then
              v2=1.
          else
              v1=1.
          end if
      else
      end if
      f = v1+v2
   end subroutine test7

end module module_test7

