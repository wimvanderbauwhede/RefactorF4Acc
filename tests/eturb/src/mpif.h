! -*- fortran -*-
!
! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2005 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2017      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Do ***not*** copy this file to the directory where your Fortran
! fortran application is compiled unless it is absolutely necessary!  Most
! modern Fortran compilers now support the -I command line flag, which
! tells the compiler where to find .h files (specifically, this one).  For
! example:
!
!      shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
!
! will probably do the trick (assuming that you have set OMPI_HOME
! properly).
!
! That being said, OMPI's "mpifort" wrapper compiler should
! automatically include the -I option for you.  The following command
! should be equivalent to the command listed above:
!
!      shell$ mpifort foo.f -o foo
!
! You should not copy this file to your local directory because it is
! possible that this file will be changed between versions of Open MPI.
! Indeed, this mpif.h is incompatible with the mpif.f of other
! implementations of MPI.  Using this mpif.h with other implementations
! of MPI, or with other versions of Open MPI will result in undefined
! behavior (to include incorrect results, segmentation faults,
! unexplainable "hanging" in your application, etc.).  Always use the
! -I command line option instead (or let mpifort do it for you).
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!      include 'mpif-config.h'
!      include 'mpif-constants.h'
!      include 'mpif-handles.h'
!      include 'mpif-io-constants.h'
!      include 'mpif-io-handles.h'
!      include 'mpif-externals.h'
!      include 'mpif-sentinels.h'
!      include 'mpif-sizeof.h'

! -*- fortran -*-
!
! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2005 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                         reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

!
!     This file contains the output from configure that is relevant for
!     Fortran applications and a few values that are necessary to
!     compile the Fortran modules (e.g., MPI_STATUS_SIZE).
!

!
!     OMPI version
!     This file is generated from configure; do not edit it manually.
!
      integer OMPI_MAJOR_VERSION, OMPI_MINOR_VERSION
      integer OMPI_RELEASE_VERSION
      parameter (OMPI_MAJOR_VERSION=4)
      parameter (OMPI_MINOR_VERSION=0)
      parameter (OMPI_RELEASE_VERSION=1)
!
!     Kind parameters
!
      integer MPI_OFFSET_KIND, MPI_ADDRESS_KIND, MPI_INTEGER_KIND
      integer MPI_COUNT_KIND
      parameter (MPI_INTEGER_KIND=4)
      parameter (MPI_ADDRESS_KIND=8)
      parameter (MPI_OFFSET_KIND=8)
      parameter (MPI_COUNT_KIND=8)
!
!     Miscellaneous constants
!
      integer MPI_STATUS_SIZE
      parameter (MPI_STATUS_SIZE=6)
!
!     Configurable length constants
!
      integer MPI_MAX_PROCESSOR_NAME
      integer MPI_MAX_ERROR_STRING
      integer MPI_MAX_OBJECT_NAME
      integer MPI_MAX_LIBRARY_VERSION_STRING
      integer MPI_MAX_INFO_KEY
      integer MPI_MAX_INFO_VAL
      integer MPI_MAX_PORT_NAME
      integer MPI_MAX_DATAREP_STRING
      parameter (MPI_MAX_PROCESSOR_NAME=256-1)
      parameter (MPI_MAX_ERROR_STRING=256-1)
      parameter (MPI_MAX_OBJECT_NAME=64-1)
      parameter (MPI_MAX_LIBRARY_VERSION_STRING=256-1)
      parameter (MPI_MAX_INFO_KEY=36-1)
      parameter (MPI_MAX_INFO_VAL=256-1)
      parameter (MPI_MAX_PORT_NAME=1024-1)
      parameter (MPI_MAX_DATAREP_STRING=128-1)

!
! MPI F08 conformance
!
      logical MPI_SUBARRAYS_SUPPORTED
      logical MPI_ASYNC_PROTECTS_NONBLOCKING
      ! Hard-coded for .false. for now
      parameter (MPI_SUBARRAYS_SUPPORTED= .false.)
      ! Hard-coded for .false. for now
      parameter (MPI_ASYNC_PROTECTS_NONBLOCKING = .false.)

! -*- fortran -*-
! WARNING! THIS IS A GENERATED FILE!!
! ANY EDITS YOU PUT HERE WILL BE LOST!
! ==> Instead, edit topdir/ompi/include/mpif-values.pl.

! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2010 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! Copyright (c) 2016      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

        integer MPI_ANY_SOURCE
        integer MPI_ANY_TAG
        integer MPI_APPNUM
        integer MPI_BSEND_OVERHEAD
        integer MPI_CART
        integer MPI_COMBINER_CONTIGUOUS
        integer MPI_COMBINER_DARRAY
        integer MPI_COMBINER_DUP
        integer MPI_COMBINER_F90_COMPLEX
        integer MPI_COMBINER_F90_INTEGER
        integer MPI_COMBINER_F90_REAL
        integer MPI_COMBINER_HINDEXED
        integer MPI_COMBINER_HINDEXED_BLOCK
        integer MPI_COMBINER_HINDEXED_INTEGER
        integer MPI_COMBINER_HVECTOR
        integer MPI_COMBINER_HVECTOR_INTEGER
        integer MPI_COMBINER_INDEXED
        integer MPI_COMBINER_INDEXED_BLOCK
        integer MPI_COMBINER_NAMED
        integer MPI_COMBINER_RESIZED
        integer MPI_COMBINER_STRUCT
        integer MPI_COMBINER_STRUCT_INTEGER
        integer MPI_COMBINER_SUBARRAY
        integer MPI_COMBINER_VECTOR
        integer MPI_COMM_TYPE_SHARED
        integer MPI_CONGRUENT
        integer MPI_DISTRIBUTE_BLOCK
        integer MPI_DISTRIBUTE_CYCLIC
        integer MPI_DISTRIBUTE_DFLT_DARG
        integer MPI_DISTRIBUTE_NONE
        integer MPI_DIST_GRAPH
        integer MPI_ERROR
        integer MPI_ERR_ACCESS
        integer MPI_ERR_AMODE
        integer MPI_ERR_ARG
        integer MPI_ERR_ASSERT
        integer MPI_ERR_BAD_FILE
        integer MPI_ERR_BASE
        integer MPI_ERR_BUFFER
        integer MPI_ERR_COMM
        integer MPI_ERR_CONVERSION
        integer MPI_ERR_COUNT
        integer MPI_ERR_DIMS
        integer MPI_ERR_DISP
        integer MPI_ERR_DUP_DATAREP
        integer MPI_ERR_FILE
        integer MPI_ERR_FILE_EXISTS
        integer MPI_ERR_FILE_IN_USE
        integer MPI_ERR_GROUP
        integer MPI_ERR_INFO
        integer MPI_ERR_INFO_KEY
        integer MPI_ERR_INFO_NOKEY
        integer MPI_ERR_INFO_VALUE
        integer MPI_ERR_INTERN
        integer MPI_ERR_IN_STATUS
        integer MPI_ERR_IO
        integer MPI_ERR_KEYVAL
        integer MPI_ERR_LASTCODE
        integer MPI_ERR_LOCKTYPE
        integer MPI_ERR_NAME
        integer MPI_ERR_NOT_SAME
        integer MPI_ERR_NO_MEM
        integer MPI_ERR_NO_SPACE
        integer MPI_ERR_NO_SUCH_FILE
        integer MPI_ERR_OP
        integer MPI_ERR_OTHER
        integer MPI_ERR_PENDING
        integer MPI_ERR_PORT
        integer MPI_ERR_QUOTA
        integer MPI_ERR_RANK
        integer MPI_ERR_READ_ONLY
        integer MPI_ERR_REQUEST
        integer MPI_ERR_RMA_ATTACH
        integer MPI_ERR_RMA_CONFLICT
        integer MPI_ERR_RMA_FLAVOR
        integer MPI_ERR_RMA_RANGE
        integer MPI_ERR_RMA_SHARED
        integer MPI_ERR_RMA_SYNC
        integer MPI_ERR_ROOT
        integer MPI_ERR_SERVICE
        integer MPI_ERR_SIZE
        integer MPI_ERR_SPAWN
        integer MPI_ERR_TAG
        integer MPI_ERR_TOPOLOGY
        integer MPI_ERR_TRUNCATE
        integer MPI_ERR_TYPE
        integer MPI_ERR_UNKNOWN
        integer MPI_ERR_UNSUPPORTED_DATAREP
        integer MPI_ERR_UNSUPPORTED_OPERATION
        integer MPI_ERR_WIN
        integer MPI_GRAPH
        integer MPI_HOST
        integer MPI_IDENT
        integer MPI_IO
        integer MPI_KEYVAL_INVALID
        integer MPI_LASTUSEDCODE
        integer MPI_LOCK_EXCLUSIVE
        integer MPI_LOCK_SHARED
        integer MPI_MODE_NOCHECK
        integer MPI_MODE_NOPRECEDE
        integer MPI_MODE_NOPUT
        integer MPI_MODE_NOSTORE
        integer MPI_MODE_NOSUCCEED
        integer MPI_ORDER_C
        integer MPI_ORDER_FORTRAN
        integer MPI_PROC_NULL
        integer MPI_ROOT
        integer MPI_SIMILAR
        integer MPI_SOURCE
        integer MPI_SUBVERSION
        integer MPI_SUCCESS
        integer MPI_TAG
        integer MPI_TAG_UB
        integer MPI_THREAD_FUNNELED
        integer MPI_THREAD_MULTIPLE
        integer MPI_THREAD_SERIALIZED
        integer MPI_THREAD_SINGLE
        integer MPI_TYPECLASS_COMPLEX
        integer MPI_TYPECLASS_INTEGER
        integer MPI_TYPECLASS_REAL
        integer MPI_T_ERR_CANNOT_INIT
        integer MPI_T_ERR_CVAR_SET_NEVER
        integer MPI_T_ERR_CVAR_SET_NOT_NOW
        integer MPI_T_ERR_INVALID
        integer MPI_T_ERR_INVALID_HANDLE
        integer MPI_T_ERR_INVALID_INDEX
        integer MPI_T_ERR_INVALID_ITEM
        integer MPI_T_ERR_INVALID_SESSION
        integer MPI_T_ERR_MEMORY
        integer MPI_T_ERR_NOT_INITIALIZED
        integer MPI_T_ERR_OUT_OF_HANDLES
        integer MPI_T_ERR_OUT_OF_SESSIONS
        integer MPI_T_ERR_PVAR_NO_ATOMIC
        integer MPI_T_ERR_PVAR_NO_STARTSTOP
        integer MPI_T_ERR_PVAR_NO_WRITE
        integer MPI_UNDEFINED
        integer MPI_UNEQUAL
        integer MPI_UNIVERSE_SIZE
        integer MPI_VERSION
        integer MPI_WIN_BASE
        integer MPI_WIN_CREATE_FLAVOR
        integer MPI_WIN_DISP_UNIT
        integer MPI_WIN_FLAVOR_ALLOCATE
        integer MPI_WIN_FLAVOR_CREATE
        integer MPI_WIN_FLAVOR_DYNAMIC
        integer MPI_WIN_FLAVOR_SHARED
        integer MPI_WIN_MODEL
        integer MPI_WIN_SEPARATE
        integer MPI_WIN_SIZE
        integer MPI_WIN_UNIFIED
        integer MPI_WTIME_IS_GLOBAL
        integer OMPI_COMM_TYPE_BOARD
        integer OMPI_COMM_TYPE_CLUSTER
        integer OMPI_COMM_TYPE_CORE
        integer OMPI_COMM_TYPE_CU
        integer OMPI_COMM_TYPE_HOST
        integer OMPI_COMM_TYPE_HWTHREAD
        integer OMPI_COMM_TYPE_L1CACHE
        integer OMPI_COMM_TYPE_L2CACHE
        integer OMPI_COMM_TYPE_L3CACHE
        integer OMPI_COMM_TYPE_NODE
        integer OMPI_COMM_TYPE_NUMA
        integer OMPI_COMM_TYPE_SOCKET

        parameter (MPI_ANY_SOURCE=-1)
        parameter (MPI_ANY_TAG=-1)
        parameter (MPI_APPNUM=4)
        parameter (MPI_BSEND_OVERHEAD=128)
        parameter (MPI_CART=1)
        parameter (MPI_COMBINER_CONTIGUOUS=2)
        parameter (MPI_COMBINER_DARRAY=13)
        parameter (MPI_COMBINER_DUP=1)
        parameter (MPI_COMBINER_F90_COMPLEX=15)
        parameter (MPI_COMBINER_F90_INTEGER=16)
        parameter (MPI_COMBINER_F90_REAL=14)
        parameter (MPI_COMBINER_HINDEXED=8)
        parameter (MPI_COMBINER_HINDEXED_BLOCK=18)
        parameter (MPI_COMBINER_HINDEXED_INTEGER=7)
        parameter (MPI_COMBINER_HVECTOR=5)
        parameter (MPI_COMBINER_HVECTOR_INTEGER=4)
        parameter (MPI_COMBINER_INDEXED=6)
        parameter (MPI_COMBINER_INDEXED_BLOCK=9)
        parameter (MPI_COMBINER_NAMED=0)
        parameter (MPI_COMBINER_RESIZED=17)
        parameter (MPI_COMBINER_STRUCT=11)
        parameter (MPI_COMBINER_STRUCT_INTEGER=10)
        parameter (MPI_COMBINER_SUBARRAY=12)
        parameter (MPI_COMBINER_VECTOR=3)
        parameter (MPI_COMM_TYPE_SHARED=0)
        parameter (MPI_CONGRUENT=1)
        parameter (MPI_DISTRIBUTE_BLOCK=0)
        parameter (MPI_DISTRIBUTE_CYCLIC=1)
        parameter (MPI_DISTRIBUTE_DFLT_DARG=-1)
        parameter (MPI_DISTRIBUTE_NONE=2)
        parameter (MPI_DIST_GRAPH=3)
        parameter (MPI_ERROR=3)
        parameter (MPI_ERR_ACCESS=20)
        parameter (MPI_ERR_AMODE=21)
        parameter (MPI_ERR_ARG=13)
        parameter (MPI_ERR_ASSERT=22)
        parameter (MPI_ERR_BAD_FILE=23)
        parameter (MPI_ERR_BASE=24)
        parameter (MPI_ERR_BUFFER=1)
        parameter (MPI_ERR_COMM=5)
        parameter (MPI_ERR_CONVERSION=25)
        parameter (MPI_ERR_COUNT=2)
        parameter (MPI_ERR_DIMS=12)
        parameter (MPI_ERR_DISP=26)
        parameter (MPI_ERR_DUP_DATAREP=27)
        parameter (MPI_ERR_FILE=30)
        parameter (MPI_ERR_FILE_EXISTS=28)
        parameter (MPI_ERR_FILE_IN_USE=29)
        parameter (MPI_ERR_GROUP=9)
        parameter (MPI_ERR_INFO=34)
        parameter (MPI_ERR_INFO_KEY=31)
        parameter (MPI_ERR_INFO_NOKEY=32)
        parameter (MPI_ERR_INFO_VALUE=33)
        parameter (MPI_ERR_INTERN=17)
        parameter (MPI_ERR_IN_STATUS=18)
        parameter (MPI_ERR_IO=35)
        parameter (MPI_ERR_KEYVAL=36)
        parameter (MPI_ERR_LASTCODE=92)
        parameter (MPI_ERR_LOCKTYPE=37)
        parameter (MPI_ERR_NAME=38)
        parameter (MPI_ERR_NOT_SAME=40)
        parameter (MPI_ERR_NO_MEM=39)
        parameter (MPI_ERR_NO_SPACE=41)
        parameter (MPI_ERR_NO_SUCH_FILE=42)
        parameter (MPI_ERR_OP=10)
        parameter (MPI_ERR_OTHER=16)
        parameter (MPI_ERR_PENDING=19)
        parameter (MPI_ERR_PORT=43)
        parameter (MPI_ERR_QUOTA=44)
        parameter (MPI_ERR_RANK=6)
        parameter (MPI_ERR_READ_ONLY=45)
        parameter (MPI_ERR_REQUEST=7)
        parameter (MPI_ERR_RMA_ATTACH=69)
        parameter (MPI_ERR_RMA_CONFLICT=46)
        parameter (MPI_ERR_RMA_FLAVOR=70)
        parameter (MPI_ERR_RMA_RANGE=68)
        parameter (MPI_ERR_RMA_SHARED=71)
        parameter (MPI_ERR_RMA_SYNC=47)
        parameter (MPI_ERR_ROOT=8)
        parameter (MPI_ERR_SERVICE=48)
        parameter (MPI_ERR_SIZE=49)
        parameter (MPI_ERR_SPAWN=50)
        parameter (MPI_ERR_TAG=4)
        parameter (MPI_ERR_TOPOLOGY=11)
        parameter (MPI_ERR_TRUNCATE=15)
        parameter (MPI_ERR_TYPE=3)
        parameter (MPI_ERR_UNKNOWN=14)
        parameter (MPI_ERR_UNSUPPORTED_DATAREP=51)
        parameter (MPI_ERR_UNSUPPORTED_OPERATION=52)
        parameter (MPI_ERR_WIN=53)
        parameter (MPI_GRAPH=2)
        parameter (MPI_HOST=1)
        parameter (MPI_IDENT=0)
        parameter (MPI_IO=2)
        parameter (MPI_KEYVAL_INVALID=-1)
        parameter (MPI_LASTUSEDCODE=5)
        parameter (MPI_LOCK_EXCLUSIVE=1)
        parameter (MPI_LOCK_SHARED=2)
        parameter (MPI_MODE_NOCHECK=1)
        parameter (MPI_MODE_NOPRECEDE=2)
        parameter (MPI_MODE_NOPUT=4)
        parameter (MPI_MODE_NOSTORE=8)
        parameter (MPI_MODE_NOSUCCEED=16)
        parameter (MPI_ORDER_C=0)
        parameter (MPI_ORDER_FORTRAN=1)
        parameter (MPI_PROC_NULL=-2)
        parameter (MPI_ROOT=-4)
        parameter (MPI_SIMILAR=2)
        parameter (MPI_SOURCE=1)
        parameter (MPI_SUBVERSION=1)
        parameter (MPI_SUCCESS=0)
        parameter (MPI_TAG=2)
        parameter (MPI_TAG_UB=0)
        parameter (MPI_THREAD_FUNNELED=1)
        parameter (MPI_THREAD_MULTIPLE=3)
        parameter (MPI_THREAD_SERIALIZED=2)
        parameter (MPI_THREAD_SINGLE=0)
        parameter (MPI_TYPECLASS_COMPLEX=3)
        parameter (MPI_TYPECLASS_INTEGER=1)
        parameter (MPI_TYPECLASS_REAL=2)
        parameter (MPI_T_ERR_CANNOT_INIT=56)
        parameter (MPI_T_ERR_CVAR_SET_NEVER=64)
        parameter (MPI_T_ERR_CVAR_SET_NOT_NOW=63)
        parameter (MPI_T_ERR_INVALID=72)
        parameter (MPI_T_ERR_INVALID_HANDLE=59)
        parameter (MPI_T_ERR_INVALID_INDEX=57)
        parameter (MPI_T_ERR_INVALID_ITEM=58)
        parameter (MPI_T_ERR_INVALID_SESSION=62)
        parameter (MPI_T_ERR_MEMORY=54)
        parameter (MPI_T_ERR_NOT_INITIALIZED=55)
        parameter (MPI_T_ERR_OUT_OF_HANDLES=60)
        parameter (MPI_T_ERR_OUT_OF_SESSIONS=61)
        parameter (MPI_T_ERR_PVAR_NO_ATOMIC=67)
        parameter (MPI_T_ERR_PVAR_NO_STARTSTOP=65)
        parameter (MPI_T_ERR_PVAR_NO_WRITE=66)
        parameter (MPI_UNDEFINED=-32766)
        parameter (MPI_UNEQUAL=3)
        parameter (MPI_UNIVERSE_SIZE=6)
        parameter (MPI_VERSION=3)
        parameter (MPI_WIN_BASE=7)
        parameter (MPI_WIN_CREATE_FLAVOR=10)
        parameter (MPI_WIN_DISP_UNIT=9)
        parameter (MPI_WIN_FLAVOR_ALLOCATE=2)
        parameter (MPI_WIN_FLAVOR_CREATE=1)
        parameter (MPI_WIN_FLAVOR_DYNAMIC=3)
        parameter (MPI_WIN_FLAVOR_SHARED=4)
        parameter (MPI_WIN_MODEL=11)
        parameter (MPI_WIN_SEPARATE=1)
        parameter (MPI_WIN_SIZE=8)
        parameter (MPI_WIN_UNIFIED=0)
        parameter (MPI_WTIME_IS_GLOBAL=3)
        parameter (OMPI_COMM_TYPE_BOARD=8)
        parameter (OMPI_COMM_TYPE_CLUSTER=11)
        parameter (OMPI_COMM_TYPE_CORE=2)
        parameter (OMPI_COMM_TYPE_CU=10)
        parameter (OMPI_COMM_TYPE_HOST=9)
        parameter (OMPI_COMM_TYPE_HWTHREAD=1)
        parameter (OMPI_COMM_TYPE_L1CACHE=3)
        parameter (OMPI_COMM_TYPE_L2CACHE=4)
        parameter (OMPI_COMM_TYPE_L3CACHE=5)
        parameter (OMPI_COMM_TYPE_NODE=0)
        parameter (OMPI_COMM_TYPE_NUMA=7)
        parameter (OMPI_COMM_TYPE_SOCKET=6)
! -*- fortran -*-
! WARNING! THIS IS A GENERATED FILE!!
! ANY EDITS YOU PUT HERE WILL BE LOST!
! ==> Instead, edit topdir/ompi/include/mpif-values.pl.

! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2010 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! Copyright (c) 2016      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

        integer MPI_2COMPLEX
        integer MPI_2DOUBLE_COMPLEX
        integer MPI_2DOUBLE_PRECISION
        integer MPI_2INT
        integer MPI_2INTEGER
        integer MPI_2REAL
        integer MPI_AINT
        integer MPI_BAND
        integer MPI_BOR
        integer MPI_BXOR
        integer MPI_BYTE
        integer MPI_CHAR
        integer MPI_CHARACTER
        integer MPI_COMM_NULL
        integer MPI_COMM_SELF
        integer MPI_COMM_WORLD
        integer MPI_COMPLEX
        integer MPI_COMPLEX16
        integer MPI_COMPLEX32
        integer MPI_COMPLEX8
        integer MPI_COUNT
        integer MPI_CXX_BOOL
        integer MPI_CXX_COMPLEX
        integer MPI_CXX_DOUBLE_COMPLEX
        integer MPI_CXX_FLOAT_COMPLEX
        integer MPI_CXX_LONG_DOUBLE_COMPLEX
        integer MPI_C_BOOL
        integer MPI_C_COMPLEX
        integer MPI_C_DOUBLE_COMPLEX
        integer MPI_C_FLOAT_COMPLEX
        integer MPI_C_LONG_DOUBLE_COMPLEX
        integer MPI_DATATYPE_NULL
        integer MPI_DOUBLE
        integer MPI_DOUBLE_COMPLEX
        integer MPI_DOUBLE_INT
        integer MPI_DOUBLE_PRECISION
        integer MPI_ERRHANDLER_NULL
        integer MPI_ERRORS_ARE_FATAL
        integer MPI_ERRORS_RETURN
        integer MPI_FLOAT
        integer MPI_FLOAT_INT
        integer MPI_GROUP_EMPTY
        integer MPI_GROUP_NULL
        integer MPI_INFO_ENV
        integer MPI_INFO_NULL
        integer MPI_INT
        integer MPI_INT16_T
        integer MPI_INT32_T
        integer MPI_INT64_T
        integer MPI_INT8_T
        integer MPI_INTEGER
        integer MPI_INTEGER1
        integer MPI_INTEGER16
        integer MPI_INTEGER2
        integer MPI_INTEGER4
        integer MPI_INTEGER8
        integer MPI_LAND
        integer MPI_LB
        integer MPI_LOGICAL
        integer MPI_LOGICAL1
        integer MPI_LOGICAL2
        integer MPI_LOGICAL4
        integer MPI_LOGICAL8
        integer MPI_LONG
        integer MPI_LONG_DOUBLE
        integer MPI_LONG_DOUBLE_INT
        integer MPI_LONG_INT
        integer MPI_LONG_LONG
        integer MPI_LONG_LONG_INT
        integer MPI_LOR
        integer MPI_LXOR
        integer MPI_MAX
        integer MPI_MAXLOC
        integer MPI_MESSAGE_NO_PROC
        integer MPI_MESSAGE_NULL
        integer MPI_MIN
        integer MPI_MINLOC
        integer MPI_NO_OP
        integer MPI_OFFSET
        integer MPI_OP_NULL
        integer MPI_PACKED
        integer MPI_PROD
        integer MPI_REAL
        integer MPI_REAL16
        integer MPI_REAL2
        integer MPI_REAL4
        integer MPI_REAL8
        integer MPI_REPLACE
        integer MPI_REQUEST_NULL
        integer MPI_SHORT
        integer MPI_SHORT_INT
        integer MPI_SIGNED_CHAR
        integer MPI_SUM
        integer MPI_UB
        integer MPI_UINT16_T
        integer MPI_UINT32_T
        integer MPI_UINT64_T
        integer MPI_UINT8_T
        integer MPI_UNSIGNED
        integer MPI_UNSIGNED_CHAR
        integer MPI_UNSIGNED_LONG
        integer MPI_UNSIGNED_LONG_LONG
        integer MPI_UNSIGNED_SHORT
        integer MPI_WCHAR
        integer MPI_WIN_NULL

        parameter (MPI_2COMPLEX=26)
        parameter (MPI_2DOUBLE_COMPLEX=27)
        parameter (MPI_2DOUBLE_PRECISION=24)
        parameter (MPI_2INT=52)
        parameter (MPI_2INTEGER=25)
        parameter (MPI_2REAL=23)
        parameter (MPI_AINT=66)
        parameter (MPI_BAND=6)
        parameter (MPI_BOR=8)
        parameter (MPI_BXOR=10)
        parameter (MPI_BYTE=1)
        parameter (MPI_CHAR=34)
        parameter (MPI_CHARACTER=5)
        parameter (MPI_COMM_NULL=2)
        parameter (MPI_COMM_SELF=1)
        parameter (MPI_COMM_WORLD=0)
        parameter (MPI_COMPLEX=18)
        parameter (MPI_COMPLEX16=20)
        parameter (MPI_COMPLEX32=21)
        parameter (MPI_COMPLEX8=19)
        parameter (MPI_COUNT=72)
        parameter (MPI_CXX_BOOL=54)
        parameter (MPI_CXX_COMPLEX=55)
        parameter (MPI_CXX_DOUBLE_COMPLEX=56)
        parameter (MPI_CXX_FLOAT_COMPLEX=55)
        parameter (MPI_CXX_LONG_DOUBLE_COMPLEX=57)
        parameter (MPI_C_BOOL=68)
        parameter (MPI_C_COMPLEX=69)
        parameter (MPI_C_DOUBLE_COMPLEX=70)
        parameter (MPI_C_FLOAT_COMPLEX=69)
        parameter (MPI_C_LONG_DOUBLE_COMPLEX=71)
        parameter (MPI_DATATYPE_NULL=0)
        parameter (MPI_DOUBLE=46)
        parameter (MPI_DOUBLE_COMPLEX=22)
        parameter (MPI_DOUBLE_INT=49)
        parameter (MPI_DOUBLE_PRECISION=17)
        parameter (MPI_ERRHANDLER_NULL=0)
        parameter (MPI_ERRORS_ARE_FATAL=1)
        parameter (MPI_ERRORS_RETURN=2)
        parameter (MPI_FLOAT=45)
        parameter (MPI_FLOAT_INT=48)
        parameter (MPI_GROUP_EMPTY=1)
        parameter (MPI_GROUP_NULL=0)
        parameter (MPI_INFO_ENV=1)
        parameter (MPI_INFO_NULL=0)
        parameter (MPI_INT=39)
        parameter (MPI_INT16_T=60)
        parameter (MPI_INT32_T=62)
        parameter (MPI_INT64_T=64)
        parameter (MPI_INT8_T=58)
        parameter (MPI_INTEGER=7)
        parameter (MPI_INTEGER1=8)
        parameter (MPI_INTEGER16=12)
        parameter (MPI_INTEGER2=9)
        parameter (MPI_INTEGER4=10)
        parameter (MPI_INTEGER8=11)
        parameter (MPI_LAND=5)
        parameter (MPI_LB=4)
        parameter (MPI_LOGICAL=6)
        parameter (MPI_LOGICAL1=29)
        parameter (MPI_LOGICAL2=30)
        parameter (MPI_LOGICAL4=31)
        parameter (MPI_LOGICAL8=32)
        parameter (MPI_LONG=41)
        parameter (MPI_LONG_DOUBLE=47)
        parameter (MPI_LONG_DOUBLE_INT=50)
        parameter (MPI_LONG_INT=51)
        parameter (MPI_LONG_LONG=43)
        parameter (MPI_LONG_LONG_INT=43)
        parameter (MPI_LOR=7)
        parameter (MPI_LXOR=9)
        parameter (MPI_MAX=1)
        parameter (MPI_MAXLOC=11)
        parameter (MPI_MESSAGE_NO_PROC=1)
        parameter (MPI_MESSAGE_NULL=0)
        parameter (MPI_MIN=2)
        parameter (MPI_MINLOC=12)
        parameter (MPI_NO_OP=14)
        parameter (MPI_OFFSET=67)
        parameter (MPI_OP_NULL=0)
        parameter (MPI_PACKED=2)
        parameter (MPI_PROD=4)
        parameter (MPI_REAL=13)
        parameter (MPI_REAL16=16)
        parameter (MPI_REAL2=28)
        parameter (MPI_REAL4=14)
        parameter (MPI_REAL8=15)
        parameter (MPI_REPLACE=13)
        parameter (MPI_REQUEST_NULL=0)
        parameter (MPI_SHORT=37)
        parameter (MPI_SHORT_INT=53)
        parameter (MPI_SIGNED_CHAR=36)
        parameter (MPI_SUM=3)
        parameter (MPI_UB=3)
        parameter (MPI_UINT16_T=61)
        parameter (MPI_UINT32_T=63)
        parameter (MPI_UINT64_T=65)
        parameter (MPI_UINT8_T=59)
        parameter (MPI_UNSIGNED=40)
        parameter (MPI_UNSIGNED_CHAR=35)
        parameter (MPI_UNSIGNED_LONG=42)
        parameter (MPI_UNSIGNED_LONG_LONG=44)
        parameter (MPI_UNSIGNED_SHORT=38)
        parameter (MPI_WCHAR=33)
        parameter (MPI_WIN_NULL=0)
! -*- fortran -*-
! WARNING! THIS IS A GENERATED FILE!!
! ANY EDITS YOU PUT HERE WILL BE LOST!
! ==> Instead, edit topdir/ompi/include/mpif-values.pl.

! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2010 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! Copyright (c) 2016      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

        integer MPI_MODE_APPEND
        integer MPI_MODE_CREATE
        integer MPI_MODE_DELETE_ON_CLOSE
        integer MPI_MODE_EXCL
        integer MPI_MODE_RDONLY
        integer MPI_MODE_RDWR
        integer MPI_MODE_SEQUENTIAL
        integer MPI_MODE_UNIQUE_OPEN
        integer MPI_MODE_WRONLY
        integer MPI_SEEK_CUR
        integer MPI_SEEK_END
        integer MPI_SEEK_SET
        integer(KIND=MPI_OFFSET_KIND) MPI_DISPLACEMENT_CURRENT

        parameter (MPI_MODE_APPEND=128)
        parameter (MPI_MODE_CREATE=1)
        parameter (MPI_MODE_DELETE_ON_CLOSE=16)
        parameter (MPI_MODE_EXCL=64)
        parameter (MPI_MODE_RDONLY=2)
        parameter (MPI_MODE_RDWR=8)
        parameter (MPI_MODE_SEQUENTIAL=256)
        parameter (MPI_MODE_UNIQUE_OPEN=32)
        parameter (MPI_MODE_WRONLY=4)
        parameter (MPI_SEEK_CUR=602)
        parameter (MPI_SEEK_END=604)
        parameter (MPI_SEEK_SET=600)
        parameter (MPI_DISPLACEMENT_CURRENT=-54278278)
! -*- fortran -*-
! WARNING! THIS IS A GENERATED FILE!!
! ANY EDITS YOU PUT HERE WILL BE LOST!
! ==> Instead, edit topdir/ompi/include/mpif-values.pl.

! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2010 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! Copyright (c) 2016      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

        integer MPI_FILE_NULL

        parameter (MPI_FILE_NULL=0)
! -*- fortran -*-
!
! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2005 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

!
!     These "external" statements are specific to the MPI mpif.h
!     interface (and are toxic to the MPI module interfaces),.
!
      external MPI_NULL_COPY_FN, MPI_NULL_DELETE_FN
      external MPI_COMM_NULL_COPY_FN, MPI_COMM_NULL_DELETE_FN
      external MPI_TYPE_NULL_COPY_FN, MPI_TYPE_NULL_DELETE_FN
      external MPI_DUP_FN, MPI_COMM_DUP_FN, MPI_TYPE_DUP_FN
      external MPI_WIN_NULL_COPY_FN
      external MPI_WIN_NULL_DELETE_FN
      external MPI_WIN_DUP_FN
!     Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!     checked for comparison; it is never invoked), but it is passed as
!     a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!     the same size/type.  It is therefore external'ed here, and not
!     defined with an integer value in mpif-common.h.
      external MPI_CONVERSION_FN_NULL

!
!     double precision functions
!
      external MPI_WTIME, MPI_WTICK , PMPI_WTICK, PMPI_WTIME
      double precision MPI_WTIME, MPI_WTICK , PMPI_WTICK, PMPI_WTIME
!
!     address integer functions
!
      external MPI_AINT_ADD, MPI_AINT_DIFF
      integer(kind=MPI_ADDRESS_KIND) MPI_AINT_ADD, MPI_AINT_DIFF
! -*- fortran -*-
!
! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2010 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

!
!     All of these types were chosen with care to match the types of
!     their corresponding C variables.  Do not arbitrarily change
!     their types without also updating:
!
!     - the "mpi" module bindings
!     - the "mpi_f08" module bindings
!     - ompi/mpi/fortran/base/gen-mpi-mangling.pl
!

!     MPI_BOTTOM is only used where choice buffers can be used (meaning
!     that we already have overloaded F90 bindings for all available
!     types), so any type is fine.
      integer MPI_BOTTOM
!     MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer MPI_IN_PLACE
!     Making MPI_ARGV_NULL be the same type as the parameter that is
!     exepected in the F90 binding for MPI_COMM_SPAWN means that we
!     don't need another interface for MPI_COMM_SPAWN.
      character MPI_ARGV_NULL(1)
!     Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character MPI_ARGVS_NULL(1, 1)
!     MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!     F77 functions are all smart enough to check that the errcodes
!     parameter is not ERRCODES_IGNORE before assigning values into it
!     (hence, the fact that this is an array of only 1 element does not
!     matter -- we'll never overrun it because we never assign values
!     into it).
      integer MPI_ERRCODES_IGNORE(1)
!     MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer MPI_STATUS_IGNORE(MPI_STATUS_SIZE)
!     Ditto for MPI_STATUSES_IGNORE
      integer MPI_STATUSES_IGNORE(MPI_STATUS_SIZE, 1)
!     Ditto for MPI_UNWEIGHTED
      integer MPI_UNWEIGHTED(1)
!     Ditto for MPI_WEIGHTS_EMPTY
      integer MPI_WEIGHTS_EMPTY(1)

      common/mpi_fortran_bottom/MPI_BOTTOM
      common/mpi_fortran_in_place/MPI_IN_PLACE
      common/mpi_fortran_argv_null/MPI_ARGV_NULL
      common/mpi_fortran_argvs_null/MPI_ARGVS_NULL
      common/mpi_fortran_errcodes_ignore/MPI_ERRCODES_IGNORE
      common/mpi_fortran_status_ignore/MPI_STATUS_IGNORE
      common/mpi_fortran_statuses_ignore/MPI_STATUSES_IGNORE
      common/mpi_fortran_unweighted/MPI_UNWEIGHTED
      common/mpi_fortran_weights_empty/MPI_WEIGHTS_EMPTY
! -*- f90 -*-
! WARNING: This is a generated file!  Edits will be lost!
!
! Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
!
! This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
! interface possibilities for intrinsic types.  Once TS 29113 is
! supported in all compilers, we can simply have *one* procedure for
! each type and use dimension(..) to indicate scalars+all array ranks.
! But until more compilers support this, we simply generate a
! procedure for scalars and all possible ranks in an attempt to
! support lots of Fortran compilers.

      INTERFACE MPI_Sizeof

      SUBROUTINE MPI_Sizeof_character_scalar(x, size, ierror)
      CHARACTER::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_scalar

      SUBROUTINE MPI_Sizeof_character_r1(x, size, ierror)
      CHARACTER, DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r1

      SUBROUTINE MPI_Sizeof_character_r2(x, size, ierror)
      CHARACTER, DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r2

      SUBROUTINE MPI_Sizeof_character_r3(x, size, ierror)
      CHARACTER, DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r3

      SUBROUTINE MPI_Sizeof_character_r4(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r4

      SUBROUTINE MPI_Sizeof_character_r5(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r5

      SUBROUTINE MPI_Sizeof_character_r6(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r6

      SUBROUTINE MPI_Sizeof_character_r7(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r7

      SUBROUTINE MPI_Sizeof_character_r8(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r8

      SUBROUTINE MPI_Sizeof_character_r9(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r9

      SUBROUTINE MPI_Sizeof_character_r10(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r10

      SUBROUTINE MPI_Sizeof_character_r11(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r11

      SUBROUTINE MPI_Sizeof_character_r12(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r12

      SUBROUTINE MPI_Sizeof_character_r13(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r13

      SUBROUTINE MPI_Sizeof_character_r14(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r14

      SUBROUTINE MPI_Sizeof_character_r15(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_character_r15

      SUBROUTINE MPI_Sizeof_complex128_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_scalar

      SUBROUTINE MPI_Sizeof_complex128_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r1

      SUBROUTINE MPI_Sizeof_complex128_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r2

      SUBROUTINE MPI_Sizeof_complex128_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r3

      SUBROUTINE MPI_Sizeof_complex128_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r4

      SUBROUTINE MPI_Sizeof_complex128_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r5

      SUBROUTINE MPI_Sizeof_complex128_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r6

      SUBROUTINE MPI_Sizeof_complex128_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r7

      SUBROUTINE MPI_Sizeof_complex128_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r8

      SUBROUTINE MPI_Sizeof_complex128_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r9

      SUBROUTINE MPI_Sizeof_complex128_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r10

      SUBROUTINE MPI_Sizeof_complex128_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r11

      SUBROUTINE MPI_Sizeof_complex128_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r12

      SUBROUTINE MPI_Sizeof_complex128_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r13

      SUBROUTINE MPI_Sizeof_complex128_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r14

      SUBROUTINE MPI_Sizeof_complex128_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex128_r15

      SUBROUTINE MPI_Sizeof_complex32_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_scalar

      SUBROUTINE MPI_Sizeof_complex32_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r1

      SUBROUTINE MPI_Sizeof_complex32_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r2

      SUBROUTINE MPI_Sizeof_complex32_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r3

      SUBROUTINE MPI_Sizeof_complex32_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r4

      SUBROUTINE MPI_Sizeof_complex32_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r5

      SUBROUTINE MPI_Sizeof_complex32_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r6

      SUBROUTINE MPI_Sizeof_complex32_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r7

      SUBROUTINE MPI_Sizeof_complex32_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r8

      SUBROUTINE MPI_Sizeof_complex32_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r9

      SUBROUTINE MPI_Sizeof_complex32_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r10

      SUBROUTINE MPI_Sizeof_complex32_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r11

      SUBROUTINE MPI_Sizeof_complex32_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r12

      SUBROUTINE MPI_Sizeof_complex32_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r13

      SUBROUTINE MPI_Sizeof_complex32_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r14

      SUBROUTINE MPI_Sizeof_complex32_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex32_r15

      SUBROUTINE MPI_Sizeof_complex64_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_scalar

      SUBROUTINE MPI_Sizeof_complex64_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r1

      SUBROUTINE MPI_Sizeof_complex64_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r2

      SUBROUTINE MPI_Sizeof_complex64_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r3

      SUBROUTINE MPI_Sizeof_complex64_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r4

      SUBROUTINE MPI_Sizeof_complex64_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r5

      SUBROUTINE MPI_Sizeof_complex64_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r6

      SUBROUTINE MPI_Sizeof_complex64_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r7

      SUBROUTINE MPI_Sizeof_complex64_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r8

      SUBROUTINE MPI_Sizeof_complex64_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r9

      SUBROUTINE MPI_Sizeof_complex64_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r10

      SUBROUTINE MPI_Sizeof_complex64_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r11

      SUBROUTINE MPI_Sizeof_complex64_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r12

      SUBROUTINE MPI_Sizeof_complex64_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r13

      SUBROUTINE MPI_Sizeof_complex64_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r14

      SUBROUTINE MPI_Sizeof_complex64_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_complex64_r15

      SUBROUTINE MPI_Sizeof_int16_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_scalar

      SUBROUTINE MPI_Sizeof_int16_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r1

      SUBROUTINE MPI_Sizeof_int16_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r2

      SUBROUTINE MPI_Sizeof_int16_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r3

      SUBROUTINE MPI_Sizeof_int16_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r4

      SUBROUTINE MPI_Sizeof_int16_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r5

      SUBROUTINE MPI_Sizeof_int16_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r6

      SUBROUTINE MPI_Sizeof_int16_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r7

      SUBROUTINE MPI_Sizeof_int16_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r8

      SUBROUTINE MPI_Sizeof_int16_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r9

      SUBROUTINE MPI_Sizeof_int16_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r10

      SUBROUTINE MPI_Sizeof_int16_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r11

      SUBROUTINE MPI_Sizeof_int16_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r12

      SUBROUTINE MPI_Sizeof_int16_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r13

      SUBROUTINE MPI_Sizeof_int16_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r14

      SUBROUTINE MPI_Sizeof_int16_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int16_r15

      SUBROUTINE MPI_Sizeof_int32_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_scalar

      SUBROUTINE MPI_Sizeof_int32_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r1

      SUBROUTINE MPI_Sizeof_int32_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r2

      SUBROUTINE MPI_Sizeof_int32_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r3

      SUBROUTINE MPI_Sizeof_int32_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r4

      SUBROUTINE MPI_Sizeof_int32_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r5

      SUBROUTINE MPI_Sizeof_int32_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r6

      SUBROUTINE MPI_Sizeof_int32_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r7

      SUBROUTINE MPI_Sizeof_int32_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r8

      SUBROUTINE MPI_Sizeof_int32_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r9

      SUBROUTINE MPI_Sizeof_int32_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r10

      SUBROUTINE MPI_Sizeof_int32_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r11

      SUBROUTINE MPI_Sizeof_int32_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r12

      SUBROUTINE MPI_Sizeof_int32_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r13

      SUBROUTINE MPI_Sizeof_int32_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r14

      SUBROUTINE MPI_Sizeof_int32_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int32_r15

      SUBROUTINE MPI_Sizeof_int64_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_scalar

      SUBROUTINE MPI_Sizeof_int64_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r1

      SUBROUTINE MPI_Sizeof_int64_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r2

      SUBROUTINE MPI_Sizeof_int64_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r3

      SUBROUTINE MPI_Sizeof_int64_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r4

      SUBROUTINE MPI_Sizeof_int64_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r5

      SUBROUTINE MPI_Sizeof_int64_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r6

      SUBROUTINE MPI_Sizeof_int64_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r7

      SUBROUTINE MPI_Sizeof_int64_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r8

      SUBROUTINE MPI_Sizeof_int64_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r9

      SUBROUTINE MPI_Sizeof_int64_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r10

      SUBROUTINE MPI_Sizeof_int64_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r11

      SUBROUTINE MPI_Sizeof_int64_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r12

      SUBROUTINE MPI_Sizeof_int64_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r13

      SUBROUTINE MPI_Sizeof_int64_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r14

      SUBROUTINE MPI_Sizeof_int64_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int64_r15

      SUBROUTINE MPI_Sizeof_int8_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_scalar

      SUBROUTINE MPI_Sizeof_int8_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r1

      SUBROUTINE MPI_Sizeof_int8_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r2

      SUBROUTINE MPI_Sizeof_int8_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r3

      SUBROUTINE MPI_Sizeof_int8_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r4

      SUBROUTINE MPI_Sizeof_int8_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r5

      SUBROUTINE MPI_Sizeof_int8_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r6

      SUBROUTINE MPI_Sizeof_int8_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r7

      SUBROUTINE MPI_Sizeof_int8_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r8

      SUBROUTINE MPI_Sizeof_int8_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r9

      SUBROUTINE MPI_Sizeof_int8_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r10

      SUBROUTINE MPI_Sizeof_int8_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r11

      SUBROUTINE MPI_Sizeof_int8_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r12

      SUBROUTINE MPI_Sizeof_int8_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r13

      SUBROUTINE MPI_Sizeof_int8_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r14

      SUBROUTINE MPI_Sizeof_int8_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_int8_r15

      SUBROUTINE MPI_Sizeof_logical_scalar(x, size, ierror)
      LOGICAL::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_scalar

      SUBROUTINE MPI_Sizeof_logical_r1(x, size, ierror)
      LOGICAL, DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r1

      SUBROUTINE MPI_Sizeof_logical_r2(x, size, ierror)
      LOGICAL, DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r2

      SUBROUTINE MPI_Sizeof_logical_r3(x, size, ierror)
      LOGICAL, DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r3

      SUBROUTINE MPI_Sizeof_logical_r4(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r4

      SUBROUTINE MPI_Sizeof_logical_r5(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r5

      SUBROUTINE MPI_Sizeof_logical_r6(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r6

      SUBROUTINE MPI_Sizeof_logical_r7(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r7

      SUBROUTINE MPI_Sizeof_logical_r8(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r8

      SUBROUTINE MPI_Sizeof_logical_r9(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r9

      SUBROUTINE MPI_Sizeof_logical_r10(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r10

      SUBROUTINE MPI_Sizeof_logical_r11(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r11

      SUBROUTINE MPI_Sizeof_logical_r12(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r12

      SUBROUTINE MPI_Sizeof_logical_r13(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r13

      SUBROUTINE MPI_Sizeof_logical_r14(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r14

      SUBROUTINE MPI_Sizeof_logical_r15(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_logical_r15

      SUBROUTINE MPI_Sizeof_real128_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_scalar

      SUBROUTINE MPI_Sizeof_real128_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r1

      SUBROUTINE MPI_Sizeof_real128_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r2

      SUBROUTINE MPI_Sizeof_real128_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r3

      SUBROUTINE MPI_Sizeof_real128_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r4

      SUBROUTINE MPI_Sizeof_real128_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r5

      SUBROUTINE MPI_Sizeof_real128_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r6

      SUBROUTINE MPI_Sizeof_real128_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r7

      SUBROUTINE MPI_Sizeof_real128_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r8

      SUBROUTINE MPI_Sizeof_real128_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r9

      SUBROUTINE MPI_Sizeof_real128_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r10

      SUBROUTINE MPI_Sizeof_real128_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r11

      SUBROUTINE MPI_Sizeof_real128_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r12

      SUBROUTINE MPI_Sizeof_real128_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r13

      SUBROUTINE MPI_Sizeof_real128_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r14

      SUBROUTINE MPI_Sizeof_real128_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real128_r15

      SUBROUTINE MPI_Sizeof_real32_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_scalar

      SUBROUTINE MPI_Sizeof_real32_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r1

      SUBROUTINE MPI_Sizeof_real32_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r2

      SUBROUTINE MPI_Sizeof_real32_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r3

      SUBROUTINE MPI_Sizeof_real32_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r4

      SUBROUTINE MPI_Sizeof_real32_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r5

      SUBROUTINE MPI_Sizeof_real32_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r6

      SUBROUTINE MPI_Sizeof_real32_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r7

      SUBROUTINE MPI_Sizeof_real32_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r8

      SUBROUTINE MPI_Sizeof_real32_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r9

      SUBROUTINE MPI_Sizeof_real32_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r10

      SUBROUTINE MPI_Sizeof_real32_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r11

      SUBROUTINE MPI_Sizeof_real32_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r12

      SUBROUTINE MPI_Sizeof_real32_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r13

      SUBROUTINE MPI_Sizeof_real32_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r14

      SUBROUTINE MPI_Sizeof_real32_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real32_r15

      SUBROUTINE MPI_Sizeof_real64_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_scalar

      SUBROUTINE MPI_Sizeof_real64_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r1

      SUBROUTINE MPI_Sizeof_real64_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r2

      SUBROUTINE MPI_Sizeof_real64_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r3

      SUBROUTINE MPI_Sizeof_real64_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r4

      SUBROUTINE MPI_Sizeof_real64_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r5

      SUBROUTINE MPI_Sizeof_real64_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r6

      SUBROUTINE MPI_Sizeof_real64_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r7

      SUBROUTINE MPI_Sizeof_real64_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r8

      SUBROUTINE MPI_Sizeof_real64_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r9

      SUBROUTINE MPI_Sizeof_real64_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r10

      SUBROUTINE MPI_Sizeof_real64_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r11

      SUBROUTINE MPI_Sizeof_real64_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r12

      SUBROUTINE MPI_Sizeof_real64_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r13

      SUBROUTINE MPI_Sizeof_real64_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r14

      SUBROUTINE MPI_Sizeof_real64_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE MPI_Sizeof_real64_r15

      END INTERFACE MPI_Sizeof

      INTERFACE PMPI_Sizeof

      SUBROUTINE PMPI_Sizeof_character_scalar(x, size, ierror)
      CHARACTER::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_scalar

      SUBROUTINE PMPI_Sizeof_character_r1(x, size, ierror)
      CHARACTER, DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r1

      SUBROUTINE PMPI_Sizeof_character_r2(x, size, ierror)
      CHARACTER, DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r2

      SUBROUTINE PMPI_Sizeof_character_r3(x, size, ierror)
      CHARACTER, DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r3

      SUBROUTINE PMPI_Sizeof_character_r4(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r4

      SUBROUTINE PMPI_Sizeof_character_r5(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r5

      SUBROUTINE PMPI_Sizeof_character_r6(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r6

      SUBROUTINE PMPI_Sizeof_character_r7(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r7

      SUBROUTINE PMPI_Sizeof_character_r8(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r8

      SUBROUTINE PMPI_Sizeof_character_r9(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r9

      SUBROUTINE PMPI_Sizeof_character_r10(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r10

      SUBROUTINE PMPI_Sizeof_character_r11(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r11

      SUBROUTINE PMPI_Sizeof_character_r12(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r12

      SUBROUTINE PMPI_Sizeof_character_r13(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r13

      SUBROUTINE PMPI_Sizeof_character_r14(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r14

      SUBROUTINE PMPI_Sizeof_character_r15(x, size, ierror)
      CHARACTER, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_character_r15

      SUBROUTINE PMPI_Sizeof_complex128_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_scalar

      SUBROUTINE PMPI_Sizeof_complex128_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r1

      SUBROUTINE PMPI_Sizeof_complex128_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r2

      SUBROUTINE PMPI_Sizeof_complex128_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r3

      SUBROUTINE PMPI_Sizeof_complex128_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r4

      SUBROUTINE PMPI_Sizeof_complex128_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r5

      SUBROUTINE PMPI_Sizeof_complex128_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r6

      SUBROUTINE PMPI_Sizeof_complex128_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r7

      SUBROUTINE PMPI_Sizeof_complex128_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r8

      SUBROUTINE PMPI_Sizeof_complex128_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r9

      SUBROUTINE PMPI_Sizeof_complex128_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r10

      SUBROUTINE PMPI_Sizeof_complex128_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r11

      SUBROUTINE PMPI_Sizeof_complex128_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r12

      SUBROUTINE PMPI_Sizeof_complex128_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r13

      SUBROUTINE PMPI_Sizeof_complex128_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r14

      SUBROUTINE PMPI_Sizeof_complex128_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      COMPLEX(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex128_r15

      SUBROUTINE PMPI_Sizeof_complex32_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_scalar

      SUBROUTINE PMPI_Sizeof_complex32_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r1

      SUBROUTINE PMPI_Sizeof_complex32_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r2

      SUBROUTINE PMPI_Sizeof_complex32_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r3

      SUBROUTINE PMPI_Sizeof_complex32_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r4

      SUBROUTINE PMPI_Sizeof_complex32_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r5

      SUBROUTINE PMPI_Sizeof_complex32_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r6

      SUBROUTINE PMPI_Sizeof_complex32_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r7

      SUBROUTINE PMPI_Sizeof_complex32_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r8

      SUBROUTINE PMPI_Sizeof_complex32_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r9

      SUBROUTINE PMPI_Sizeof_complex32_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r10

      SUBROUTINE PMPI_Sizeof_complex32_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r11

      SUBROUTINE PMPI_Sizeof_complex32_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r12

      SUBROUTINE PMPI_Sizeof_complex32_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r13

      SUBROUTINE PMPI_Sizeof_complex32_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r14

      SUBROUTINE PMPI_Sizeof_complex32_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      COMPLEX(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex32_r15

      SUBROUTINE PMPI_Sizeof_complex64_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_scalar

      SUBROUTINE PMPI_Sizeof_complex64_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r1

      SUBROUTINE PMPI_Sizeof_complex64_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r2

      SUBROUTINE PMPI_Sizeof_complex64_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r3

      SUBROUTINE PMPI_Sizeof_complex64_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r4

      SUBROUTINE PMPI_Sizeof_complex64_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r5

      SUBROUTINE PMPI_Sizeof_complex64_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r6

      SUBROUTINE PMPI_Sizeof_complex64_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r7

      SUBROUTINE PMPI_Sizeof_complex64_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r8

      SUBROUTINE PMPI_Sizeof_complex64_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r9

      SUBROUTINE PMPI_Sizeof_complex64_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r10

      SUBROUTINE PMPI_Sizeof_complex64_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r11

      SUBROUTINE PMPI_Sizeof_complex64_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r12

      SUBROUTINE PMPI_Sizeof_complex64_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r13

      SUBROUTINE PMPI_Sizeof_complex64_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r14

      SUBROUTINE PMPI_Sizeof_complex64_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      COMPLEX(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_complex64_r15

      SUBROUTINE PMPI_Sizeof_int16_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_scalar

      SUBROUTINE PMPI_Sizeof_int16_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r1

      SUBROUTINE PMPI_Sizeof_int16_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r2

      SUBROUTINE PMPI_Sizeof_int16_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r3

      SUBROUTINE PMPI_Sizeof_int16_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r4

      SUBROUTINE PMPI_Sizeof_int16_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r5

      SUBROUTINE PMPI_Sizeof_int16_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r6

      SUBROUTINE PMPI_Sizeof_int16_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r7

      SUBROUTINE PMPI_Sizeof_int16_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r8

      SUBROUTINE PMPI_Sizeof_int16_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r9

      SUBROUTINE PMPI_Sizeof_int16_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r10

      SUBROUTINE PMPI_Sizeof_int16_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r11

      SUBROUTINE PMPI_Sizeof_int16_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r12

      SUBROUTINE PMPI_Sizeof_int16_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r13

      SUBROUTINE PMPI_Sizeof_int16_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r14

      SUBROUTINE PMPI_Sizeof_int16_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT16
      INTEGER(INT16), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int16_r15

      SUBROUTINE PMPI_Sizeof_int32_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_scalar

      SUBROUTINE PMPI_Sizeof_int32_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r1

      SUBROUTINE PMPI_Sizeof_int32_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r2

      SUBROUTINE PMPI_Sizeof_int32_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r3

      SUBROUTINE PMPI_Sizeof_int32_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r4

      SUBROUTINE PMPI_Sizeof_int32_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r5

      SUBROUTINE PMPI_Sizeof_int32_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r6

      SUBROUTINE PMPI_Sizeof_int32_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r7

      SUBROUTINE PMPI_Sizeof_int32_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r8

      SUBROUTINE PMPI_Sizeof_int32_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r9

      SUBROUTINE PMPI_Sizeof_int32_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r10

      SUBROUTINE PMPI_Sizeof_int32_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r11

      SUBROUTINE PMPI_Sizeof_int32_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r12

      SUBROUTINE PMPI_Sizeof_int32_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r13

      SUBROUTINE PMPI_Sizeof_int32_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r14

      SUBROUTINE PMPI_Sizeof_int32_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT32
      INTEGER(INT32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int32_r15

      SUBROUTINE PMPI_Sizeof_int64_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_scalar

      SUBROUTINE PMPI_Sizeof_int64_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r1

      SUBROUTINE PMPI_Sizeof_int64_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r2

      SUBROUTINE PMPI_Sizeof_int64_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r3

      SUBROUTINE PMPI_Sizeof_int64_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r4

      SUBROUTINE PMPI_Sizeof_int64_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r5

      SUBROUTINE PMPI_Sizeof_int64_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r6

      SUBROUTINE PMPI_Sizeof_int64_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r7

      SUBROUTINE PMPI_Sizeof_int64_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r8

      SUBROUTINE PMPI_Sizeof_int64_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r9

      SUBROUTINE PMPI_Sizeof_int64_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r10

      SUBROUTINE PMPI_Sizeof_int64_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r11

      SUBROUTINE PMPI_Sizeof_int64_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r12

      SUBROUTINE PMPI_Sizeof_int64_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r13

      SUBROUTINE PMPI_Sizeof_int64_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r14

      SUBROUTINE PMPI_Sizeof_int64_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT64
      INTEGER(INT64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int64_r15

      SUBROUTINE PMPI_Sizeof_int8_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_scalar

      SUBROUTINE PMPI_Sizeof_int8_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r1

      SUBROUTINE PMPI_Sizeof_int8_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r2

      SUBROUTINE PMPI_Sizeof_int8_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r3

      SUBROUTINE PMPI_Sizeof_int8_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r4

      SUBROUTINE PMPI_Sizeof_int8_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r5

      SUBROUTINE PMPI_Sizeof_int8_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r6

      SUBROUTINE PMPI_Sizeof_int8_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r7

      SUBROUTINE PMPI_Sizeof_int8_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r8

      SUBROUTINE PMPI_Sizeof_int8_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r9

      SUBROUTINE PMPI_Sizeof_int8_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r10

      SUBROUTINE PMPI_Sizeof_int8_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r11

      SUBROUTINE PMPI_Sizeof_int8_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r12

      SUBROUTINE PMPI_Sizeof_int8_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r13

      SUBROUTINE PMPI_Sizeof_int8_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r14

      SUBROUTINE PMPI_Sizeof_int8_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: INT8
      INTEGER(INT8), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_int8_r15

      SUBROUTINE PMPI_Sizeof_logical_scalar(x, size, ierror)
      LOGICAL::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_scalar

      SUBROUTINE PMPI_Sizeof_logical_r1(x, size, ierror)
      LOGICAL, DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r1

      SUBROUTINE PMPI_Sizeof_logical_r2(x, size, ierror)
      LOGICAL, DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r2

      SUBROUTINE PMPI_Sizeof_logical_r3(x, size, ierror)
      LOGICAL, DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r3

      SUBROUTINE PMPI_Sizeof_logical_r4(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r4

      SUBROUTINE PMPI_Sizeof_logical_r5(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r5

      SUBROUTINE PMPI_Sizeof_logical_r6(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r6

      SUBROUTINE PMPI_Sizeof_logical_r7(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r7

      SUBROUTINE PMPI_Sizeof_logical_r8(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r8

      SUBROUTINE PMPI_Sizeof_logical_r9(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r9

      SUBROUTINE PMPI_Sizeof_logical_r10(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r10

      SUBROUTINE PMPI_Sizeof_logical_r11(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r11

      SUBROUTINE PMPI_Sizeof_logical_r12(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r12

      SUBROUTINE PMPI_Sizeof_logical_r13(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r13

      SUBROUTINE PMPI_Sizeof_logical_r14(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r14

      SUBROUTINE PMPI_Sizeof_logical_r15(x, size, ierror)
      LOGICAL, DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_logical_r15

      SUBROUTINE PMPI_Sizeof_real128_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_scalar

      SUBROUTINE PMPI_Sizeof_real128_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r1

      SUBROUTINE PMPI_Sizeof_real128_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r2

      SUBROUTINE PMPI_Sizeof_real128_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r3

      SUBROUTINE PMPI_Sizeof_real128_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r4

      SUBROUTINE PMPI_Sizeof_real128_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r5

      SUBROUTINE PMPI_Sizeof_real128_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r6

      SUBROUTINE PMPI_Sizeof_real128_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r7

      SUBROUTINE PMPI_Sizeof_real128_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r8

      SUBROUTINE PMPI_Sizeof_real128_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r9

      SUBROUTINE PMPI_Sizeof_real128_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r10

      SUBROUTINE PMPI_Sizeof_real128_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r11

      SUBROUTINE PMPI_Sizeof_real128_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r12

      SUBROUTINE PMPI_Sizeof_real128_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r13

      SUBROUTINE PMPI_Sizeof_real128_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r14

      SUBROUTINE PMPI_Sizeof_real128_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL128
      REAL(REAL128), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real128_r15

      SUBROUTINE PMPI_Sizeof_real32_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_scalar

      SUBROUTINE PMPI_Sizeof_real32_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r1

      SUBROUTINE PMPI_Sizeof_real32_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r2

      SUBROUTINE PMPI_Sizeof_real32_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r3

      SUBROUTINE PMPI_Sizeof_real32_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r4

      SUBROUTINE PMPI_Sizeof_real32_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r5

      SUBROUTINE PMPI_Sizeof_real32_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r6

      SUBROUTINE PMPI_Sizeof_real32_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r7

      SUBROUTINE PMPI_Sizeof_real32_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r8

      SUBROUTINE PMPI_Sizeof_real32_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r9

      SUBROUTINE PMPI_Sizeof_real32_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r10

      SUBROUTINE PMPI_Sizeof_real32_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r11

      SUBROUTINE PMPI_Sizeof_real32_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r12

      SUBROUTINE PMPI_Sizeof_real32_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r13

      SUBROUTINE PMPI_Sizeof_real32_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r14

      SUBROUTINE PMPI_Sizeof_real32_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL32
      REAL(REAL32), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real32_r15

      SUBROUTINE PMPI_Sizeof_real64_scalar(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_scalar

      SUBROUTINE PMPI_Sizeof_real64_r1(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r1

      SUBROUTINE PMPI_Sizeof_real64_r2(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r2

      SUBROUTINE PMPI_Sizeof_real64_r3(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r3

      SUBROUTINE PMPI_Sizeof_real64_r4(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r4

      SUBROUTINE PMPI_Sizeof_real64_r5(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r5

      SUBROUTINE PMPI_Sizeof_real64_r6(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r6

      SUBROUTINE PMPI_Sizeof_real64_r7(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r7

      SUBROUTINE PMPI_Sizeof_real64_r8(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r8

      SUBROUTINE PMPI_Sizeof_real64_r9(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r9

      SUBROUTINE PMPI_Sizeof_real64_r10(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r10

      SUBROUTINE PMPI_Sizeof_real64_r11(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r11

      SUBROUTINE PMPI_Sizeof_real64_r12(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r12

      SUBROUTINE PMPI_Sizeof_real64_r13(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r13

      SUBROUTINE PMPI_Sizeof_real64_r14(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r14

      SUBROUTINE PMPI_Sizeof_real64_r15(x, size, ierror)
        USE, INTRINSIC :: iso_fortran_env, ONLY: REAL64
      REAL(REAL64), DIMENSION(1,1,1,1,1,1,1,1,1,1,1,1,1,1,*)::x
        INTEGER, INTENT(OUT) :: size
        INTEGER, INTENT(OUT) :: ierror
      END SUBROUTINE PMPI_Sizeof_real64_r15

      END INTERFACE PMPI_Sizeof

