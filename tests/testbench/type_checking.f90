program ts
    implicit none
    integer(kind=4) :: i41
    integer(kind=8) :: i81
    real :: r1
    real(kind=8) :: d2
    integer(kind=2) :: s1
    double precision :: d1
    logical :: l1
    i41 = 2147483647
    i81 = 2147483647*2147483647
    r1 = 1e-4
    d1 = 1e-8
    d2 = 7188
    d2 = d1

    i41 = i81 ! Possible change of value in conversion ('Unsafe')
    i41 = 2*i41+i81/2
    i41= int(i81,4)
    i41 = r1 ! Unsafe
    i41 = d1 ! Unsafe

    s1 = r1 ! Unsafe
    s1 = i41 ! Unsafe
    s1 = i81 ! Unsafe

    i81 = i41 ! OK
    i81 = r1 ! Unsafe
    i81 = d1 ! Unsafe

    d1 = r1 ! OK
    d1 = i41 ! OK
    d1 = i81 ! OK

    r1 = d1  ! Unsafe
    r1 = i41 ! OK
    r1 = i81 ! Unsafe
    ! Extension
    l1 = i41
    l1 = i41
    l1 = i41
    l1 = i41

    i41 = l1
    i81 = l1

    ! Error
    !r1 = l1 ! Error
    !d1 = l1 ! Error


    print *, 'Subroutine calls'
    r1 = 1e4
    d1 = 1e8      
    call fi41(i81)
    call fi41(r1)
    call fi41(d1)

    call fi81(i41) ! OK
    call fi81(r1)
    call fi81(d1)      

    call fd1(i41) 
    call fd1(i81)
    call fd1(r1) 

    call fr1(i41)
    call fr1(i81)
    call fr1(d1)           

end program ts

subroutine fi41(i41)
    implicit none
    integer(kind=4) :: i41
    print *, i41
end subroutine fi41        

subroutine fi81(i81)
    implicit none
    integer(kind=4) :: i81
    print *, i81
end subroutine fi81    

subroutine fd1(d1)
    implicit none
    double precision :: d1
    print *, d1
end subroutine fd1                

subroutine fr1(r1)
    implicit none
    real :: r1
    print *, r1
end subroutine fr1          
