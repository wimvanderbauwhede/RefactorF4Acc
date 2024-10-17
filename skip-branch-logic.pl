my $if_stacks=[];
my $if_counter=0;

if (exists $info->{'IfThen'}) {
    ++$if_counter;
    my $cond_is_const = $info->{'Cond'}{'AST'}[0] == 31;
    if ($cond_is_const) {
        if ( $info->{'Cond'}{'AST'}[1] eq '.true.') { 
            #delete IF line
            $info->{'DeadCode'}=1;
            push @{$if_stacks->[$if_counter]}, 'IfTrue';
            $is_dead_code=0;

        }
        elsif ( $info->{'Cond'}{'AST'}[1] eq '.false.' ) {
            #delete IF line
            push @{$if_stacks->[$if_counter]}, 'IfFalse';
            $is_dead_code=1;
        }
    } else {
        push @{$if_stacks->[$if_counter]}, 'If';
    }
}
elsif (exists $info->{'ElseIf'}) {
    my $case = pop  @{$if_stacks->[$if_counter]};
    my $change_elseif_to_if=0;
    if ($case eq 'IfTrue') {
        $info->{'DeadCode'}=1;
        $is_dead_code=1;
    }
    elsif ($case eq 'IfFalse') {
    # change ElseIf to If
        $change_elseif_to_if=1;
        $is_dead_code=0;
    }
    else {
    # else push the If back on the stack
        push @{$if_stacks->[$if_counter]}, 'If';
    }
}
elsif (exists $info->{'Else'}) {
    my $case = pop  @{$if_stacks->[$if_counter]};
    if ($case eq 'IfTrue') {
        $info->{'DeadCode'}=1;
        $is_dead_code=1;
    }
    elsif ($case eq 'IfFalse') {
        $info->{'DeadCode'}=1;
        $is_dead_code=0;
    }
    else {
        # else push the If back on the stack
        push @{$if_stacks->[$if_counter]}, 'If';
    }
}
elsif (exists $info->{'EndIf'}) {
    my $case = pop  @{$if_stacks->[$if_counter]};
    if ($case ne 'If' and scalar @{$if_stacks->[$if_counter]}==0) {
         $info->{'DeadCode'}=1;
    }
     $is_dead_code=0;
    $if_stacks->[$if_counter]=[];
    --$if_counter;
} elsif ($is_dead_code) {
    $info->{'DeadCode'}=1;
}
