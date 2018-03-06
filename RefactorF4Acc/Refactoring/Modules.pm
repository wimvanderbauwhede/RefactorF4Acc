package RefactorF4Acc::Refactoring::Modules;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines create_refactored_source splice_additional_lines_cond emit_f95_var_decl );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Modules::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Modules::EXPORT_OK = qw(
  &add_module_decls
);

=pod
This subroutine created the module declarations around the original F77 files
=cut

# -----------------------------------------------------------------------------
sub add_module_decls {
	( my $stref ) = @_;

	#    my $no_module=0;
	my %is_existing_module   = ();
	my %existing_module_name = ();
	my %no_modules           = exists $Config{'NO_MODULE'} ? map { $_ => 1 } @{ $Config{'NO_MODULE'} } : ();

	# This assumes a source file contains only a single module
	# - For all sources $src in the source tree
	# 	1. Get all code units in this source ($sub_or_func_or_mod)
	# 	2. - For each of these code units
	#		- check if the code unit is an existing Module (assuming only 1 module per source!), if so
	#			set 	$is_existing_module and $existing_module_name
	#   3. For all code units, get a list of CalledSubs (so in practice this is only for Subroutines)
	#		- get the sources for these subs, to include in the current module.
	for my $src ( keys %{ $stref->{'SourceContains'} } ) {
		if (    exists $stref->{'SourceContains'}{$src}{'Path'}
			and exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'} )
		{
			# External, SKIP!
			say "SKIPPING $src";
		} else {

			# Get the unit name from the list
			for my $sub_or_func_or_mod ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {

				# Get its type
				my $sub_func_type = $stref->{'SourceContains'}{$src}{'Set'}{$sub_or_func_or_mod};
				if ( $sub_func_type eq 'Modules' ) {
					$is_existing_module{$src}   = 1;
					$existing_module_name{$src} = $sub_or_func_or_mod;
				}
				my $Sf = $stref->{$sub_func_type}{$sub_or_func_or_mod};

				for my $called_sub_or_entry ( @{ $Sf->{'CalledSubs'}{'List'} } ) {
					my $called_sub = $called_sub_or_entry;
					if ( exists $stref->{'Entries'}{$called_sub_or_entry} ) {
						$called_sub = $stref->{'Entries'}{$called_sub_or_entry};
					}
					next if exists $stref->{'ExternalSubroutines'}{$called_sub};    # Don't descend into external subs

					my $cs_src;
					if ( exists $stref->{'Subroutines'}{$called_sub} and exists $stref->{'Subroutines'}{$called_sub}{'Source'} ) {
						$cs_src = $stref->{'Subroutines'}{$called_sub}{'Source'};
					} else {
						croak "PROBLEM: NO $called_sub in $src" . Dumper( keys %{ $stref->{'Subroutines'} } ) . $stref->{'Subroutines'}{$called_sub}{'Source'};
					}
					next if $cs_src eq $src;                                                # FIXME: ad-hoc!
					next if $stref->{'SourceFiles'}{$cs_src}{'SourceType'} eq 'Modules';    # Because in that case there should already be a USE

					$stref->{'UsedModules'}{$src}{$cs_src} = $sub_or_func_or_mod;
				}
			}
		}
	}

	# Now we go through the sources again and check
	for my $src ( keys %{ $stref->{'SourceContains'} } ) {
		if ($I) {
			say '! ', '-' x 80;
			say "! SRC: $src";
			print "!\tCONTAINS: ";
			say join( ', ', @{ $stref->{'SourceContains'}{$src}{'List'} } );
		}
		if ( $is_existing_module{$src} ) {

			# What we need to do is find $info->{'Contains'} and splice in the subroutines in order there.
			# So we create $new_annlines simply by merging the annlines for all subs, then splice.

			# WV20170607
			# I want the option here to split existing modules on a per-subroutine basis.
			# This means that they need new names, i.e. the names of the subs, like above.
			# And then I need to figure out how to adapt the USE declarations in other subroutines.
			# Unless there is a way to re-export modules
			my $split_out_modules_per_subroutine=1;
			if ($split_out_modules_per_subroutine==1 and $stref->{'Modules'}{  $existing_module_name{$src} }{'Inlineable'}==0) {
				_split_module_per_subroutine( $stref,  \%existing_module_name, $src, \%no_modules );
			} else {
			
				my $new_annlines = [];
				for my $sub ( @{ $stref->{'Modules'}{ $existing_module_name{$src} }{'Contains'} } ) {
					say '=' x 80 if $V;
					say 'SUB: ' . $sub if $V;
					$stref = _create_module_src(  $stref, $src, $sub, \%no_modules );
					
					$new_annlines = [ @{$new_annlines}, @{ $stref->{'Subroutines'}{$sub}{'RefactoredCode'} } ];
					say '=' x 80 if $V;
				}
	#			croak;
				my $old_annlines                          = $stref->{'Modules'}{ $existing_module_name{$src} }{'AnnLines'};
				my $old_annlines_with_refactored_vardecls = [
					map {
						my $annline = $_;
						( my $line, my $info ) = @{$annline};
						if ( exists $info->{'VarDecl'} ) {
							my $ref_vardecl_line = emit_f95_var_decl( get_var_record_from_set( $stref->{'Modules'}{ $existing_module_name{$src} }{'Vars'}, $info->{'VarDecl'}{'Name'} ) );
							[ $ref_vardecl_line, $info ];
						} elsif ( exists $info->{'Use'} and $info->{'Use'}{'Inlineable'} == 1 ) {
							[ '!      ' . $line . ' ! commented out in add_module_decls() because Inlineable', $info ];
						} else {
							$annline;
						}
					} @{$old_annlines}
				];
				$old_annlines = $old_annlines_with_refactored_vardecls;
	
				if ( scalar @{$new_annlines} > 0 ) {
					my $merged_annlines = splice_additional_lines_cond( $stref, $existing_module_name{$src}, sub { ( my $annline ) = @_; ( my $line, my $info ) = @{$annline}; return exists $info->{'Contains'} }, $old_annlines, $new_annlines, 0, 0, 1 );
					$stref->{'RefactoredCode'}{$src} = $merged_annlines;
				} else {
					$stref->{'RefactoredCode'}{$src} = $old_annlines;
				}
			}
		} else {

			# This is either a subroutine or the main program
			# So I wonder why I have this code when it's a program?
			$stref = _create_module_src(  $stref, $src, '', \%no_modules );
	
		}
	
	}    # loop over all source files

	return $stref;
}    # END of add_module_decls()

sub _split_module_per_subroutine {
	( my $stref, my $existing_module_name, my $src, my $no_modules ) = @_;
	my $module_to_split = $existing_module_name->{$src}; 

	# Plan:
	# 1/ create a module per subroutine
	# 2/ create an grouping module

	# 1/ create a module per subroutine
	my @subs=();
	for my $sub ( @{ $stref->{'Modules'}{ $module_to_split }{'Contains'} } ) {
		$stref = _create_module_src(  $stref, $src, $sub, $no_modules );
		push @subs, $sub;
	}
	
	
	# Now we have to create the wrapper module source which replaces the original module source


	my @wrapper_module_annlines=( ["module $module_to_split",{'Module' => $module_to_split }]);
	for my $sub (@subs) {
		push @wrapper_module_annlines,[ "     use module_$sub", {'Use' =>{'Name' => "module_$sub", 'Inlineable' => 0 } } ];
	}
	for my $sub (@subs) {
		push @wrapper_module_annlines,["     interface $sub",{'Interface'=> $sub }];
		push @wrapper_module_annlines,["       module procedure $sub",{ 'ModuleProcDecl' => $sub }];
		push @wrapper_module_annlines,["     end interface $sub",{ 'EndInterface'=> $sub}]; 
	}
	push @wrapper_module_annlines,["end module $module_to_split",{ 'EndModule' => $module_to_split }];
	
	$stref->{'RefactoredCode'}{$src}=\@wrapper_module_annlines;

#	show_annlines(\@wrapper_module_annlines);
#croak;
	return $stref;
}    # END of _split_module_per_subroutine

# This routine creates the new module source.
# The extra argument $subname is used to split out modules per subroutine
sub _create_module_src { (my $stref, my $src, my $subname, my $no_modules ) = @_;
	# This is either a subroutine or the main program
    # So I wonder why I have this code when it's a program?
	my $is_program = ( exists $stref->{'Program'} and $stref->{'Program'} eq $src ) ? 1 : 0;

	# Means "do not wrap in module statements"
	my $no_module = $is_program;                    # if it's a program
	$no_module = exists $no_modules->{$src} ? 1 : $no_module;    # if it occurs in %no_modules

	print "INFO: adding module decls to $src\n" if $I;
	my $mod_name = $subname ? $subname : $src;
	$mod_name =~ s/\.\///;
	$mod_name =~ s/\..*$//;
	$mod_name =~ s/[\.\/\-]/_/g;

	$mod_name = "module_$mod_name";
	my $mod_header = [ "module $mod_name\n",       { 'Ref' => 1 } ];
	my $mod_footer = [ "\nend module $mod_name\n", { 'Ref' => 1 } ];

	my @mod_uses = ();
	for my $mod_src ( keys %{ $stref->{'UsedModules'}{$src} } ) {
		next if exists $no_modules->{$mod_src};
		if ($subname ne '') {
			my $called_from = $stref->{'UsedModules'}{$src}{$mod_src };
			next unless  $called_from eq $subname;
		}
		my $used_mod_name = $mod_src;
		$used_mod_name =~ s/\.\///;
		$used_mod_name =~ s/\..*$//;
		$used_mod_name =~ s/[\.\/\-]/_/g;

		next if $used_mod_name eq $mod_name;    # FIXME: ad-hoc!
		$used_mod_name = "module_$used_mod_name";
		my $use_mod_line = "      use $used_mod_name";

		# NOT OK: must check if the sub is actually used!
		push @mod_uses, [ $use_mod_line, { 'Ref' => 1, 'Ann' => [ annotate( '', __LINE__ ) ] } ];
	}

	my $mod_contains            = [ "contains\n", { 'Ref' => 1 } ];
	my @refactored_source_lines = ();
	my $refactored_sources      = {};

	# Normally we simply concatenate all lines for every $f in SourceContains
	# However, if this is a Program that contains subroutines, we need to do this differently
	# And in principle a source file can contain a combination.
	# Step 1
	if ($no_module) {
		if ($is_program) {

			# This means that $src is a source file with a Program
			# What is the Program?
			my $prog_name = 'PROGRAM_NAME_UNKNOWN';
			for my $f ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
				if ( exists $stref->{'Subroutines'}{$f}{'Program'}
					and $stref->{'Subroutines'}{$f}{'Program'} == 1 )
				{
					$prog_name = $f;
					last;
				}
			}
			my $annlines       = get_annotated_sourcelines( $stref, $prog_name );
			my $before         = 1;
			my @prog_p1        = ();
			my @prog_p2        = ();
			my @contained_subs = ();
			for my $annline ( @{$annlines} ) {
				my $info = $annline->[1];
				if ($before) {
					push @prog_p1, $annline;
				} else {
					push @prog_p2, $annline;
				}
				if ( exists $info->{'Contains'} ) {
					$before = 0;
				}
			}
			for my $sub ( @{ $stref->{'Subroutines'}{$prog_name}{'Contains'} } ) {
				my $annlines = get_annotated_sourcelines( $stref, $sub );
				@contained_subs = ( @contained_subs, $BLANK_LINE, comment("CONTAINED SUB $sub"), $BLANK_LINE, @{$annlines}, $BLANK_LINE );
			}
			@refactored_source_lines = ( @prog_p1, @contained_subs, @prog_p2 );

			# If there are subs or functions that are not contained in the program, tag them on after the program
			for my $sub ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {

				if ( not exists $stref->{'Subroutines'}{$sub}{'Program'}
					or $stref->{'Subroutines'}{$sub}{'Program'} == 0 )
				{
					#						say "PROC $sub";
					my $annlines = get_annotated_sourcelines( $stref, $sub );
					if ( not exists $refactored_sources->{$sub} ) {
						$annlines = create_refactored_source( $stref, $sub, $annlines );
						$refactored_sources->{$sub} = 1;
					}
					@refactored_source_lines = ( @refactored_source_lines, @{$annlines} );
				}
			}
		} else {

			#  source listed in NO_MODULE in rf4a.cfg,  do not  turn into a module for compatibily with F77
			for my $f ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
				my $annlines = get_annotated_sourcelines( $stref, $f );
				if ( not exists $refactored_sources->{$f} ) {    # This is a HACK because we need to make sure this is caught higher up
					$annlines = create_refactored_source( $stref, $f, $annlines );
					$refactored_sources->{$f} = 1;
				}
				@refactored_source_lines = ( @refactored_source_lines, @{$annlines} );
			}

		}
	} else {
		# It's a module. We just get the refactored sources here, do the rest in the next step
		for my $f ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
			if ($subname ne '') {
				next unless $f eq $subname;
			}
			my $annlines = get_annotated_sourcelines( $stref, $f );
			if ( not exists $refactored_sources->{$f} ) {    # FIXME: This is a HACK because we need to make sure this is caught higher up
				$annlines = create_refactored_source( $stref, $f, $annlines );
				$refactored_sources->{$f} = 1;
			}
			@refactored_source_lines = ( @refactored_source_lines, @{$annlines} );
		}
	}

	# Step 2
#	say "SRC $src";
	my $nsrc = $subname ne '' ? $Config{'SRCDIRS'}->[0]."/$subname$EXT" : $src;
	if ( !$no_module ) {
		$stref->{'RefactoredCode'}{$nsrc} = [ $mod_header, @mod_uses, $mod_contains, @refactored_source_lines, $mod_footer ];
	} else {
		
		if ($is_program) {
			# In case it is a program
			# We add the 'use' declarations after the program signature
			my $before  = 1;
			my @prog_p1 = ();
			my @prog_p2 = ();

			for my $annline (@refactored_source_lines) {

				my $info = $annline->[1];
				if ($before) {
					push @prog_p1, $annline;
				} else {
					push @prog_p2, $annline;
				}
				if ( exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} ) {

					my $progname = $info->{'Signature'}{'Name'};
					if ( exists $stref->{'Subroutines'}{$progname}{'Program'}
						and $stref->{'Subroutines'}{$progname}{'Program'} == 1 )
					{
						$before = 0;
					}
				}
			}
			$stref->{'RefactoredCode'}{$src} = [ @prog_p1, @mod_uses, @prog_p2 ];
		} else {
			$stref->{'RefactoredCode'}{$src} = [@refactored_source_lines];
		}
	}
	if ($subname ne '') {
#		say "NEW SRC $nsrc ";
#		show_annlines($stref->{'RefactoredCode'}{$nsrc});
		 $stref->{'SourceContains'}{$nsrc} = {'List' =>[$subname]   };
		$stref->{'BuildSources'}{'F'}{$nsrc}=1;
	}
	return $stref;
}    # END of _create_module_src

1;
=pod			
			my $is_program = ( exists $stref->{'Program'} and $stref->{'Program'} eq $src ) ? 1 : 0;

			# Means "do not wrap in module statements"
			my $no_module = $is_program;    # if it's a program
			$no_module = exists $no_modules{$src} ? 1 : $no_module;    # if it occurs in %no_modules

			#	        say "NO_MODULE $src:$no_module ($is_program)";
			print "INFO: adding module decls to $src\n" if $I;

			my $mod_name = $src;
			$mod_name =~ s/\.\///;
			$mod_name =~ s/\..*$//;
			$mod_name =~ s/[\.\/\-]/_/g;

			$mod_name = "module_$mod_name";
			my $mod_header = [ "module $mod_name\n",       { 'Ref' => 1 } ];
			my $mod_footer = [ "\nend module $mod_name\n", { 'Ref' => 1 } ];

			my @mod_uses = ();
			for my $mod_src ( keys %{ $stref->{'UsedModules'}{$src} } ) {

				#	            	say "NO_MODULES: <<".Dumper(%no_modules).' >> '.$mod_src;
				next if exists $no_modules{$mod_src};
				my $used_mod_name = $mod_src;
				$used_mod_name =~ s/\.\///;
				$used_mod_name =~ s/\..*$//;
				$used_mod_name =~ s/[\.\/\-]/_/g;

				#	        say "$used_mod_name <> $mod_name";
				next if $used_mod_name eq $mod_name;    # FIXME: ad-hoc!
				$used_mod_name = "module_$used_mod_name";
				my $use_mod_line = "      use $used_mod_name";

				# NOT OK: must check if the sub is actually used!
				#my $only_list = join(', ',@{ $stref->{'SourceContains'}{$mod_src}{'List'} } );
				#$use_mod_line .= ($NO_ONLY ?  '!' : '') .', only : '.$only_list;
				push @mod_uses, [ $use_mod_line, { 'Ref' => 1, 'Ann' => [ annotate( '', __LINE__ ) ] } ];
			}

			my $mod_contains            = [ "contains\n", { 'Ref' => 1 } ];
			my @refactored_source_lines = ();
			my $refactored_sources      = {};

			# Normally we simply concatenate all lines for every $f in SourceContains
			# However, if this is a Program that contains subroutines, we need to do this differently
			# And in principle a source file can contain a combination.
			# Step 1
			#	            say "STEP 1 : $src => $no_module";

			if ($no_module) {
				if ($is_program) {

					# This means that $src is a source file with a Program
					# What is the Program?
					my $prog_name = 'PROGRAM_NAME_UNKNOWN';
					for my $f ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
						if ( exists $stref->{'Subroutines'}{$f}{'Program'}
							and $stref->{'Subroutines'}{$f}{'Program'} == 1 )
						{
							$prog_name = $f;
							last;
						}
					}
					my $annlines       = get_annotated_sourcelines( $stref, $prog_name );
					my $before         = 1;
					my @prog_p1        = ();
					my @prog_p2        = ();
					my @contained_subs = ();
					for my $annline ( @{$annlines} ) {
						my $info = $annline->[1];
						if ($before) {
							push @prog_p1, $annline;
						} else {
							push @prog_p2, $annline;
						}
						if ( exists $info->{'Contains'} ) {
							$before = 0;
						}
					}
					for my $sub ( @{ $stref->{'Subroutines'}{$prog_name}{'Contains'} } ) {
						my $annlines = get_annotated_sourcelines( $stref, $sub );
						@contained_subs = ( @contained_subs, $BLANK_LINE, comment("CONTAINED SUB $sub"), $BLANK_LINE, @{$annlines}, $BLANK_LINE );
					}
					@refactored_source_lines = ( @prog_p1, @contained_subs, @prog_p2 );

					# If there are subs or functions that are not contained in the program, tag them on after the program
					for my $sub ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {

						if ( not exists $stref->{'Subroutines'}{$sub}{'Program'}
							or $stref->{'Subroutines'}{$sub}{'Program'} == 0 )
						{
							#						say "PROC $sub";
							my $annlines = get_annotated_sourcelines( $stref, $sub );
							if ( not exists $refactored_sources->{$sub} ) {
								$annlines = create_refactored_source( $stref, $sub, $annlines );
								$refactored_sources->{$sub} = 1;
							}
							@refactored_source_lines = ( @refactored_source_lines, @{$annlines} );
						}
					}

				} else {

					#  source listed in NO_MODULE in rf4a.cfg,  do not  turn into a module for compatibily with F77
					for my $f ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
						my $annlines = get_annotated_sourcelines( $stref, $f );
						if ( not exists $refactored_sources->{$f} ) {    # This is a HACK because we need to make sure this is caught higher up
							$annlines = create_refactored_source( $stref, $f, $annlines );
							$refactored_sources->{$f} = 1;
						}
						@refactored_source_lines = ( @refactored_source_lines, @{$annlines} );
					}

				}
			} else {

				# It's a module. We just get the refactored sources here, do the rest in the next step

				for my $f ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {

					#	            	croak if $f=~/^\s*$/;
					my $annlines = get_annotated_sourcelines( $stref, $f );
					if ( not exists $refactored_sources->{$f} ) {    # This is a HACK because we need to make sure this is caught higher up
						$annlines = create_refactored_source( $stref, $f, $annlines );
						$refactored_sources->{$f} = 1;
					}
					@refactored_source_lines = ( @refactored_source_lines, @{$annlines} );
				}
			}

			# Step 2
			#	            say "STEP 2 : $src => $no_module";
			if ( !$no_module ) {
				$stref->{'RefactoredCode'}{$src} = [ $mod_header, @mod_uses, $mod_contains, @refactored_source_lines, $mod_footer ];

				#	                croak Dumper($stref->{'RefactoredCode'}{$src}) if $src=~/press/;
			} else {

				if ($is_program) {

					# In case it is a program
					# We add the 'use' declarations after the program signature
					my $before  = 1;
					my @prog_p1 = ();
					my @prog_p2 = ();

					for my $annline (@refactored_source_lines) {

						my $info = $annline->[1];
						if ($before) {
							push @prog_p1, $annline;
						} else {
							push @prog_p2, $annline;
						}
						if ( exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} ) {

							my $progname = $info->{'Signature'}{'Name'};
							if ( exists $stref->{'Subroutines'}{$progname}{'Program'}
								and $stref->{'Subroutines'}{$progname}{'Program'} == 1 )
							{
								$before = 0;
							}
						}
					}
					$stref->{'RefactoredCode'}{$src} = [ @prog_p1, @mod_uses, @prog_p2 ];
				} else {
					$stref->{'RefactoredCode'}{$src} = [@refactored_source_lines];
				}
			}
=cut	