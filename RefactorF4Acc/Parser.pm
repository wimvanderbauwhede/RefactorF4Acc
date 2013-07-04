package RefactorF4Acc::Parser;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallGraph qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common
  qw( format_f95_var_decl format_f77_var_decl );
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::CTranslation qw( add_to_C_build_sources );

#
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Parser::ISA = qw(Exporter);

@RefactorF4Acc::Parser::EXPORT_OK = qw(
  &parse_fortran_src
  &_parse_vardecl
);

# -----------------------------------------------------------------------------
# parse_fortran_src() only parses the source to build the call tree, nothing else
# We don't need to parse the includes nor the functions at this stage.
# All that should happen in a separate pass. But we do it here anyway
sub parse_fortran_src {
	( my $f, my $stref ) = @_;
#    local $V=1;	
	print "parse_fortran_src(): PARSING $f\n " if $V;
	
	# 1. Read the source and do some minimal processsing
	$stref = read_fortran_src( $f, $stref );#
	print "DONE read_fortran_src( $f )\n" if $V;
	
	my $sub_or_func = sub_func_or_incl( $f, $stref );
	print "SRC TYPE: $sub_or_func\n" if $V;
	if ($sub_or_func ne 'ExternalSubroutines') {
	my $Sf          = $stref->{$sub_or_func}{$f};
	my $is_incl     = exists $stref->{'IncludeFiles'}{$f} ? 1 : 0;

# Set 'RefactorGlobals' to 0, we only refactor the globals for subs that are kernel targets and their dependencies
	if ( not exists $Sf->{'RefactorGlobals'} ) {
		$Sf->{'RefactorGlobals'} = 0;
	} 
	if ($refactor_toplevel_globals==1) { # and $f ne $stref->{'Top'}) {
		$Sf->{'RefactorGlobals'} = 1;
	}
    
# 2. Parse the type declarations in the source, create a per-target table Vars and a per-line VarDecl list and other context-free stuff
print "ANALYSE LINES of $f\n" if $V;
	$stref = _analyse_lines( $f, $stref );
	print "DONE _analyse_lines( $f )\n" if $V;
	

	# 3. Parse includes
	$stref = _parse_includes( $f, $stref );
	if ( not $is_incl ) {
		if ( $stref->{$sub_or_func}{$f}{'HasBlocks'} == 1 ) {					
			$stref = _separate_blocks( $f, $stref );
		}
        # Recursive descent via subroutine calls
		$stref = _parse_subroutine_and_function_calls( $f, $stref );
		$stref->{$sub_or_func}{$f}{'Status'} = $PARSED;
		print "DONE PARSING $sub_or_func $f\n" if $V;		
	} else {    # includes

# 4. For includes, parse common blocks and parameters, create $stref->{'Commons'}
		$stref = _get_commons_params_from_includes( $f, $stref );
		$stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;
	}

#	if ( $f eq 'includecom' ) {

		#    $Data::Dumper::Indent=1;
		#    warn "END of parse_fortran_src( $f )\n-------\n";
		#    warn Dumper($stref->{'Subroutines'}{$f}{'AnnLines'} );
		#    warn "-------\n";
#		die;
#	}
}
	#    $stref=create_annotated_lines($stref,$f);
	print "LEAVING parse_fortran_src( $f ) with Status $stref->{$sub_or_func}{$f}{'Status'}\n" if $V; 
	return $stref;
}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------

# Create a table of all variables declared in the target, and a list of all the var names occuring on each line.
# We record the type of the var and whether it's a scalar or array, because we need that information for translation to C.
# Also check if the variable happens to be a function. If that is the case, mark that function as 'Called'; if we have not yet parsed its source, do it now.

# In order to get proper hooks for the ex-globals, I think we need to check signatures, includes and variable declarations here.
sub _analyse_lines {
	( my $f, my $stref ) = @_;
	my $sub_func_incl = sub_func_or_incl( $f, $stref );
	my $Sf            = $stref->{$sub_func_incl}{$f};
	$Sf->{ExGlobVarDeclHook}=0;
	my $srcref        = $Sf->{'AnnLines'};
	if ( defined $srcref ) {
		print "\nVAR DECLS in $f:\n" if $V;
		my %vars       = ();
		my $first      = 1;
		my $is_vardecl = 0;
		my $type       = 'NONE';
		my $varlst     = '';
		my $indent     = '';
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $attr = '';
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s+/ ) {
				next;
			}
            if (exists $info->{'Includes'} or
               exists $info->{'FunctionSig'} or
               exists $info->{'SubroutineSig'}
               ) {               	
               	$info->{'ExGlobVarDecls'} = ++$Sf->{'ExGlobVarDeclHook'};
#               	print "_analyse_lines($f)\t",$line,"\tEX:",$info->{'ExGlobVarDecls'},"\n";               	 
		    }
            
	   # FIXME Trailing comments are ignored!
	   #            if ( $line =~ /^\!\s/ ) {
	   #                $stref->{$sub_func_incl}{$f}{'Info'}
	   #                  ->[$index]{'TrailingComments'} = {};
	   #                next;
	   #            }

			if ( $line =~ /implicit\s+none/ ) {
				$info->{'ImplicitNone'} = 1;
				$Sf->{'ImplicitNone'}   = $index;
			} elsif ( $line =~ /implicit\s+/ ) {
                $info->{'Implicit'} = 1;
                $stref = _parse_implicit($line,$f,$stref);
#                warn	Dumper($stref ->{'Implicits'}{$f});			
			} elsif ( $line =~ /^\d*\s+(else\s+if)/ ) {
				$info->{'ElseIf'} = 1;
				
			} elsif ( $line =~
/^\d*\s+(if|else|select|case|read|write|print|open|close|return|stop)\s*\(/
			  )
			{				
				$info->{ ucfirst($1) } = 1;
			} elsif ( $line =~ /^\d*\s+do\b/ ) {
				
				$info->{'Do'} = 1;
			} elsif ( $line !~ /\bparameter\b/ && $line =~ /[\w\)]\s*=\s*[^=]/ )
			{				
				$info->{'Assignment'} = 1;
			}

		 # Actual variable declaration line
		 # FIXME: in principle every type can be followed by '*<number>' or *(*)
		 # So we have

			elsif ( $line =~
            /\b(logical|integer|real|double\s*precision|character)\s+([^\*]?.*)\s*$/
				or $line =~
            /\b((?:logical|integer|real|double\s*precision|character)\s*\*(?:\d+|\(\*\)))\s+(.+)\s*$/
			  )
			{
				$type   = $1;
				$varlst = $2;
				# Now an ad hoc fix for spaces between the type and the asterisk. FIXME! I should just write a better FSM!
				if ($line=~/\w+\s+(\*\s*(\d+|\(\s*\*\s*\)))/) { # FIXME: I assume after the asterisk there MUST be an integer constant
				    my $len=$1;
					$type.=$len;
					$varlst=~s/^\S+\s+//;
					
				}  
				
				$type =~ /\*/ && do { 
					( $type, $attr ) = split( /\*/, $type );
					if ( $attr eq '(' ) { $attr = '*' }
				};
				$indent = $line;
				$indent =~ s/\S.*$//;
				$is_vardecl = 1;
#			if ($line=~/character/) {die "<$line>\nTYPE:$type\nATTR:$attr\nVARLST:$varlst";}	 
				
				
			} elsif ( $line =~ /^\s*(.*)\s*::\s*(.*?)\s*$/ )
			{    #F95 declaration, no need for refactoring

				$type   = $1;
				$varlst = $2;
				$indent = $line;
				$indent =~ s/\S.*$//;

			 # But this could be a parameter declaration, with an assignment ...
#               if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+)\s*=\s*(.+?)\s*$/ )
                if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ )
				{    # F95-style parameters

					my $parliststr = $1;										
					my @partups    = split( /\s*,\s*/, $parliststr );
					my %pvars      =
					  map { split( /\s*=\s*/, $_ ) }
					  @partups;    # Perl::Critic, EYHO
					if ( not exists $Sf->{'Parameters'} ) {
						$Sf->{'Parameters'} = {};
					}
					my $pars = [];
					my @pvarl = map { s/\s*=.+//; $_ } @partups;
					for my $var (@pvarl) {
						if ( not defined $vars{$var} ) {
							print
"WARNING: PARAMETER $var not declared in $f (F95-style)\n"
							  if $W;
						} else {
							$Sf->{'Parameters'}{$var} = {
								'Type' => $type,
								'Var'  => $vars{$var},
								'Val'  => $pvars{$var}
							};
							push @{$pars}, $var;
						}
					}
					$info->{'Parameter'} = $pars;
					if ( not exists $Sf->{'Parameters'}{'OrderedList'} ) {
						$Sf->{'Parameters'}{'OrderedList'} = [];
					}
					@{ $Sf->{'Parameters'}{'OrderedList'} } =
					  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @{$pars} );
				}
				$is_vardecl = 1;
			} elsif ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ )
			{    # F77-style parameters
				my $parliststr = $1;
				$indent = $line;
				$indent =~ s/\S.*$//;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my $pars = [];
				for my $var (@pvarl) {

					if ( not defined $vars{$var} ) {
						
						if (exists $pvars{$var}) {
							
                          my $val=$pvars{$var};
                          if ($val=~/[0-9eE\.\+\-]/) {
                          	my $type='Unknown';
                          if ($val=~/\./ or $val=~/e/i or $val=~/\//) {
                          	$type = 'real'; # FIXME: could be double!
                          } else {
                          	$type = 'integer';
                          }
                            $Sf->{'Parameters'}{$var} = {
                            'Type' => $type,
                            'Var'  => $var,
                            'Val'  => $val                            
                            };
                           print "INFO: PARAMETER $var infered type: $type $var = $val\n" if $I; 
                            push @{$pars}, $var;
                          
                          } else {
                          	print "WARNING: PARAMETER $var not declared in $f; can't infer type:\n" if $W;
                          	print "WARNING: PARAMETER $var has NON_NUMERIC val $pvars{$var} in $f  (Parser::_analyse_lines)\n"
                          if $W;
                          }
						}  
					} else {
						$Sf->{'Parameters'}{$var} = {
							'Type' => 'Unknown',
							'Var'  => $vars{$var},
							'Val'  => $pvars{$var}
						};
						push @{$pars}, $var;
					}
				}
				$info->{'Parameter'} = $pars;
				if ( not exists $Sf->{'Parameters'}{'OrderedList'} ) {
					$Sf->{'Parameters'}{'OrderedList'} = [];
				}
				@{ $Sf->{'Parameters'}{'OrderedList'} } =
				  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @{$pars} );
			}    # match var decls, parameter statements F77/F95

			if ($is_vardecl) {
				$is_vardecl = 0;

				#				my $tvarlst = $varlst;
				my $T =
				  0;  #($f eq 'particles_main_loop' && $varlst=~/drydep/) ? 1:0;
				my $pvars = _parse_vardecl( $varlst, $T );
#				die Dumper(sort keys %{$pvars}) if $line=~/character/;

				#                if ($f eq 'read_ncwrfout_1realfield') {
				#	               print Dumper($pvars);
				#                }
				my @varnames = ();
				for my $var ( keys %{$pvars} ) {
					if ( $var eq '' ) { croak "<$line> in $f" }
					my $tvar = $var;
					$vars{$tvar}{'Type'}  = $type;
					$vars{$tvar}{'Shape'} = $pvars->{$var}{'Shape'};
					$vars{$tvar}{'Kind'}  = $pvars->{$var}{'Kind'};
					if ( not exists $pvars->{$var}{'Attr'} ) {
						if ($attr) {
							if ( $type =~ /character/ ) {
								$vars{$tvar}{'Attr'} = '(len=' . $attr . ')';
							} else {
								$vars{$tvar}{'Attr'} = '(kind=' . $attr . ')';
							}
						} else {
							$vars{$tvar}{'Attr'} = '';
						}
					} else {
						if ( $type =~ /character/ ) {
							$vars{$tvar}{'Attr'} =
							  '(len=' . $pvars->{$var}{'Attr'} . ')';
						} else {
							$vars{$tvar}{'Attr'} =
							  '(kind=' . $pvars->{$var}{'Attr'} . ')';
						}
					}

					# Take IODir from INTENT
					if ( $type =~ /\bintent\s*\(\s*(\w+)\s*\)/ ) {
						my $iodir = $1;
						$iodir = ucfirst($iodir);
						if ( $iodir eq 'Inout' ) {
							$iodir = 'InOut';
						}
						$vars{$tvar}{'IODir'} = $iodir;
					}

					#                    $var =~ s/;/,/g;
					$vars{$tvar}{'Decl'} = "        $type $var";

					# TODO: this should maybe not be a textual representation
					# make it [$type,$var] ?
					$vars{$tvar}{'Indent'} = $indent;

					if ( exists $stref->{'Functions'}{$tvar} and $tvar ne $f) { # FIXME: NO RECURSION!

						$stref->{'Functions'}{$tvar}{'Called'} = 1;
						$stref->{'Functions'}{$tvar}{'Callers'}{$f}++;
						if (
							not
							exists $stref->{'Functions'}{$tvar}{'AnnLines'} )
						{
							$stref = parse_fortran_src( $tvar, $stref );
						}
					}
					push @varnames, $tvar;
				}    # loop over all vars declared on a single line

				print "\tVARS <$line>:\n ", join( ',', sort @varnames ), "\n" if $V;				
				$info->{'VarDecl'} = \@varnames;
				if ($first) {
					$first = 0;
					# FIXME: no use in include files!
					$info->{'ExGlobVarDecls'} = ++$Sf->{ExGlobVarDeclHook};# {};
#					print "_analyse_lines($f): VAR DECL\t",$line,"\tEX:",$info->{'ExGlobVarDecls'},"\n";
				}				
			}
			$srcref->[$index] = [ $line, $info ];
		}    # Loop over lines
		$stref->{$sub_func_incl}{$f}{'Vars'} = \%vars;
	}
	#           die "FIXME: shapes not correct!";
	return $stref;
}    # END of _analyse_lines()

# -----------------------------------------------------------------------------
# For every 'include' statement in a subroutine
# the filename is entered in 'Includes' and in Info->[$index]{'Include'}
# If the include was not yet read, do it now.
sub _parse_includes {
	( my $f, my $stref ) = @_;
#	local $V=1;
	
	my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
    print "PARSING INCLUDES for $f ($sub_or_func_or_inc)\n" if $V;
	my $srcref       = $Sf->{'AnnLines'};
	my $last_inc_idx = 0;
	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];
		if ( $line =~ /^\!\s/ ) {
			next;
		}

		if ( $line =~ /^\s*include\s+\'([\w\.]+)\'/ ) {
			my $name = $1;
			print "FOUND include $name in $f\n" if $V;
			$Sf->{'Includes'}{$name} = $index;
			 
			if (
			 exists $Sf->{'Translate'} 
            and exists $stref->{'IncludeFiles'}{$name}
			and not exists $stref->{'IncludeFiles'}{$name}{'Translate'}
			) {
			     $stref->{'IncludeFiles'}{$name}{'Translate'} = $Sf->{'Translate'};
			     if( $Sf->{'Translate'} eq 'C') {
                    $stref = add_to_C_build_sources( $name, $stref );
                } else {
                    croak '!$acc translate ('.$f.') '.$Sf->{'Translate'}.": Only C translation through F2C_ACC is currently supported.\n";
                }
			}
			$last_inc_idx = $index;

			#            $Sf->{'Info'}->[$index]{'Include'}{'Name'} = $name;
			$info->{'Include'} = {};
			$info->{'Include'}{'Name'} = $name;
#			$info->{'ExGlobVarDecls'} = ++$Sf->{ExGlobVarDeclHook};
#			print "parse_includes($f)\t",$line,"\tEX:",$info->{'ExGlobVarDecls'},"\n";
			if ( $stref->{'IncludeFiles'}{$name}{'Status'} == $UNREAD ) {
				print $line, "\n" if $V;

				# Initial guess for Root. OK? FIXME?
				$stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
				$stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
				$stref = parse_fortran_src( $name, $stref );
			} else {
				print $line, " already processed\n" if $V;
			}
			if (exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$name}) {
				print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;
				if (not exists $stref->{'Implicits'}{$f}) {
					$stref->{'Implicits'}{$f}=$stref->{'Implicits'}{$name};
				} else {
					for my $k (keys %{ $stref->{'Implicits'}{$name} }) {
						if (not exists $stref->{'Implicits'}{$f}{$k}) {
						  $stref->{'Implicits'}{$f}{$k}=$stref->{'Implicits'}{$name}{$k};
						} else {
							die "ERROR: $f and $name have different type for $k";
						}
					}					
				}
			}
		}
		$srcref->[$index] = [ $line, $info ];
	}

	# tag the next line after the last include
	
	$last_inc_idx++;
#	while ($srcref->[$last_inc_idx][0] =~/^\s*$/) {
#		$last_inc_idx++;
#	}
	$srcref->[$last_inc_idx][1]{'ExtraIncludesHook'} = 1;
#	print '<'.$srcref->[$last_inc_idx][0].">\n";
#	print '<'.Dumper($srcref->[$last_inc_idx][1]).">\n";
#	die if $f eq 'timemanager';
	return $stref;
}    # END of parse_includes()

# -----------------------------------------------------------------------------

sub OBSOLETE_detect_blocks {
	( my $stref, my $s ) = @_;
	print "CHECKING BLOCKS in $s\n" if $V;
	my $sub_func_incl = sub_func_or_incl( $s, $stref );
	die "$sub_func_incl $s ".$stref->{$sub_func_incl}{$s}{'HasBlocks'}  if $s eq 'timemanager';
	$stref->{$sub_func_incl}{$s}{'HasBlocks'} = 0;
	my $srcref = $stref->{$sub_func_incl}{$s}{'AnnLines'};
	for my $annline ( @{$srcref} ) {
		my $line = $annline->[0];
		if ( $line =~ /^\!\s/ ) {

# I'd like to use the OpenACC compliant pragma !$acc kernels , !$acc end kernels
# but OpenACC does not allow to provide a name
# so I propose my own tag: !$acc subroutine name, !$acc end subroutine
			if (   $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
				or $line =~ /^\!\s*\$acc\ssubroutine\s(\w+)/i )
			{
				$stref->{$sub_func_incl}{$s}{'HasBlocks'} = 1;
				my $tgt = uc( substr( $sub_func_incl, 0, 3 ) );
				print "$tgt $s HAS BLOCK: $1\n" if $V;
				last;
			}
		}
	}

	return $stref;
}    # END of detect_blocks()

# -----------------------------------------------------------------------------

=pod

=begin markdown

### Factoring out code blocks into subroutines



=end markdown

=cut

sub _separate_blocks {
	( my $f, my $stref ) = @_;

#    die "separate_blocks(): FIXME: we need to add in the locals from the parent subroutine as locals in the new subroutine!";
	my $sub_or_func = sub_func_or_incl( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};
	my $srcref      = $Sf->{'AnnLines'};

	# All local variables in the parent subroutine
	my %vars = %{ $Sf->{'Vars'} };
	$Data::Dumper::Indent = 2;

	#warn "USING VARS FROM PARENT $f HERE!\n";
	#warn Dumper($Sf->{'Vars'}{'drydeposit'});
	# Occurence
	my %occs = ();

	# A map of every block in the parent
	my %blocks   = ();
	my $in_block = 0;

	# Initial settings
	my $block = 'OUTER';
	$blocks{'OUTER'} = { 'AnnLines' => [] };

	#   my $block_idx = 0;

# 1. Process every line in $f, scan for blocks marked with pragmas.
# What this does is to separate the code into blocks (%blocks) and keep track of the line numbers
# The lines with the pragmas occur both in OUTER and the block

	#TODO: replace by sub
	#    (my $stref, my $blocksref) = separate_into_blocks($stref,$f);

	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];
		
		if (   $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
			or $line =~ /^\!\s*\$acc\s+subroutine\s(\w+)/i )
		{
			$in_block = 1;
			$block    = $1;
			print "FOUND BLOCK $block\n" if $V;

#            # Enter the name of the block in the metadata for the line
#            $Sf->{'Info'}[$index]{'RefactoredSubroutineCall'}{'Name'} = $block;
#            $Sf->{'Info'}[$index]{'SubroutineCall'}{'Name'} = $block;
#            delete $Sf->{'Info'}[$index]{'Comments'};
#            $Sf->{'Info'}[$index]{'BeginBlock'}{'Name'} = $block;

			# Enter the name of the block in the metadata for the line
			$info->{'RefactoredSubroutineCall'}{'Name'} = $block;
			$info->{'SubroutineCall'}{'Name'}           = $block;
			delete $info->{'Comments'};
			$info->{'BeginBlock'}{'Name'} = $block;

			# Push the line with the pragma onto the list of 'OUTER' lines
			push @{ $blocks{'OUTER'}{'AnnLines'} },
			  [ "! *** Refactored code into $block ***", {} ];

		   # Push the line with the pragma onto the list of lines for the block,
		   # to be replaced by function signature
			push @{ $blocks{$block}{'AnnLines'} },
			  [
				"! *** Original code from $f starts here ***",
				{ 'RefactoredSubroutineCall' => { 'Name' => $block } }
			  ];

		  #            # Add the name and index to %blocks
		  #            push @{ $blocks{$block}{'Info'} },
		  #              { 'RefactoredSubroutineCall' => { 'Name' => $block } };
			$blocks{$block}{'BeginBlockIdx'} = $index;
			next;
		}
		if (   $line =~ /^\!\s+END\sSUBROUTINE\s(\w+)/
			or $line =~ /^\!\s*\$acc\s+end\ssubroutine\s(\w+)/i )
		{
			$in_block = 0;
			$block    = $1;

			# Push end-of-block pragma onto 'OUTER'
			push @{ $blocks{'OUTER'}{'AnnLines'} }, [ $line, {} ];

			# Push 'end' onto the list of lines for the block,
			push @{ $blocks{$block}{'AnnLines'} }, [ '      end', $info ];

		  # Add info to %blocks.
		  #            push @{ $blocks{$block}{'Info'} }, $Sf->{'Info'}[$index];
		  #            $Sf->{'Info'}[$index]{'EndBlock'}{'Name'} = $block;
			$info->{'EndBlock'}{'Name'} = $block;
			$blocks{$block}{'EndBlockIdx'} = $index;
			next;
		}
		if ($in_block) {

			# Push the line onto the list of lines for the block
			push @{ $blocks{$block}{'AnnLines'} }, [ $line, $info ];

			# and the index onto Info in %blocks and $Sf
			#            push @{ $blocks{$block}{'Info'} }, $info;
			$info->{'InBlock'}{'Name'} = $block;
		} else {

			# Other lines go onto 'OUTER'
			push @{ $blocks{'OUTER'}{'AnnLines'} }, [ $line, $info ];
		}
		$srcref->[$index] = [ $line, $info ];
	}    # loop over annlines

# 2. For all non-OUTER blocks, create an entry for the new subroutine in 'Subroutines'
# Based on the content of %blocks
# TODO: $stref=create_new_subroutine_entries($blocksref,$stref)
	for my $block ( keys %blocks ) {
		die "EMPTY block name $block" if $block eq '';
		next if $block eq 'OUTER';
		if (not exists $stref->{'Subroutines'}{$block} ) {
		  $stref->{'Subroutines'}{$block} = {};
		  $stref->{'Subroutines'}{$block}{'Source'} = $Sf->{'Source'};
		} elsif (exists $stref->{'Subroutines'}{$block}{'Translate'} ) {
			if( $stref->{'Subroutines'}{$block}{'Translate'} eq 'C') {
				$stref->{'Subroutines'}{$block}{'Source'} = "./$block.f95";
                 $stref = add_to_C_build_sources( $block, $stref );
            } else {
                croak '!$acc translate ('.$block.') '.$stref->{'Subroutines'}{$block}{'Translate'}.": Only C translation through F2C_ACC is currently supported.\n";
            }
		}
		my $Sblock = $stref->{'Subroutines'}{$block};
		$Sblock->{'AnnLines'} = $blocks{$block}{'AnnLines'};
#if (exists $Sblock->{'Translate'} ) {die $block;}
		#        $Sblock->{'Info'}  = $blocks{$block}{'Info'};
#		$Sblock->{'Source'}          = $Sf->{'Source'};
		$stref->{'SourceContains'}{$Sf->{'Source'}}{$block} = 'Subroutines';
		$Sblock->{'RefactorGlobals'} = 1;
		if ( $Sf->{'RefactorGlobals'} == 0 ) {
			$Sf->{'RefactorGlobals'} = 2;
		} else {
			die 'BOOM!';
		}
	}

# 3. Identify which vars are used
#   - in both => these become function arguments
#   - only in "outer" => do nothing for those
#   - only in "inner" => can be removed from outer variable declarations
#
# Find all vars used in each block, starting with the outer block
# It is best to loop over all vars per line per block, because we can remove the encountered vars
# TODO: my $occsref = determine_new_subroutine_arguments($blocksref,$varsref,$linesref);

	for my $block ( keys %blocks ) {

		my @annlines = @{ $blocks{$block}{'AnnLines'} };
		my %tvars = %vars;    # Hurray for pass-by-value!
		print "\nVARS in $block:\n\n" if $V;
		for my $annline (@annlines) {
			my $tline = $annline->[0];
			$tline =~ s/\'.+?\'//;
			for my $var ( sort keys %tvars ) {
				if ( $tline =~ /\b$var\b/ ) {    # or $tline =~ /\W$var\s*$/ ) {
					print "FOUND $var\n" if $V;
					$occs{$block}{$var} = $var;
					delete $tvars{$var};
				}
			}
		}
	}

	# 4. Construct the subroutine signatures
	# TODO: $stref = construct_new_subroutine_signatures();
	# TODO: see if this can be separated into shorter subs
	#	local $V=1;
	my %args = ();
	for my $block ( keys %blocks ) {
		next if $block eq 'OUTER';
		my $Sblock = $stref->{'Subroutines'}{$block};
		print "\nARGS for BLOCK $block:\n" if $V;

		# Collect args for new subroutine
		for my $var ( sort keys %{ $occs{$block} } ) {
			if ( exists $occs{'OUTER'}{$var} ) {
				print "$var\n" if $V;
				push @{ $args{$block} }, $var;
			}
			$Sblock->{'Vars'}{$var} =
			  $vars{$var
			  }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
		}
		$Sblock->{'Args'}{'List'} = $args{$block};

		# Create Signature and corresponding Decls
		my $sixspaces = ' ' x 6;
		my $sig       = $sixspaces . 'subroutine ' . $block . '(';
#		my $decls     = [];
		for my $argv ( @{ $args{$block} } ) {
			$sig .= "$argv,";
			my $decl =
			  ( $Sf->{'FStyle'} eq 'F77' )
			  ? format_f77_var_decl( $Sf, $argv )
			  : format_f95_var_decl( $Sf, $argv );

#			if ($f eq 'timemanager' && $block eq 'particles_main_loop' && $decl=~/drydeposit/) {
#				print "DECL: $decl\n";
#				print "VARS: ".Dumper( $Sf->{'Vars'}{$argv});
#			}
#			push @{$decls}, $sixspaces . $decl;    # Why do we need this anyway?
			$Sf->{'Vars'}{$argv}{'Decl'} = $sixspaces . $decl;
		}
		$sig =~ s/\,$/)/s;
		$Sblock->{'Sig'}   = $sig;
#		$Sblock->{'Decls'} = $decls;

		# Add variable declarations and info to line
		my $sigline = shift @{ $Sblock->{'AnnLines'} };
		for my $argv ( @{ $args{$block} } ) {
			my $decl = $Sf->{'Vars'}{$argv}{'Decl'};
			unshift @{ $Sblock->{'AnnLines'} },
			  [ $decl, { 'VarDecl' => [$argv] } ];
		}
		unshift @{ $Sblock->{'AnnLines'} }, $sigline;

	 # Now also add include statements and the actual sig to the line
	 #        croak Dumper($Sblock->{'AnnLines'});
	 #        my $fl = shift @{ $Sblock->{'Info'} }; # remove comment, keep line
		my $fal = $Sblock->{'AnnLines'}[0][1];    # remove comment, keep line
		$Sblock->{'AnnLines'}[0][1] = {};
		for my $inc ( keys %{ $Sf->{'Includes'} } ) {
			$Sblock->{'Includes'}{$inc} = 1;
			unshift @{ $Sblock->{'AnnLines'} },
			  [ "      include '$inc'", { 'Include' => { 'Name' => $inc } } ]
			  ;                                   # add new lines at the front

#            unshift @{ $Sblock->{'Info'} }, { 'Include' => { 'Name' => $inc } };
			$Sblock->{'Includes'}{$inc} = 1;
		}
		unshift @{ $Sblock->{'AnnLines'} },
		  [ $sig, {} ];                           # add a line but not a comment
		  # And finally, in the original source, replace the blocks by calls to the new subs

		#        print "\n-----\n".Dumper($srcref)."\n-----";
		for my $tindex ( 0 .. scalar( @{$srcref} ) - 1 ) {
			if ( $tindex == $blocks{$block}{'BeginBlockIdx'} ) {
				$sig =~ s/subroutine/call/;
				$srcref->[$tindex][0] = $sig;
			} elsif ( $tindex > $blocks{$block}{'BeginBlockIdx'}
				and $tindex <= $blocks{$block}{'EndBlockIdx'} )
			{
				$srcref->[$tindex][0] = '';
				$srcref->[$tindex][1]{'Deleted'} = 1;
			}
		}

#        unshift @{ $Sblock->{'Info'} }, $fl; # put the comment back at the front, no change to the lines
		$Sblock->{'AnnLines'}[0][1] = $fal;

		#print "YES! GENERATED DECLS ARE WRONG!!!\n";
		if ($V) {
			print $sig, "\n";
#			print join( "\n", @{$decls} ), "\n";
		}
		$Sblock->{'Status'} = $READ;

	}

#	warn "Vars are CORRECT AT END OF separate_blocks( $f ):\n-----\n";
#	warn Dumper($stref->{'Subroutines'}{'particles_main_loop'}{'Vars'}{'drydeposit'});
#	warn "-----\n";
#	croak "BOOM!" if $f eq 'timemanager';

	return $stref;
}    # END of separate_blocks()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

sub _parse_subroutine_and_function_calls {
	( my $f, my $stref ) = @_;
	print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;
	my $pnid        = $stref->{'NId'};
	my $sub_or_func = sub_func_or_incl( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};

	# For C translation and call tree generation
	# TODO: $translate is obsolete! 
	if ( $translate == $GO
		|| ( $call_tree_only && ( $gen_sub || $main_tree ) ) )
	{

		if ( $translate == $GO ) {
			$stref = add_to_C_build_sources( $f, $stref );
		}
	}
	if (exists $Sf->{'Translate'} ) {		
		if( $Sf->{'Translate'} eq 'C') {
			     $stref = add_to_C_build_sources( $f, $stref );
		} else {
			croak '!$acc translate ('.$f.') '.$Sf->{'Translate'}.": Only C translation through F2C_ACC is currently supported.\n";
		}
	}
	my $srcref = $Sf->{'AnnLines'};

	#   croak Dumper( $srcref) if $f=~/timemanager/;
	if ( defined $srcref ) {

		#        my %called_subs         = ();
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			next if $line =~ /^\!\s/;

	  # Subroutine calls. Surprisingly, these even occur in functions! *shudder*
            if ( $line =~ /call\s+(\w+)\s*\((.*)\)/ || $line =~ /call\s+(\w+)\s*$/ ) # WV23JUL2012
#			if ( $line =~ /call\s(\w+)\((.*)\)/ || $line =~ /call\s(\w+)\s*$/ )            
			{
#				die if $line=~/advance/;
				my $name = $1;
				$stref = add_to_call_tree( $name, $stref, $f );
				my $Sname = $stref->{'Subroutines'}{$name};
                if ( exists $Sf->{'Translate'}
                and not exists $Sname->{'Translate'}
                 ) {
                	$Sname->{'Translate'} = $Sf->{'Translate'}  
                }
				$stref->{'NId'}++;
				my $nid = $stref->{'NId'};
				push @{ $stref->{'Nodes'}{$pnid}{'Children'} }, $nid;
				$stref->{'Nodes'}{$nid} = {
					'Parent'     => $pnid,
					'Children'   => [],
					'Subroutine' => $name
				};

				my $argstr = $2 || '';
				if ( $argstr =~ /^\s*$/ ) {
					$argstr = '';
				}

				$Sname->{'Called'} = 1;
				$Sname->{'Callers'}{$f}++;

#               if ($Sf->{'RefactorGlobals'} == 2) {
#               warn "NAME: $f => $name,".(exists $Sname->{'RefactorGlobals'}? $Sname->{'RefactorGlobals'} : 'UNDEF')."\n" if $f eq 'timemanager';
#               }
				if ( $Sf->{'RefactorGlobals'} == 1 ) {
					print "SUB $name NEEDS GLOBALS REFACTORING\n" if $V;
					$Sname->{'RefactorGlobals'} = 1;
				}

				#                $called_subs{$name} = $name;
#				$info->{'SubroutineCall'}{'Args'} = $argstr;
				my $tvarlst = $argstr;

				# replace , by ; in array indices and nested function calls FIXME: UGLY! USE PROPER FSM!
				if ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
					while ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
						my $chunk  = $1;
						my $chunkr = $chunk;
						$chunkr =~ s/,/;/g;
						my $pos = index( $tvarlst, $chunk );
						substr( $tvarlst, $pos, length($chunk), $chunkr );
					}
				}

				my @tvars = split( /\s*\,\s*/, $tvarlst );

				my @argvars = ();
				for my $var (@tvars) {
					$var =~ s/^\s+//;
					$var =~ s/\s+$//;
					$var =~ s/;/,/g;
					push @argvars, $var;
				}

				$info->{'SubroutineCall'}{'Args'}{'List'} = \@argvars;
				$info->{'SubroutineCall'}{'Args'}{'Set'} = { map {$_ => 1} @argvars };
				$info->{'SubroutineCall'}{'Name'} = $name;

				if ( defined $Sname
					and not exists $Sf->{'CalledSubs'}{$name} )
				{
					$Sf->{'CalledSubs'}{$name} = 1;
					if (   not exists $Sname->{'Status'}
						or $Sname->{'Status'} < $PARSED
						or $gen_sub )
					{
						print "\tFOUND SUBROUTINE CALL $name in $f\n" if $V;
						$stref = parse_fortran_src( $name, $stref );
					}
				}
			}

			# Maybe Function calls
			if (   $line !~ /function\s/
				&& $line !~ /subroutine\s/
				&& $line =~ /(\w+)\(/ )
			{
				my @chunks = ();
				my $cline  = $line;
				while ( $cline =~ /(\w+)\(/ ) {
					if ( $line !~ /call\s+$1/ ) {
						push @chunks, $1;
						$cline =~ s/$1\(//;
					} else {
						$cline =~ s/call\s+\w+\(//;
					}
				}
				for my $chunk (@chunks) {
					if (
						exists $stref->{'Functions'}{$chunk}

					   # This means it's the first call to function $chunk in $f
						and not exists $Sf->{'CalledFunctions'}{$chunk}
					  )
					{
						$Sf->{'CalledFunctions'}{$chunk} = 1;
						print "FOUND FUNCTION CALL $chunk in $f\n" if $V;
						if ( $chunk eq $f ) {							
							show($srcref); 
							die $line 
						}
						$stref->{'Functions'}{$chunk}{'Called'} = 1;

# We need to parse the function to detect called functions inside it, unless that has been done
						if (   not exists $stref->{'Functions'}{$chunk}
							or not
							exists $stref->{'Functions'}{$chunk}{'Status'}
							or $stref->{'Functions'}{$chunk}{'Status'} <
							$PARSED )
						{
							$stref = parse_fortran_src( $chunk, $stref );
						} else {
							$stref = add_to_call_tree( $chunk, $stref, $f );
						}
						
                if ( exists $Sf->{'Translate'}
                and not exists $stref->{'Functions'}{$chunk}{'Translate'}
                 ) {
                    $stref->{'Functions'}{$chunk}{'Translate'} = $Sf->{'Translate'};  
                }
						
						
					}
				}
			}

			$srcref->[$index] = [ $line, $info ];
		}    # loop over all annlines

		#        $Sf->{'CalledSubs'}=\%called_subs;
	}
	return $stref;
}    # END of parse_subroutine_and_function_calls()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Identify the include file as containing params or commons.
# If it contains both, split and call the routine again.
sub _get_commons_params_from_includes {
	( my $f, my $stref ) = @_;
	my $Sf     = $stref->{'IncludeFiles'}{$f};
	my $srcref = $Sf->{'AnnLines'};

	if ( defined $srcref ) {

		$Sf->{'Parameters'} = {} unless exists $Sf->{'Parameters'};
		$Sf->{'Parameters'}{'OrderedList'} = [] unless exists $Sf->{'Parameters'}{'OrderedList'};

		my %vars = %{ $stref->{'IncludeFiles'}{$f}{'Vars'} }; 

		if ( exists $vars{''} ) { croak "EMPTY VAR! in $f" }
		my $has_pars    = 0;
		my $has_commons = 0;

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s/ ) {
				next;
			}
            # common /name/ x...
            # However, common/name/x is also valid, damn F77!
			if ( $line =~ /^\s*common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ ) {
				my $common_block_name = $1;
				my $commonlst = $2;
				$has_commons = 1;
				my @tcommons = split( /\s*\,\s*/, $commonlst );
				my $parsedvars = _parse_vardecl($commonlst,0);
#				die Dumper(keys %{$parsedvars}) if $line=~/km/;
				for my $var (keys %{$parsedvars}) {					
					if ( not defined $vars{$var} ) {						
						if (exists $stref->{'Implicits'}{$f}{lc(substr($var,0,1))} ) {
							print "INFO: common <", $var, "> typed via Implicits for $f\n" if $I;
							
							my $type_kind_shape_attr = $stref->{'Implicits'}{$f}{lc(substr($var,0,1))};
							(my $type,my $kind,my $shape, my $attr ) = @{$type_kind_shape_attr };
							my $var_rec = {
							  'Decl' => "        $type $var",
							  'Shape' => $parsedvars->{$var}{'Shape'},
							  'Type' => $type,
							  'Attr' => $attr,
							  'Indent' => '      ',
							  'Kind' => $parsedvars->{$var}{'Kind'}
							};			
							$Sf->{'Commons'}{$var} = $var_rec;		
							$vars{$var}=$var_rec;
									
						} else {
							print "WARNING: common <", $var, "> is not in {'IncludeFiles'}{$f}{'Vars'}\n" if $W;
						}
					} else {
						print $var, "\t", $vars{$var}{'Type'}, "\n"
						  if $V;
#                        die Dumper($vars{$var});
						$stref->{'IncludeFiles'}{$f}{'Commons'}{$var} =
						  $vars{$var};
					}
				}
#				die Dumper($vars{'nou5'}) if $line=~/nou5/;
				$srcref->[$index][1]{'Common'} = {'Name' => $common_block_name };
			}
			
              #  parameter(ip=150,jp=150,kp=90)
			if ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ ) {

				my $parliststr = $1;

#                warn "PARAM:$parliststr\n";
				$has_pars = 1;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) }
				  @partups;    # Perl::Critic, EYHO # s/\s*=.+//; $_

#				warn Dumper(%pvars);
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
#				warn Dumper(@pvarl);
				my @pars = ();
				for my $var (@pvarl) {
					my $type='Unknown';
					if ( not defined $vars{$var} and not exists $Sf->{'Parameters'}{$var}) {
						print "WARNING: PARAMETER $var not declared in $f (Parser::_get_commons_params_from_includes)\n"
						  if $W;
#						  warn "WARNING: PARAMETER $var not declared in $f\n";
					}
						  if ($pvars{$var}=~/^\d*/) {
						  	$type='integer';
						  } elsif ($pvars{$var}=~/^[\d\.]+/) { # FIXME: weak
						  	$type='real';
						  }						  					 
						$Sf->{'Parameters'}{$var} = {
							'Type' => $type,
							'Var'  => $vars{$var},
							'Val'  => $pvars{$var}
						};
						push @pars, $var;
				}
#				warn Dumper(@pars);
				@{ $Sf->{'Parameters'}{'OrderedList'} } =
				  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @pars );

#                warn "PARLIST: ",join(',',@{ $Sf->{'Parameters'}{'OrderedList'} }),"\n";
				$srcref->[$index][1]{'Parameter'} = [@pars];
			} elsif ( $line =~ /,\s*parameter\s*.*?::\s*(\w+)\s*=\s*(.+?)\s*$/ )
			{    # F95-style parameters
				my $type = $line;
				$type =~ s/^\s+//;
				$type =~ s/\s*\:\:.*$//;
				my $parliststr = $1;
				$has_pars = 1;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my @pars  = ();

				for my $var (@pvarl) {
					if ( not defined $vars{$var} ) {
						print
"WARNING: PARAMETER $var not declared in $f (F95-style)\n"
						  if $W;
					} else {
						$Sf->{'Parameters'}{$var} = {
							'Type' => $type,
							'Var'  => $vars{$var},
							'Val'  => $pvars{$var}
						};
						push @pars, $var;
					}
				}
				@{ $Sf->{'Parameters'}{'OrderedList'} } =
				  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @pars );
				$srcref->[$index][1]{'Parameter'} = {};

			}

			$srcref->[$index] = [ $line, $info ];
		}    # loop over annlines

		if ($V) {
			print "\nCOMMONS for $f:\n\n";
			for my $v ( sort keys %{ $Sf->{'Commons'} } ) {
				print $v, "\n";
			}
		}

        $Sf->{'Vars'} = { %vars  }; 
#        die "BOOM!",Dumper( $Sf->{'Vars'} );
		# FIXME!
		# An include file should basically only contain parameters and commons.
		# If it contains commons, we should remove them!
		if ( $has_commons && $has_pars ) {
			print "INFO: The include file $f contains both parameters and commons, attempting to split out params_$f.\n" if $I;
            $Sf->{'InclType'} = 'Both';
            $stref=__split_out_parameters($f,$stref);
            $has_pars=0;
            # What we should do is split this split out parameters into params_$name
            # and include params_$name in $name            

		} elsif ($has_commons) {
			$Sf->{'InclType'} = 'Common';
		} elsif ($has_pars) {
			$Sf->{'InclType'} = 'Parameter';
		} else {
			$Sf->{'InclType'} = 'None';
		}
		# Checking if any variable encountered in the include file is either a Parameter or Common var
		for my $var ( keys %vars ) {
			my $is_not_par = $has_pars && !exists( $Sf->{'Parameters'}{$var} );
			my $is_not_common =  $has_commons && !exists( $Sf->{'Commons'}{$var} ) ; 
			if (
				 $is_not_par or $is_not_common 
			  )
			{
				for my $annline ( @{ $Sf->{'AnnLines'} } ) {
					next
					  if $annline->[0] eq ''
					  or exists $annline->[1]{'Comments'};
					if ( $annline->[0] =~ /\W$var\W/ ) {
						my $info = $is_not_par ? "$f has params but $var is not a param" : "$f has commons but $var is not common"; 
						warn "WARNING: Parser: $info on the following line in $f:\n";
						warn $annline->[0], "\n";
#						die Dumper($Sf->{'Commons'}{$var});
					}
					

				}

				#                warn Dumper( $Sf->{'AnnLines'} );
				print "WARNING: The include $f contains a variable <$var> that is neither a parameter nor a common variable, this is not supported\n" if $W;
			}
		}
	}

#    die "BOOM!",Dumper($stref->{'IncludeFiles'}{$f}{'Vars'}{'km'});
#    croak Dumper($stref->{'IncludeFiles'}{$f}{'Commons'}{'memind'}) if $f eq 'includecom'; #OK here
	return $stref;
}    # END of get_commons_params_from_includes()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Proper FSM parser for F77 variable declarations (apart from the type)
sub _parse_vardecl {
	( my $varlst, my $T ) = @_;

	print "VARLST: <$varlst>\n" if $T;

	# parse varlst into this hash
	my $vars = {};

	#  We need following states:
	my (
		$do_nothing,     # 0
		$read_var,       # 1
		$store_var,      # 2
		$found_len,      # 3
		$read_len,       # 4
		$store_len,      # 5
		$found_shape,    # 6
		$read_shape,     # 7
		$store_shape     # 8
	) = 0 .. 8;

	my @states = qw(
	  do_nothing
	  read_var
	  store_var
	  found_len
	  read_len
	  store_len
	  found_shape
	  read_shape
	  store_shape
	);

	# initial state
	my $st = $do_nothing;

	# inside read_shape, we need a parenthesis counter:
	my $nest_count = 0;

	my $var   = '';
	my $pvar  = '';
	my $shape = '';
	my $len   = '';
	my $pc    = '';

	for my $c ( split( '', $varlst ) ) {

		my $pst = $st;    # previous state, for testing only

#### The transitions are:

		if ( $st == $do_nothing ) {
			if ( $c =~ /[a-z]/ ) { $st = $read_var }
			elsif ( $c eq '*' ) { $st = $read_len; next; }
			elsif ( $c eq '(' ) { $st = $found_shape; $nest_count = 0 }
		} elsif ( $st == $read_var && $c =~ /\W/ ) {
			$st = $store_var;
		} elsif ( $st == $store_var ) {
			if ( $pc eq '*' ) {
				$st = $read_len;
			} elsif ( $pc eq '(' ) {
				$st         = $read_shape;
				$nest_count = 0;
			} elsif ( $c eq '(' ) {
				$st         = $found_shape;
				$nest_count = 0;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $read_len && $c =~ /[\s,]/ ) {
			$st = $store_len;
		} elsif ( $st == $store_len ) {
			if ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $found_len ) {
			$st = $read_len;
		} elsif ( $st == $found_shape ) {
			if ( $c eq ')' ) {
				$st = $store_shape;
			} else {
				$st = $read_shape;
			}
		} elsif ( $st == $read_shape && $nest_count <= 0 && $c eq ')' ) {
			$st = $store_shape;
		} elsif ( $st == $store_shape ) {
			if ( $c eq '*' ) {
				$st = $found_len;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		}
		print
" PC: $pc; C:$c; NC: $nest_count; ST: $states[$st]; PST: $states[$pst]\n"
		  if $T;

##### The actions are:
		if    ( $st == $read_var ) { $var .= $c }
		elsif ( $st == $read_len ) { $len .= $c }

		#    elsif ($st==$found_shape) {$shape.=$c;}
		elsif ( $st == $read_shape ) {
			$shape .= $c;
			if    ( $c eq '(' ) { $nest_count++; }
			elsif ( $c eq ')' ) { $nest_count--; }
		} elsif ( $st == $store_var ) {
			print "VAR:[$var]\n" if $T;
			if ( $var eq '' ) { croak $varlst }
			$vars->{$var}{'Kind'}  = 'Scalar';
			$vars->{$var}{'Shape'} = [];
			$pvar                  = $var;
			$var                   = '';
		} elsif ( $st == $store_len ) {
			print "LEN: {$len}\n" if $T;
			$vars->{$pvar}{'Attr'} = $len;
			$len = '';
		} elsif ( $st == $store_shape ) {
			print "SHAPE: <$shape>\n" if $T;
			$shape =~ s/^\s+//;
			$shape =~ s/\s+$//;
			my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
			my @shape = ();
			for my $range (@ranges) {
				if ( $range =~ /:/ ) {
					push @shape, split( /:/, $range );
				} else {
					push @shape, ( '1', $range );
				}
			}
			$vars->{$pvar}{'Shape'} = [@shape];			
			$vars->{$pvar}{'Kind'}  = 'Array';
			$shape                  = '';
		}
		$pc = $c;

	}
	if ($T) {
		print "VAR: $var\n";
		print "PVAR: $var\n";
		print "SHAPE: $shape\n";
		print "LEN: $len\n";
		print "STATE: $states[$st]\n";
	}
#### Pending actions on end of string

	if ( $st == $read_var && $var ne '' ) {
		$vars->{$var} = { 'Shape' => [], 'Kind' => 'Scalar' };
	} elsif ( $st == $read_len && $pvar ne '' ) {
		$vars->{$pvar}{'Attr'} = $len;
	} elsif ( $st == $read_shape && $pvar ne '' ) {
		$shape =~ s/^\s+//;
		$shape =~ s/\s+$//;
		my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
		my @shape = ();
		for my $range (@ranges) {
			if ( $range =~ /:/ ) {
				push @shape, split( /:/, $range );
			} else {
				push @shape, ( '1', $range );
			}
		}
		$vars->{$pvar}{'Shape'} = [@shape];
		$vars->{$pvar}{'Kind'}  = 'Array';
	}

	return $vars;
} # END of _parse_vardecl()

sub __split_out_parameters {
	   ( my $f, my $stref ) = @_;
    my $Sf     = $stref->{'IncludeFiles'}{$f};
    my $srcref = $Sf->{'AnnLines'};
#    print "__split_out_parameters\n",Dumper(keys %{$Sf});
    my $param_lines=[];    
    my $nsrcref=[];
    my $nindex=0;my $nidx_offset=0;
    push @{ $nsrcref }, ["      include 'params_$f'", {'Include' => {'Name' => "params_$f", 'InclType' => 'Parameter'} }];
    for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
    	$nindex=$index+$nidx_offset;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
#        if ( $line =~ /^\!\s/ ) {
#            next;
#        }
        if (exists $info->{'Parameter'}) {        	
 	          push @{$param_lines}, [$line,{'Parameter'=>[@{$info->{'Parameter'}}]}];
 	          delete $srcref->[$index][1]{'Parameter'};
              $srcref->[$index][1]{'Comment'}=1;
 	          $srcref->[$index][0]='! '.$srcref->[$index][0]
        }
        
#        if (exists $info->{'ExtraIncludesHook'}) {
#            push @{ $nsrcref }, ["      include 'params_$f'", {'Include' => {'Name' => "params_$f", 'InclType' => 'Parameter'} }];                
#        }
        push @{ $nsrcref }, $srcref->[$index];        
    }
#    die Dumper($nsrcref);
#    warn '=' x 80,"\n";
#    die Dumper($param_lines);
    $stref->{'IncludeFiles'}{$f}{'AnnLines'}=$nsrcref;
    $stref->{'IncludeFiles'}{"params_$f"}={};
    $stref->{'IncludeFiles'}{"params_$f"}{'AnnLines'}=$param_lines;
    $stref->{'IncludeFiles'}{"params_$f"}{'InclType'}='Parameter';
    $stref->{'IncludeFiles'}{$f}{'InclType'}='Common';    
    $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'} =  dclone($stref->{'IncludeFiles'}{$f}{'Parameters'} );
    delete $stref->{'IncludeFiles'}{$f}{'Parameters'};
    
#    die Dumper( $stref->{'IncludeFiles'}{"$f"}{'RefactorGlobals'} );
    $stref->{'IncludeFiles'}{"params_$f"}{'Root'}=$f;
    $stref->{'IncludeFiles'}{"params_$f"}{'Source'}='Virtual';#"params_$f";
    $stref->{'IncludeFiles'}{"params_$f"}{'Status'}=$PARSED;
    $stref->{'IncludeFiles'}{"params_$f"}{'RefactorGlobals'}=$NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'HasBlocks'}=$NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'FStyle'}=$stref->{'IncludeFiles'}{$f}{'FStyle'};
    $stref->{'IncludeFiles'}{"params_$f"}{'FreeForm'}=$stref->{'IncludeFiles'}{$f}{'FreeForm'};

#    die Dumper($stref->{'IncludeFiles'}{"params_$f"});
    return $stref;	
} # END of __split_out_parameters

sub _parse_implicit {
	(my $line, my $f, my $stref) =@_;
	# 1. test for compound, bail out
	my $tline=$line;
	while ($tline=~/\(/) {
		$tline=~s/\(.+?\)//;
	}
	if ($tline=~/,/) {
		die "Sorry, no support for combined implicit declarations, please split them over multiple lines -- or better, use proper typing!\n";
	}
	# 2. Get the spec and turn into a regexp
	my $type = 'Unknown';
	my $kind = 'Scalar'; # by default. If it is Array, need the size, so need a shapre
	my $shape = [];
	my $attr='';
	my $patt='.+';
	# IMPLICIT REAL(KIND=8)(d),COMPLEX(8)(z) => this is WEAK!
	if ($line=~/implicit\s+(\w.+)\(.+?\)\((.+?)\)/ ) {
        $type = $1;
        $kind = $2;
        $kind=~s/\s*kind\s*=\s*//i; # strip "kind="
        $shape=['1',$kind]; # FIXME only works for 1-D array 
        $kind= 'Array';
        $patt=$3;
        $patt=~s/,/|/g;
        $patt=~s/(\w\-\w)/[$1]/g;
    } elsif ( $line=~/implicit\s+(\w.+)\((.+?)\)/ ) {
		$type = $1;
		$patt=$2;
		if ($type=~/\*/) {
			($type, $attr) = split(/\*/,$type); # WEAK!
			if ( $attr eq '(' ) { $attr = '(*)' } else {
			$attr="(kind=$attr)";
			}
		}
		$patt=~s/,/|/g;
		$patt=~s/(\w\-\w)/[$1]/g;
	}
	# 3. Generate the lookup table
	my %implicit_type_lookup=();
	if (exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$f}) {
		%implicit_type_lookup=%{ $stref->{'Implicits'}{$f} };
	}
	for my $c ('a' .. 'z') {
		if ($c=~/($patt)/) {
			$implicit_type_lookup{$c}=[$type, $kind, $shape, $attr];
		}
	}
	$stref->{'Implicits'}={} unless exists $stref->{'Implicits'};
	$stref->{'Implicits'}{$f}={%implicit_type_lookup };
	return $stref;
}

