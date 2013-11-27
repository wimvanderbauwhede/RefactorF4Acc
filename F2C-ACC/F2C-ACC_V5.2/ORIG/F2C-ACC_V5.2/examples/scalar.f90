

! Scalar Values Test:
! Designed for GPU translation and execution
! Mark Govett 	July 2011
! NOAA/ESRL
!
! Unit tests for handling of scalar values thru subroutine interfaces and
! between kernels.  The C language is pass-by value for scalars, and pass-by
! reference for arrays.  This test insures scalars can be passed by reference
! and updated if necessary.
!
! The intent attribute is used in subroutine declarations, and used to 
! indicate if an update of the scalar is needed.  By default, scalars are
! pass-by-value (intent IN) to avoid problems when contants are passed into
! the subroutine.  Users must explicitly state when intent is IN or INOUT.
!
! To communicate scalar results between CPU and GPU, intent must be
! specified in the ACC$REGION data section.
!
subroutine scalar(vol,counter,ims,ime,kms,kme)

implicit none
integer k,ipn
integer, intent (INOUT)  :: counter
integer, intent (IN)     :: ims,ime,kms,kme
real   ,intent (IN)    :: vol  (kms:kme,ims:ime)
integer counter_gpu(ims:ime)

counter = 0






!ACC$REGION(<kme-kms+1>,<ime-ims+1>,<ims,ime,kms,kme,vol:in>,<counter_gpu,counter:inout>) BEGIN
!acc$do parallel
do ipn=ims,ime

!acc$thread(1) begin
  do k=kms,kme
    if (vol(k,ipn) .eq. 2.0) then



      counter = counter + 1

    endif
  end do
!acc$thread end

end do
!ACC$REGION END






return
end subroutine scalar
