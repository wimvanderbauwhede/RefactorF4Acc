
#include "eliproto.h"



/* Establish a scan pointer
 *   If no further text is available then on exit-
 *     TokenEnd points to a null string
 *   Otherwise on exit-
 *     TokenEnd points to a string that is guaranteed to contain
 *       a newline character
 */
#define SCANPTR  \
{ extern void NewStmtBuffer(); NewStmtBuffer(); }



/* Set the coordinates of the current token
 *   On entry-
 *     p=index of the current position in the current source line
 *   On exit-
 *     curpos=coordinates of the current position
 */
#define SETCOORD(p)  \
  { extern void TokenCoords ELI_ARG((int, POSITION *, int)); \
    TokenCoords(p, &curpos, 0); }


/* Set the coordinates of the end of the current token
 *   On entry-
 *     p=index of the current position in the current source line
 *   On exit-
 *     endpos=coordinates of the current position
 */
#define SETENDCOORD(p)  \
  { extern void TokenCoords ELI_ARG((int, POSITION *, int)); \
    TokenCoords(p, &curpos, 1); }

