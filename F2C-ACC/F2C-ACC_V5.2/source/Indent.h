
#ifndef _INDENT_H
#define _INDENT_H

#include "ptg_gen.h"

#if defined(__STDC__) || defined(__cplusplus)
extern void IndentSetStep (int     i);
extern void IndentIncr    (PTG_OUTPUT_FILE f);
extern void IndentDecr    (PTG_OUTPUT_FILE f);
extern void IndentNewLine (PTG_OUTPUT_FILE f);
#else
extern void IndentSetStep ();
extern void IndentIncr ();
extern void IndentDecr ();
extern void IndentNewLine ();
#endif

#endif
