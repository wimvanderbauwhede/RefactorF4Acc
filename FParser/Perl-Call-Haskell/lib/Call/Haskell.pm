package Call::Haskell;
use warnings;
use strict;
use v5.16;

use Call::Haskell::FFIGenerator qw( create_hs_ffi_generator );
use Cwd;
use Config;
require Inline;

use version; our $VERSION = version->declare('v0.0.2');
@Call::Haskell::ISA = qw(Exporter);
my $VV = 0;


sub import {
 my ( $hs, @import_list ) = @_;

 my %config = (
  'functions' => '',
  'path'       => '.',
  'clean'     => 0,
  'verbose'   => 0,
  'perl_types' => '', 
  'packages' => []
 );
 if ( scalar @import_list == 1 ) {
  $config{'functions'} = $import_list[0];
 }
 else {
  my %import_config = @import_list;
  map { $config{ lc($_) } = $import_config{$_} } keys(%import_config);
 }
 if (exists $config{'import'} ) {
  $config{'functions'}=$config{'import'};
 }
 my $func_import_str = $config{'functions'};

 $func_import_str =~ s/\s+//g;
 $func_import_str =~ s/\)$//;
 my @func_imports = split( /\),/, $func_import_str );
 if ( scalar @func_imports > 1 ) {
  die
"Sorry, at the moment you can only call functions from a single Haskell module\n";
 }
 my $fq_func = shift @func_imports;
 ( my $module, my $funclst ) = split( /\(/, $fq_func );
 my @mfuncs = split( /,/, $funclst );

 #    my %funcs=();
 #    for my $fq_func (@func_imports) {
 #        say "<$fq_func>";
 #        (my $module, my $funclst)=split(/\(/,$fq_func);
 #        my @mfuncs = split(/,/,$funclst);
 #        for my $func (@mfuncs) {
 #        push @{$funcs{$module}},$func;
 #        }
 #    }
 build( $module, \@mfuncs, $config{'path'}, $config{'packages'}, $config{'clean'},
  $config{'verbose'} , $config{'perl_types'} );
  my $wd = cwd();
#  say "Before EXPORT code";
 for my $fn (@mfuncs) {
  if (-e "$wd/_Call_Haskell/CallHaskellWrappers/$fn.pm") {
#   push @Call::Haskell::EXPORT, "${fn}_ser";
  #Call::Haskell->export_to_level( 1, 'Call::Haskell', @Call::Haskell::EXPORT );
  require "$wd/_Call_Haskell/CallHaskellWrappers/$fn.pm";
  eval("CallHaskellWrappers::$fn->import()");
  }
  push @Call::Haskell::EXPORT, $fn;
 }
#say "After EXPORT code, now exporting to level 1";
 Call::Haskell->export_to_level( 1, 'Call::Haskell', @Call::Haskell::EXPORT );
# say "LEAVING Call::Haskell::Import";
}

sub build {
 ( my $hs_module, my $function_names, my $hs_module_dir, my $packages, my $CLEAN, $VV, my $perl_types ) =
   @_;                     #'ProcessString';
 my $wd = cwd();
 if ($CLEAN) {
    system('rm -Rf _Call_Haskell _Inline');
        system('rm *.o *.hi');

 }
 ( my $inline_c_code, my $generated ) =
   create_hs_ffi_generator( $hs_module, $function_names, $hs_module_dir, $CLEAN,
  $VV, $perl_types );

 if ( $generated == 1 ) { $CLEAN = 1 }
 print "INLINE C CODE:\n" . $inline_c_code if $VV;

 if ( not -d './tmp' ) {
  mkdir 'tmp';
 }

 my $perl_link_options_str = $Config::Config{lddlflags};
 my $perl_ld_str           = $Config::Config{ld};
 if ( $perl_link_options_str =~ /-fstack-protector/ ) {
  $perl_link_options_str =~ s/-fstack-protector//;
 }
 print "PERL LD = $perl_ld_str\nPERL LDDLFLAGS = $perl_link_options_str\n"
   if $VV;

 # The code below could go into a module
 #say join(':',@INC),';',"\n",Dumper(%INC);#,';',
 my $Call_Haskell_path=$INC{"Call/Haskell.pm"};

 my $hs_FFIGenerator_dir=$Call_Haskell_path;
 $hs_FFIGenerator_dir=~s/Call.Haskell.pm$//;

 #if ($hs_FFIGenerator_dir=~/^\./) {die "\nThe path to the Call::Haskell module _must_ be absolute, please redefine your PERL5LIB\n\n"; }
 $hs_FFIGenerator_dir='.';
 say  "FFIGenerator path:",$hs_FFIGenerator_dir if $VV;
 my $hs_ffi_module = $hs_module . 'FFIWrapper';

# This requires test_hs_c_str.c to exist and be compiled. I should generate that!
 my $test_src           = 'test_src';
 my $test_out           = 'testl';
 my $c_wrapper          = $hs_module . 'CWrapper';
 my $hs_lib             = $hs_module . 'HsC';
 my $link_options_cache = '.lddlflags.cache';
 my $obj_file_names_cache ='.objs.cache';

# # Clean up
 if ($CLEAN) {
  system("rm *.o *.hi lib$hs_lib.a $test_src.c $test_out $link_options_cache $obj_file_names_cache 2>/dev/null ");
  system("rm -Rf ./tmp/* 2>/dev/null");
 }

 #  Now, first compile the Haskell file:
  my $object_files="";
if (not -e  "$obj_file_names_cache") {
# if ( not -e "$hs_ffi_module.o" ) {
  say "ghc -c -O --make -i$wd/$hs_module_dir -i$hs_FFIGenerator_dir $hs_ffi_module" if $VV;
  my @ghc_lines=`ghc -c -O --make -i$wd/$hs_module_dir -i$hs_FFIGenerator_dir $hs_ffi_module`;
 
  for my $line (@ghc_lines) {
      chomp $line;
      $line=~s/^.*,\s//; 
          $line=~s/\s\)\s*$/ /;
      $object_files.=$line;
  }
#  say "<<$object_files>>";

  # Here we should write these to a file cache
  open my $OBJS, '>', $obj_file_names_cache;
  print $OBJS $object_files;
  close $OBJS;
 }
 else {
  say "USING CACHED OBJECT NAMES" if $VV;
  open my $OBJS, '<', $obj_file_names_cache;
  $object_files = <$OBJS>;
  close $OBJS;      
# cache the list of object files
 }
 if ( not -e "$c_wrapper.o" ) {
  say "ghc --make -i$wd/$hs_module_dir -i$hs_FFIGenerator_dir -optc-O -no-hs-main -c $c_wrapper.c $hs_ffi_module $hs_module FFIGenerator.ShowToPerl" if $VV; 
  system(
"ghc --make -i$wd/$hs_module_dir -i$hs_FFIGenerator_dir -optc-O -no-hs-main -c $c_wrapper.c $hs_ffi_module $hs_module FFIGenerator.ShowToPerl"
  );
 }
 if ( not -e "lib$hs_lib.a" ) {
  say "ar rcs lib$hs_lib.a  $c_wrapper.o $object_files" if $VV;
#  say "OLD: ar rcs lib$hs_lib.a  $c_wrapper.o $hs_ffi_module.o $wd/$hs_module_dir/$hs_module.o $hs_FFIGenerator_dir/FFIGenerator/ShowToPerl.o";
#  system( "ar rcs lib$hs_lib.a  $c_wrapper.o $hs_ffi_module.o $wd/$hs_module_dir/$hs_module.o $hs_FFIGenerator_dir/FFIGenerator/ShowToPerl.o");
  system( "ar rcs lib$hs_lib.a  $c_wrapper.o $object_files");
 }
 if ( $CLEAN or not -e "$test_src.c" ) {
  my $test_src_code = "#include \"${c_wrapper}.h\"
        int main(int argc, char* argv[]) {
            hs_${hs_module}_init();
            hs_${hs_module}_end();
            return 1;
        }
    ";
  open my $TST, '>', "$test_src.c";
  print $TST $test_src_code;
  close $TST;
  system("gcc -c $test_src.c");
 }
 my $link_options = '';
 my $ld           = '';

 # if there is no cached link options file
 my $package_str = join(' ', map {"-package $_"} @{$packages});
 if ( not -e $link_options_cache ) {
  print
"ghc -v -keep-tmp-files -tmpdir=./tmp  -no-hs-main $test_src.o -L. -l$hs_lib -package parsec -package containers $package_str -o $test_out 2>&1\n"
    if $VV;
  my @ghc_link_output =
`ghc -v -keep-tmp-files -tmpdir=./tmp  -no-hs-main $test_src.o -L. -l$hs_lib -package parsec -package containers $package_str -o $test_out 2>&1`;
  my $ghc_link_options_str = $ghc_link_output[-1];
  $ghc_link_options_str =~ s/^\s*\'//;
  $ghc_link_options_str =~ s/\'\s*$//;
#  print "HASKELL LD CMD: $ghc_link_options_str\n" if $VV;
  my @ghc_link_options = ();
  if ( $ghc_link_options_str =~ /\'\s+\'/ ) {

   @ghc_link_options = split( /\'\s+\'/, $ghc_link_options_str );
  }
  else {
   @ghc_link_options = split( /\s+/, $ghc_link_options_str );
  }
  $ld = shift @ghc_link_options;

  for my $opt (@ghc_link_options) {
   $opt eq '-m64'                 && do { $opt = ''; next };
   $opt eq '-fno-stack-protector' && do { $opt = ''; next };
   $opt eq '-o'                   && do { $opt = ''; next };
   $opt eq $test_out              && do { $opt = ''; next };
   $opt eq '-L.' && do { $opt = '-L../../../../_Call_Haskell'; next };
   $opt eq "$test_src.o"
     && do { $opt = '../../../../_Call_Haskell/' . $opt; next };
   $opt =~ /^tmp.ghc/
     && do { $opt = '../../../../_Call_Haskell/' . $opt; next };
  }
  $ghc_link_options_str = join( ' ', @ghc_link_options );
  $link_options = "$perl_link_options_str $ghc_link_options_str";

  # Here we should write these to a file cache
  open my $LO, '>', $link_options_cache;
  print $LO "$ld :: $link_options";
  close $LO;
 }
 else {
  say "USING CACHED LINK OPTIONS" if $VV;
  open my $LO, '<', $link_options_cache;
  my $ld_link_options = <$LO>;
  close $LO;
  ( $ld, $link_options ) = split( /\s::\s/, $ld_link_options );
 }
 print "=" x 80, "\n" if $VV;
 print "LDDLFLAGS = $link_options\n" if $VV;
 print "=" x 80, "\n" if $VV;
 chdir $wd;
 Inline->import(
  C         => Config => LD => $ld,
  LDDLFLAGS => $link_options,
  'INC'     => "-I$wd/_Call_Haskell"
 );
 Inline->import( C => $inline_c_code );
 say "CALL hs_begin" if $VV;
 hs_begin(1);
# say "LEAVING build()" if $VV;
}

END {
 say "CALL hs_end" if $VV;
 hs_end(0);
}

1;
__END__

=head1 NAME

Call::Haskell - Call Haskell functions from Perl


=head1 SYNOPSIS

    use Call::Haskell 'My::Haskell::Module( f1, f2, f3, f4 )'

or more explicitly:

    use Call::Haskell functions => 'My::Haskell::Module( f1, f2, f3, f4 )' , path => '..', clean => 0, verbose => 0 ;
    
    my $res = f1(@args);

Note that the path to C<Call/Haskell.pm> must be I<absolute> in C<@INC>. The easiest way is to add the absolute path to the C<PERL5LIB> environment variable.  



=head1 DESCRIPTION

Call::Haskell provides a simple mechanism to call Haskell functions from Perl. The syntax for the import statement is similar to what you would write in Haskell. If the path is not specified, the local directory is assumed.

To use this module you need

    - perl 5.16 or later,
    - ghc 7.8 or more recent,
    - gcc 4.8 or more recent

You also need recent versions of

    - the Inline, Inline::C and Digest::MD5 Perl packages
    - the Parsec Haskell package

Currently the Haskell function arguments and return values must have types that are lists, tuples or maps of primitive types (Int, Bool, String). Haskell's Data.Map becomes a Perl hash and vice versa. Maybe is also supported, Nothing is mapped to undef and vice versa.

The module packs the arguments into a string and unpacks the return value from a string. This will be very slow for large data structures.

Currently, you can only use functions from a single Haskell module.

The module creates two subdirectories in your working directory: C<_Call_Haskell> and C<_Inline>. You can find all generated code in there. 


=head1 AUTHOR

Wim Vanderbauwhede  <Wim.Vanderbauwhede@mail.be>


=head1 COPYRIGHT

Copyright 2015- Wim Vanderbauwhede


=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=head1 SEE ALSO

=over

=item -

Inline, Inline::C and Digest::MD5 Perl packages


=item -

The Parsec Haskell package L<http://hackage.haskell.org/package/parsec>


=back

