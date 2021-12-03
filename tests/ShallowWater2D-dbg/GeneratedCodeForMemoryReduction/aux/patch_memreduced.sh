perl ../aux/patch_superkernel_module_src.pl $*
perl ../aux/patch_scalarised_functions.pl $*
# patch_module_gen__superkernel doesn't add
# 'use module global_id' when -i flag is used
perl ../aux/patch_module_gen__superkernel.pl