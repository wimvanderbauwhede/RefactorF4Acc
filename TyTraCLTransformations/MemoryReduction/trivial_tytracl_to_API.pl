use warnings;
use strict;
use Data::Dumper;
$Data::Dumper::Terse=1;
 $Data::Dumper::Indent = 0; 
my @lines = map { [split(/\s+/,$_)] } split(/\n/, 
's1 = [-1,0,1]
p_1_s = stencil s1 p_0
p_1 = map sor p_1_s
p_2_s = stencil s1 p_1
p_2 = map sor p_2_s
p_3_s = stencil s1 p_2
p_3 = map sor p_3_s 
p_4_s = stencil s1 p_3
p_4 = map sor p_4_s');

my %stencils=();
my @api_lines=();
for my $chunks ( @lines) {
    my @t_chunks=@{$chunks};
      if (scalar @{$chunks} >3) {
    my $vo = shift @t_chunks;
    shift @t_chunks;
    my $hof = shift @t_chunks;
    $hof='mk'.ucfirst($hof);
    if ($hof=~/Stencil/ ) {
        my $s = shift @t_chunks;
        my $sz = scalar @{$stencils{$s}} ;
        my $ct=$s;
        $ct=~s/^s//;
        $ct*=1;
        @t_chunks = map { [split(/_/,$_)] } (@t_chunks, $vo);
        @t_chunks = map { scalar @{$_} == 2 ? [@{$_},''] : $_ } @t_chunks;
        push @api_lines, [$hof.'Appl',$ct,$sz,@t_chunks];
            
    } else {
        my $f = shift @t_chunks;
        @t_chunks = map { [split(/_/,$_)] } (@t_chunks, $vo);
        @t_chunks = map { scalar @{$_} == 2 ? [[@{$_},'']] : [$_] } @t_chunks;
        if ($hof eq 'mkMap' and @t_chunks==2) {
            @t_chunks=([],@t_chunks);
        }
        push @api_lines, [$hof,$f,@t_chunks];
    }
       } else {
           my $ct = shift @t_chunks;
           shift @t_chunks;
           my $def = shift @t_chunks;
           $def=~s/[\[\]]//g;
           $def= [map {1*$_} split (/,/,$def)];
           $stencils{$ct}=$def;
           $ct=~s/^s//;
           $ct*=1;
        push @api_lines, ['mkStencilDef',$ct,$def];
   }

}
map { my $hof = shift @{$_};
    my $args=   join(",",map {Dumper $_} @{$_});
    print "$hof($args),\n" ;
} @api_lines;
#my @api_calls = map {join @api_lines;
