package RefactorF4Acc::Inventory;
use v5.16;
use RefactorF4Acc::Config qw ($V $W $UNREAD);
# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings;
use strict;
use Data::Dumper;
use Carp qw( croak );
use Exporter;

@RefactorF4Acc::Inventory::ISA = qw(Exporter);

@RefactorF4Acc::Inventory::EXPORT = qw(
    &find_subroutines_functions_and_includes
);

use File::Find;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw(module_has_only);

# Find all source files in the current directory
# The files are parsed to determine the following information:
# Subroutines, Functions or IncludeFile
# Fortran style: FStyle
# Free or fixed form: FreeForm
# Are there blocks to be refactored: HasBlocks
# For F90/95, we also find the modules and tag the modules with
# Uses, Subroutines, Functions, Includes, Parameters, TypeDecls, ImplicitRules, Interfaces (not yet).
sub find_subroutines_functions_and_includes {	
    my $stref = shift;
    my $prefix   = $Config{PREFIX};
    my @srcdirs=@{ $Config{SRCDIRS} };
    my %excluded_sources = map { $_ => 1 } @{ $Config{EXCL_SRCS} };
    my %excluded_dirs = map { $_ => 1 } @{ $Config{EXCL_DIRS} };
    # find sources (borrowed from PerlMonks)
    
    my %src_files = ();
    my $tf_finder = sub {
        return if !-f;
        return if (!/\.f(?:9[05])?$/ &&!/\.c$/); # rather ad-hoc for Flexpart + WRF
        # FIXME: we must have a list of folders to search or not to search!
        my $srcname = $File::Find::name; 
        $srcname =~s/^\.\///;
        my $srcdir = $File::Find::name; 
        $srcdir=~s/\/.+$//;        
#        print "<$srcdir>\n";
        if (not (
         exists $excluded_sources{$srcname} or 
         exists $excluded_sources{"./$srcname"} 
        ) and
        not exists $excluded_dirs{$srcdir} # this does not work as the $srcdir is simply '.' 
         ) {
         $src_files{$File::Find::name} = 1;
        } else {
            print "EXCLUDED SOURCE: $srcname\n" if $V;
        }
    };
    
    for my $dir (@srcdirs) {
    	my $path="$prefix/$dir";
    	if ($dir eq '.') {
    	   $path=$prefix;
    	} 
#    	print "$path\n";
        find( $tf_finder, $path );
    }
#    print Dumper(%src_files);die;
#    find( $tf_finder, '.' );
#	$stref->{'SourceFiles'}=\%src_files;
    for my $src ( sort keys %src_files ) {#sort WV23JUL2012
#    my $test_src=$src;
        my $exclude=0;
        
#        die Dumper(%excluded_dirs);
        for my $excl_dir (keys %excluded_dirs) {            
            if ($src=~/$excl_dir\//) { 
                $exclude=1;
#                print "EXCLUDED DIR: $excl_dir\n" if $V;                
                last;
            }
        }    
        next if $exclude;
#        die $src if ($src=~/timdata/); 
    	if  ($src=~/\.c$/) { 
#    		warn "C SOURCE: $src\n";
    		# FIXME: ugly ad-hoc hack!
    		# WRF uses cpp to make subroutine names match with Fortran
    		# So we need to call cpp first, but with all the correct macros ...
    		# Without any defined macros, it's like this:    	
#    		my @lines=`grep -v '#include' $src  | cpp -P -`;
    		# I guess we could use some command-line flag to add the macro definitions
    		# And now we must parse C sources too ...
    		
#    		die;
            
    	} 
#    	else {
#    	   print "F90 SOURCE: $src\n"; 
#    	}
    	
        $stref=_process_src($src,$stref);
    }
#    for my $mn (sort keys %{ $stref->{'Modules'} } ) {
#say "$mn:\t".Dumper($stref->{'Modules'}{$mn});
#    }
#    die;
    _test_can_be_inlined_all_modules($stref);    
    
    
    return $stref;
}    # END of find_subroutines_functions_and_includes()




sub _process_src {
	(my $src, my $stref)=@_;
	
    my $srctype=''; # sub, func or incl; for F90/95 also module, and then we must tag the module by what it contains
    my $f=''; # name of the entity
    my $has_blocks=0;
    my $free_form=0;
    my $fstyle='F77';   
    my $translate_to='';
    my $in_interface_block=0;
    my $is_module=0;
    my $mod_name='NONE'; 
    
    open my $SRC, '<', $src;
    while ( my $line = <$SRC> ) {

            # Skip blanks
        $line =~ /^\s*$/ && next;
            # Translate pragma
        if ( $line =~ /^\!\s*\$(?:ACC|RF4A)\stranslate\s(\w+)/i ) { 
            $translate_to=$1;
        }             

        # Detect blocks. FIXME: we need to distinguish between the Subroutine and KernelWrapper pragmas!
            if ( $has_blocks == 0 ) {
                if ( $line =~ /^[Cc\*\!]\s+BEGIN\sSUBROUTINE\s(\w+)/ 
        or $line =~ /^\!\s*\$(?:ACC|RF4A)\s+(Subroutine|KernelWrapper)\s+(\w+)/i ){
                        my $block_type=$1;
                         my $sub=$2;
                         say 'Detected block: '."$block_type $sub" if $V;
                         croak 'Detect blocks: No '.$block_type.' name from '.$line if $sub eq '';
                        $has_blocks = 1;
                        if ($translate_to ne '') {
                            $stref->{'Subroutines'}{$sub}{'Translate'}= $translate_to;
                            $translate_to='';                           
                        }
                }
            }
            
            # Skip comments 
            $line =~ /^\s*[C\*\!]/i && next;
            
        # Tests for free or fixed form
        if ($free_form==0) {
            if ( $line !~ /^[\s\d]{5}.+/ and $line !~ /^\t[\t\s]*\w/ and $line !~/^\s+\t/) {
                $free_form = 1;       
#                die $line,$src;                                                     
            } 
               
            if ($line =~ /\&\s*$/ ) {
                    $free_form = 1;          
            }
        }   
        # Tests for F77 or F95
        
            if ( $line =~ /^\s*module\s+(\w+)/i ) { # die "LINE: $line";
            
                $is_module=1; 
                $srctype='Modules';
                $mod_name = lc($1); #die $line.':'.$mod_name;
                $f=$mod_name;
# What I want is a connection between a module and its file name, and also with its content.
# So that we can say, given a module name, get the source, from there get the contents                
# Maybe we don't really need the source, as we can use the module name as identifier
                $stref->{'Modules'}{$mod_name}{'Source'}=$src;
                $fstyle='F95';
            } 
        if ($fstyle eq 'F77') {            
            if ( $line =~ /^\s*(.*)\s*::\s*(.*?)\s*$/ ) {
                 $fstyle='F95';
            }
        } 
        
        if ( $line =~ /^\s+interface/i ) { #TODO: should be added to inventory of module
            $in_interface_block=1;
             $stref->{$srctype}{$f}{'Interface'}={};
        }
        if ( $line =~ /^\s+end\s+interface/i ) { 
            $in_interface_block=0;
        }
        
            # Find subroutine/program signatures
            $line =~ /^\s*(recursive\s+subroutine|subroutine|program)\s+(\w+)/i && do {
                my $is_prog = (lc($1) eq 'program') ? 1 : 0;
                my $tmp=$1;
                my $sub  = lc($2);
                my $is_rec = ($tmp =~/recursive/i) ? 1 : 0;
                if ( $is_prog == 1 ) {
                    print "Found program $2 in $src\n" if $V;                    
                }
                if ($is_module) {
                    $stref->{'Modules'}{$mod_name}{'Subroutines'}{$sub}={};
                }
                die 'No subroutine name from '.$line if $sub eq '' or not defined $sub;
                if (not $in_interface_block) {
	                $f=$sub;                
	                $srctype='Subroutines';
	                $stref->{'Subroutines'}{$sub}={};
	                $stref->{'SourceContains'}{$src}{$f}=$srctype;
	                my $Ssub = $stref->{'Subroutines'}{$sub};
	                if (
	                    not exists $Ssub->{'Source'}
	                    or (    $src =~ /$sub\.f(?:9[05])?/
	                        and $Ssub->{'Source'} !~ /$sub\.f(?:9[05])?/ )
	                  )
	                {
	                    if (    exists $Ssub->{'Source'}
	                        and $src =~ /$sub\.f(?:9[05])?/
	                        and $Ssub->{'Source'} !~ /$sub\.f(?:9[05])?/ )
	                    {
	                        print "WARNING: Ignoring source "
	                          . $Ssub->{'Source'}
	                          . " because source $src matches subroutine name $sub.\n"
	                          if $W;
	                    }
	                    $Ssub->{'Source'}  = $src;
	                    $Ssub->{'Status'}  = $UNREAD;
	                    $Ssub->{'Program'} = $is_prog;
	                    $Ssub->{'Recursive'} = $is_rec;
	                    $Ssub->{'Callers'}  = {};
	                    if ($is_prog==1) {
	                    	$stref->{'Program'}=$src;	                    	
	                    }
	                    if ($translate_to ne '') {
	                        $Ssub->{'Translate'}  = $translate_to;
	                        $translate_to = '';
	                    }
	
	                } else {
	                    print
	"WARNING: Ignoring source $src for $sub because another source, "
	                      . $Ssub->{'Source'}
	                      . " exists.\n"
	                      if $W;
	                }
                } else {
                	$stref->{$srctype}{$f}{'Interface'}{$sub}=1; #WV: TODO: add functionality here
                }
            };
            
            # Find include statements
            $line =~ /^\s*include\s+\'([\w\.]+)\'/ && do {
                my $inc = $1;
                 if ($is_module) {
                    $stref->{'Modules'}{$mod_name}{'IncludeFiles'}{$inc}={};
                }

#                print "FOUND INC $inc\n" if $V;
                if ( not exists $stref->{'IncludeFiles'}{$inc} ) {
                    $stref->{'IncludeFiles'}{$inc}{'Status'} = $UNREAD;                                        
                    $srctype='IncludeFiles';
                    $stref->{$srctype}{$inc}{'Source'}=$inc;
                    $f=$inc;
                    if (not -e $inc) {
                    	$stref->{$srctype}{$inc}{'InclType'} = 'External';
                    } else {
                        $stref->{$srctype}{$inc}{'InclType'} = 'Local';
                    }
                }
            };
            
            # Find use statements, for F90/F95. 
#die $line if $f=~/common/ and $line=~/params_common_sn/;
            $line =~/^\s*use\s+([_\w]+)(?:\s*,\s*only\s*:\s*(.+)\s*)?/ && do { #FIXME: no support for R1108 rename ; R1109 is incomplete; no support for R1110, R1111
                my $mod = lc($1); 
                my $only_list = $2;
                if ($is_module) {
                    $stref->{'Modules'}{$mod_name}{'Uses'}{$mod}={};
                }
                if ( not exists $stref->{'Modules'}{$mod} ) {
                    $stref->{'Modules'}{$mod}{'Status'} = $UNREAD;                                        
                }
            };
            
            # Find function signatures
            $line =~ /\bfunction\s+(\w+)/i && do {
#            	print "FUNC: $line process_src() 216 \n";
                my $func = lc($1);                               
                if ($is_module) {
                    $stref->{'Modules'}{$mod_name}{'Subroutines'}{$func}={};
                }
                $stref->{'Subroutines'}{$func}{'Function'} = 1;
                
                $stref->{'Subroutines'}{$func}{'Source'} = $src;
                $stref->{'Subroutines'}{$func}{'Status'} = $UNREAD;
                if ($translate_to ne '') {
                        $stref->{'Subroutines'}{$func}{'Translate'}  = $translate_to;
                        $translate_to = '';
                    }
                  $f=$func;
                  $srctype='Subroutines';
                  $stref->{'SourceContains'}{$src}{$f}=$srctype;
            };

            $line =~/::/ && do {
                if ($is_module) {
                    if ($line =~ /parameter/ ) {
                        $stref->{'Modules'}{$mod_name}{'Parameters'}={};
                    } else {
                        $stref->{'Modules'}{$mod_name}{'TypeDecls'}={};
                    }
                }
            };
         
            $line =~/implicit\s+(?!none)/ &&  do {
                if ($is_module) {
                    $stref->{'Modules'}{$mod_name}{'ImplicitRules'}={};                    
                }
            };
         
            $stref->{$srctype}{$f}{'FStyle'}=$fstyle;
            $stref->{$srctype}{$f}{'FreeForm'}=$free_form;  
            $stref->{$srctype}{$f}{'HasBlocks'}=$has_blocks;
#            print "{$srctype}{$f}{'HasBlocks'}=$has_blocks\n";
            if ($is_module) {
                $stref->{'Modules'}{$mod_name}{'Status'} = $INVENTORIED; 
            }
        
        } # loop over lines;
            
        close $SRC;
#        if ($mod_name =~/module_bondFG/) { die $mod_name.':'.Dumper($stref->{'Modules'}{$mod_name}) };

        return $stref;	
	
} # END of _process_src()

sub _test_can_be_inlined_all_modules { (my $stref) = @_;
    for my $mod_name (keys %{ $stref->{'Modules'} }) {
#        print "MODULE TEST FOR INLINE: ",$mod_name ,"\n";
        my $inline_ok=1;
        my $inline_sub_ok=1;
        if (_can_be_inlined($stref, $mod_name,  $inline_ok) )  {
#            print "INLINEABLE: $mod_name\n" if $V;
            $stref->{'Modules'}{$mod_name}{'Inlineable'}=1;
        } else {
            $stref->{'Modules'}{$mod_name}{'Inlineable'}=0;
        }
        if (_subs_can_be_inlined($stref, $mod_name,  $inline_sub_ok) )  {
#            print "INLINEABLE SUBS: $mod_name\n" if $V;
            $stref->{'Modules'}{$mod_name}{'InlineableSubs'}=1;
        } else {
               $stref->{'Modules'}{$mod_name}{'InlineableSubs'}=0;
        }
        
    }
    
}


sub _can_be_inlined { (my $stref, my $mod_name, my $inline_ok) = @_;
#    if ($mod_name =~/velfg/) { die Dumper($stref->{'Modules'}{$mod_name}) };
    if ( module_has_only($stref, $mod_name,['Parameters','TypeDecls','ImplicitRules','Uses'] ) ) {
#        print "Module $mod_name candidate for INLINE\n";# if $V;
        for my $used_mods (keys %{  $stref->{'Modules'}{$mod_name}{'Uses'} } ) {
#            print "USED MODULE $used_mods\n";
            $inline_ok*=_can_be_inlined($stref,$used_mods, $inline_ok);
        }
#        if ($inline_ok) {
#            print "Module $mod_name is INLINEABLE\n" if $V;
#        }
    } else {
        return 0;
    }
    return $inline_ok;
}

sub _subs_can_be_inlined { (my $stref, my $mod_name, my $inline_ok) = @_;
#    if ($mod_name =~/velfg/) { die Dumper($stref->{'Modules'}{$mod_name}) };
    if ( module_has_only($stref, $mod_name,['Parameters','TypeDecls','ImplicitRules','Uses','Subroutines'] )
    and (exists  $stref->{'Modules'}{$mod_name}{'Subroutines'})
    ) {
#        print "MODULE $mod_name:". ((exists  $stref->{'Modules'}{$mod_name}{'Subroutines'})? "HAS SUBS\n" : "DOES NOT HAVE SUBS\n");
#        print "Module $mod_name candidate for INLINE SUBS\n";# if $V;
        for my $used_mods (keys %{  $stref->{'Modules'}{$mod_name}{'Uses'} } ) {
#            print "USED MODULE $used_mods\n";
            $inline_ok*=(_subs_can_be_inlined($stref,$used_mods, $inline_ok) + _can_be_inlined($stref,$used_mods, $inline_ok));
        }
#        if ($inline_ok) {
#            print "Module $mod_name is INLINEABLE\n" if $V;
#        }
    } else {
        return 0;
    }
    return $inline_ok;
}