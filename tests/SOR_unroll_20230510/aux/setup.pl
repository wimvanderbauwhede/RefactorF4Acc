#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;
if (not -d 'data') {
system('cp -r ../data .');
}
#if (not -e 'data10') {
#system('cp ../data* .');
#}
if (not -d 'GIS') {
system('cp -r ../GIS .');
}

my @sources=qw(anime.f95
aveflow.f95
bondFG.f95
bondv1.f95
boundp.f95
boundsm.f95
common_sn.f95
feedbfm.f95
grid.f95
ifdata.f95
init.f95
params_common_sn.f95
set.f95
timdata.f95
timseris.f95);

=info
adam_host.f95
bondv1_host.f95
feedbf_host.f95
les_host.f95
main_host.f95
press_host.f95
velFG_host.f95
velnw_host.f95
=cut

my $ref_dir = '../PostCPP';
for my $src (@sources) {
   system("cp $ref_dir/$src .");
}

my @sources2=qw(macros_kernel.h
SConstruct.auto
generate_OpenCL_kernel.sh
rf4a_to_C.cfg
array_index_f2c1d.h);

my $ref_dir_2 = '../aux';
for my $src (@sources2) {
    system("cp $ref_dir_2/$src . ");
}
