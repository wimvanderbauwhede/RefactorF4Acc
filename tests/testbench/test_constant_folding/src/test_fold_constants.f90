program test_fold_constants
    use Constants
    character(len=maxSize*2) :: characters 
    integer(kind=2), dimension(maxSize) :: tokens
    integer(kind=2) :: ii
    do ii = 1,maxSize
        tokens(ii)=ii*int(secret,2)
        characters(ii:ii) = achar(ii)
    end do
    print *, testHex
end program test_fold_constants
