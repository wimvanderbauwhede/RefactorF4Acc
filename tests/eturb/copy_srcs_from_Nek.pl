#!/usr/bin/env perl
use warnings;
use strict;

my $root='~/Git/Nek5000/core/';
my @srcs=qw(
3rd_party/blas.f
calcz.f
comm_mpi.f
math.f
mpi_dummy.f
mxm_bgq.f
mxm_std.f
mxm_wrapper.f
navier5.f
papi.f
postpro.f
singlmesh.f
subs1.f
mpi_dummy.h
);

my @incsrcs=(
       'AVG',
       'CTIMER',
       'DEALIAS',
       'DOMAIN',
       'DXYZ',
       'EIGEN',
       'ESOLV',
       'FDMH1',
       'GEOM',
       'INPUT',
       'IXYZ',
       'MASS',
       'MVGEOM',
       'NEKUSE',
       'OPCTR',
       'ORTHOSTRS',
       'PARALLEL',
       'RESTART',
       'SIZE',
       'SIZE.inc',
       'SOLN',
       'STEADY',
       'TOPOL',
       'TOTAL',
       'TSTEP',
       'WZ',
       'WZF',
       'ZPER',
);

#f77papi.h from PAPI sources
#mpif.h from OpenMPI header files

for my $src (@srcs, @incsrcs) {
    if (not -e "src/$src") {
system("cp $root$src src");
}
}
