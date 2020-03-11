module singleton_module_src_subs1

      use singleton_module_src_math
contains

      subroutine flush_io()
      return
      end subroutine flush_io
      subroutine setaxdy(ifaxdy,dym1,dam1,dytm1,datm1,dcm1,dctm1)
      use params_SIZE, only : ly1
      implicit none
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dym1
      real, dimension(1:ly1,1:ly1), intent(In) :: dam1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dytm1
      real, dimension(1:ly1,1:ly1), intent(In) :: datm1
      real, dimension(1:ly1,1:ly1), intent(In) :: dcm1
      real, dimension(1:ly1,1:ly1), intent(In) :: dctm1
      logical, intent(In) :: ifaxdy
      if (ifaxdy) then
         call copy(dym1,dam1,ly1*ly1)
         call copy(dytm1,datm1,ly1*ly1)
      else
         call copy(dym1,dcm1,ly1*ly1)
         call copy(dytm1,dctm1,ly1*ly1)
      endif
      return
      end subroutine setaxdy

end module singleton_module_src_subs1

