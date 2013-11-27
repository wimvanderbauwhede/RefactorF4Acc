#include <stdio.h>
#include <stdlib.h>

#include "ptg_gen.h"
#include "obstack.h"

/* -------------------------------------------------------- */
/*                      Memory Management                   */
/* -------------------------------------------------------- */

static Obstack _PTGObstack;
static void *_PTGFirstObj = NULL;

static void _PTGInit()
{
       if (_PTGFirstObj)
               return;
       obstack_init(&_PTGObstack);
       _PTGFirstObj = obstack_alloc(&_PTGObstack, 0);
}

void PTGFree()
{
       obstack_free(&_PTGObstack, _PTGFirstObj);
       _PTGFirstObj = obstack_alloc(&_PTGObstack, 0);
}


#if defined(__STDC__) || defined(__cplusplus)
static void *MALLOC(int size)
#else
static void *MALLOC(size) int size;
#endif
{
       if (! _PTGFirstObj)
               _PTGInit();
       return (obstack_alloc(&_PTGObstack, size));
}

/* -------------------------------------------------------- */
/*                       Output-functions                   */
/* -------------------------------------------------------- */

static PTG_OUTPUT_FILE f;
static char buffer[40];

#if PTG_OUTPUT_DEFAULT
#if defined(__STDC__) || defined(__cplusplus)
PTGNode PTGOut (PTGNode r)
#else
PTGNode PTGOut (r)
       PTGNode r;
#endif
{
       f = stdout;
       if (r) {
               (* (r->_print)) (r);
       }
       return (r);
}

#if defined(__STDC__) || defined(__cplusplus)
PTGNode PTGOutFile (const char *fn, PTGNode r)
#else
PTGNode PTGOutFile (fn, r)
       char * fn; PTGNode r;
#endif
{
       if ((f = fopen(fn, "w"))  == (FILE *)NULL)
       {
               fprintf(stderr, "ERROR: PTGOutFile: output file '%s' can't be opened.\n",fn);
               exit(1);
       }
       if (r)
               (* (r->_print)) (r);
       fclose(f);
       return (r);
}

#if defined(__STDC__) || defined(__cplusplus)
PTGNode PTGOutFPtr(FILE *fptr, PTGNode r)
#else
PTGNode PTGOutFPtr(fptr, r)
       FILE *fptr; PTGNode r;
#endif
{
       if ((f = fptr) == (FILE *)NULL)
       {
               fprintf(stderr, "ERROR: PTGOutFPtr: output file not open.\n");
               exit(1);
       }
       if (r)
               (* (r->_print)) (r);
       return (r);
}

#endif

#if defined(__STDC__) || defined(__cplusplus)
PTGNode PTGProcess(PTG_OUTPUT_FILE file, PTGNode r)
#else
PTGNode PTGProcess(file, r)
       PTG_OUTPUT_FILE file; PTGNode r;
#endif
{
       f = file;
       if (r)
               (* (r->_print)) (r);
       return (r);
}
/* -------------------------------------------------------- */
/*                            PTGNULL                       */
/* -------------------------------------------------------- */

/* Define PTGNULL as a PTGNode that prints nothing. */

#if defined(__STDC__) || defined(__cplusplus)
static void _PrPTGNULL(_PPTG0 n)
#else
static void _PrPTGNULL(n)
_PPTG0 n;
#endif
{(void)n; /* function printing nothing */}

struct _SPTG0   _PTGNULL = { (_PTGProc) _PrPTGNULL };

/* -------------------------------------------------------- */
/*          Node-Construction and Print-functions           */
/* -------------------------------------------------------- */

/* ============================ */

/* Implementation of Pattern Id */

typedef struct _SPTGId{
	_PTGProc _print;
	int p1;
} * _PPTGId;

#ifdef PROTO_OK
static void _PrPTGId(_PPTGId n)
#else
static void _PrPTGId(n)
	_PPTGId n;
#endif
{
	PtgOutId(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGId(int p1)
#else
PTGNode PTGId(p1)

int p1;
#endif
{
	_PPTGId n;
	n = (_PPTGId)MALLOC(sizeof(struct _SPTGId));
	n->_print = (_PTGProc)_PrPTGId;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern AsIs */

typedef struct _SPTGAsIs{
	_PTGProc _print;
	CONST char* p1;
} * _PPTGAsIs;

#ifdef PROTO_OK
static void _PrPTGAsIs(_PPTGAsIs n)
#else
static void _PrPTGAsIs(n)
	_PPTGAsIs n;
#endif
{
	PTG_OUTPUT_STRING(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGAsIs(CONST char* p1)
#else
PTGNode PTGAsIs(p1)

CONST char* p1;
#endif
{
	_PPTGAsIs n;
	n = (_PPTGAsIs)MALLOC(sizeof(struct _SPTGAsIs));
	n->_print = (_PTGProc)_PrPTGAsIs;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Numb */

typedef struct _SPTGNumb{
	_PTGProc _print;
	int p1;
} * _PPTGNumb;

#ifdef PROTO_OK
static void _PrPTGNumb(_PPTGNumb n)
#else
static void _PrPTGNumb(n)
	_PPTGNumb n;
#endif
{
	PTG_OUTPUT_INT(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGNumb(int p1)
#else
PTGNode PTGNumb(p1)

int p1;
#endif
{
	_PPTGNumb n;
	n = (_PPTGNumb)MALLOC(sizeof(struct _SPTGNumb));
	n->_print = (_PTGProc)_PrPTGNumb;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern CString */

typedef struct _SPTGCString{
	_PTGProc _print;
	CONST char* p1;
} * _PPTGCString;

#ifdef PROTO_OK
static void _PrPTGCString(_PPTGCString n)
#else
static void _PrPTGCString(n)
	_PPTGCString n;
#endif
{
	CPtgOutstr(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGCString(CONST char* p1)
#else
PTGNode PTGCString(p1)

CONST char* p1;
#endif
{
	_PPTGCString n;
	n = (_PPTGCString)MALLOC(sizeof(struct _SPTGCString));
	n->_print = (_PTGProc)_PrPTGCString;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern CChar */

typedef struct _SPTGCChar{
	_PTGProc _print;
	int p1;
} * _PPTGCChar;

#ifdef PROTO_OK
static void _PrPTGCChar(_PPTGCChar n)
#else
static void _PrPTGCChar(n)
	_PPTGCChar n;
#endif
{
	CPtgOutchar(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGCChar(int p1)
#else
PTGNode PTGCChar(p1)

int p1;
#endif
{
	_PPTGCChar n;
	n = (_PPTGCChar)MALLOC(sizeof(struct _SPTGCChar));
	n->_print = (_PTGProc)_PrPTGCChar;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern PString */

typedef struct _SPTGPString{
	_PTGProc _print;
	CONST char* p1;
} * _PPTGPString;

#ifdef PROTO_OK
static void _PrPTGPString(_PPTGPString n)
#else
static void _PrPTGPString(n)
	_PPTGPString n;
#endif
{
	PPtgOutstr(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGPString(CONST char* p1)
#else
PTGNode PTGPString(p1)

CONST char* p1;
#endif
{
	_PPTGPString n;
	n = (_PPTGPString)MALLOC(sizeof(struct _SPTGPString));
	n->_print = (_PTGProc)_PrPTGPString;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Seq */

typedef struct _SPTGSeq{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSeq;

#ifdef PROTO_OK
static void _PrPTGSeq(_PPTGSeq n)
#else
static void _PrPTGSeq(n)
	_PPTGSeq n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGSeq(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSeq(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSeq n;
	if(p1 == PTGNULL && p2 == PTGNULL)
		return PTGNULL;
	n = (_PPTGSeq)MALLOC(sizeof(struct _SPTGSeq));
	n->_print = (_PTGProc)_PrPTGSeq;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern CommaSeq */

typedef struct _SPTGCommaSeq{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGCommaSeq;

#ifdef PROTO_OK
static void _PrPTGCommaSeq(_PPTGCommaSeq n)
#else
static void _PrPTGCommaSeq(n)
	_PPTGCommaSeq n;
#endif
{
	n->p1->_print(n->p1);
	if (n->p1 != PTGNULL && n->p2 != PTGNULL)
	{
		PTG_OUTPUT_STRING(f, ", ");
	}
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGCommaSeq(PTGNode p1, PTGNode p2)
#else
PTGNode PTGCommaSeq(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGCommaSeq n;
	if(p1 == PTGNULL && p2 == PTGNULL)
		return PTGNULL;
	n = (_PPTGCommaSeq)MALLOC(sizeof(struct _SPTGCommaSeq));
	n->_print = (_PTGProc)_PrPTGCommaSeq;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Eol */

typedef struct _SPTGEol{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGEol;

#ifdef PROTO_OK
static void _PrPTGEol(_PPTGEol n)
#else
static void _PrPTGEol(n)
	_PPTGEol n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "\n");
}

#ifdef PROTO_OK
PTGNode PTGEol(PTGNode p1)
#else
PTGNode PTGEol(p1)

PTGNode p1;
#endif
{
	_PPTGEol n;
	n = (_PPTGEol)MALLOC(sizeof(struct _SPTGEol));
	n->_print = (_PTGProc)_PrPTGEol;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Size */

typedef struct _SPTGSize{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSize;

#ifdef PROTO_OK
static void _PrPTGSize(_PPTGSize n)
#else
static void _PrPTGSize(n)
	_PPTGSize n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")-(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")+1");
}

#ifdef PROTO_OK
PTGNode PTGSize(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSize(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSize n;
	n = (_PPTGSize)MALLOC(sizeof(struct _SPTGSize));
	n->_print = (_PTGProc)_PrPTGSize;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern FArrayArgs */

typedef struct _SPTGFArrayArgs{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGFArrayArgs;

#ifdef PROTO_OK
static void _PrPTGFArrayArgs(_PPTGFArrayArgs n)
#else
static void _PrPTGFArrayArgs(n)
	_PPTGFArrayArgs n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGFArrayArgs(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGFArrayArgs(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGFArrayArgs n;
	n = (_PPTGFArrayArgs)MALLOC(sizeof(struct _SPTGFArrayArgs));
	n->_print = (_PTGProc)_PrPTGFArrayArgs;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern GlobalSize */

typedef struct _SPTGGlobalSize{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGGlobalSize;

#ifdef PROTO_OK
static void _PrPTGGlobalSize(_PPTGGlobalSize n)
#else
static void _PrPTGGlobalSize(n)
	_PPTGGlobalSize n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "__GlobalSize(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGGlobalSize(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGGlobalSize(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGGlobalSize n;
	n = (_PPTGGlobalSize)MALLOC(sizeof(struct _SPTGGlobalSize));
	n->_print = (_PTGProc)_PrPTGGlobalSize;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern LowBounds */

typedef struct _SPTGLowBounds{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGLowBounds;

#ifdef PROTO_OK
static void _PrPTGLowBounds(_PPTGLowBounds n)
#else
static void _PrPTGLowBounds(n)
	_PPTGLowBounds n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "__LowBounds(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGLowBounds(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGLowBounds(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGLowBounds n;
	n = (_PPTGLowBounds)MALLOC(sizeof(struct _SPTGLowBounds));
	n->_print = (_PTGProc)_PrPTGLowBounds;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern UpperBounds */

typedef struct _SPTGUpperBounds{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGUpperBounds;

#ifdef PROTO_OK
static void _PrPTGUpperBounds(_PPTGUpperBounds n)
#else
static void _PrPTGUpperBounds(n)
	_PPTGUpperBounds n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "__UpperBounds(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGUpperBounds(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGUpperBounds(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGUpperBounds n;
	n = (_PPTGUpperBounds)MALLOC(sizeof(struct _SPTGUpperBounds));
	n->_print = (_PTGProc)_PrPTGUpperBounds;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern FourArgs */

typedef struct _SPTGFourArgs{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGFourArgs;

#ifdef PROTO_OK
static void _PrPTGFourArgs(_PPTGFourArgs n)
#else
static void _PrPTGFourArgs(n)
	_PPTGFourArgs n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
}

#ifdef PROTO_OK
PTGNode PTGFourArgs(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGFourArgs(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGFourArgs n;
	if(p1 == PTGNULL && p2 == PTGNULL && p3 == PTGNULL && p4 == PTGNULL)
		return PTGNULL;
	n = (_PPTGFourArgs)MALLOC(sizeof(struct _SPTGFourArgs));
	n->_print = (_PTGProc)_PrPTGFourArgs;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern AccDoLoop1 */

typedef struct _SPTGAccDoLoop1{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
	PTGNode p8;
} * _PPTGAccDoLoop1;

#ifdef PROTO_OK
static void _PrPTGAccDoLoop1(_PPTGAccDoLoop1 n)
#else
static void _PrPTGAccDoLoop1(n)
	_PPTGAccDoLoop1 n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " = ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "//");
	n->p7->_print(n->p7);
	n->p8->_print(n->p8);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAccDoLoop1(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8)
#else
PTGNode PTGAccDoLoop1(p1, p2, p3, p4, p5, p6, p7, p8)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
PTGNode p8;
#endif
{
	_PPTGAccDoLoop1 n;
	n = (_PPTGAccDoLoop1)MALLOC(sizeof(struct _SPTGAccDoLoop1));
	n->_print = (_PTGProc)_PrPTGAccDoLoop1;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	n->p8 = p8;
	return (PTGNode)n;
}


/* Implementation of Pattern AccDoLoop */

typedef struct _SPTGAccDoLoop{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
	PTGNode p8;
	PTGNode p9;
} * _PPTGAccDoLoop;

#ifdef PROTO_OK
static void _PrPTGAccDoLoop(_PPTGAccDoLoop n)
#else
static void _PrPTGAccDoLoop(n)
	_PPTGAccDoLoop n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " = ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "+");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p7->_print(n->p7);
	PTG_OUTPUT_STRING(f, "//");
	n->p8->_print(n->p8);
	n->p9->_print(n->p9);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAccDoLoop(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8, PTGNode p9)
#else
PTGNode PTGAccDoLoop(p1, p2, p3, p4, p5, p6, p7, p8, p9)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
PTGNode p8;
PTGNode p9;
#endif
{
	_PPTGAccDoLoop n;
	n = (_PPTGAccDoLoop)MALLOC(sizeof(struct _SPTGAccDoLoop));
	n->_print = (_PTGProc)_PrPTGAccDoLoop;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	n->p8 = p8;
	n->p9 = p9;
	return (PTGNode)n;
}


/* Implementation of Pattern Append */

typedef struct _SPTGAppend{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGAppend;

#ifdef PROTO_OK
static void _PrPTGAppend(_PPTGAppend n)
#else
static void _PrPTGAppend(n)
	_PPTGAppend n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAppend(PTGNode p1, PTGNode p2)
#else
PTGNode PTGAppend(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGAppend n;
	n = (_PPTGAppend)MALLOC(sizeof(struct _SPTGAppend));
	n->_print = (_PTGProc)_PrPTGAppend;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern AppendNL */

typedef struct _SPTGAppendNL{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGAppendNL;

#ifdef PROTO_OK
static void _PrPTGAppendNL(_PPTGAppendNL n)
#else
static void _PrPTGAppendNL(n)
	_PPTGAppendNL n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAppendNL(PTGNode p1, PTGNode p2)
#else
PTGNode PTGAppendNL(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGAppendNL n;
	n = (_PPTGAppendNL)MALLOC(sizeof(struct _SPTGAppendNL));
	n->_print = (_PTGProc)_PrPTGAppendNL;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern AppendMaxMinStmt */

typedef struct _SPTGAppendMaxMinStmt{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGAppendMaxMinStmt;

#ifdef PROTO_OK
static void _PrPTGAppendMaxMinStmt(_PPTGAppendMaxMinStmt n)
#else
static void _PrPTGAppendMaxMinStmt(n)
	_PPTGAppendMaxMinStmt n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	IndentNewLine(f);
	n->p3->_print(n->p3);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAppendMaxMinStmt(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGAppendMaxMinStmt(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGAppendMaxMinStmt n;
	n = (_PPTGAppendMaxMinStmt)MALLOC(sizeof(struct _SPTGAppendMaxMinStmt));
	n->_print = (_PTGProc)_PrPTGAppendMaxMinStmt;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ArrayDim */

typedef struct _SPTGArrayDim{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGArrayDim;

#ifdef PROTO_OK
static void _PrPTGArrayDim(_PPTGArrayDim n)
#else
static void _PrPTGArrayDim(n)
	_PPTGArrayDim n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGArrayDim(PTGNode p1)
#else
PTGNode PTGArrayDim(p1)

PTGNode p1;
#endif
{
	_PPTGArrayDim n;
	n = (_PPTGArrayDim)MALLOC(sizeof(struct _SPTGArrayDim));
	n->_print = (_PTGProc)_PrPTGArrayDim;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ArrayDimSize */

typedef struct _SPTGArrayDimSize{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGArrayDimSize;

#ifdef PROTO_OK
static void _PrPTGArrayDimSize(_PPTGArrayDimSize n)
#else
static void _PrPTGArrayDimSize(n)
	_PPTGArrayDimSize n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "-");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "+1)");
}

#ifdef PROTO_OK
PTGNode PTGArrayDimSize(PTGNode p1, PTGNode p2)
#else
PTGNode PTGArrayDimSize(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGArrayDimSize n;
	n = (_PPTGArrayDimSize)MALLOC(sizeof(struct _SPTGArrayDimSize));
	n->_print = (_PTGProc)_PrPTGArrayDimSize;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern BeginAppend */

typedef struct _SPTGBeginAppend{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGBeginAppend;

#ifdef PROTO_OK
static void _PrPTGBeginAppend(_PPTGBeginAppend n)
#else
static void _PrPTGBeginAppend(n)
	_PPTGBeginAppend n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGBeginAppend(PTGNode p1)
#else
PTGNode PTGBeginAppend(p1)

PTGNode p1;
#endif
{
	_PPTGBeginAppend n;
	n = (_PPTGBeginAppend)MALLOC(sizeof(struct _SPTGBeginAppend));
	n->_print = (_PTGProc)_PrPTGBeginAppend;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Brackets */

typedef struct _SPTGBrackets{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGBrackets;

#ifdef PROTO_OK
static void _PrPTGBrackets(_PPTGBrackets n)
#else
static void _PrPTGBrackets(n)
	_PPTGBrackets n;
#endif
{
	PTG_OUTPUT_STRING(f, "[");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "]");
}

#ifdef PROTO_OK
PTGNode PTGBrackets(PTGNode p1)
#else
PTGNode PTGBrackets(p1)

PTGNode p1;
#endif
{
	_PPTGBrackets n;
	n = (_PPTGBrackets)MALLOC(sizeof(struct _SPTGBrackets));
	n->_print = (_PTGProc)_PrPTGBrackets;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ArrayRef */

typedef struct _SPTGArrayRef{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGArrayRef;

#ifdef PROTO_OK
static void _PrPTGArrayRef(_PPTGArrayRef n)
#else
static void _PrPTGArrayRef(n)
	_PPTGArrayRef n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGArrayRef(PTGNode p1, PTGNode p2)
#else
PTGNode PTGArrayRef(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGArrayRef n;
	if(p1 == PTGNULL && p2 == PTGNULL)
		return PTGNULL;
	n = (_PPTGArrayRef)MALLOC(sizeof(struct _SPTGArrayRef));
	n->_print = (_PTGProc)_PrPTGArrayRef;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ArrayRefArg */

typedef struct _SPTGArrayRefArg{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGArrayRefArg;

#ifdef PROTO_OK
static void _PrPTGArrayRefArg(_PPTGArrayRefArg n)
#else
static void _PrPTGArrayRefArg(n)
	_PPTGArrayRefArg n;
#endif
{
	PTG_OUTPUT_STRING(f, "&");
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGArrayRefArg(PTGNode p1, PTGNode p2)
#else
PTGNode PTGArrayRefArg(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGArrayRefArg n;
	n = (_PPTGArrayRefArg)MALLOC(sizeof(struct _SPTGArrayRefArg));
	n->_print = (_PTGProc)_PrPTGArrayRefArg;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ArraySize */

typedef struct _SPTGArraySize{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGArraySize;

#ifdef PROTO_OK
static void _PrPTGArraySize(_PPTGArraySize n)
#else
static void _PrPTGArraySize(n)
	_PPTGArraySize n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "*");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGArraySize(PTGNode p1, PTGNode p2)
#else
PTGNode PTGArraySize(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGArraySize n;
	n = (_PPTGArraySize)MALLOC(sizeof(struct _SPTGArraySize));
	n->_print = (_PTGProc)_PrPTGArraySize;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern AssignStmt1 */

typedef struct _SPTGAssignStmt1{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGAssignStmt1;

#ifdef PROTO_OK
static void _PrPTGAssignStmt1(_PPTGAssignStmt1 n)
#else
static void _PrPTGAssignStmt1(n)
	_PPTGAssignStmt1 n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " = ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
}

#ifdef PROTO_OK
PTGNode PTGAssignStmt1(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGAssignStmt1(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGAssignStmt1 n;
	n = (_PPTGAssignStmt1)MALLOC(sizeof(struct _SPTGAssignStmt1));
	n->_print = (_PTGProc)_PrPTGAssignStmt1;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern AssignStmt2 */

typedef struct _SPTGAssignStmt2{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGAssignStmt2;

#ifdef PROTO_OK
static void _PrPTGAssignStmt2(_PPTGAssignStmt2 n)
#else
static void _PrPTGAssignStmt2(n)
	_PPTGAssignStmt2 n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " = ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
}

#ifdef PROTO_OK
PTGNode PTGAssignStmt2(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGAssignStmt2(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGAssignStmt2 n;
	n = (_PPTGAssignStmt2)MALLOC(sizeof(struct _SPTGAssignStmt2));
	n->_print = (_PTGProc)_PrPTGAssignStmt2;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern BlockIndex */

typedef struct _SPTGBlockIndex{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGBlockIndex;

#ifdef PROTO_OK
static void _PrPTGBlockIndex(_PPTGBlockIndex n)
#else
static void _PrPTGBlockIndex(n)
	_PPTGBlockIndex n;
#endif
{
	PTG_OUTPUT_STRING(f, "(blockIdx.");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "*");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")+(threadIdx.");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "/(blockDim.");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "/");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "))+");
	n->p6->_print(n->p6);
}

#ifdef PROTO_OK
PTGNode PTGBlockIndex(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGBlockIndex(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGBlockIndex n;
	n = (_PPTGBlockIndex)MALLOC(sizeof(struct _SPTGBlockIndex));
	n->_print = (_PTGProc)_PrPTGBlockIndex;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern BlockIndex0 */

typedef struct _SPTGBlockIndex0{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGBlockIndex0;

#ifdef PROTO_OK
static void _PrPTGBlockIndex0(_PPTGBlockIndex0 n)
#else
static void _PrPTGBlockIndex0(n)
	_PPTGBlockIndex0 n;
#endif
{
	PTG_OUTPUT_STRING(f, "(blockIdx.");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "*");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")+(threadIdx.");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "/(blockDim.");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "/");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "))");
}

#ifdef PROTO_OK
PTGNode PTGBlockIndex0(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGBlockIndex0(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGBlockIndex0 n;
	n = (_PPTGBlockIndex0)MALLOC(sizeof(struct _SPTGBlockIndex0));
	n->_print = (_PTGProc)_PrPTGBlockIndex0;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern BlockIndexDef */

typedef struct _SPTGBlockIndexDef{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGBlockIndexDef;

#ifdef PROTO_OK
static void _PrPTGBlockIndexDef(_PPTGBlockIndexDef n)
#else
static void _PrPTGBlockIndexDef(n)
	_PPTGBlockIndexDef n;
#endif
{
	PTG_OUTPUT_STRING(f, "blockIdx.");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "+");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGBlockIndexDef(PTGNode p1, PTGNode p2)
#else
PTGNode PTGBlockIndexDef(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGBlockIndexDef n;
	n = (_PPTGBlockIndexDef)MALLOC(sizeof(struct _SPTGBlockIndexDef));
	n->_print = (_PTGProc)_PrPTGBlockIndexDef;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern BlockThread */

typedef struct _SPTGBlockThread{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGBlockThread;

#ifdef PROTO_OK
static void _PrPTGBlockThread(_PPTGBlockThread n)
#else
static void _PrPTGBlockThread(n)
	_PPTGBlockThread n;
#endif
{
	PTG_OUTPUT_STRING(f, "(blockIdx.");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "*blockDim.");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")+threadIdx.");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "+");
	n->p4->_print(n->p4);
}

#ifdef PROTO_OK
PTGNode PTGBlockThread(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGBlockThread(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGBlockThread n;
	n = (_PPTGBlockThread)MALLOC(sizeof(struct _SPTGBlockThread));
	n->_print = (_PTGProc)_PrPTGBlockThread;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern CommaArgs */

typedef struct _SPTGCommaArgs{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGCommaArgs;

#ifdef PROTO_OK
static void _PrPTGCommaArgs(_PPTGCommaArgs n)
#else
static void _PrPTGCommaArgs(n)
	_PPTGCommaArgs n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGCommaArgs(PTGNode p1, PTGNode p2)
#else
PTGNode PTGCommaArgs(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGCommaArgs n;
	n = (_PPTGCommaArgs)MALLOC(sizeof(struct _SPTGCommaArgs));
	n->_print = (_PTGProc)_PrPTGCommaArgs;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ComplexConst */

typedef struct _SPTGComplexConst{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGComplexConst;

#ifdef PROTO_OK
static void _PrPTGComplexConst(_PPTGComplexConst n)
#else
static void _PrPTGComplexConst(n)
	_PPTGComplexConst n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGComplexConst(PTGNode p1, PTGNode p2)
#else
PTGNode PTGComplexConst(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGComplexConst n;
	n = (_PPTGComplexConst)MALLOC(sizeof(struct _SPTGComplexConst));
	n->_print = (_PTGProc)_PrPTGComplexConst;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern C_Decl */

typedef struct _SPTGC_Decl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGC_Decl;

#ifdef PROTO_OK
static void _PrPTGC_Decl(_PPTGC_Decl n)
#else
static void _PrPTGC_Decl(n)
	_PPTGC_Decl n;
#endif
{
	PTG_OUTPUT_STRING(f, "  ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "=*");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGC_Decl(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGC_Decl(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGC_Decl n;
	n = (_PPTGC_Decl)MALLOC(sizeof(struct _SPTGC_Decl));
	n->_print = (_PTGProc)_PrPTGC_Decl;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern DataStmt */

typedef struct _SPTGDataStmt{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGDataStmt;

#ifdef PROTO_OK
static void _PrPTGDataStmt(_PPTGDataStmt n)
#else
static void _PrPTGDataStmt(n)
	_PPTGDataStmt n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "static ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "[");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "] = {");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "};");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDataStmt(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGDataStmt(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGDataStmt n;
	n = (_PPTGDataStmt)MALLOC(sizeof(struct _SPTGDataStmt));
	n->_print = (_PTGProc)_PrPTGDataStmt;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclareLoopVar */

typedef struct _SPTGDeclareLoopVar{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDeclareLoopVar;

#ifdef PROTO_OK
static void _PrPTGDeclareLoopVar(_PPTGDeclareLoopVar n)
#else
static void _PrPTGDeclareLoopVar(n)
	_PPTGDeclareLoopVar n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "int ii_");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDeclareLoopVar(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDeclareLoopVar(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDeclareLoopVar n;
	n = (_PPTGDeclareLoopVar)MALLOC(sizeof(struct _SPTGDeclareLoopVar));
	n->_print = (_PTGProc)_PrPTGDeclareLoopVar;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern DefAppend */

typedef struct _SPTGDefAppend{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDefAppend;

#ifdef PROTO_OK
static void _PrPTGDefAppend(_PPTGDefAppend n)
#else
static void _PrPTGDefAppend(n)
	_PPTGDefAppend n;
#endif
{
	PTG_OUTPUT_STRING(f, "remove ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDefAppend(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDefAppend(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDefAppend n;
	n = (_PPTGDefAppend)MALLOC(sizeof(struct _SPTGDefAppend));
	n->_print = (_PTGProc)_PrPTGDefAppend;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern DeviceInit */

typedef struct _SPTGDeviceInit{
	_PTGProc _print;
} * _PPTGDeviceInit;

#ifdef PROTO_OK
static void _PrPTGDeviceInit(_PPTGDeviceInit n)
#else
static void _PrPTGDeviceInit(n)
	_PPTGDeviceInit n;
#endif
{
	PTG_OUTPUT_STRING(f, "  int argc=2;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  char *argv[]= {\"\",\"-device=0\"};");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  CUT_DEVICE_INIT(argc, argv);");
	IndentNewLine(f);
	IndentNewLine(f);
}

static struct _SPTGDeviceInit _sptgDeviceInit = { (_PTGProc) _PrPTGDeviceInit };

#ifdef PROTO_OK
PTGNode PTGDeviceInit(void)
#else
PTGNode PTGDeviceInit()
#endif
{
	return (PTGNode)(&_sptgDeviceInit);
}


/* Implementation of Pattern DefineGlobalCR */

typedef struct _SPTGDefineGlobalCR{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDefineGlobalCR;

#ifdef PROTO_OK
static void _PrPTGDefineGlobalCR(_PPTGDefineGlobalCR n)
#else
static void _PrPTGDefineGlobalCR(n)
	_PPTGDefineGlobalCR n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "=");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDefineGlobalCR(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDefineGlobalCR(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDefineGlobalCR n;
	n = (_PPTGDefineGlobalCR)MALLOC(sizeof(struct _SPTGDefineGlobalCR));
	n->_print = (_PTGProc)_PrPTGDefineGlobalCR;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern DefineGlobalCRP */

typedef struct _SPTGDefineGlobalCRP{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDefineGlobalCRP;

#ifdef PROTO_OK
static void _PrPTGDefineGlobalCRP(_PPTGDefineGlobalCRP n)
#else
static void _PrPTGDefineGlobalCRP(n)
	_PPTGDefineGlobalCRP n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "=");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDefineGlobalCRP(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDefineGlobalCRP(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDefineGlobalCRP n;
	n = (_PPTGDefineGlobalCRP)MALLOC(sizeof(struct _SPTGDefineGlobalCRP));
	n->_print = (_PTGProc)_PrPTGDefineGlobalCRP;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern Else */

typedef struct _SPTGElse{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGElse;

#ifdef PROTO_OK
static void _PrPTGElse(_PPTGElse n)
#else
static void _PrPTGElse(n)
	_PPTGElse n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "} else {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGElse(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGElse(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGElse n;
	n = (_PPTGElse)MALLOC(sizeof(struct _SPTGElse));
	n->_print = (_PTGProc)_PrPTGElse;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ElseIf */

typedef struct _SPTGElseIf{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGElseIf;

#ifdef PROTO_OK
static void _PrPTGElseIf(_PPTGElseIf n)
#else
static void _PrPTGElseIf(n)
	_PPTGElseIf n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "} else if ( ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " ) {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGElseIf(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGElseIf(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGElseIf n;
	n = (_PPTGElseIf)MALLOC(sizeof(struct _SPTGElseIf));
	n->_print = (_PTGProc)_PrPTGElseIf;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern EndAppend */

typedef struct _SPTGEndAppend{
	_PTGProc _print;
} * _PPTGEndAppend;

#ifdef PROTO_OK
static void _PrPTGEndAppend(_PPTGEndAppend n)
#else
static void _PrPTGEndAppend(n)
	_PPTGEndAppend n;
#endif
{
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

static struct _SPTGEndAppend _sptgEndAppend = { (_PTGProc) _PrPTGEndAppend };

#ifdef PROTO_OK
PTGNode PTGEndAppend(void)
#else
PTGNode PTGEndAppend()
#endif
{
	return (PTGNode)(&_sptgEndAppend);
}


/* Implementation of Pattern EndifStmt */

typedef struct _SPTGEndifStmt{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGEndifStmt;

#ifdef PROTO_OK
static void _PrPTGEndifStmt(_PPTGEndifStmt n)
#else
static void _PrPTGEndifStmt(n)
	_PPTGEndifStmt n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGEndifStmt(PTGNode p1, PTGNode p2)
#else
PTGNode PTGEndifStmt(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGEndifStmt n;
	n = (_PPTGEndifStmt)MALLOC(sizeof(struct _SPTGEndifStmt));
	n->_print = (_PTGProc)_PrPTGEndifStmt;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern EndLoop */

typedef struct _SPTGEndLoop{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGEndLoop;

#ifdef PROTO_OK
static void _PrPTGEndLoop(_PPTGEndLoop n)
#else
static void _PrPTGEndLoop(n)
	_PPTGEndLoop n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
	n->p5->_print(n->p5);
}

#ifdef PROTO_OK
PTGNode PTGEndLoop(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGEndLoop(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGEndLoop n;
	n = (_PPTGEndLoop)MALLOC(sizeof(struct _SPTGEndLoop));
	n->_print = (_PTGProc)_PrPTGEndLoop;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern EndLoopAppend */

typedef struct _SPTGEndLoopAppend{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGEndLoopAppend;

#ifdef PROTO_OK
static void _PrPTGEndLoopAppend(_PPTGEndLoopAppend n)
#else
static void _PrPTGEndLoopAppend(n)
	_PPTGEndLoopAppend n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGEndLoopAppend(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGEndLoopAppend(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGEndLoopAppend n;
	n = (_PPTGEndLoopAppend)MALLOC(sizeof(struct _SPTGEndLoopAppend));
	n->_print = (_PTGProc)_PrPTGEndLoopAppend;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern Exit */

typedef struct _SPTGExit{
	_PTGProc _print;
} * _PPTGExit;

#ifdef PROTO_OK
static void _PrPTGExit(_PPTGExit n)
#else
static void _PrPTGExit(n)
	_PPTGExit n;
#endif
{
	PTG_OUTPUT_STRING(f, "exit(0);");
}

static struct _SPTGExit _sptgExit = { (_PTGProc) _PrPTGExit };

#ifdef PROTO_OK
PTGNode PTGExit(void)
#else
PTGNode PTGExit()
#endif
{
	return (PTGNode)(&_sptgExit);
}


/* Implementation of Pattern EndRoutine */

typedef struct _SPTGEndRoutine{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGEndRoutine;

#ifdef PROTO_OK
static void _PrPTGEndRoutine(_PPTGEndRoutine n)
#else
static void _PrPTGEndRoutine(n)
	_PPTGEndRoutine n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " }");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGEndRoutine(PTGNode p1)
#else
PTGNode PTGEndRoutine(p1)

PTGNode p1;
#endif
{
	_PPTGEndRoutine n;
	n = (_PPTGEndRoutine)MALLOC(sizeof(struct _SPTGEndRoutine));
	n->_print = (_PTGProc)_PrPTGEndRoutine;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern EndRoutineGPU */

typedef struct _SPTGEndRoutineGPU{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGEndRoutineGPU;

#ifdef PROTO_OK
static void _PrPTGEndRoutineGPU(_PPTGEndRoutineGPU n)
#else
static void _PrPTGEndRoutineGPU(n)
	_PPTGEndRoutineGPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "remove ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p2->_print(n->p2);
	IndentNewLine(f);
	n->p3->_print(n->p3);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGEndRoutineGPU(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGEndRoutineGPU(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGEndRoutineGPU n;
	n = (_PPTGEndRoutineGPU)MALLOC(sizeof(struct _SPTGEndRoutineGPU));
	n->_print = (_PTGProc)_PrPTGEndRoutineGPU;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern Expr */

typedef struct _SPTGExpr{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGExpr;

#ifdef PROTO_OK
static void _PrPTGExpr(_PPTGExpr n)
#else
static void _PrPTGExpr(n)
	_PPTGExpr n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGExpr(PTGNode p1)
#else
PTGNode PTGExpr(p1)

PTGNode p1;
#endif
{
	_PPTGExpr n;
	n = (_PPTGExpr)MALLOC(sizeof(struct _SPTGExpr));
	n->_print = (_PTGProc)_PrPTGExpr;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ExprArgs */

typedef struct _SPTGExprArgs{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGExprArgs;

#ifdef PROTO_OK
static void _PrPTGExprArgs(_PPTGExprArgs n)
#else
static void _PrPTGExprArgs(n)
	_PPTGExprArgs n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGExprArgs(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGExprArgs(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGExprArgs n;
	n = (_PPTGExprArgs)MALLOC(sizeof(struct _SPTGExprArgs));
	n->_print = (_PTGProc)_PrPTGExprArgs;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ExternDecl */

typedef struct _SPTGExternDecl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGExternDecl;

#ifdef PROTO_OK
static void _PrPTGExternDecl(_PPTGExternDecl n)
#else
static void _PrPTGExternDecl(n)
	_PPTGExternDecl n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " void ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "( ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGExternDecl(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGExternDecl(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGExternDecl n;
	n = (_PPTGExternDecl)MALLOC(sizeof(struct _SPTGExternDecl));
	n->_print = (_PTGProc)_PrPTGExternDecl;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern FreeAlloc */

typedef struct _SPTGFreeAlloc{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGFreeAlloc;

#ifdef PROTO_OK
static void _PrPTGFreeAlloc(_PPTGFreeAlloc n)
#else
static void _PrPTGFreeAlloc(n)
	_PPTGFreeAlloc n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "free(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGFreeAlloc(PTGNode p1, PTGNode p2)
#else
PTGNode PTGFreeAlloc(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGFreeAlloc n;
	n = (_PPTGFreeAlloc)MALLOC(sizeof(struct _SPTGFreeAlloc));
	n->_print = (_PTGProc)_PrPTGFreeAlloc;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ForLoop */

typedef struct _SPTGForLoop{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGForLoop;

#ifdef PROTO_OK
static void _PrPTGForLoop(_PPTGForLoop n)
#else
static void _PrPTGForLoop(n)
	_PPTGForLoop n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "for ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGForLoop(PTGNode p1, PTGNode p2)
#else
PTGNode PTGForLoop(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGForLoop n;
	n = (_PPTGForLoop)MALLOC(sizeof(struct _SPTGForLoop));
	n->_print = (_PTGProc)_PrPTGForLoop;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern FTNFunction */

typedef struct _SPTGFTNFunction{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGFTNFunction;

#ifdef PROTO_OK
static void _PrPTGFTNFunction(_PPTGFTNFunction n)
#else
static void _PrPTGFTNFunction(n)
	_PPTGFTNFunction n;
#endif
{
	PTG_OUTPUT_STRING(f, "FTNREF");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "D(");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGFTNFunction(PTGNode p1, PTGNode p2)
#else
PTGNode PTGFTNFunction(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGFTNFunction n;
	n = (_PPTGFTNFunction)MALLOC(sizeof(struct _SPTGFTNFunction));
	n->_print = (_PTGProc)_PrPTGFTNFunction;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern FunctionCall */

typedef struct _SPTGFunctionCall{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGFunctionCall;

#ifdef PROTO_OK
static void _PrPTGFunctionCall(_PPTGFunctionCall n)
#else
static void _PrPTGFunctionCall(n)
	_PPTGFunctionCall n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " = ");
}

#ifdef PROTO_OK
PTGNode PTGFunctionCall(PTGNode p1, PTGNode p2)
#else
PTGNode PTGFunctionCall(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGFunctionCall n;
	n = (_PPTGFunctionCall)MALLOC(sizeof(struct _SPTGFunctionCall));
	n->_print = (_PTGProc)_PrPTGFunctionCall;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern FunctionDecl */

typedef struct _SPTGFunctionDecl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGFunctionDecl;

#ifdef PROTO_OK
static void _PrPTGFunctionDecl(_PPTGFunctionDecl n)
#else
static void _PrPTGFunctionDecl(n)
	_PPTGFunctionDecl n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " ");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGFunctionDecl(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGFunctionDecl(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGFunctionDecl n;
	n = (_PPTGFunctionDecl)MALLOC(sizeof(struct _SPTGFunctionDecl));
	n->_print = (_PTGProc)_PrPTGFunctionDecl;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern FunctionRef */

typedef struct _SPTGFunctionRef{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGFunctionRef;

#ifdef PROTO_OK
static void _PrPTGFunctionRef(_PPTGFunctionRef n)
#else
static void _PrPTGFunctionRef(n)
	_PPTGFunctionRef n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGFunctionRef(PTGNode p1, PTGNode p2)
#else
PTGNode PTGFunctionRef(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGFunctionRef n;
	n = (_PPTGFunctionRef)MALLOC(sizeof(struct _SPTGFunctionRef));
	n->_print = (_PTGProc)_PrPTGFunctionRef;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern GenerateForLoop */

typedef struct _SPTGGenerateForLoop{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGGenerateForLoop;

#ifdef PROTO_OK
static void _PrPTGGenerateForLoop(_PPTGGenerateForLoop n)
#else
static void _PrPTGGenerateForLoop(n)
	_PPTGGenerateForLoop n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "for(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "=");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "<=");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ";");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "++) {");
}

#ifdef PROTO_OK
PTGNode PTGGenerateForLoop(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGGenerateForLoop(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGGenerateForLoop n;
	n = (_PPTGGenerateForLoop)MALLOC(sizeof(struct _SPTGGenerateForLoop));
	n->_print = (_PTGProc)_PrPTGGenerateForLoop;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern GenerateEndLoop */

typedef struct _SPTGGenerateEndLoop{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGGenerateEndLoop;

#ifdef PROTO_OK
static void _PrPTGGenerateEndLoop(_PPTGGenerateEndLoop n)
#else
static void _PrPTGGenerateEndLoop(n)
	_PPTGGenerateEndLoop n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "}");
}

#ifdef PROTO_OK
PTGNode PTGGenerateEndLoop(PTGNode p1)
#else
PTGNode PTGGenerateEndLoop(p1)

PTGNode p1;
#endif
{
	_PPTGGenerateEndLoop n;
	n = (_PPTGGenerateEndLoop)MALLOC(sizeof(struct _SPTGGenerateEndLoop));
	n->_print = (_PTGProc)_PrPTGGenerateEndLoop;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern GlobalMemoryDeclareVars */

typedef struct _SPTGGlobalMemoryDeclareVars{
	_PTGProc _print;
} * _PPTGGlobalMemoryDeclareVars;

#ifdef PROTO_OK
static void _PrPTGGlobalMemoryDeclareVars(_PPTGGlobalMemoryDeclareVars n)
#else
static void _PrPTGGlobalMemoryDeclareVars(n)
	_PPTGGlobalMemoryDeclareVars n;
#endif
{
	PTG_OUTPUT_STRING(f, "  // int GlobalMemorySize;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, " // int GlobalMemoryCnt = 0;");
	IndentNewLine(f);
}

static struct _SPTGGlobalMemoryDeclareVars _sptgGlobalMemoryDeclareVars = { (_PTGProc) _PrPTGGlobalMemoryDeclareVars };

#ifdef PROTO_OK
PTGNode PTGGlobalMemoryDeclareVars(void)
#else
PTGNode PTGGlobalMemoryDeclareVars()
#endif
{
	return (PTGNode)(&_sptgGlobalMemoryDeclareVars);
}


/* Implementation of Pattern GPUReturn */

typedef struct _SPTGGPUReturn{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGGPUReturn;

#ifdef PROTO_OK
static void _PrPTGGPUReturn(_PPTGGPUReturn n)
#else
static void _PrPTGGPUReturn(n)
	_PPTGGPUReturn n;
#endif
{
	PTG_OUTPUT_STRING(f, "remove ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p2->_print(n->p2);
	IndentNewLine(f);
	n->p3->_print(n->p3);
	IndentNewLine(f);
	n->p4->_print(n->p4);
	n->p5->_print(n->p5);
	n->p6->_print(n->p6);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGGPUReturn(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGGPUReturn(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGGPUReturn n;
	n = (_PPTGGPUReturn)MALLOC(sizeof(struct _SPTGGPUReturn));
	n->_print = (_PTGProc)_PrPTGGPUReturn;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern GoTo */

typedef struct _SPTGGoTo{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGGoTo;

#ifdef PROTO_OK
static void _PrPTGGoTo(_PPTGGoTo n)
#else
static void _PrPTGGoTo(n)
	_PPTGGoTo n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "goto ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
}

#ifdef PROTO_OK
PTGNode PTGGoTo(PTGNode p1, PTGNode p2)
#else
PTGNode PTGGoTo(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGGoTo n;
	n = (_PPTGGoTo)MALLOC(sizeof(struct _SPTGGoTo));
	n->_print = (_PTGProc)_PrPTGGoTo;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern IfThread */

typedef struct _SPTGIfThread{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGIfThread;

#ifdef PROTO_OK
static void _PrPTGIfThread(_PPTGIfThread n)
#else
static void _PrPTGIfThread(n)
	_PPTGIfThread n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "if ((");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " >= ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ") && (");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " <= ");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ")) {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGIfThread(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGIfThread(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGIfThread n;
	n = (_PPTGIfThread)MALLOC(sizeof(struct _SPTGIfThread));
	n->_print = (_PTGProc)_PrPTGIfThread;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern IfThreadEnd */

typedef struct _SPTGIfThreadEnd{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGIfThreadEnd;

#ifdef PROTO_OK
static void _PrPTGIfThreadEnd(_PPTGIfThreadEnd n)
#else
static void _PrPTGIfThreadEnd(n)
	_PPTGIfThreadEnd n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append  ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGIfThreadEnd(PTGNode p1, PTGNode p2)
#else
PTGNode PTGIfThreadEnd(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGIfThreadEnd n;
	n = (_PPTGIfThreadEnd)MALLOC(sizeof(struct _SPTGIfThreadEnd));
	n->_print = (_PTGProc)_PrPTGIfThreadEnd;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern IfStmt */

typedef struct _SPTGIfStmt{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGIfStmt;

#ifdef PROTO_OK
static void _PrPTGIfStmt(_PPTGIfStmt n)
#else
static void _PrPTGIfStmt(n)
	_PPTGIfStmt n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "if ( ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " ) {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGIfStmt(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGIfStmt(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGIfStmt n;
	n = (_PPTGIfStmt)MALLOC(sizeof(struct _SPTGIfStmt));
	n->_print = (_PTGProc)_PrPTGIfStmt;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern IfStmtSingle */

typedef struct _SPTGIfStmtSingle{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGIfStmtSingle;

#ifdef PROTO_OK
static void _PrPTGIfStmtSingle(_PPTGIfStmtSingle n)
#else
static void _PrPTGIfStmtSingle(n)
	_PPTGIfStmtSingle n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "if ( ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " ) { ");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, " }");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGIfStmtSingle(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGIfStmtSingle(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGIfStmtSingle n;
	n = (_PPTGIfStmtSingle)MALLOC(sizeof(struct _SPTGIfStmtSingle));
	n->_print = (_PTGProc)_PrPTGIfStmtSingle;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern IfStmtLabel */

typedef struct _SPTGIfStmtLabel{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGIfStmtLabel;

#ifdef PROTO_OK
static void _PrPTGIfStmtLabel(_PPTGIfStmtLabel n)
#else
static void _PrPTGIfStmtLabel(n)
	_PPTGIfStmtLabel n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "if ( ");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, " ) {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGIfStmtLabel(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGIfStmtLabel(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGIfStmtLabel n;
	n = (_PPTGIfStmtLabel)MALLOC(sizeof(struct _SPTGIfStmtLabel));
	n->_print = (_PTGProc)_PrPTGIfStmtLabel;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern IncludeFilesCPU */

typedef struct _SPTGIncludeFilesCPU{
	_PTGProc _print;
} * _PPTGIncludeFilesCPU;

#ifdef PROTO_OK
static void _PrPTGIncludeFilesCPU(_PPTGIncludeFilesCPU n)
#else
static void _PrPTGIncludeFilesCPU(n)
	_PPTGIncludeFilesCPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append 0 ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include <stdio.h>");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include <stdlib.h>");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include <math.h>");
	IndentNewLine(f);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include \"ftocmacros.h\"");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#define TRUE 1");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#define FALSE 0");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

static struct _SPTGIncludeFilesCPU _sptgIncludeFilesCPU = { (_PTGProc) _PrPTGIncludeFilesCPU };

#ifdef PROTO_OK
PTGNode PTGIncludeFilesCPU(void)
#else
PTGNode PTGIncludeFilesCPU()
#endif
{
	return (PTGNode)(&_sptgIncludeFilesCPU);
}


/* Implementation of Pattern IncludeFilesGPU */

typedef struct _SPTGIncludeFilesGPU{
	_PTGProc _print;
} * _PPTGIncludeFilesGPU;

#ifdef PROTO_OK
static void _PrPTGIncludeFilesGPU(_PPTGIncludeFilesGPU n)
#else
static void _PrPTGIncludeFilesGPU(n)
	_PPTGIncludeFilesGPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append 0 ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include <stdio.h>");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include <stdlib.h>");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include <math.h>");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include \"ftocmacros.h\"");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#include \"F2Cinclude.h\"");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#define TRUE 1");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "#define FALSE 0");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

static struct _SPTGIncludeFilesGPU _sptgIncludeFilesGPU = { (_PTGProc) _PrPTGIncludeFilesGPU };

#ifdef PROTO_OK
PTGNode PTGIncludeFilesGPU(void)
#else
PTGNode PTGIncludeFilesGPU()
#endif
{
	return (PTGNode)(&_sptgIncludeFilesGPU);
}


/* Implementation of Pattern Indent */

typedef struct _SPTGIndent{
	_PTGProc _print;
	int p1;
} * _PPTGIndent;

#ifdef PROTO_OK
static void _PrPTGIndent(_PPTGIndent n)
#else
static void _PrPTGIndent(n)
	_PPTGIndent n;
#endif
{
	IndentLabl(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGIndent(int p1)
#else
PTGNode PTGIndent(p1)

int p1;
#endif
{
	_PPTGIndent n;
	n = (_PPTGIndent)MALLOC(sizeof(struct _SPTGIndent));
	n->_print = (_PTGProc)_PrPTGIndent;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern IntrinsicRef */

typedef struct _SPTGIntrinsicRef{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGIntrinsicRef;

#ifdef PROTO_OK
static void _PrPTGIntrinsicRef(_PPTGIntrinsicRef n)
#else
static void _PrPTGIntrinsicRef(n)
	_PPTGIntrinsicRef n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGIntrinsicRef(PTGNode p1, PTGNode p2)
#else
PTGNode PTGIntrinsicRef(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGIntrinsicRef n;
	n = (_PPTGIntrinsicRef)MALLOC(sizeof(struct _SPTGIntrinsicRef));
	n->_print = (_PTGProc)_PrPTGIntrinsicRef;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Kind */

typedef struct _SPTGKind{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGKind;

#ifdef PROTO_OK
static void _PrPTGKind(_PPTGKind n)
#else
static void _PrPTGKind(n)
	_PPTGKind n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGKind(PTGNode p1, PTGNode p2)
#else
PTGNode PTGKind(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGKind n;
	n = (_PPTGKind)MALLOC(sizeof(struct _SPTGKind));
	n->_print = (_PTGProc)_PrPTGKind;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern LabelDef */

typedef struct _SPTGLabelDef{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGLabelDef;

#ifdef PROTO_OK
static void _PrPTGLabelDef(_PPTGLabelDef n)
#else
static void _PrPTGLabelDef(n)
	_PPTGLabelDef n;
#endif
{
	PTG_OUTPUT_STRING(f, "C__");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ":");
}

#ifdef PROTO_OK
PTGNode PTGLabelDef(PTGNode p1)
#else
PTGNode PTGLabelDef(p1)

PTGNode p1;
#endif
{
	_PPTGLabelDef n;
	n = (_PPTGLabelDef)MALLOC(sizeof(struct _SPTGLabelDef));
	n->_print = (_PTGProc)_PrPTGLabelDef;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern LabelRef */

typedef struct _SPTGLabelRef{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGLabelRef;

#ifdef PROTO_OK
static void _PrPTGLabelRef(_PPTGLabelRef n)
#else
static void _PrPTGLabelRef(n)
	_PPTGLabelRef n;
#endif
{
	PTG_OUTPUT_STRING(f, "C__");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGLabelRef(PTGNode p1)
#else
PTGNode PTGLabelRef(p1)

PTGNode p1;
#endif
{
	_PPTGLabelRef n;
	n = (_PPTGLabelRef)MALLOC(sizeof(struct _SPTGLabelRef));
	n->_print = (_PTGProc)_PrPTGLabelRef;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern LoopBounds */

typedef struct _SPTGLoopBounds{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGLoopBounds;

#ifdef PROTO_OK
static void _PrPTGLoopBounds(_PPTGLoopBounds n)
#else
static void _PrPTGLoopBounds(n)
	_PPTGLoopBounds n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "=");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "<=");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "++)");
}

#ifdef PROTO_OK
PTGNode PTGLoopBounds(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGLoopBounds(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGLoopBounds n;
	n = (_PPTGLoopBounds)MALLOC(sizeof(struct _SPTGLoopBounds));
	n->_print = (_PTGProc)_PrPTGLoopBounds;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern LoopGen */

typedef struct _SPTGLoopGen{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGLoopGen;

#ifdef PROTO_OK
static void _PrPTGLoopGen(_PPTGLoopGen n)
#else
static void _PrPTGLoopGen(n)
	_PPTGLoopGen n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "for (");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "=");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "<=");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ";");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "++) {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGLoopGen(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGLoopGen(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGLoopGen n;
	n = (_PPTGLoopGen)MALLOC(sizeof(struct _SPTGLoopGen));
	n->_print = (_PTGProc)_PrPTGLoopGen;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern LoopGenEnd */

typedef struct _SPTGLoopGenEnd{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGLoopGenEnd;

#ifdef PROTO_OK
static void _PrPTGLoopGenEnd(_PPTGLoopGenEnd n)
#else
static void _PrPTGLoopGenEnd(n)
	_PPTGLoopGenEnd n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGLoopGenEnd(PTGNode p1)
#else
PTGNode PTGLoopGenEnd(p1)

PTGNode p1;
#endif
{
	_PPTGLoopGenEnd n;
	n = (_PPTGLoopGenEnd)MALLOC(sizeof(struct _SPTGLoopGenEnd));
	n->_print = (_PTGProc)_PrPTGLoopGenEnd;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Malloc */

typedef struct _SPTGMalloc{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGMalloc;

#ifdef PROTO_OK
static void _PrPTGMalloc(_PPTGMalloc n)
#else
static void _PrPTGMalloc(n)
	_PPTGMalloc n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " *");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " = (");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "*) malloc(");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "*sizeof(");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "));");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGMalloc(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGMalloc(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGMalloc n;
	n = (_PPTGMalloc)MALLOC(sizeof(struct _SPTGMalloc));
	n->_print = (_PTGProc)_PrPTGMalloc;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern MallocTest */

typedef struct _SPTGMallocTest{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGMallocTest;

#ifdef PROTO_OK
static void _PrPTGMallocTest(_PPTGMallocTest n)
#else
static void _PrPTGMallocTest(n)
	_PPTGMallocTest n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "if (");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " == NULL) {");
	IndentNewLine(f);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "  printf(\"ERROR: memory allocation error\");");
	IndentNewLine(f);
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "  exit(1);");
	IndentNewLine(f);
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGMallocTest(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGMallocTest(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGMallocTest n;
	n = (_PPTGMallocTest)MALLOC(sizeof(struct _SPTGMallocTest));
	n->_print = (_PTGProc)_PrPTGMallocTest;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern Max */

typedef struct _SPTGMax{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGMax;

#ifdef PROTO_OK
static void _PrPTGMax(_PPTGMax n)
#else
static void _PrPTGMax(n)
	_PPTGMax n;
#endif
{
	PTG_OUTPUT_STRING(f, "fmaxf(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGMax(PTGNode p1, PTGNode p2)
#else
PTGNode PTGMax(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGMax n;
	n = (_PPTGMax)MALLOC(sizeof(struct _SPTGMax));
	n->_print = (_PTGProc)_PrPTGMax;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Min */

typedef struct _SPTGMin{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGMin;

#ifdef PROTO_OK
static void _PrPTGMin(_PPTGMin n)
#else
static void _PrPTGMin(n)
	_PPTGMin n;
#endif
{
	PTG_OUTPUT_STRING(f, "fminf(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGMin(PTGNode p1, PTGNode p2)
#else
PTGNode PTGMin(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGMin n;
	n = (_PPTGMin)MALLOC(sizeof(struct _SPTGMin));
	n->_print = (_PTGProc)_PrPTGMin;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Mod */

typedef struct _SPTGMod{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGMod;

#ifdef PROTO_OK
static void _PrPTGMod(_PPTGMod n)
#else
static void _PrPTGMod(n)
	_PPTGMod n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ") % (");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGMod(PTGNode p1, PTGNode p2)
#else
PTGNode PTGMod(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGMod n;
	n = (_PPTGMod)MALLOC(sizeof(struct _SPTGMod));
	n->_print = (_PTGProc)_PrPTGMod;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern MulSequence */

typedef struct _SPTGMulSequence{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGMulSequence;

#ifdef PROTO_OK
static void _PrPTGMulSequence(_PPTGMulSequence n)
#else
static void _PrPTGMulSequence(n)
	_PPTGMulSequence n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "*(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGMulSequence(PTGNode p1, PTGNode p2)
#else
PTGNode PTGMulSequence(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGMulSequence n;
	n = (_PPTGMulSequence)MALLOC(sizeof(struct _SPTGMulSequence));
	n->_print = (_PTGProc)_PrPTGMulSequence;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Number */

typedef struct _SPTGNumber{
	_PTGProc _print;
	int p1;
} * _PPTGNumber;

#ifdef PROTO_OK
static void _PrPTGNumber(_PPTGNumber n)
#else
static void _PrPTGNumber(n)
	_PPTGNumber n;
#endif
{
	PTG_OUTPUT_INT(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGNumber(int p1)
#else
PTGNode PTGNumber(p1)

int p1;
#endif
{
	_PPTGNumber n;
	n = (_PPTGNumber)MALLOC(sizeof(struct _SPTGNumber));
	n->_print = (_PTGProc)_PrPTGNumber;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Parens */

typedef struct _SPTGParens{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGParens;

#ifdef PROTO_OK
static void _PrPTGParens(_PPTGParens n)
#else
static void _PrPTGParens(n)
	_PPTGParens n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGParens(PTGNode p1)
#else
PTGNode PTGParens(p1)

PTGNode p1;
#endif
{
	_PPTGParens n;
	n = (_PPTGParens)MALLOC(sizeof(struct _SPTGParens));
	n->_print = (_PTGProc)_PrPTGParens;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern PowerExprFTN */

typedef struct _SPTGPowerExprFTN{
	_PTGProc _print;
} * _PPTGPowerExprFTN;

#ifdef PROTO_OK
static void _PrPTGPowerExprFTN(_PPTGPowerExprFTN n)
#else
static void _PrPTGPowerExprFTN(n)
	_PPTGPowerExprFTN n;
#endif
{
	PTG_OUTPUT_STRING(f, "ftn_powf_(&PowArg1F,&PowArg2F)");
}

static struct _SPTGPowerExprFTN _sptgPowerExprFTN = { (_PTGProc) _PrPTGPowerExprFTN };

#ifdef PROTO_OK
PTGNode PTGPowerExprFTN(void)
#else
PTGNode PTGPowerExprFTN()
#endif
{
	return (PTGNode)(&_sptgPowerExprFTN);
}


/* Implementation of Pattern PowerExprFTND */

typedef struct _SPTGPowerExprFTND{
	_PTGProc _print;
} * _PPTGPowerExprFTND;

#ifdef PROTO_OK
static void _PrPTGPowerExprFTND(_PPTGPowerExprFTND n)
#else
static void _PrPTGPowerExprFTND(n)
	_PPTGPowerExprFTND n;
#endif
{
	PTG_OUTPUT_STRING(f, "ftn_powd_(&PowArg1D,&PowArg2D)");
}

static struct _SPTGPowerExprFTND _sptgPowerExprFTND = { (_PTGProc) _PrPTGPowerExprFTND };

#ifdef PROTO_OK
PTGNode PTGPowerExprFTND(void)
#else
PTGNode PTGPowerExprFTND()
#endif
{
	return (PTGNode)(&_sptgPowerExprFTND);
}


/* Implementation of Pattern PowerExpr */

typedef struct _SPTGPowerExpr{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGPowerExpr;

#ifdef PROTO_OK
static void _PrPTGPowerExpr(_PPTGPowerExpr n)
#else
static void _PrPTGPowerExpr(n)
	_PPTGPowerExpr n;
#endif
{
	PTG_OUTPUT_STRING(f, "powf(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGPowerExpr(PTGNode p1, PTGNode p2)
#else
PTGNode PTGPowerExpr(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGPowerExpr n;
	n = (_PPTGPowerExpr)MALLOC(sizeof(struct _SPTGPowerExpr));
	n->_print = (_PTGProc)_PrPTGPowerExpr;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern PowerExprD */

typedef struct _SPTGPowerExprD{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGPowerExprD;

#ifdef PROTO_OK
static void _PrPTGPowerExprD(_PPTGPowerExprD n)
#else
static void _PrPTGPowerExprD(n)
	_PPTGPowerExprD n;
#endif
{
	PTG_OUTPUT_STRING(f, "pow(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGPowerExprD(PTGNode p1, PTGNode p2)
#else
PTGNode PTGPowerExprD(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGPowerExprD n;
	n = (_PPTGPowerExprD)MALLOC(sizeof(struct _SPTGPowerExprD));
	n->_print = (_PTGProc)_PrPTGPowerExprD;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern PowerVarsInit */

typedef struct _SPTGPowerVarsInit{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGPowerVarsInit;

#ifdef PROTO_OK
static void _PrPTGPowerVarsInit(_PPTGPowerVarsInit n)
#else
static void _PrPTGPowerVarsInit(n)
	_PPTGPowerVarsInit n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "PowArg1F = ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "PowArg2F = ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGPowerVarsInit(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGPowerVarsInit(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGPowerVarsInit n;
	n = (_PPTGPowerVarsInit)MALLOC(sizeof(struct _SPTGPowerVarsInit));
	n->_print = (_PTGProc)_PrPTGPowerVarsInit;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern PowerVarsInitD */

typedef struct _SPTGPowerVarsInitD{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGPowerVarsInitD;

#ifdef PROTO_OK
static void _PrPTGPowerVarsInitD(_PPTGPowerVarsInitD n)
#else
static void _PrPTGPowerVarsInitD(n)
	_PPTGPowerVarsInitD n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "PowArg1D = ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "PowArg2D = ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGPowerVarsInitD(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGPowerVarsInitD(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGPowerVarsInitD n;
	n = (_PPTGPowerVarsInitD)MALLOC(sizeof(struct _SPTGPowerVarsInitD));
	n->_print = (_PTGProc)_PrPTGPowerVarsInitD;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern PowerVarsFloat */

typedef struct _SPTGPowerVarsFloat{
	_PTGProc _print;
} * _PPTGPowerVarsFloat;

#ifdef PROTO_OK
static void _PrPTGPowerVarsFloat(_PPTGPowerVarsFloat n)
#else
static void _PrPTGPowerVarsFloat(n)
	_PPTGPowerVarsFloat n;
#endif
{
	PTG_OUTPUT_STRING(f, "  float PowArg1F,PowArg2F;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  float ftn_powf_(float *,float *);");
}

static struct _SPTGPowerVarsFloat _sptgPowerVarsFloat = { (_PTGProc) _PrPTGPowerVarsFloat };

#ifdef PROTO_OK
PTGNode PTGPowerVarsFloat(void)
#else
PTGNode PTGPowerVarsFloat()
#endif
{
	return (PTGNode)(&_sptgPowerVarsFloat);
}


/* Implementation of Pattern PowerVarsDouble */

typedef struct _SPTGPowerVarsDouble{
	_PTGProc _print;
} * _PPTGPowerVarsDouble;

#ifdef PROTO_OK
static void _PrPTGPowerVarsDouble(_PPTGPowerVarsDouble n)
#else
static void _PrPTGPowerVarsDouble(n)
	_PPTGPowerVarsDouble n;
#endif
{
	PTG_OUTPUT_STRING(f, "  double PowArg1D,PowArg2D;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  double ftn_powf_(double *,double *);");
}

static struct _SPTGPowerVarsDouble _sptgPowerVarsDouble = { (_PTGProc) _PrPTGPowerVarsDouble };

#ifdef PROTO_OK
PTGNode PTGPowerVarsDouble(void)
#else
PTGNode PTGPowerVarsDouble()
#endif
{
	return (PTGNode)(&_sptgPowerVarsDouble);
}


/* Implementation of Pattern QuotedString */

typedef struct _SPTGQuotedString{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGQuotedString;

#ifdef PROTO_OK
static void _PrPTGQuotedString(_PPTGQuotedString n)
#else
static void _PrPTGQuotedString(n)
	_PPTGQuotedString n;
#endif
{
	PTG_OUTPUT_STRING(f, "'");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "'");
}

#ifdef PROTO_OK
PTGNode PTGQuotedString(PTGNode p1)
#else
PTGNode PTGQuotedString(p1)

PTGNode p1;
#endif
{
	_PPTGQuotedString n;
	n = (_PPTGQuotedString)MALLOC(sizeof(struct _SPTGQuotedString));
	n->_print = (_PTGProc)_PrPTGQuotedString;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Remove */

typedef struct _SPTGRemove{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGRemove;

#ifdef PROTO_OK
static void _PrPTGRemove(_PPTGRemove n)
#else
static void _PrPTGRemove(n)
	_PPTGRemove n;
#endif
{
	PTG_OUTPUT_STRING(f, "remove ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGRemove(PTGNode p1)
#else
PTGNode PTGRemove(p1)

PTGNode p1;
#endif
{
	_PPTGRemove n;
	n = (_PPTGRemove)MALLOC(sizeof(struct _SPTGRemove));
	n->_print = (_PTGProc)_PrPTGRemove;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Replace */

typedef struct _SPTGReplace{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGReplace;

#ifdef PROTO_OK
static void _PrPTGReplace(_PPTGReplace n)
#else
static void _PrPTGReplace(n)
	_PPTGReplace n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGReplace(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGReplace(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGReplace n;
	n = (_PPTGReplace)MALLOC(sizeof(struct _SPTGReplace));
	n->_print = (_PTGProc)_PrPTGReplace;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ReplaceNoCR */

typedef struct _SPTGReplaceNoCR{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGReplaceNoCR;

#ifdef PROTO_OK
static void _PrPTGReplaceNoCR(_PPTGReplaceNoCR n)
#else
static void _PrPTGReplaceNoCR(n)
	_PPTGReplaceNoCR n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGReplaceNoCR(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGReplaceNoCR(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGReplaceNoCR n;
	n = (_PPTGReplaceNoCR)MALLOC(sizeof(struct _SPTGReplaceNoCR));
	n->_print = (_PTGProc)_PrPTGReplaceNoCR;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ReplaceMaxMin */

typedef struct _SPTGReplaceMaxMin{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGReplaceMaxMin;

#ifdef PROTO_OK
static void _PrPTGReplaceMaxMin(_PPTGReplaceMaxMin n)
#else
static void _PrPTGReplaceMaxMin(n)
	_PPTGReplaceMaxMin n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p2->_print(n->p2);
	IndentNewLine(f);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGReplaceMaxMin(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGReplaceMaxMin(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGReplaceMaxMin n;
	n = (_PPTGReplaceMaxMin)MALLOC(sizeof(struct _SPTGReplaceMaxMin));
	n->_print = (_PTGProc)_PrPTGReplaceMaxMin;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern RetName */

typedef struct _SPTGRetName{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGRetName;

#ifdef PROTO_OK
static void _PrPTGRetName(_PPTGRetName n)
#else
static void _PrPTGRetName(n)
	_PPTGRetName n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "R");
}

#ifdef PROTO_OK
PTGNode PTGRetName(PTGNode p1)
#else
PTGNode PTGRetName(p1)

PTGNode p1;
#endif
{
	_PPTGRetName n;
	n = (_PPTGRetName)MALLOC(sizeof(struct _SPTGRetName));
	n->_print = (_PTGProc)_PrPTGRetName;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Return */

typedef struct _SPTGReturn{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGReturn;

#ifdef PROTO_OK
static void _PrPTGReturn(_PPTGReturn n)
#else
static void _PrPTGReturn(n)
	_PPTGReturn n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "return;");
}

#ifdef PROTO_OK
PTGNode PTGReturn(PTGNode p1)
#else
PTGNode PTGReturn(p1)

PTGNode p1;
#endif
{
	_PPTGReturn n;
	n = (_PPTGReturn)MALLOC(sizeof(struct _SPTGReturn));
	n->_print = (_PTGProc)_PrPTGReturn;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern Break */

typedef struct _SPTGBreak{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGBreak;

#ifdef PROTO_OK
static void _PrPTGBreak(_PPTGBreak n)
#else
static void _PrPTGBreak(n)
	_PPTGBreak n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "break;");
}

#ifdef PROTO_OK
PTGNode PTGBreak(PTGNode p1)
#else
PTGNode PTGBreak(p1)

PTGNode p1;
#endif
{
	_PPTGBreak n;
	n = (_PPTGBreak)MALLOC(sizeof(struct _SPTGBreak));
	n->_print = (_PTGProc)_PrPTGBreak;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ReturnExpr */

typedef struct _SPTGReturnExpr{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGReturnExpr;

#ifdef PROTO_OK
static void _PrPTGReturnExpr(_PPTGReturnExpr n)
#else
static void _PrPTGReturnExpr(n)
	_PPTGReturnExpr n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "return(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGReturnExpr(PTGNode p1, PTGNode p2)
#else
PTGNode PTGReturnExpr(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGReturnExpr n;
	n = (_PPTGReturnExpr)MALLOC(sizeof(struct _SPTGReturnExpr));
	n->_print = (_PTGProc)_PrPTGReturnExpr;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Sequence */

typedef struct _SPTGSequence{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSequence;

#ifdef PROTO_OK
static void _PrPTGSequence(_PPTGSequence n)
#else
static void _PrPTGSequence(n)
	_PPTGSequence n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGSequence(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSequence(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSequence n;
	if(p1 == PTGNULL && p2 == PTGNULL)
		return PTGNULL;
	n = (_PPTGSequence)MALLOC(sizeof(struct _SPTGSequence));
	n->_print = (_PTGProc)_PrPTGSequence;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern SequenceCR1 */

typedef struct _SPTGSequenceCR1{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSequenceCR1;

#ifdef PROTO_OK
static void _PrPTGSequenceCR1(_PPTGSequenceCR1 n)
#else
static void _PrPTGSequenceCR1(n)
	_PPTGSequenceCR1 n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGSequenceCR1(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSequenceCR1(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSequenceCR1 n;
	n = (_PPTGSequenceCR1)MALLOC(sizeof(struct _SPTGSequenceCR1));
	n->_print = (_PTGProc)_PrPTGSequenceCR1;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern SharedBlock */

typedef struct _SPTGSharedBlock{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGSharedBlock;

#ifdef PROTO_OK
static void _PrPTGSharedBlock(_PPTGSharedBlock n)
#else
static void _PrPTGSharedBlock(n)
	_PPTGSharedBlock n;
#endif
{
	PTG_OUTPUT_STRING(f, "(threadIdx.x/(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "))*(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")+");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "-1");
}

#ifdef PROTO_OK
PTGNode PTGSharedBlock(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGSharedBlock(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGSharedBlock n;
	n = (_PPTGSharedBlock)MALLOC(sizeof(struct _SPTGSharedBlock));
	n->_print = (_PTGProc)_PrPTGSharedBlock;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern SQRmacro */

typedef struct _SPTGSQRmacro{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGSQRmacro;

#ifdef PROTO_OK
static void _PrPTGSQRmacro(_PPTGSQRmacro n)
#else
static void _PrPTGSQRmacro(n)
	_PPTGSQRmacro n;
#endif
{
	PTG_OUTPUT_STRING(f, "SQR(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGSQRmacro(PTGNode p1)
#else
PTGNode PTGSQRmacro(p1)

PTGNode p1;
#endif
{
	_PPTGSQRmacro n;
	n = (_PPTGSQRmacro)MALLOC(sizeof(struct _SPTGSQRmacro));
	n->_print = (_PTGProc)_PrPTGSQRmacro;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern StmtFunction */

typedef struct _SPTGStmtFunction{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGStmtFunction;

#ifdef PROTO_OK
static void _PrPTGStmtFunction(_PPTGStmtFunction n)
#else
static void _PrPTGStmtFunction(n)
	_PPTGStmtFunction n;
#endif
{
	PTG_OUTPUT_STRING(f, "[");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "]");
	PTG_OUTPUT_STRING(f, " = ");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGStmtFunction(PTGNode p1, PTGNode p2)
#else
PTGNode PTGStmtFunction(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGStmtFunction n;
	n = (_PPTGStmtFunction)MALLOC(sizeof(struct _SPTGStmtFunction));
	n->_print = (_PTGProc)_PrPTGStmtFunction;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern StrideLoopBounds */

typedef struct _SPTGStrideLoopBounds{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGStrideLoopBounds;

#ifdef PROTO_OK
static void _PrPTGStrideLoopBounds(_PPTGStrideLoopBounds n)
#else
static void _PrPTGStrideLoopBounds(n)
	_PPTGStrideLoopBounds n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "=");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "<=");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "+=");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGStrideLoopBounds(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGStrideLoopBounds(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGStrideLoopBounds n;
	n = (_PPTGStrideLoopBounds)MALLOC(sizeof(struct _SPTGStrideLoopBounds));
	n->_print = (_PTGProc)_PrPTGStrideLoopBounds;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern StrideNegLoopBounds */

typedef struct _SPTGStrideNegLoopBounds{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGStrideNegLoopBounds;

#ifdef PROTO_OK
static void _PrPTGStrideNegLoopBounds(_PPTGStrideNegLoopBounds n)
#else
static void _PrPTGStrideNegLoopBounds(n)
	_PPTGStrideNegLoopBounds n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "=");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ">=");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "+=");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGStrideNegLoopBounds(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGStrideNegLoopBounds(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGStrideNegLoopBounds n;
	n = (_PPTGStrideNegLoopBounds)MALLOC(sizeof(struct _SPTGStrideNegLoopBounds));
	n->_print = (_PTGProc)_PrPTGStrideNegLoopBounds;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern String */

typedef struct _SPTGString{
	_PTGProc _print;
	CONST char* p1;
} * _PPTGString;

#ifdef PROTO_OK
static void _PrPTGString(_PPTGString n)
#else
static void _PrPTGString(n)
	_PPTGString n;
#endif
{
	PTG_OUTPUT_STRING(f, n->p1);
}

#ifdef PROTO_OK
PTGNode PTGString(CONST char* p1)
#else
PTGNode PTGString(p1)

CONST char* p1;
#endif
{
	_PPTGString n;
	n = (_PPTGString)MALLOC(sizeof(struct _SPTGString));
	n->_print = (_PTGProc)_PrPTGString;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineArg */

typedef struct _SPTGSubroutineArg{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGSubroutineArg;

#ifdef PROTO_OK
static void _PrPTGSubroutineArg(_PPTGSubroutineArg n)
#else
static void _PrPTGSubroutineArg(n)
	_PPTGSubroutineArg n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGSubroutineArg(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGSubroutineArg(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGSubroutineArg n;
	n = (_PPTGSubroutineArg)MALLOC(sizeof(struct _SPTGSubroutineArg));
	n->_print = (_PTGProc)_PrPTGSubroutineArg;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern StaticVar */

typedef struct _SPTGStaticVar{
	_PTGProc _print;
} * _PPTGStaticVar;

#ifdef PROTO_OK
static void _PrPTGStaticVar(_PPTGStaticVar n)
#else
static void _PrPTGStaticVar(n)
	_PPTGStaticVar n;
#endif
{
	PTG_OUTPUT_STRING(f, "  static float runtime = 0.0;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  float elapsed_time_ms = 0.f;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEvent_t start, stop;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEventCreate(&start);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEventCreate(&stop);");
	IndentNewLine(f);
}

static struct _SPTGStaticVar _sptgStaticVar = { (_PTGProc) _PrPTGStaticVar };

#ifdef PROTO_OK
PTGNode PTGStaticVar(void)
#else
PTGNode PTGStaticVar()
#endif
{
	return (PTGNode)(&_sptgStaticVar);
}


/* Implementation of Pattern Subroutine_forCPU */

typedef struct _SPTGSubroutine_forCPU{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGSubroutine_forCPU;

#ifdef PROTO_OK
static void _PrPTGSubroutine_forCPU(_PPTGSubroutine_forCPU n)
#else
static void _PrPTGSubroutine_forCPU(n)
	_PPTGSubroutine_forCPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p5->_print(n->p5);
	IndentNewLine(f);
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGSubroutine_forCPU(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGSubroutine_forCPU(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGSubroutine_forCPU n;
	n = (_PPTGSubroutine_forCPU)MALLOC(sizeof(struct _SPTGSubroutine_forCPU));
	n->_print = (_PTGProc)_PrPTGSubroutine_forCPU;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern Subroutine_forGPU1 */

typedef struct _SPTGSubroutine_forGPU1{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
	PTGNode p8;
} * _PPTGSubroutine_forGPU1;

#ifdef PROTO_OK
static void _PrPTGSubroutine_forGPU1(_PPTGSubroutine_forGPU1 n)
#else
static void _PrPTGSubroutine_forGPU1(n)
	_PPTGSubroutine_forGPU1 n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	IndentNewLine(f);
	IndentNewLine(f);
	n->p5->_print(n->p5);
	n->p6->_print(n->p6);
	n->p7->_print(n->p7);
	n->p8->_print(n->p8);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGSubroutine_forGPU1(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8)
#else
PTGNode PTGSubroutine_forGPU1(p1, p2, p3, p4, p5, p6, p7, p8)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
PTGNode p8;
#endif
{
	_PPTGSubroutine_forGPU1 n;
	n = (_PPTGSubroutine_forGPU1)MALLOC(sizeof(struct _SPTGSubroutine_forGPU1));
	n->_print = (_PTGProc)_PrPTGSubroutine_forGPU1;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	n->p8 = p8;
	return (PTGNode)n;
}


/* Implementation of Pattern Subroutine_forGPU */

typedef struct _SPTGSubroutine_forGPU{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
	PTGNode p8;
	PTGNode p9;
} * _PPTGSubroutine_forGPU;

#ifdef PROTO_OK
static void _PrPTGSubroutine_forGPU(_PPTGSubroutine_forGPU n)
#else
static void _PrPTGSubroutine_forGPU(n)
	_PPTGSubroutine_forGPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	IndentNewLine(f);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " FUNCTION(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ") ARGS(`");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "') {");
	IndentNewLine(f);
	IndentNewLine(f);
	n->p6->_print(n->p6);
	n->p7->_print(n->p7);
	n->p8->_print(n->p8);
	n->p9->_print(n->p9);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGSubroutine_forGPU(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8, PTGNode p9)
#else
PTGNode PTGSubroutine_forGPU(p1, p2, p3, p4, p5, p6, p7, p8, p9)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
PTGNode p8;
PTGNode p9;
#endif
{
	_PPTGSubroutine_forGPU n;
	n = (_PPTGSubroutine_forGPU)MALLOC(sizeof(struct _SPTGSubroutine_forGPU));
	n->_print = (_PTGProc)_PrPTGSubroutine_forGPU;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	n->p8 = p8;
	n->p9 = p9;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineCallNoArgs */

typedef struct _SPTGSubroutineCallNoArgs{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSubroutineCallNoArgs;

#ifdef PROTO_OK
static void _PrPTGSubroutineCallNoArgs(_PPTGSubroutineCallNoArgs n)
#else
static void _PrPTGSubroutineCallNoArgs(n)
	_PPTGSubroutineCallNoArgs n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "(");
	PTG_OUTPUT_STRING(f, ");");
}

#ifdef PROTO_OK
PTGNode PTGSubroutineCallNoArgs(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSubroutineCallNoArgs(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSubroutineCallNoArgs n;
	n = (_PPTGSubroutineCallNoArgs)MALLOC(sizeof(struct _SPTGSubroutineCallNoArgs));
	n->_print = (_PTGProc)_PrPTGSubroutineCallNoArgs;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineCall */

typedef struct _SPTGSubroutineCall{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGSubroutineCall;

#ifdef PROTO_OK
static void _PrPTGSubroutineCall(_PPTGSubroutineCall n)
#else
static void _PrPTGSubroutineCall(n)
	_PPTGSubroutineCall n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "( ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " );");
}

#ifdef PROTO_OK
PTGNode PTGSubroutineCall(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGSubroutineCall(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGSubroutineCall n;
	n = (_PPTGSubroutineCall)MALLOC(sizeof(struct _SPTGSubroutineCall));
	n->_print = (_PTGProc)_PrPTGSubroutineCall;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineExtern */

typedef struct _SPTGSubroutineExtern{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGSubroutineExtern;

#ifdef PROTO_OK
static void _PrPTGSubroutineExtern(_PPTGSubroutineExtern n)
#else
static void _PrPTGSubroutineExtern(n)
	_PPTGSubroutineExtern n;
#endif
{
	PTG_OUTPUT_STRING(f, "extern \"C\" ");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGSubroutineExtern(PTGNode p1)
#else
PTGNode PTGSubroutineExtern(p1)

PTGNode p1;
#endif
{
	_PPTGSubroutineExtern n;
	n = (_PPTGSubroutineExtern)MALLOC(sizeof(struct _SPTGSubroutineExtern));
	n->_print = (_PTGProc)_PrPTGSubroutineExtern;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineNoArgs_forCPU */

typedef struct _SPTGSubroutineNoArgs_forCPU{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGSubroutineNoArgs_forCPU;

#ifdef PROTO_OK
static void _PrPTGSubroutineNoArgs_forCPU(_PPTGSubroutineNoArgs_forCPU n)
#else
static void _PrPTGSubroutineNoArgs_forCPU(n)
	_PPTGSubroutineNoArgs_forCPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " FUNCTION(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ") ARGS(`");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "') {");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGSubroutineNoArgs_forCPU(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGSubroutineNoArgs_forCPU(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGSubroutineNoArgs_forCPU n;
	n = (_PPTGSubroutineNoArgs_forCPU)MALLOC(sizeof(struct _SPTGSubroutineNoArgs_forCPU));
	n->_print = (_PTGProc)_PrPTGSubroutineNoArgs_forCPU;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineStmt_M4 */

typedef struct _SPTGSubroutineStmt_M4{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGSubroutineStmt_M4;

#ifdef PROTO_OK
static void _PrPTGSubroutineStmt_M4(_PPTGSubroutineStmt_M4 n)
#else
static void _PrPTGSubroutineStmt_M4(n)
	_PPTGSubroutineStmt_M4 n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " FUNCTION(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ") ARGS(`");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "') {");
}

#ifdef PROTO_OK
PTGNode PTGSubroutineStmt_M4(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGSubroutineStmt_M4(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGSubroutineStmt_M4 n;
	n = (_PPTGSubroutineStmt_M4)MALLOC(sizeof(struct _SPTGSubroutineStmt_M4));
	n->_print = (_PTGProc)_PrPTGSubroutineStmt_M4;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern SubroutineStmt */

typedef struct _SPTGSubroutineStmt{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGSubroutineStmt;

#ifdef PROTO_OK
static void _PrPTGSubroutineStmt(_PPTGSubroutineStmt n)
#else
static void _PrPTGSubroutineStmt(n)
	_PPTGSubroutineStmt n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " (");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ") {");
}

#ifdef PROTO_OK
PTGNode PTGSubroutineStmt(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGSubroutineStmt(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGSubroutineStmt n;
	n = (_PPTGSubroutineStmt)MALLOC(sizeof(struct _SPTGSubroutineStmt));
	n->_print = (_PTGProc)_PrPTGSubroutineStmt;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern ThreadIndex */

typedef struct _SPTGThreadIndex{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGThreadIndex;

#ifdef PROTO_OK
static void _PrPTGThreadIndex(_PPTGThreadIndex n)
#else
static void _PrPTGThreadIndex(n)
	_PPTGThreadIndex n;
#endif
{
	PTG_OUTPUT_STRING(f, "threadIdx.");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "%(blockDim.");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "/");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")+");
	n->p4->_print(n->p4);
}

#ifdef PROTO_OK
PTGNode PTGThreadIndex(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGThreadIndex(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGThreadIndex n;
	n = (_PPTGThreadIndex)MALLOC(sizeof(struct _SPTGThreadIndex));
	n->_print = (_PTGProc)_PrPTGThreadIndex;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern ThreadIndexDef */

typedef struct _SPTGThreadIndexDef{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGThreadIndexDef;

#ifdef PROTO_OK
static void _PrPTGThreadIndexDef(_PPTGThreadIndexDef n)
#else
static void _PrPTGThreadIndexDef(n)
	_PPTGThreadIndexDef n;
#endif
{
	PTG_OUTPUT_STRING(f, "threadIdx.");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "+");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGThreadIndexDef(PTGNode p1, PTGNode p2)
#else
PTGNode PTGThreadIndexDef(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGThreadIndexDef n;
	n = (_PPTGThreadIndexDef)MALLOC(sizeof(struct _SPTGThreadIndexDef));
	n->_print = (_PTGProc)_PrPTGThreadIndexDef;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ThreeArgs */

typedef struct _SPTGThreeArgs{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGThreeArgs;

#ifdef PROTO_OK
static void _PrPTGThreeArgs(_PPTGThreeArgs n)
#else
static void _PrPTGThreeArgs(n)
	_PPTGThreeArgs n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGThreeArgs(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGThreeArgs(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGThreeArgs n;
	if(p1 == PTGNULL && p2 == PTGNULL && p3 == PTGNULL)
		return PTGNULL;
	n = (_PPTGThreeArgs)MALLOC(sizeof(struct _SPTGThreeArgs));
	n->_print = (_PTGProc)_PrPTGThreeArgs;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern Void */

typedef struct _SPTGVoid{
	_PTGProc _print;
} * _PPTGVoid;

#ifdef PROTO_OK
static void _PrPTGVoid(_PPTGVoid n)
#else
static void _PrPTGVoid(n)
	_PPTGVoid n;
#endif
{
	PTG_OUTPUT_STRING(f, "void");
}

static struct _SPTGVoid _sptgVoid = { (_PTGProc) _PrPTGVoid };

#ifdef PROTO_OK
PTGNode PTGVoid(void)
#else
PTGNode PTGVoid()
#endif
{
	return (PTGNode)(&_sptgVoid);
}


/* Implementation of Pattern AccRegion */

typedef struct _SPTGAccRegion{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGAccRegion;

#ifdef PROTO_OK
static void _PrPTGAccRegion(_PPTGAccRegion n)
#else
static void _PrPTGAccRegion(n)
	_PPTGAccRegion n;
#endif
{
	PTG_OUTPUT_STRING(f, "replace ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " !ACC$REGION(");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ") BEGIN");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAccRegion(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGAccRegion(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGAccRegion n;
	n = (_PPTGAccRegion)MALLOC(sizeof(struct _SPTGAccRegion));
	n->_print = (_PTGProc)_PrPTGAccRegion;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern AccSync */

typedef struct _SPTGAccSync{
	_PTGProc _print;
} * _PPTGAccSync;

#ifdef PROTO_OK
static void _PrPTGAccSync(_PPTGAccSync n)
#else
static void _PrPTGAccSync(n)
	_PPTGAccSync n;
#endif
{
	PTG_OUTPUT_STRING(f, "__syncthreads();");
	IndentNewLine(f);
}

static struct _SPTGAccSync _sptgAccSync = { (_PTGProc) _PrPTGAccSync };

#ifdef PROTO_OK
PTGNode PTGAccSync(void)
#else
PTGNode PTGAccSync()
#endif
{
	return (PTGNode)(&_sptgAccSync);
}


/* Implementation of Pattern AllocateLocal */

typedef struct _SPTGAllocateLocal{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGAllocateLocal;

#ifdef PROTO_OK
static void _PrPTGAllocateLocal(_PPTGAllocateLocal n)
#else
static void _PrPTGAllocateLocal(n)
	_PPTGAllocateLocal n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAllocateLocal(PTGNode p1, PTGNode p2)
#else
PTGNode PTGAllocateLocal(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGAllocateLocal n;
	n = (_PPTGAllocateLocal)MALLOC(sizeof(struct _SPTGAllocateLocal));
	n->_print = (_PTGProc)_PrPTGAllocateLocal;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern AssignVar */

typedef struct _SPTGAssignVar{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGAssignVar;

#ifdef PROTO_OK
static void _PrPTGAssignVar(_PPTGAssignVar n)
#else
static void _PrPTGAssignVar(n)
	_PPTGAssignVar n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " = ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGAssignVar(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGAssignVar(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGAssignVar n;
	n = (_PPTGAssignVar)MALLOC(sizeof(struct _SPTGAssignVar));
	n->_print = (_PTGProc)_PrPTGAssignVar;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern Blocks */

typedef struct _SPTGBlocks{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGBlocks;

#ifdef PROTO_OK
static void _PrPTGBlocks(_PPTGBlocks n)
#else
static void _PrPTGBlocks(n)
	_PPTGBlocks n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")/");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGBlocks(PTGNode p1, PTGNode p2)
#else
PTGNode PTGBlocks(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGBlocks n;
	n = (_PPTGBlocks)MALLOC(sizeof(struct _SPTGBlocks));
	n->_print = (_PTGProc)_PrPTGBlocks;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaDecl */

typedef struct _SPTGCudaDecl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGCudaDecl;

#ifdef PROTO_OK
static void _PrPTGCudaDecl(_PPTGCudaDecl n)
#else
static void _PrPTGCudaDecl(n)
	_PPTGCudaDecl n;
#endif
{
	PTG_OUTPUT_STRING(f, "  ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " *");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaDecl(PTGNode p1, PTGNode p2)
#else
PTGNode PTGCudaDecl(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGCudaDecl n;
	n = (_PPTGCudaDecl)MALLOC(sizeof(struct _SPTGCudaDecl));
	n->_print = (_PTGProc)_PrPTGCudaDecl;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaGlobalDecl */

typedef struct _SPTGCudaGlobalDecl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGCudaGlobalDecl;

#ifdef PROTO_OK
static void _PrPTGCudaGlobalDecl(_PPTGCudaGlobalDecl n)
#else
static void _PrPTGCudaGlobalDecl(n)
	_PPTGCudaGlobalDecl n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " *");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ", ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaGlobalDecl(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGCudaGlobalDecl(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGCudaGlobalDecl n;
	n = (_PPTGCudaGlobalDecl)MALLOC(sizeof(struct _SPTGCudaGlobalDecl));
	n->_print = (_PTGProc)_PrPTGCudaGlobalDecl;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaGlobalExternDecl */

typedef struct _SPTGCudaGlobalExternDecl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGCudaGlobalExternDecl;

#ifdef PROTO_OK
static void _PrPTGCudaGlobalExternDecl(_PPTGCudaGlobalExternDecl n)
#else
static void _PrPTGCudaGlobalExternDecl(n)
	_PPTGCudaGlobalExternDecl n;
#endif
{
	PTG_OUTPUT_STRING(f, "  extern ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " *");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ", ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaGlobalExternDecl(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGCudaGlobalExternDecl(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGCudaGlobalExternDecl n;
	n = (_PPTGCudaGlobalExternDecl)MALLOC(sizeof(struct _SPTGCudaGlobalExternDecl));
	n->_print = (_PTGProc)_PrPTGCudaGlobalExternDecl;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaDeclExtern */

typedef struct _SPTGCudaDeclExtern{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGCudaDeclExtern;

#ifdef PROTO_OK
static void _PrPTGCudaDeclExtern(_PPTGCudaDeclExtern n)
#else
static void _PrPTGCudaDeclExtern(n)
	_PPTGCudaDeclExtern n;
#endif
{
	PTG_OUTPUT_STRING(f, "  extern ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " *");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaDeclExtern(PTGNode p1, PTGNode p2)
#else
PTGNode PTGCudaDeclExtern(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGCudaDeclExtern n;
	n = (_PPTGCudaDeclExtern)MALLOC(sizeof(struct _SPTGCudaDeclExtern));
	n->_print = (_PTGProc)_PrPTGCudaDeclExtern;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaMalloc */

typedef struct _SPTGCudaMalloc{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
} * _PPTGCudaMalloc;

#ifdef PROTO_OK
static void _PrPTGCudaMalloc(_PPTGCudaMalloc n)
#else
static void _PrPTGCudaMalloc(n)
	_PPTGCudaMalloc n;
#endif
{
	PTG_OUTPUT_STRING(f, "  cudaError = cudaMalloc((void **) &");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ")*sizeof(");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "));");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaErrorChk(\"");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "\",");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ",\"");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "\",cudaError);");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaMalloc(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6)
#else
PTGNode PTGCudaMalloc(p1, p2, p3, p4, p5, p6)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
#endif
{
	_PPTGCudaMalloc n;
	n = (_PPTGCudaMalloc)MALLOC(sizeof(struct _SPTGCudaMalloc));
	n->_print = (_PTGProc)_PrPTGCudaMalloc;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaMemcpyToCPU */

typedef struct _SPTGCudaMemcpyToCPU{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
} * _PPTGCudaMemcpyToCPU;

#ifdef PROTO_OK
static void _PrPTGCudaMemcpyToCPU(_PPTGCudaMemcpyToCPU n)
#else
static void _PrPTGCudaMemcpyToCPU(n)
	_PPTGCudaMemcpyToCPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "  cudaError = cudaMemcpy(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",(");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")*sizeof(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "),");
	PTG_OUTPUT_STRING(f, "cudaMemcpyDeviceToHost);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaErrorChk(\"");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "\",");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, ",\"");
	n->p7->_print(n->p7);
	PTG_OUTPUT_STRING(f, "\",cudaError);");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaMemcpyToCPU(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7)
#else
PTGNode PTGCudaMemcpyToCPU(p1, p2, p3, p4, p5, p6, p7)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
#endif
{
	_PPTGCudaMemcpyToCPU n;
	n = (_PPTGCudaMemcpyToCPU)MALLOC(sizeof(struct _SPTGCudaMemcpyToCPU));
	n->_print = (_PTGProc)_PrPTGCudaMemcpyToCPU;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaMemcpyToGPU */

typedef struct _SPTGCudaMemcpyToGPU{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
} * _PPTGCudaMemcpyToGPU;

#ifdef PROTO_OK
static void _PrPTGCudaMemcpyToGPU(_PPTGCudaMemcpyToGPU n)
#else
static void _PrPTGCudaMemcpyToGPU(n)
	_PPTGCudaMemcpyToGPU n;
#endif
{
	PTG_OUTPUT_STRING(f, "  cudaError = cudaMemcpy(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",(");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")*sizeof(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "),");
	PTG_OUTPUT_STRING(f, "cudaMemcpyHostToDevice);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaErrorChk(\"");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "\",");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, ",\"");
	n->p7->_print(n->p7);
	PTG_OUTPUT_STRING(f, "\",cudaError);");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaMemcpyToGPU(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7)
#else
PTGNode PTGCudaMemcpyToGPU(p1, p2, p3, p4, p5, p6, p7)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
#endif
{
	_PPTGCudaMemcpyToGPU n;
	n = (_PPTGCudaMemcpyToGPU)MALLOC(sizeof(struct _SPTGCudaMemcpyToGPU));
	n->_print = (_PTGProc)_PrPTGCudaMemcpyToGPU;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaMemcpyToSymbol */

typedef struct _SPTGCudaMemcpyToSymbol{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
} * _PPTGCudaMemcpyToSymbol;

#ifdef PROTO_OK
static void _PrPTGCudaMemcpyToSymbol(_PPTGCudaMemcpyToSymbol n)
#else
static void _PrPTGCudaMemcpyToSymbol(n)
	_PPTGCudaMemcpyToSymbol n;
#endif
{
	PTG_OUTPUT_STRING(f, "  cudaError = cudaMemcpyToSymbol(\"");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "\",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ", (");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")*sizeof(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "));");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaErrorChk(\"");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "\",");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, ",\"");
	n->p7->_print(n->p7);
	PTG_OUTPUT_STRING(f, "\",cudaError);");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaMemcpyToSymbol(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7)
#else
PTGNode PTGCudaMemcpyToSymbol(p1, p2, p3, p4, p5, p6, p7)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
#endif
{
	_PPTGCudaMemcpyToSymbol n;
	n = (_PPTGCudaMemcpyToSymbol)MALLOC(sizeof(struct _SPTGCudaMemcpyToSymbol));
	n->_print = (_PTGProc)_PrPTGCudaMemcpyToSymbol;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	return (PTGNode)n;
}


/* Implementation of Pattern CudaFree */

typedef struct _SPTGCudaFree{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGCudaFree;

#ifdef PROTO_OK
static void _PrPTGCudaFree(_PPTGCudaFree n)
#else
static void _PrPTGCudaFree(n)
	_PPTGCudaFree n;
#endif
{
	PTG_OUTPUT_STRING(f, "  cudaError = cudaFree(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaErrorChk(\"");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "\",");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ",\"");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, "\",cudaError);");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGCudaFree(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGCudaFree(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGCudaFree n;
	n = (_PPTGCudaFree)MALLOC(sizeof(struct _SPTGCudaFree));
	n->_print = (_PTGProc)_PrPTGCudaFree;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern CommaArgs3 */

typedef struct _SPTGCommaArgs3{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGCommaArgs3;

#ifdef PROTO_OK
static void _PrPTGCommaArgs3(_PPTGCommaArgs3 n)
#else
static void _PrPTGCommaArgs3(n)
	_PPTGCommaArgs3 n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ",");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ",");
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGCommaArgs3(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGCommaArgs3(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGCommaArgs3 n;
	n = (_PPTGCommaArgs3)MALLOC(sizeof(struct _SPTGCommaArgs3));
	n->_print = (_PTGProc)_PrPTGCommaArgs3;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern CondExpr */

typedef struct _SPTGCondExpr{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGCondExpr;

#ifdef PROTO_OK
static void _PrPTGCondExpr(_PPTGCondExpr n)
#else
static void _PrPTGCondExpr(n)
	_PPTGCondExpr n;
#endif
{
	PTG_OUTPUT_STRING(f, "if (");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ") { ");
}

#ifdef PROTO_OK
PTGNode PTGCondExpr(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGCondExpr(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGCondExpr n;
	n = (_PPTGCondExpr)MALLOC(sizeof(struct _SPTGCondExpr));
	n->_print = (_PTGProc)_PrPTGCondExpr;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern CondExprSimple */

typedef struct _SPTGCondExprSimple{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGCondExprSimple;

#ifdef PROTO_OK
static void _PrPTGCondExprSimple(_PPTGCondExprSimple n)
#else
static void _PrPTGCondExprSimple(n)
	_PPTGCondExprSimple n;
#endif
{
	PTG_OUTPUT_STRING(f, "if (");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ") { ");
}

#ifdef PROTO_OK
PTGNode PTGCondExprSimple(PTGNode p1)
#else
PTGNode PTGCondExprSimple(p1)

PTGNode p1;
#endif
{
	_PPTGCondExprSimple n;
	n = (_PPTGCondExprSimple)MALLOC(sizeof(struct _SPTGCondExprSimple));
	n->_print = (_PTGProc)_PrPTGCondExprSimple;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern CondExprSimpleNeg */

typedef struct _SPTGCondExprSimpleNeg{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGCondExprSimpleNeg;

#ifdef PROTO_OK
static void _PrPTGCondExprSimpleNeg(_PPTGCondExprSimpleNeg n)
#else
static void _PrPTGCondExprSimpleNeg(n)
	_PPTGCondExprSimpleNeg n;
#endif
{
	PTG_OUTPUT_STRING(f, "if ( !");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ") { ");
}

#ifdef PROTO_OK
PTGNode PTGCondExprSimpleNeg(PTGNode p1)
#else
PTGNode PTGCondExprSimpleNeg(p1)

PTGNode p1;
#endif
{
	_PPTGCondExprSimpleNeg n;
	n = (_PPTGCondExprSimpleNeg)MALLOC(sizeof(struct _SPTGCondExprSimpleNeg));
	n->_print = (_PTGProc)_PrPTGCondExprSimpleNeg;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclAssignVar */

typedef struct _SPTGDeclAssignVar{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGDeclAssignVar;

#ifdef PROTO_OK
static void _PrPTGDeclAssignVar(_PPTGDeclAssignVar n)
#else
static void _PrPTGDeclAssignVar(n)
	_PPTGDeclAssignVar n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, " = ");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDeclAssignVar(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGDeclAssignVar(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGDeclAssignVar n;
	n = (_PPTGDeclAssignVar)MALLOC(sizeof(struct _SPTGDeclAssignVar));
	n->_print = (_PTGProc)_PrPTGDeclAssignVar;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclAssignExtern */

typedef struct _SPTGDeclAssignExtern{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
} * _PPTGDeclAssignExtern;

#ifdef PROTO_OK
static void _PrPTGDeclAssignExtern(_PPTGDeclAssignExtern n)
#else
static void _PrPTGDeclAssignExtern(n)
	_PPTGDeclAssignExtern n;
#endif
{
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ",");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, " ");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, " = ");
	n->p7->_print(n->p7);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDeclAssignExtern(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7)
#else
PTGNode PTGDeclAssignExtern(p1, p2, p3, p4, p5, p6, p7)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
#endif
{
	_PPTGDeclAssignExtern n;
	n = (_PPTGDeclAssignExtern)MALLOC(sizeof(struct _SPTGDeclAssignExtern));
	n->_print = (_PTGProc)_PrPTGDeclAssignExtern;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclareErrorVar */

typedef struct _SPTGDeclareErrorVar{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGDeclareErrorVar;

#ifdef PROTO_OK
static void _PrPTGDeclareErrorVar(_PPTGDeclareErrorVar n)
#else
static void _PrPTGDeclareErrorVar(n)
	_PPTGDeclareErrorVar n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "cudaError_t cudaError;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDeclareErrorVar(PTGNode p1)
#else
PTGNode PTGDeclareErrorVar(p1)

PTGNode p1;
#endif
{
	_PPTGDeclareErrorVar n;
	n = (_PPTGDeclareErrorVar)MALLOC(sizeof(struct _SPTGDeclareErrorVar));
	n->_print = (_PTGProc)_PrPTGDeclareErrorVar;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclareLocal */

typedef struct _SPTGDeclareLocal{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGDeclareLocal;

#ifdef PROTO_OK
static void _PrPTGDeclareLocal(_PPTGDeclareLocal n)
#else
static void _PrPTGDeclareLocal(n)
	_PPTGDeclareLocal n;
#endif
{
	PTG_OUTPUT_STRING(f, "  ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDeclareLocal(PTGNode p1, PTGNode p2)
#else
PTGNode PTGDeclareLocal(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGDeclareLocal n;
	n = (_PPTGDeclareLocal)MALLOC(sizeof(struct _SPTGDeclareLocal));
	n->_print = (_PTGProc)_PrPTGDeclareLocal;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclareVar */

typedef struct _SPTGDeclareVar{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGDeclareVar;

#ifdef PROTO_OK
static void _PrPTGDeclareVar(_PPTGDeclareVar n)
#else
static void _PrPTGDeclareVar(n)
	_PPTGDeclareVar n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  ");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, " ");
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGDeclareVar(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGDeclareVar(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGDeclareVar n;
	n = (_PPTGDeclareVar)MALLOC(sizeof(struct _SPTGDeclareVar));
	n->_print = (_PTGProc)_PrPTGDeclareVar;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern DeclareSharedLoopVars */

typedef struct _SPTGDeclareSharedLoopVars{
	_PTGProc _print;
} * _PPTGDeclareSharedLoopVars;

#ifdef PROTO_OK
static void _PrPTGDeclareSharedLoopVars(_PPTGDeclareSharedLoopVars n)
#else
static void _PrPTGDeclareSharedLoopVars(n)
	_PPTGDeclareSharedLoopVars n;
#endif
{
	PTG_OUTPUT_STRING(f, "  int iS1,iS2,iS3,iS4,iS5,iS6,iS7;");
	IndentNewLine(f);
}

static struct _SPTGDeclareSharedLoopVars _sptgDeclareSharedLoopVars = { (_PTGProc) _PrPTGDeclareSharedLoopVars };

#ifdef PROTO_OK
PTGNode PTGDeclareSharedLoopVars(void)
#else
PTGNode PTGDeclareSharedLoopVars()
#endif
{
	return (PTGNode)(&_sptgDeclareSharedLoopVars);
}


/* Implementation of Pattern DeviceName */

typedef struct _SPTGDeviceName{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGDeviceName;

#ifdef PROTO_OK
static void _PrPTGDeviceName(_PPTGDeviceName n)
#else
static void _PrPTGDeviceName(n)
	_PPTGDeviceName n;
#endif
{
	PTG_OUTPUT_STRING(f, "D_");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGDeviceName(PTGNode p1)
#else
PTGNode PTGDeviceName(p1)

PTGNode p1;
#endif
{
	_PPTGDeviceName n;
	n = (_PPTGDeviceName)MALLOC(sizeof(struct _SPTGDeviceName));
	n->_print = (_PTGProc)_PrPTGDeviceName;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ExternAssign */

typedef struct _SPTGExternAssign{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGExternAssign;

#ifdef PROTO_OK
static void _PrPTGExternAssign(_PPTGExternAssign n)
#else
static void _PrPTGExternAssign(n)
	_PPTGExternAssign n;
#endif
{
	PTG_OUTPUT_STRING(f, "  ");
	n->p1->_print(n->p1);
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " = ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	n->p4->_print(n->p4);
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGExternAssign(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGExternAssign(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGExternAssign n;
	n = (_PPTGExternAssign)MALLOC(sizeof(struct _SPTGExternAssign));
	n->_print = (_PTGProc)_PrPTGExternAssign;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern GlobalName */

typedef struct _SPTGGlobalName{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGGlobalName;

#ifdef PROTO_OK
static void _PrPTGGlobalName(_PPTGGlobalName n)
#else
static void _PrPTGGlobalName(n)
	_PPTGGlobalName n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "__G");
}

#ifdef PROTO_OK
PTGNode PTGGlobalName(PTGNode p1)
#else
PTGNode PTGGlobalName(p1)

PTGNode p1;
#endif
{
	_PPTGGlobalName n;
	n = (_PPTGGlobalName)MALLOC(sizeof(struct _SPTGGlobalName));
	n->_print = (_PTGProc)_PrPTGGlobalName;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern HostName */

typedef struct _SPTGHostName{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGHostName;

#ifdef PROTO_OK
static void _PrPTGHostName(_PPTGHostName n)
#else
static void _PrPTGHostName(n)
	_PPTGHostName n;
#endif
{
	PTG_OUTPUT_STRING(f, "H_");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGHostName(PTGNode p1)
#else
PTGNode PTGHostName(p1)

PTGNode p1;
#endif
{
	_PPTGHostName n;
	n = (_PPTGHostName)MALLOC(sizeof(struct _SPTGHostName));
	n->_print = (_PTGProc)_PrPTGHostName;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern KernelProgramName */

typedef struct _SPTGKernelProgramName{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGKernelProgramName;

#ifdef PROTO_OK
static void _PrPTGKernelProgramName(_PPTGKernelProgramName n)
#else
static void _PrPTGKernelProgramName(n)
	_PPTGKernelProgramName n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_Kernel");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGKernelProgramName(PTGNode p1, PTGNode p2)
#else
PTGNode PTGKernelProgramName(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGKernelProgramName n;
	n = (_PPTGKernelProgramName)MALLOC(sizeof(struct _SPTGKernelProgramName));
	n->_print = (_PTGProc)_PrPTGKernelProgramName;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern KernelRoutineCopyEnd */

typedef struct _SPTGKernelRoutineCopyEnd{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGKernelRoutineCopyEnd;

#ifdef PROTO_OK
static void _PrPTGKernelRoutineCopyEnd(_PPTGKernelRoutineCopyEnd n)
#else
static void _PrPTGKernelRoutineCopyEnd(n)
	_PPTGKernelRoutineCopyEnd n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGKernelRoutineCopyEnd(PTGNode p1, PTGNode p2)
#else
PTGNode PTGKernelRoutineCopyEnd(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGKernelRoutineCopyEnd n;
	n = (_PPTGKernelRoutineCopyEnd)MALLOC(sizeof(struct _SPTGKernelRoutineCopyEnd));
	n->_print = (_PTGProc)_PrPTGKernelRoutineCopyEnd;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern KernelRoutineEnd */

typedef struct _SPTGKernelRoutineEnd{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGKernelRoutineEnd;

#ifdef PROTO_OK
static void _PrPTGKernelRoutineEnd(_PPTGKernelRoutineEnd n)
#else
static void _PrPTGKernelRoutineEnd(n)
	_PPTGKernelRoutineEnd n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  return;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGKernelRoutineEnd(PTGNode p1, PTGNode p2)
#else
PTGNode PTGKernelRoutineEnd(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGKernelRoutineEnd n;
	n = (_PPTGKernelRoutineEnd)MALLOC(sizeof(struct _SPTGKernelRoutineEnd));
	n->_print = (_PTGProc)_PrPTGKernelRoutineEnd;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern KernelRoutineStart */

typedef struct _SPTGKernelRoutineStart{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
} * _PPTGKernelRoutineStart;

#ifdef PROTO_OK
static void _PrPTGKernelRoutineStart(_PPTGKernelRoutineStart n)
#else
static void _PrPTGKernelRoutineStart(n)
	_PPTGKernelRoutineStart n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ") {");
	IndentNewLine(f);
	n->p5->_print(n->p5);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGKernelRoutineStart(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5)
#else
PTGNode PTGKernelRoutineStart(p1, p2, p3, p4, p5)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
#endif
{
	_PPTGKernelRoutineStart n;
	n = (_PPTGKernelRoutineStart)MALLOC(sizeof(struct _SPTGKernelRoutineStart));
	n->_print = (_PTGProc)_PrPTGKernelRoutineStart;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	return (PTGNode)n;
}


/* Implementation of Pattern KernelCall */

typedef struct _SPTGKernelCall{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
	PTGNode p5;
	PTGNode p6;
	PTGNode p7;
	PTGNode p8;
	PTGNode p9;
	PTGNode p10;
	PTGNode p11;
} * _PPTGKernelCall;

#ifdef PROTO_OK
static void _PrPTGKernelCall(_PPTGKernelCall n)
#else
static void _PrPTGKernelCall(n)
	_PPTGKernelCall n;
#endif
{
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  dim3 cuda_threads");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  dim3 cuda_grids");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "(");
	n->p4->_print(n->p4);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
	IndentNewLine(f);
	n->p5->_print(n->p5);
	PTG_OUTPUT_STRING(f, "  cudaEventRecord( start, 0 );");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEventSynchronize(start);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  // setup execution parameters ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  // execute the kernel ");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  ");
	n->p6->_print(n->p6);
	PTG_OUTPUT_STRING(f, "<<< cuda_grids");
	n->p7->_print(n->p7);
	PTG_OUTPUT_STRING(f, ", cuda_threads");
	n->p8->_print(n->p8);
	PTG_OUTPUT_STRING(f, " >>>(");
	n->p9->_print(n->p9);
	PTG_OUTPUT_STRING(f, ");");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaThreadSynchronize();");
	IndentNewLine(f);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEventRecord( stop, 0);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEventSynchronize(stop);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  cudaEventElapsedTime( &elapsed_time_ms, start, stop );");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  runtime += elapsed_time_ms;");
	IndentNewLine(f);
	n->p10->_print(n->p10);
	PTG_OUTPUT_STRING(f, "  printf(\"");
	n->p11->_print(n->p11);
	PTG_OUTPUT_STRING(f, " kernel execution time: %.2f ms\\n\",runtime);");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGKernelCall(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8, PTGNode p9, PTGNode p10, PTGNode p11)
#else
PTGNode PTGKernelCall(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
PTGNode p5;
PTGNode p6;
PTGNode p7;
PTGNode p8;
PTGNode p9;
PTGNode p10;
PTGNode p11;
#endif
{
	_PPTGKernelCall n;
	n = (_PPTGKernelCall)MALLOC(sizeof(struct _SPTGKernelCall));
	n->_print = (_PTGProc)_PrPTGKernelCall;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	n->p5 = p5;
	n->p6 = p6;
	n->p7 = p7;
	n->p8 = p8;
	n->p9 = p9;
	n->p10 = p10;
	n->p11 = p11;
	return (PTGNode)n;
}


/* Implementation of Pattern KernelCopyArgsIn */

typedef struct _SPTGKernelCopyArgsIn{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGKernelCopyArgsIn;

#ifdef PROTO_OK
static void _PrPTGKernelCopyArgsIn(_PPTGKernelCopyArgsIn n)
#else
static void _PrPTGKernelCopyArgsIn(n)
	_PPTGKernelCopyArgsIn n;
#endif
{
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGKernelCopyArgsIn(PTGNode p1, PTGNode p2)
#else
PTGNode PTGKernelCopyArgsIn(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGKernelCopyArgsIn n;
	n = (_PPTGKernelCopyArgsIn)MALLOC(sizeof(struct _SPTGKernelCopyArgsIn));
	n->_print = (_PTGProc)_PrPTGKernelCopyArgsIn;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern Pointer */

typedef struct _SPTGPointer{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGPointer;

#ifdef PROTO_OK
static void _PrPTGPointer(_PPTGPointer n)
#else
static void _PrPTGPointer(n)
	_PPTGPointer n;
#endif
{
	PTG_OUTPUT_STRING(f, "*");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGPointer(PTGNode p1)
#else
PTGNode PTGPointer(p1)

PTGNode p1;
#endif
{
	_PPTGPointer n;
	n = (_PPTGPointer)MALLOC(sizeof(struct _SPTGPointer));
	n->_print = (_PTGProc)_PrPTGPointer;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern VariableAddr */

typedef struct _SPTGVariableAddr{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGVariableAddr;

#ifdef PROTO_OK
static void _PrPTGVariableAddr(_PPTGVariableAddr n)
#else
static void _PrPTGVariableAddr(n)
	_PPTGVariableAddr n;
#endif
{
	PTG_OUTPUT_STRING(f, "&");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGVariableAddr(PTGNode p1)
#else
PTGNode PTGVariableAddr(p1)

PTGNode p1;
#endif
{
	_PPTGVariableAddr n;
	n = (_PPTGVariableAddr)MALLOC(sizeof(struct _SPTGVariableAddr));
	n->_print = (_PTGProc)_PrPTGVariableAddr;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStruct */

typedef struct _SPTGScalarStruct{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGScalarStruct;

#ifdef PROTO_OK
static void _PrPTGScalarStruct(_PPTGScalarStruct n)
#else
static void _PrPTGScalarStruct(n)
	_PPTGScalarStruct n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_s");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGScalarStruct(PTGNode p1, PTGNode p2)
#else
PTGNode PTGScalarStruct(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGScalarStruct n;
	n = (_PPTGScalarStruct)MALLOC(sizeof(struct _SPTGScalarStruct));
	n->_print = (_PTGProc)_PrPTGScalarStruct;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStructVar */

typedef struct _SPTGScalarStructVar{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGScalarStructVar;

#ifdef PROTO_OK
static void _PrPTGScalarStructVar(_PPTGScalarStructVar n)
#else
static void _PrPTGScalarStructVar(n)
	_PPTGScalarStructVar n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_k");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGScalarStructVar(PTGNode p1, PTGNode p2)
#else
PTGNode PTGScalarStructVar(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGScalarStructVar n;
	n = (_PPTGScalarStructVar)MALLOC(sizeof(struct _SPTGScalarStructVar));
	n->_print = (_PTGProc)_PrPTGScalarStructVar;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStructDecl */

typedef struct _SPTGScalarStructDecl{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
	PTGNode p4;
} * _PPTGScalarStructDecl;

#ifdef PROTO_OK
static void _PrPTGScalarStructDecl(_PPTGScalarStructDecl n)
#else
static void _PrPTGScalarStructDecl(n)
	_PPTGScalarStructDecl n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_s");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, "_k");
	n->p4->_print(n->p4);
}

#ifdef PROTO_OK
PTGNode PTGScalarStructDecl(PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4)
#else
PTGNode PTGScalarStructDecl(p1, p2, p3, p4)

PTGNode p1;
PTGNode p2;
PTGNode p3;
PTGNode p4;
#endif
{
	_PPTGScalarStructDecl n;
	n = (_PPTGScalarStructDecl)MALLOC(sizeof(struct _SPTGScalarStructDecl));
	n->_print = (_PTGProc)_PrPTGScalarStructDecl;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	n->p4 = p4;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStructBegin */

typedef struct _SPTGScalarStructBegin{
	_PTGProc _print;
} * _PPTGScalarStructBegin;

#ifdef PROTO_OK
static void _PrPTGScalarStructBegin(_PPTGScalarStructBegin n)
#else
static void _PrPTGScalarStructBegin(n)
	_PPTGScalarStructBegin n;
#endif
{
	PTG_OUTPUT_STRING(f, "typedef struct {");
	IndentNewLine(f);
}

static struct _SPTGScalarStructBegin _sptgScalarStructBegin = { (_PTGProc) _PrPTGScalarStructBegin };

#ifdef PROTO_OK
PTGNode PTGScalarStructBegin(void)
#else
PTGNode PTGScalarStructBegin()
#endif
{
	return (PTGNode)(&_sptgScalarStructBegin);
}


/* Implementation of Pattern ScalarStructEnd */

typedef struct _SPTGScalarStructEnd{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGScalarStructEnd;

#ifdef PROTO_OK
static void _PrPTGScalarStructEnd(_PPTGScalarStructEnd n)
#else
static void _PrPTGScalarStructEnd(n)
	_PPTGScalarStructEnd n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "} ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "_s");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGScalarStructEnd(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGScalarStructEnd(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGScalarStructEnd n;
	n = (_PPTGScalarStructEnd)MALLOC(sizeof(struct _SPTGScalarStructEnd));
	n->_print = (_PTGProc)_PrPTGScalarStructEnd;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStructName */

typedef struct _SPTGScalarStructName{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGScalarStructName;

#ifdef PROTO_OK
static void _PrPTGScalarStructName(_PPTGScalarStructName n)
#else
static void _PrPTGScalarStructName(n)
	_PPTGScalarStructName n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_k");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ".");
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGScalarStructName(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGScalarStructName(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGScalarStructName n;
	n = (_PPTGScalarStructName)MALLOC(sizeof(struct _SPTGScalarStructName));
	n->_print = (_PTGProc)_PrPTGScalarStructName;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStructNamePtr */

typedef struct _SPTGScalarStructNamePtr{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGScalarStructNamePtr;

#ifdef PROTO_OK
static void _PrPTGScalarStructNamePtr(_PPTGScalarStructNamePtr n)
#else
static void _PrPTGScalarStructNamePtr(n)
	_PPTGScalarStructNamePtr n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "_k");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "->");
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGScalarStructNamePtr(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGScalarStructNamePtr(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGScalarStructNamePtr n;
	n = (_PPTGScalarStructNamePtr)MALLOC(sizeof(struct _SPTGScalarStructNamePtr));
	n->_print = (_PTGProc)_PrPTGScalarStructNamePtr;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern ScalarStructField */

typedef struct _SPTGScalarStructField{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGScalarStructField;

#ifdef PROTO_OK
static void _PrPTGScalarStructField(_PPTGScalarStructField n)
#else
static void _PrPTGScalarStructField(n)
	_PPTGScalarStructField n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "  ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, " ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGScalarStructField(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGScalarStructField(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGScalarStructField n;
	n = (_PPTGScalarStructField)MALLOC(sizeof(struct _SPTGScalarStructField));
	n->_print = (_PTGProc)_PrPTGScalarStructField;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern SequenceCR */

typedef struct _SPTGSequenceCR{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSequenceCR;

#ifdef PROTO_OK
static void _PrPTGSequenceCR(_PPTGSequenceCR n)
#else
static void _PrPTGSequenceCR(n)
	_PPTGSequenceCR n;
#endif
{
	n->p1->_print(n->p1);
	IndentNewLine(f);
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGSequenceCR(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSequenceCR(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSequenceCR n;
	n = (_PPTGSequenceCR)MALLOC(sizeof(struct _SPTGSequenceCR));
	n->_print = (_PTGProc)_PrPTGSequenceCR;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern LineCR */

typedef struct _SPTGLineCR{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGLineCR;

#ifdef PROTO_OK
static void _PrPTGLineCR(_PPTGLineCR n)
#else
static void _PrPTGLineCR(n)
	_PPTGLineCR n;
#endif
{
	PTG_OUTPUT_STRING(f, "  ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ";");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGLineCR(PTGNode p1)
#else
PTGNode PTGLineCR(p1)

PTGNode p1;
#endif
{
	_PPTGLineCR n;
	n = (_PPTGLineCR)MALLOC(sizeof(struct _SPTGLineCR));
	n->_print = (_PTGProc)_PrPTGLineCR;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern SharedDim1 */

typedef struct _SPTGSharedDim1{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGSharedDim1;

#ifdef PROTO_OK
static void _PrPTGSharedDim1(_PPTGSharedDim1 n)
#else
static void _PrPTGSharedDim1(n)
	_PPTGSharedDim1 n;
#endif
{
	PTG_OUTPUT_STRING(f, "[");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "]");
}

#ifdef PROTO_OK
PTGNode PTGSharedDim1(PTGNode p1)
#else
PTGNode PTGSharedDim1(p1)

PTGNode p1;
#endif
{
	_PPTGSharedDim1 n;
	n = (_PPTGSharedDim1)MALLOC(sizeof(struct _SPTGSharedDim1));
	n->_print = (_PTGProc)_PrPTGSharedDim1;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern SharedDim2 */

typedef struct _SPTGSharedDim2{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGSharedDim2;

#ifdef PROTO_OK
static void _PrPTGSharedDim2(_PPTGSharedDim2 n)
#else
static void _PrPTGSharedDim2(n)
	_PPTGSharedDim2 n;
#endif
{
	PTG_OUTPUT_STRING(f, "[");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "*");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, "]");
}

#ifdef PROTO_OK
PTGNode PTGSharedDim2(PTGNode p1, PTGNode p2)
#else
PTGNode PTGSharedDim2(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGSharedDim2 n;
	n = (_PPTGSharedDim2)MALLOC(sizeof(struct _SPTGSharedDim2));
	n->_print = (_PTGProc)_PrPTGSharedDim2;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern TimerDecl */

typedef struct _SPTGTimerDecl{
	_PTGProc _print;
} * _PPTGTimerDecl;

#ifdef PROTO_OK
static void _PrPTGTimerDecl(_PPTGTimerDecl n)
#else
static void _PrPTGTimerDecl(n)
	_PPTGTimerDecl n;
#endif
{
	PTG_OUTPUT_STRING(f, "  unsigned int timer = 0;");
	IndentNewLine(f);
}

static struct _SPTGTimerDecl _sptgTimerDecl = { (_PTGProc) _PrPTGTimerDecl };

#ifdef PROTO_OK
PTGNode PTGTimerDecl(void)
#else
PTGNode PTGTimerDecl()
#endif
{
	return (PTGNode)(&_sptgTimerDecl);
}


/* Implementation of Pattern Thread */

typedef struct _SPTGThread{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGThread;

#ifdef PROTO_OK
static void _PrPTGThread(_PPTGThread n)
#else
static void _PrPTGThread(n)
	_PPTGThread n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "if (threadIdx.x == ");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ") {");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGThread(PTGNode p1, PTGNode p2)
#else
PTGNode PTGThread(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGThread n;
	n = (_PPTGThread)MALLOC(sizeof(struct _SPTGThread));
	n->_print = (_PTGProc)_PrPTGThread;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern ThreadEnd */

typedef struct _SPTGThreadEnd{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGThreadEnd;

#ifdef PROTO_OK
static void _PrPTGThreadEnd(_PPTGThreadEnd n)
#else
static void _PrPTGThreadEnd(n)
	_PPTGThreadEnd n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "}");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGThreadEnd(PTGNode p1)
#else
PTGNode PTGThreadEnd(p1)

PTGNode p1;
#endif
{
	_PPTGThreadEnd n;
	n = (_PPTGThreadEnd)MALLOC(sizeof(struct _SPTGThreadEnd));
	n->_print = (_PTGProc)_PrPTGThreadEnd;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern ThreadMod */

typedef struct _SPTGThreadMod{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGThreadMod;

#ifdef PROTO_OK
static void _PrPTGThreadMod(_PPTGThreadMod n)
#else
static void _PrPTGThreadMod(n)
	_PPTGThreadMod n;
#endif
{
	PTG_OUTPUT_STRING(f, "begin_append ");
	n->p1->_print(n->p1);
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "if (threadIdx.x%(");
	n->p2->_print(n->p2);
	PTG_OUTPUT_STRING(f, ") == ");
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ") {");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "end_append");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGThreadMod(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGThreadMod(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGThreadMod n;
	n = (_PPTGThreadMod)MALLOC(sizeof(struct _SPTGThreadMod));
	n->_print = (_PTGProc)_PrPTGThreadMod;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern Threads */

typedef struct _SPTGThreads{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
} * _PPTGThreads;

#ifdef PROTO_OK
static void _PrPTGThreads(_PPTGThreads n)
#else
static void _PrPTGThreads(n)
	_PPTGThreads n;
#endif
{
	PTG_OUTPUT_STRING(f, "(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")*");
	n->p2->_print(n->p2);
}

#ifdef PROTO_OK
PTGNode PTGThreads(PTGNode p1, PTGNode p2)
#else
PTGNode PTGThreads(p1, p2)

PTGNode p1;
PTGNode p2;
#endif
{
	_PPTGThreads n;
	n = (_PPTGThreads)MALLOC(sizeof(struct _SPTGThreads));
	n->_print = (_PTGProc)_PrPTGThreads;
	n->p1 = p1;
	n->p2 = p2;
	return (PTGNode)n;
}


/* Implementation of Pattern DataSectionBlockFactor */

typedef struct _SPTGDataSectionBlockFactor{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGDataSectionBlockFactor;

#ifdef PROTO_OK
static void _PrPTGDataSectionBlockFactor(_PPTGDataSectionBlockFactor n)
#else
static void _PrPTGDataSectionBlockFactor(n)
	_PPTGDataSectionBlockFactor n;
#endif
{
	PTG_OUTPUT_STRING(f, ":block=");
	n->p1->_print(n->p1);
}

#ifdef PROTO_OK
PTGNode PTGDataSectionBlockFactor(PTGNode p1)
#else
PTGNode PTGDataSectionBlockFactor(p1)

PTGNode p1;
#endif
{
	_PPTGDataSectionBlockFactor n;
	n = (_PPTGDataSectionBlockFactor)MALLOC(sizeof(struct _SPTGDataSectionBlockFactor));
	n->_print = (_PTGProc)_PrPTGDataSectionBlockFactor;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern DataSectionChevrons */

typedef struct _SPTGDataSectionChevrons{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGDataSectionChevrons;

#ifdef PROTO_OK
static void _PrPTGDataSectionChevrons(_PPTGDataSectionChevrons n)
#else
static void _PrPTGDataSectionChevrons(n)
	_PPTGDataSectionChevrons n;
#endif
{
	PTG_OUTPUT_STRING(f, "<");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ">");
}

#ifdef PROTO_OK
PTGNode PTGDataSectionChevrons(PTGNode p1)
#else
PTGNode PTGDataSectionChevrons(p1)

PTGNode p1;
#endif
{
	_PPTGDataSectionChevrons n;
	n = (_PPTGDataSectionChevrons)MALLOC(sizeof(struct _SPTGDataSectionChevrons));
	n->_print = (_PTGProc)_PrPTGDataSectionChevrons;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern DataSectionDemotePTG */

typedef struct _SPTGDataSectionDemotePTG{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGDataSectionDemotePTG;

#ifdef PROTO_OK
static void _PrPTGDataSectionDemotePTG(_PPTGDataSectionDemotePTG n)
#else
static void _PrPTGDataSectionDemotePTG(n)
	_PPTGDataSectionDemotePTG n;
#endif
{
	PTG_OUTPUT_STRING(f, ",demote(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGDataSectionDemotePTG(PTGNode p1)
#else
PTGNode PTGDataSectionDemotePTG(p1)

PTGNode p1;
#endif
{
	_PPTGDataSectionDemotePTG n;
	n = (_PPTGDataSectionDemotePTG)MALLOC(sizeof(struct _SPTGDataSectionDemotePTG));
	n->_print = (_PTGProc)_PrPTGDataSectionDemotePTG;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern DataSectionPromotePTG */

typedef struct _SPTGDataSectionPromotePTG{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDataSectionPromotePTG;

#ifdef PROTO_OK
static void _PrPTGDataSectionPromotePTG(_PPTGDataSectionPromotePTG n)
#else
static void _PrPTGDataSectionPromotePTG(n)
	_PPTGDataSectionPromotePTG n;
#endif
{
	PTG_OUTPUT_STRING(f, ",promote(");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ":");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ")");
}

#ifdef PROTO_OK
PTGNode PTGDataSectionPromotePTG(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDataSectionPromotePTG(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDataSectionPromotePTG n;
	n = (_PPTGDataSectionPromotePTG)MALLOC(sizeof(struct _SPTGDataSectionPromotePTG));
	n->_print = (_PTGProc)_PrPTGDataSectionPromotePTG;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern DataSectionRename */

typedef struct _SPTGDataSectionRename{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDataSectionRename;

#ifdef PROTO_OK
static void _PrPTGDataSectionRename(_PPTGDataSectionRename n)
#else
static void _PrPTGDataSectionRename(n)
	_PPTGDataSectionRename n;
#endif
{
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, "=>");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
}

#ifdef PROTO_OK
PTGNode PTGDataSectionRename(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDataSectionRename(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDataSectionRename n;
	n = (_PPTGDataSectionRename)MALLOC(sizeof(struct _SPTGDataSectionRename));
	n->_print = (_PTGProc)_PrPTGDataSectionRename;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern DataSectionVarUsage */

typedef struct _SPTGDataSectionVarUsage{
	_PTGProc _print;
	PTGNode p1;
	PTGNode p2;
	PTGNode p3;
} * _PPTGDataSectionVarUsage;

#ifdef PROTO_OK
static void _PrPTGDataSectionVarUsage(_PPTGDataSectionVarUsage n)
#else
static void _PrPTGDataSectionVarUsage(n)
	_PPTGDataSectionVarUsage n;
#endif
{
	PTG_OUTPUT_STRING(f, "<");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ":");
	n->p2->_print(n->p2);
	n->p3->_print(n->p3);
	PTG_OUTPUT_STRING(f, ">");
}

#ifdef PROTO_OK
PTGNode PTGDataSectionVarUsage(PTGNode p1, PTGNode p2, PTGNode p3)
#else
PTGNode PTGDataSectionVarUsage(p1, p2, p3)

PTGNode p1;
PTGNode p2;
PTGNode p3;
#endif
{
	_PPTGDataSectionVarUsage n;
	n = (_PPTGDataSectionVarUsage)MALLOC(sizeof(struct _SPTGDataSectionVarUsage));
	n->_print = (_PTGProc)_PrPTGDataSectionVarUsage;
	n->p1 = p1;
	n->p2 = p2;
	n->p3 = p3;
	return (PTGNode)n;
}


/* Implementation of Pattern GlobalMemoryAdd */

typedef struct _SPTGGlobalMemoryAdd{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGGlobalMemoryAdd;

#ifdef PROTO_OK
static void _PrPTGGlobalMemoryAdd(_PPTGGlobalMemoryAdd n)
#else
static void _PrPTGGlobalMemoryAdd(n)
	_PPTGGlobalMemoryAdd n;
#endif
{
	PTG_OUTPUT_STRING(f, "  if (GlobalMemoryCnt == 0) {");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "    GlobalMemorySize += (");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, ")*4;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  }");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGGlobalMemoryAdd(PTGNode p1)
#else
PTGNode PTGGlobalMemoryAdd(p1)

PTGNode p1;
#endif
{
	_PPTGGlobalMemoryAdd n;
	n = (_PPTGGlobalMemoryAdd)MALLOC(sizeof(struct _SPTGGlobalMemoryAdd));
	n->_print = (_PTGProc)_PrPTGGlobalMemoryAdd;
	n->p1 = p1;
	return (PTGNode)n;
}


/* Implementation of Pattern GlobalMemoryInit */

typedef struct _SPTGGlobalMemoryInit{
	_PTGProc _print;
} * _PPTGGlobalMemoryInit;

#ifdef PROTO_OK
static void _PrPTGGlobalMemoryInit(_PPTGGlobalMemoryInit n)
#else
static void _PrPTGGlobalMemoryInit(n)
	_PPTGGlobalMemoryInit n;
#endif
{
	PTG_OUTPUT_STRING(f, "  GlobalMemorySize = 0;");
	IndentNewLine(f);
}

static struct _SPTGGlobalMemoryInit _sptgGlobalMemoryInit = { (_PTGProc) _PrPTGGlobalMemoryInit };

#ifdef PROTO_OK
PTGNode PTGGlobalMemoryInit(void)
#else
PTGNode PTGGlobalMemoryInit()
#endif
{
	return (PTGNode)(&_sptgGlobalMemoryInit);
}


/* Implementation of Pattern GlobalMemorySizeOutput */

typedef struct _SPTGGlobalMemorySizeOutput{
	_PTGProc _print;
	PTGNode p1;
} * _PPTGGlobalMemorySizeOutput;

#ifdef PROTO_OK
static void _PrPTGGlobalMemorySizeOutput(_PPTGGlobalMemorySizeOutput n)
#else
static void _PrPTGGlobalMemorySizeOutput(n)
	_PPTGGlobalMemorySizeOutput n;
#endif
{
	PTG_OUTPUT_STRING(f, "  if (GlobalMemoryCnt == 0) {");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "    //printf(\"Routine: ");
	n->p1->_print(n->p1);
	PTG_OUTPUT_STRING(f, " GPU Global Memory: %d bytes\\n\",GlobalMemorySize);");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "    GlobalMemoryCnt++;");
	IndentNewLine(f);
	PTG_OUTPUT_STRING(f, "  }");
	IndentNewLine(f);
}

#ifdef PROTO_OK
PTGNode PTGGlobalMemorySizeOutput(PTGNode p1)
#else
PTGNode PTGGlobalMemorySizeOutput(p1)

PTGNode p1;
#endif
{
	_PPTGGlobalMemorySizeOutput n;
	n = (_PPTGGlobalMemorySizeOutput)MALLOC(sizeof(struct _SPTGGlobalMemorySizeOutput));
	n->_print = (_PTGProc)_PrPTGGlobalMemorySizeOutput;
	n->p1 = p1;
	return (PTGNode)n;
}

/* ============================ */

/* -------------------------------------------------------- */
/*                  Default Output Functions                */
/* -------------------------------------------------------- */


#ifdef PROTO_OK
void _PTGPrintInt(PTG_OUTPUT_FILE file, int param)
#else
void _PTGPrintInt(file, param)
       PTG_OUTPUT_FILE file; int param;
#endif
{    /* used for short and int */
       sprintf(buffer,"%d",param);
       PTG_OUTPUT_STRING(file,buffer);
}

#ifdef PROTO_OK
void _PTGPrintLong(PTG_OUTPUT_FILE file, long param)
#else
void _PTGPrintLong(file, param)
       PTG_OUTPUT_FILE file; long param;
#endif
{
       sprintf(buffer,"%ld",param);
       PTG_OUTPUT_STRING(file,buffer);
}

#ifdef PROTO_OK
void _PTGPrintDouble(PTG_OUTPUT_FILE file, double param)
#else
void _PTGPrintDouble(file, param)
       PTG_OUTPUT_FILE file; double param;
#endif
{    /* used for float and double */
       sprintf(buffer,"%g",param);
       PTG_OUTPUT_STRING(file,buffer);
}

#ifdef PROTO_OK
void _PTGPrintChar(PTG_OUTPUT_FILE file, char param)
#else
void _PTGPrintChar(file, param)
       PTG_OUTPUT_FILE file; char param;
#endif
{
       buffer[0] = param;
       buffer[1] = 0;
       PTG_OUTPUT_STRING(file,buffer);
}

