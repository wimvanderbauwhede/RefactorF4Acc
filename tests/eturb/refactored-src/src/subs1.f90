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
      real, dimension(1:1) :: dytm1_copy
      real, dimension(1:1) :: dctm1_copy
      if (ifaxdy) then
         call copy(dym1_copy,dam1_copy,ly1*ly1)

         call copy(dytm1_copy,datm1_copy,ly1*ly1)

      else
         call copy(dym1_copy,dcm1_copy,ly1*ly1)

         call copy(dytm1_copy,dctm1_copy,ly1*ly1)

      endif
      return
      end subroutine setaxdy

end module singleton_module_src_subs1

