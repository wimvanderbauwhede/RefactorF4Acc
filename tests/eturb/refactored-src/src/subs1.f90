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
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dam1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dytm1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: datm1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dcm1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dctm1
      logical, intent(In) :: ifaxdy
      real, dimension(1:ly1,1:ly1) :: dam1_copy
      real, dimension(1:ly1,1:ly1) :: datm1_copy
      real, dimension(1:ly1,1:ly1) :: dcm1_copy
      real, dimension(1:ly1,1:ly1) :: dctm1_copy
      real, dimension(1:ly1,1:ly1) :: dym1_copy
      real, dimension(1:ly1,1:ly1) :: dytm1_copy
      if (ifaxdy) then
         dym1_copy = reshape(dym1,shape(dym1_copy))
         dam1_copy = reshape(dam1,shape(dam1_copy))
         call copy(dym1_copy,dam1_copy,ly1*ly1)

         dym1 = reshape(dym1_copy, shape(dym1))
         dam1 = reshape(dam1_copy, shape(dam1))
         dytm1_copy = reshape(dytm1,shape(dytm1_copy))
         datm1_copy = reshape(datm1,shape(datm1_copy))
         call copy(dytm1_copy,datm1_copy,ly1*ly1)

         dytm1 = reshape(dytm1_copy, shape(dytm1))
         datm1 = reshape(datm1_copy, shape(datm1))
      else
         dym1_copy = reshape(dym1,shape(dym1_copy))
         dcm1_copy = reshape(dcm1,shape(dcm1_copy))
         call copy(dym1_copy,dcm1_copy,ly1*ly1)

         dym1 = reshape(dym1_copy, shape(dym1))
         dcm1 = reshape(dcm1_copy, shape(dcm1))
         dytm1_copy = reshape(dytm1,shape(dytm1_copy))
         dctm1_copy = reshape(dctm1,shape(dctm1_copy))
         call copy(dytm1_copy,dctm1_copy,ly1*ly1)

         dytm1 = reshape(dytm1_copy, shape(dytm1))
         dctm1 = reshape(dctm1_copy, shape(dctm1))
      endif
      return
      end subroutine setaxdy

end module singleton_module_src_subs1

