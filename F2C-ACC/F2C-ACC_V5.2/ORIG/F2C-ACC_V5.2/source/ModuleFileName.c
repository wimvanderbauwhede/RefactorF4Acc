
#define FALSE 0
#define TRUE 1
#include <stdio.h>

#define LookupFile "Fortran_Module_Lookup.txt"

void AddLookupEntry(char *modulename, char *filename) {

FILE *infile;
char module[40],file[120];
char line[201];
int done=FALSE;
int found = FALSE;

  if ((infile = fopen(LookupFile,"r+")) != NULL) {
    while (fgets(line,200,infile) != NULL) {
        (void) sscanf(line,"%s %s\n",module,file);
        if (strcmp(module,modulename) == 0) {
          found = TRUE;
        }
    }
        /* append the new entry if it was not found     */
    if (found == FALSE) {
      fprintf(infile,"%s %s\n",modulename,filename);
    }
  } else {
    printf("adding: %s %s\n",modulename,filename);
    if ((infile = fopen(LookupFile,"w")) != NULL) {
      fprintf(infile,"%s %s\n",modulename,filename);
    }
  }
  fclose(infile);

  return;
}
