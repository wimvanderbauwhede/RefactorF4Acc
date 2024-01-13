module Constants

    integer, parameter :: maxSize = 42
    integer, parameter :: byteSz = 0
    integer, parameter :: maxSizeExpr = (byteSz*2+2)*4
    integer(kind=(maxSize*2+2)*4), parameter :: testExpr = 7188+(maxSize+13)*10000
    integer(kind=1), parameter :: testHex = Z"2A"
    real, parameter :: secret = 5.57188
    character, parameter :: NL = achar(10)

end module Constants

