
#ifndef INCLUDE_H
#define INCLUDE_H

#include "source.h"

typedef struct stkelt {
  SrcBufPtr buffer;     /* Suspended buffer */
  CONST char *name;             /* Suspended break table file name */
  int line;             /* Next line in suspended file */
} SrcFile;

#ifdef ELI_ARGS
#undef ELI_ARGS
#endif
#if defined(__cplusplus) || defined(__STDC__)
#define ELI_ARGS(x) x
#else
#define ELI_ARGS(x) ()
#endif

extern int ReadingFrom ELI_ARGS((char *name));
/* Suspend input and switch to a new file
 *   On entry-
 *     name is the desired file
 *     SrcBuffer describes the current file
 *     TEXTSTART points to the first unexamined character
 *     LineNum indexes the line containing the first unexamined character
 *   If the desired file can be opened then on exit-
 *     ReadingFrom=1
 *     The description of the current file has been saved
 *     SrcBuffer describes the desired file
 *     TEXTSTART points to the first unexamined character
 *     LineNum indexes the line containing the first unexamined character
 *   Else on exit-
 *     ReadingFrom=0
 *     SrcBuffer, TEXTSTART and LineNum remain unchanged
 ***/

extern char *ContinuationText ELI_ARGS((void));
/* Return to the last suspended input file
 *   If suspended input exists then on exit-
 *     SrcBuffer describes the suspended input
 *     TEXTSTART points to the first unexamined character
 *     LineNum indexes the line containing the first unexamined character
 *   Else on exit-
 *     SrcBuffer remains unchanged
 ***/

#endif
