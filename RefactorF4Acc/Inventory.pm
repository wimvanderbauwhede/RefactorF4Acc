package RefactorF4Acc::Inventory;
use v5.10;
use RefactorF4Acc::Config qw ($V $W $UNREAD);
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.0";

use warnings;
use strict;
use Data::Dumper;
use Carp qw( carp croak );
use Exporter;

@RefactorF4Acc::Inventory::ISA = qw(Exporter);

@RefactorF4Acc::Inventory::EXPORT = qw(
    &find_subroutines_functions_and_includes
);

use File::Find;
use Cwd qw( cwd );
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
    
    my $incl='';
    if (@_) {
    	($incl)=@_;
        say "Looking for INC $incl" if $V;
    }
    	
    my $prefix   = exists $Config{PREFIX} ? $Config{PREFIX} : '.';
    
    my %src_files = ();
    my %excluded_dirs = $Config{EXCL_DIRS} ? map { $_ => 1 } @{ $Config{EXCL_DIRS} } : ();
    # The NEWSRCPATH should always be excluded
     if ($Config{'NEWSRCPATH'} ne '.') {
            $excluded_dirs{ $Config{'NEWSRCPATH'} } = 1;
     } else {
        # I don't exclude it if it is '.', instead I throw an error as that is not a good idea  
        die "NEWSRCPATH can't be '.', has to be a subfolder\n";
     }
    
    if ($incl eq '' and scalar @{$Config{'SOURCEFILES'}} > 0) {
    	%src_files = map { $_ => {'Local' => $prefix } } @{$Config{'SOURCEFILES'}};
    	%excluded_dirs=();     	
    }  else {
        my @srcdirs=exists $Config{SRCDIRS} ?  @{ $Config{SRCDIRS} } : ('.');    
        my @extsrcdirs=exists $Config{EXTSRCDIRS} ? @{ $Config{EXTSRCDIRS} } : (); # External sources, should not be refactored but can be parsed
        my %ext_src_dirs = map { $prefix.'/'.$_ => 1 } @extsrcdirs; 
        
        my %excluded_sources = exists $Config{EXCL_SRCS} ? map { $_ => 1 } @{ $Config{EXCL_SRCS} } : ();
        if (not exists $Config{EXCL_SRCS}) {
            $Config{EXCL_SRCS} = [];
        }
        
        # if there is an entry in $Config{EXCL_SRCS} then it is a regex
        my $has_pattern =  scalar @{ $Config{EXCL_SRCS} } > 0 ? 1 : 0;    
        my $excl_srcs_pattern    = @{ $Config{EXCL_SRCS} }>1? '(?:'.join('|', @{ $Config{EXCL_SRCS} }).')' : @{ $Config{EXCL_SRCS} }==1 ? $Config{EXCL_SRCS}->[0] : '';
        # I treat the EXCL_SRC regex as relative to SRCDIRS unless it starts with '^'
        if ($excl_srcs_pattern!~/^\^/) {
            my @excl_srcs_pattern_w_srcdirs =();
            for my $srcdir (@srcdirs) {
                push @excl_srcs_pattern_w_srcdirs , "$srcdir\\/$excl_srcs_pattern"
            }
            $excl_srcs_pattern = join('|', @excl_srcs_pattern_w_srcdirs);
        }
        say 'Exclude pattern: /'. ($excl_srcs_pattern!~/[\^\$]/ ? '^'.$excl_srcs_pattern.'$'  :  $excl_srcs_pattern). '/' if $V; 
        my $excl_srcs_regex      = $excl_srcs_pattern!~/[\^\$]/ 
            ? qr/^$excl_srcs_pattern$/ 
            : qr/$excl_srcs_pattern/;
        
        $stref->{'SourceDirs'} = [@srcdirs];
        $stref->{'Prefix'} = $prefix;

        # find sources (borrowed from PerlMonks)    
        my $tf_finder = sub { 
            return if !-f;
            if ($incl) {
                return if (!/$incl$/);
            } else {
                return if (!/\.f(?:or|9[05])?$/i &&!/\.c$/); # rather ad-hoc for Flexpart + WRF # FIXME: make pattern configurable in rf4a.cfg
            }
            my $filepath = $File::Find::name;  # i.e. $path+ the name of the file found
            
            my $srcname = $filepath; # e.g. ./admin/aadmn.f
            $srcname =~s/^\.\///;  # e.g. admin/aadmn.f
            my $srcdir = $filepath;  
            $srcdir=~s/\/.+$//;        # i.e. $path # e.g. admin
            if (not (
                exists $excluded_sources{$srcname} or 
                exists $excluded_sources{"./$srcname"} or
                ($has_pattern and $srcname=~$excl_srcs_regex)
                ) and not exists $excluded_dirs{$srcdir} # this does not work as the $srcdir is simply '.' 
            ) {
            $src_files{$File::Find::name} = (exists $ext_src_dirs{$srcdir}) ? { 'Ext' => $filepath }  : {'Local' => $filepath };
            } else {
                print "EXCLUDED SOURCE: $srcname\n" if $V;
            }
        };
        
        for my $dir (@srcdirs,@extsrcdirs) {
            my $path="$prefix/$dir";
            if ($dir eq '.') {
                $path=$prefix;
            }     	
            find( $tf_finder, $path );
        }
    }
    for my $src ( sort keys %src_files ) {
		say "SRC: $src" if $V;
        my $exclude=0;        
        for my $excl_dir (keys %excluded_dirs) {            
            if ($src=~/$excl_dir\//) {
                $exclude=1;
                last;
            }
        }    
        next if $exclude; 
 
    	if  ($src=~/\.c$/) { 
    		say "WARNING: IGNORING C SOURCE: $src\n" if $W;
    		# FIXME: ugly ad-hoc hack!
    		# WRF uses cpp to make subroutine names match with Fortran
    		# So we need to call cpp first, but with all the correct macros ...
    		# Without any defined macros, it's like this:    	
#    		my @lines=`grep -v '#include' $src  | cpp -P -`;
    		# I guess we could use some command-line flag to add the macro definitions
    		# And now we must parse C sources too ...
    	} 

        say "DBG: Fortran SOURCE: $src" if $DBG; 

    	$stref->{'SourceContains'}{$src}={
    		'Path' => $src_files{$src},
    		'Set'=>{},
    		'List'=>[]
    	};
    	
        $stref=_process_src($src,$stref) ;#if not $incl ;
        say "Done _process_src($src)" if $V;   
    }
    if (!$incl) {
    _find_external_modules($stref);
    
    _test_can_be_inlined_all_modules($stref);    
    
    _add_path_to_includes($stref);
    }
    
    return $stref;
}    # END of find_subroutines_functions_and_includes()




sub _process_src {
	(my $src, my $stref)=@_;
	# say "_process_src($src)";
	my @extsrcdirs=exists $Config{EXTSRCDIRS} ? @{ $Config{EXTSRCDIRS} } : (); # External sources, should not be refactored but can be parsed
	my $prefix   = $Config{'PREFIX'};
    my $srctype=''; # sub, func or incl; for F90/95 also module, and then we must tag the module by what it contains
#    my $f=''; # name of the entity
    my $has_blocks=0;
    my $free_form=0;
    my $tab_format=0;
    my $is_cont=0;
    my $fstyle='F77';   
    my $translate_to='';
    my $in_interface_block=0;
    my $in_module=0;
    my $mod_name='NONE'; 
    my $sub_name='NONE'; 
    my $in_contains=0;
    my $container='';
    if (not exists $stref->{'SourceFiles'}{$src}) {
    	$stref->{'SourceFiles'}{$src}={};
    	$stref->{'SourceFiles'}{$src}{'AnnLines'}=[];
    	$stref->{'SourceFiles'}{$src}{'Path'} =$stref->{'SourceContains'}{$src}{'Path'} ;  
    } else {    	
    	say "DBG: Already processed $src" if $DBG;
    	return $stref;
    }
    open my $SRC, '<', $src;
    while ( my $lline = <$SRC> ) {

            # Skip blanks
        $lline =~ /^\s*$/ && next;
            # Translate pragma
            
        if ( $lline =~ /^\s*\!\s*\$(?:ACC|RF4A)\stranslate\s(\w+)/i ) { 
            $translate_to=$1;
        }             
		my $line = $lline;
		$line=~s/\s+\!.+$//;
		# Skip blanks
        $line =~ /^\s*$/ && next;
#		 print "$src LINE: $line";
        # Detect blocks. FIXME: we need to distinguish between the Subroutine and KernelWrapper pragmas!
            if ( $has_blocks == 0 ) {
                if ( $line =~ /^(?:[Cc\*]|\s*\!)\s+BEGIN\sSUBROUTINE\s(\w+)/ 
        		  or $line =~ /^\s*\!\s*\$(?:ACC|RF4A)\s+(Subroutine|KernelWrapper)\s+(\w+)/i ){
                        my $block_type=$1;
                         my $sub=$2;
                         say 'Detected block: '."$block_type $sub in $srctype $sub_name" if $V;
                         croak 'Detect blocks: No '.$block_type.' name from '.$line  if $DBG and $sub eq '';
                        $has_blocks = 1;
                        $stref->{$srctype}{$sub_name}{'HasBlocks'}=$has_blocks;
                        if ($translate_to ne '') {
                            $stref->{'Subroutines'}{$sub}{'Translate'}= $translate_to;
                            $translate_to='';                           
                        }
                }
            }
            
            # Skip comments              
            # A line with a c, C, *, d, D, or! in column one is a comment line. The d, D, and! are nonstandard.
            # Problem is, if this is free form, then this line could be a statement line. But the declarations should come first so should be OK. 
            if ($free_form == 0 and $line =~ /^[CD\*\!]/i ) {
            	 next;
            }
            if ($line =~ /^\s*\!/) {
            	 next; # for free form
            }
#             $line =~ /^\s*\*/ && next;
#             $line =~ /^\s*[CcDd]\W/ && next;
        # Tests for free or fixed form
        if ($free_form==0) {
        	# Get 6 cols
        	my $cols1to6 = substr($line,0,6);
        	# FIXME: HACK: change TAB to 4 spaces
        	if ($cols1to6 =~/^\s*\d*\t/) {
        		my $tline = $line;
        		chomp $tline;
        		$tline=~s/\t/    /g;
        		$cols1to6 = substr($tline,0,6);
        	}
			my @cols1to6_chars = split('',$cols1to6);
			my $nchars= scalar @cols1to6_chars ;
			
# Standard Fixed Format        	
#The standard fixed format source lines are defined as follows:
#• The first 72 columns of each line are scanned. See “Extended Lines,” page 9.
#• Continuation lines are identified by a nonblank, nonzero in column 6.
			if (
				defined $cols1to6_chars[5] 
			and $cols1to6_chars[5] ne " " 
			and $cols1to6_chars[5] ne "0") {
				$is_cont=1;
			} 

#• Short lines are padded to 72 characters.
#• Long lines are truncated. See “Extended Lines,” below.
        	
#• The first five columns must be blank or contain a numeric label.
        	# And the whitespace at the start of the line does not contain tabs
            if ( $line!~/^\s*$/ and $line !~ /^[\s\d]{5}.+/ and $line !~ /^\t[\t\s]*\w/ and $line !~/^\s+\t/ and $line!~/^\s*\#/) {
                $free_form = 1;
#                croak "<$line>" if $src=~/dyn_shapiro_vernieuw_device_code.f95/;     
            } 

            # TAB format
#A tab in any of columns 1 through 6, or an ampersand in column 1,
#establishes the line as a tab-format source line.
				my $col_ctr=0;
            for my $cols1to6_char (@cols1to6_chars) {
            	
            	if ($cols1to6_char eq "\t") {
            		 $free_form = 0;     
            		 $tab_format=1;
            		 carp 'TAB FORMAT IS NOT WELL SUPPORTED!';
#• Continuation lines are identified by  a nonzero digit after the first tab.                        		 
            		 if ($cols1to6_chars[$col_ctr+1] =~/1-9/) {
            		 	$is_cont=1;
            		 }
            		 last;
            	}
            	$col_ctr++;
            }   
#• Continuation lines are identified by an ampersand (&) in column 1.            
            if ($cols1to6_chars[0] eq '&' ) {
            		$tab_format=1;            	
                    $free_form = 0;          
                    $is_cont=1;
            }

#• If the tab is the first nonblank character, the text following the tab is scanned
#as if it started in column 7.
#• A comment indicator or a statement number can precede the tab.
            
        }   
        # Tests for F77 or F95
        if ( $line =~ /^\s*module\s+(\w+)/i ) { # die "LINE: $line";
        
            $in_module=1; 
            $srctype='Modules';
            $stref->{'SourceFiles'}{$src}{'SourceType'}='Modules';
            $mod_name = lc($1); #die $line.':'.$mod_name;
            $stref->{'SourceFiles'}{$src}{'ModuleName'}=$mod_name;
            say "SRC $src IS MODULE SRC: $mod_name" if $DBG;
#                $f=$mod_name;
            $container=$mod_name;
# What I want is a connection between a module and its file name, and also with its content.
# So that we can say, given a module name, get the source, from there get the contents                
# Maybe we don't really need the source, as we can use the module name as identifier
            $stref->{'Modules'}{$mod_name}{'Source'}=$src;
            
            $stref->{'SourceContains'}{$src}{'Set'}{$mod_name}=$srctype;
            push @{ $stref->{'SourceContains'}{$src}{'List'} },$mod_name;
            
            $fstyle='F95';                
            $stref->{'Modules'}{$mod_name}{'FStyle'}=$fstyle;
            $stref->{'Modules'}{$mod_name}{'FreeForm'}=1;#$free_form;                  
            $stref->{'Modules'}{$mod_name}{'TabFormat'}=$tab_format;         
            
        } 
        if ( $line =~ /^\s*end\s+(?:module|program)/i ) { 
            $in_contains=0;
        }
        if ($fstyle eq 'F77') {            
            if ( $line =~ /^\s*(^[\'\"]+)\s*::\s*(.*?)\s*$/ ) {
                 $fstyle='F95'; 
                 if (scalar @{ $stref->{'SourceContains'}{$src}{'List'} } == 1) {
                 	(my $code_unit, $srctype) = %{ $stref->{'SourceContains'}{$src}{'Set'} };
	                $stref->{$srctype}{$code_unit}{'FStyle'}='F95';
    	        	$stref->{$srctype}{$code_unit}{'FreeForm'}=1;        
                    
                 }
                 
            }
        } 
        
        if ( $line =~ /^\s+interface/i ) { #TODO: should be added to inventory of module
            $in_interface_block=1;
             $stref->{$srctype}{$mod_name}{'Interface'}={};
        }
        if ( $line =~ /^\s+end\s+interface/i ) { 
            $in_interface_block=0;
        }
        
        
            # Find subroutine/function/program signatures
            
           (
           $line =~ /^\s*(\w+\s+\w+\s+(?:function|subroutine|entry)|\w+\s+(?:subroutine|entry)|[\*\(\)\w]+\s+function|function|subroutine|entry|program|block)\s+(\w+)/i
           || $line =~ /^\s*(block)(data)/i
           ) && $line!~/\Wend\s+/i && $line!~/^end\s+/i && do {           	
            	my $full_proc_type=$1;            	
            	my $proc_name=$2;

#				say "$src PROC NAME: $proc_name PROC TYPE: $full_proc_type" unless $full_proc_type=~/END/;
				my @proc_type_chunks = split(/\s+/,$full_proc_type);
				my $proc_type=$proc_type_chunks[-1];
				my $is_block_data = (lc($proc_type) eq 'block' and lc($proc_name) eq 'data' ) ? 1 : 0;
                my $is_prog = (lc($proc_type) eq 'program') ? 1 : 0;
                my $is_function = (lc($proc_type) eq 'function') ? 1 : 0;
                my $is_entry = (lc($proc_type) eq 'entry') ? 1 : 0;
                my $is_rec = ($full_proc_type =~/recursive/i) ? 1 : 0;
                my $is_pure = ($full_proc_type =~/pure/i) ? 1 : 0;
                my $is_elemental = ($full_proc_type =~/elemental/i) ? 1 : 0;
                my @maybe_type = grep { $_!~/pure|elemental|recursive|function|subroutine|entry|program/ } ( map { lc($_) } @proc_type_chunks) ;
                my $has_type = @maybe_type ? $maybe_type[0] : '';
#                say "$line => $has_type" if $has_type;   
                my $sub  = lc($proc_name);                
                if ( $is_prog == 1 ) {
                    print "Found program $sub in $src\n" if $V;
                    # If there is no TOP, the PROGRAM is the top
                    if (not exists $Config{'TOP'} or $Config{'TOP'} eq '') {
                        # print "Found program $sub in $src\n" ;
                    	$Config{'TOP'} = $sub;
                    } elsif (exists $Config{'TOP'} and $Config{'TOP'} eq $sub) {
                    	say "INFO: Found TOP program $sub" if $I; 
                    } elsif  (exists $Config{'TOP'} and $Config{'TOP'} ne $sub) {
                    	# TOP has a different name from the program
                    	my $topsub = $Config{'TOP'};
                    	# If this TOP subroutine is also a program, then there are at least two programs with different names, or TOP is wrong
                    	 if (exists $stref->{'Subroutines'}{$topsub} and exists $stref->{'Subroutines'}{$topsub}{'Program'} and $stref->{'Subroutines'}{$topsub}{'Program'}==1) {
                    	 	say "WARNING: TOP routine $topsub is a program but $sub is also a program at " . __PACKAGE__ . ' ' . __LINE__ if $W;
                    	 } 
                    }
                    $container=$sub;                    
                }
                if ( $is_block_data == 1 ) { 
                	if (lc($sub) eq 'data') {
                		$sub = 'block_data';
                		$line=~/block\s*data\s{1,4}(\w+)/i && do { $sub=lc($1) };
                	}
					say "Found block data $sub in $src: $line" if $V;
                }
                if ($in_module) {					
                    $stref->{'Modules'}{$mod_name}{'Subroutines'}{$sub}={};
                    $stref->{'Subroutines'}{$sub}{'InModule'}=$mod_name;
                } 
#                say "PROC NAME: $proc_name in SRC: $src";
                die 'No subroutine/function name from '.$line if $sub eq '' or not defined $sub;
                
                	
                if ((not $is_function and not $in_interface_block) or $is_function) {	
                	                
	                $srctype='Subroutines';
	                if (not exists $stref->{'SourceFiles'}{$src}{'SourceType'}) {
	                	$stref->{'SourceFiles'}{$src}{'SourceType'}='Subroutines';
	                }
	                $stref->{'Subroutines'}{$sub}={} unless exists $stref->{'Subroutines'}{$sub}{'InModule'};
                    say "DBG: Fortran SOURCE: $src" if $DBG; 
	                $stref->{'SourceContains'}{$src}{'Set'}{$sub}=$srctype;
	                push @{ $stref->{'SourceContains'}{$src}{'List'} },$sub;
	                my $Ssub = $stref->{'Subroutines'}{$sub};
	                $Ssub->{'Name'}=$sub;
	                if ($is_function) {
	                	$Ssub->{'Function'} = 1;     
	                }
	                if ( $is_block_data == 1 ) { 
	                		$Ssub->{'BlockData'} = 1;
	                		$stref->{'BlockData'}{$sub}=1;
	                }
                    $Ssub->{'Source'}  = $src;
                    $Ssub->{'Status'}  = $UNREAD;
                    
                    $Ssub->{'Program'} = $is_prog;
                    $Ssub->{'Entry'} = $is_entry;
                    if ($is_entry) {
#                    	say "PARENT FOR $sub is '$sub_name'";
                    	$stref->{'Entries'}{$sub}=$sub_name;
                    }
                    $Ssub->{'Recursive'} = $is_rec;
                    $Ssub->{'Pure'} = $is_pure;
                    $Ssub->{'Elemental'} = $is_elemental;
                    $Ssub->{'HasType'} = $has_type;
	               	if ($line=~/pure\s+function|pure\s+recursive\s+function|pure\s+elemental\s+recursive\s+function/i) {
	                	$Ssub->{'Pure'} = 1;
	                } else {
	                	$Ssub->{'Pure'} = 0;
	                }	                    
                    $Ssub->{'Callers'}  = {};
#                    say "MODULE $in_module $container $in_contains $sub";
                    if ($is_prog==1) {                    	
                    	$stref->{'Program'}=$src;	                    	
                    } elsif ($in_contains==1) {
                    	$Ssub->{'Container'} = $container;
                    	if (not $in_module) {
                    		push @{ $stref->{'Subroutines'}{$container}{'Contains'} }, $sub;
                    	} else {
                    		push @{ $stref->{'Modules'}{$container}{'Contains'} }, $sub;
#                    		say "MODULE $container CONTAINS $sub";
                    	}
                    } 
                    
                    if ($translate_to ne '') {
                        $Ssub->{'Translate'}  = $translate_to;
                        $translate_to = '';
                    }
	
                } elsif ($in_interface_block) {
                	$stref->{$srctype}{$mod_name}{'Interface'}{$sub}=1; #WV: TODO: add functionality here
                } else {
                	croak 'TROUBLE!' if $DBG;
                }
                $stref->{'Subroutines'}{$sub}{'FStyle'}=$fstyle;
            	$stref->{'Subroutines'}{$sub}{'FreeForm'}=$free_form;                  
            	$stref->{'Subroutines'}{$sub}{'TabFormat'}=$tab_format;
		        $stref->{'Subroutines'}{$sub}{'HasBlocks'}=$has_blocks;
                $sub_name=$sub unless $is_entry;
            };
            
            # Find include statements
            $line =~ /^\s*\#?include\s+[\"\']([\w\.]+)[\"\']/i && do {
                my $inc = $1;       
                say "FOUND include $inc in $src" if $V;
                # What we should do now is go and find this file!       
                $stref = find_subroutines_functions_and_includes($stref,$inc);
                my $src_path=$inc;  
                for my $k (keys %{$stref->{'SourceContains'}} ){
                    # say "SRC_PATH: $src_path <$k> '$inc'" if $V;
                    if ($k=~/$inc$/) {
                        $src_path=$k;
                        last;
                    }
                }
                 say "SRC_PATH: <$src_path> '$inc'" if $V;
                if ($in_module) {
                    $stref->{'Modules'}{$mod_name}{'IncludeFiles'}{$inc}={};
                }
                if ( not exists $stref->{'IncludeFiles'}{$inc} ) {
                    $stref->{'IncludeFiles'}{$inc}{'Status'} = $UNREAD;                                                            
                    $stref->{'IncludeFiles'}{$inc}{'Source'}=$inc;
					$stref->{'SourceFiles'}{$inc}{'SourceType'}='IncludeFiles';
                    my $is_external=1;
                    for my $src_dir (@{$stref->{'SourceDirs'}}) {
                        # This only works if the $inc is in the $src_dir but not in a subdirectory
                        if (-e "$src_dir/$inc") {    
                            $is_external=0;
                            $stref->{'IncludeFiles'}{$inc}{'InclType'} = 'Local';
                            last;
                        }
                        # To check if $inc might be in a subdirectory, simply check if $src_path starts with "$prefix/$src_dir";
                        if (
                            substr($src_path, 0, length("$prefix/$src_dir")) eq "$prefix/$src_dir"
                        ) {
                            $is_external=0;
                            $stref->{'IncludeFiles'}{$inc}{'InclType'} = 'Local';
                            # But let's store the full path here. Should probably be SrcPath, TODO
                            $stref->{'IncludeFiles'}{$inc}{'SrcPath'} = $src_path; 
                            last;                            
                        }
                    }

                    # if (not -e $inc) {
                    if ($is_external) {
                    	$stref->{'IncludeFiles'}{$inc}{'InclType'} = 'External'; #croak cwd().' '.$inc;          	
                    	for my $ext_dir (@extsrcdirs) {
                    		if (-e "$prefix/$ext_dir/$inc") { 
                    			$stref->{'IncludeFiles'}{$inc}{'ExtPath'} =  "$prefix/$ext_dir/$inc";
                                say "INC SRC PATH $src_path" if $DBG;
                    			$stref->{'SourceContains'}{$src_path}={
                    				'Inc' => $inc,
                    				'Path' => { 'Ext' => "$prefix/$ext_dir/$inc"},                    				
    								'Set'=>{},
    								'List'=>[]
                    			};
                    			last;
                    		}
                    	}
                    } 
                    # else {
                    #     $stref->{'IncludeFiles'}{$inc}{'InclType'} = 'Local';
                    # }
                }
                $stref->{'IncludeFiles'}{$inc}{'FreeForm'}=$free_form;                
                $stref->{'IncludeFiles'}{$inc}{'FStyle'}=$fstyle;
            };
            
            # Find use statements, for F90/F95. 
            $line =~/^\s*use\s+([_\w]+)(?:\s*,\s*only\s*:\s*(.+)\s*)?/i && do { #FIXME: no support for R1108 rename ; R1109 is incomplete; no support for R1110, R1111           
                my $mod = lc($1); 
                my $only_list = $2;
                if ($in_module) {
                    $stref->{'Modules'}{$mod_name}{'Uses'}{$mod}={};
                } else { # must be a bare sub or a program
                    $stref->{'Subroutines'}{$sub_name}{'Uses'}{$mod}={};
                }
                if ( not exists $stref->{'Modules'}{$mod} ) {
                    $stref->{'Modules'}{$mod}{'Status'} = $UNREAD;                                        
                }
            };
            
            $line =~/::/ && do {
                if ($in_module) {
                    if ($line =~ /parameter/ ) {
                        $stref->{'Modules'}{$mod_name}{'Parameters'}={};
                    } else {
                        $stref->{'Modules'}{$mod_name}{'TypeDecls'}={};
                    }
                }
            };
         
            $line =~/implicit\s+(?!none)/i &&  do {
                if ($in_module) {
                    $stref->{'Modules'}{$mod_name}{'ImplicitRules'}={};                    
                }
            };
            
            $line =~/^\s*contains\s*$/i &&  do {
            	
            	$in_contains=1;
            	if (not $in_module) { 
            		$stref->{'Subroutines'}{$container}{'Contains'} =[];
            	} else {
#            		say "MODULE $container CONTAINS";
            		$stref->{'Modules'}{$container}{'Contains'} =[];
            	}
            };
                     
            if ($in_module) {
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
#            print "Module $mod_name is INLINEABLE\n";# if $V;
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


sub _add_path_to_includes { (my $stref) =@_; 
	my $prefix = $stref->{'Prefix'};
	
	for my $entry ( keys %{$stref->{'SourceFiles'} } ) {
		
		next if $entry=~/\//;
		for my $srcdir (@{ $stref->{'SourceDirs'} } ) {
			my $inclpath="$srcdir/$entry";
			if ($prefix ne '') {
				$inclpath="$prefix/$inclpath";
			}
			if (exists $stref->{'SourceFiles'}{$inclpath}) {
		say " $entry => $inclpath" if $V;		
				my $new_record = { %{ $stref->{'SourceFiles'}{$entry} }, %{ $stref->{'SourceFiles'}{$inclpath} } };
				delete $stref->{'SourceFiles'}{$entry};
				$stref->{'SourceFiles'}{$inclpath} = $new_record;
#				croak Dumper($stref->{'SourceFiles'}{$entry}).Dumper($stref->{'SourceFiles'}{$inclpath})."\n".Dumper($new_record);;
			}
		}
	}
	return $stref;
}

sub _find_external_modules { (my $stref) =@_; 
	my $prefix = $stref->{'Prefix'};
	
	for my $mod ( keys %{$stref->{'Modules'} } ) {
	                if ( $stref->{'Modules'}{$mod}{'Status'} == $UNREAD ) {
	                	say "MODULE $mod is EXTERNAL" if $V;
						$stref->{'Modules'}{$mod}{'ModType'} = 'External';                		
	                } else {
	                	$stref->{'Modules'}{$mod}{'ModType'} = 'Local';
	                }                                        
                }
                         
	return $stref;
}

1;
