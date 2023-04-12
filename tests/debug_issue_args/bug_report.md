The `memory_reduction.pl` script errors out when encountering a subroutine call where the names of the passed arguments do not match the names in the subroutine signature. I think the mapping between passed argument names and signature names is missing when using some of the data structures.

Attached is a [small reproducible](https://github.com/wimvanderbauwhede/RefactorF4Acc/files/10517955/module_jacobi3d_superkernel.zip). Running `memory_reduction.pl` gives:
`Use of uninitialized value $call_arg_type in string eq at /home/rob/git/RefactorF4Acc/RefactorF4Acc/Analysis/ArgumentIODirs.pm line 772.`

Line 772 gets the type of call arguments using the name of the passed argument:
`my $call_arg_type = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Type'};` 

Dumping `$info->{'SubroutineCall'}` gives:
```$VAR1 = {
  'ArgMap' => {
    'u_ip1_j_k' => 'u_ip1_j_k',
    'u_i_j_km1' => 'u_i_j_km1',
    'u_im1_j_k' => 'u_im1_j_k',
    'un_i_j_k' => 'un_i_j_k',
    'u_i_jm1_k' => 'u_i_jm1_k',
    'u_i_j_kp1' => 'u_i_j_kp1',
    'u_i_jp1_k' => 'u_i_jp1_k',
    'un' => 'v0'
  },
  'Name' => 'stencil_0',
  'ExpressionAST' => [
    27,
    [
      2,
      'u'
    ],
    [
      2,
      'v0'
    ]
  ],
  'Args' => {
    'List' => [
      'u_i_j_km1',
      'u_i_jm1_k',
      'u_im1_j_k',
      'u_ip1_j_k',
      'u_i_jp1_k',
      'u_i_j_kp1',
      'un_i_j_k'
    ],
    'Set' => {
      'u_i_j_km1' => {
        'Type' => 'Scalar',
        'Expr' => 'u_i_j_km1'
      },
      'u_im1_j_k' => {
        'Expr' => 'u_im1_j_k',
        'Type' => 'Scalar'
      },
      'un_i_j_k' => {
        'Type' => 'Scalar',
        'Expr' => 'un_i_j_k'
      },
      'u_ip1_j_k' => {
        'Type' => 'Scalar',
        'Expr' => 'u_ip1_j_k'
      },
      'u_i_j_kp1' => {
        'Type' => 'Scalar',
        'Expr' => 'u_i_j_kp1'
      },
      'v0' => {},
      'u_i_jm1_k' => {
        'Expr' => 'u_i_jm1_k',
        'Type' => 'Scalar'
      },
      'u_i_jp1_k' => {
        'Expr' => 'u_i_jp1_k',
        'Type' => 'Scalar'
      }
    }
  }
};```
