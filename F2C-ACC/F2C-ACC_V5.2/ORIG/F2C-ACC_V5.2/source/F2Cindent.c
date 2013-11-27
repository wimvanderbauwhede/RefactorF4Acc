
#include <stdio.h>

void IndentLabl(f,sp)
FILE *f; int sp;
{
int i;
for (i=0;i<sp;i++) {
  (void) fprintf(f," ");
}
}
