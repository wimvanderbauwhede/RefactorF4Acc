
#include "Indent.h"

static int curind = 0;
static int indstep = 3;

#if defined(__STDC__) || defined(__cplusplus)
void IndentSetStep (int i)
#else
void IndentSetStep (i) int i;
#endif
{
    indstep = i;
}

#if defined(__STDC__) || defined(__cplusplus)
void IndentIncr (PTG_OUTPUT_FILE f)
#else
void IndentIncr (f) 
        PTG_OUTPUT_FILE f;
#endif
{
    curind += indstep;
}

#if defined(__STDC__) || defined(__cplusplus)
void IndentDecr (PTG_OUTPUT_FILE f)
#else
void IndentDecr (f) 
        PTG_OUTPUT_FILE f;
#endif
{
    curind -= indstep;
}

#if defined(__STDC__) || defined(__cplusplus)
void IndentNewLine (PTG_OUTPUT_FILE f)
#else
void IndentNewLine (f) 
        PTG_OUTPUT_FILE f;
#endif
{
    int i;

    PTG_OUTPUT_CHAR(f, '\n');

    for (i=0; i<curind; i++)
        PTG_OUTPUT_CHAR (f, ' ');
}
