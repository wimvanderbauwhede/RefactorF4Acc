
#ifndef _GPUVarsLIST_H
#define _GPUVarsLIST_H

/* include header file defining GPUVars if myDataList is set: */
#define EMPTYmyDataListHDR
#ifndef EMPTYHDR
#include "myDataList.h"
#endif
#undef EMPTYmyDataListHDR

#include "GPUVarsFunctionTypes.h"

typedef struct _GPUVarsLE *GPUVarsList;
typedef GPUVarsList    *GPUVarsListPtr;

struct _GPUVarsLE {
GPUVars         head;
GPUVarsList     tail;
};

#define NULLGPUVarsList         ((GPUVarsList)0)
#define NullGPUVarsList()       ((GPUVarsList)0)
#define SingleGPUVarsList(e)    (ConsGPUVarsList((e),NULLGPUVarsList))

#if defined(__STDC__) || defined(__cplusplus)

extern void FinlGPUVarsList(void);
   /* Deallocates all GPUVarsLists. */
   /* Dynamic storage is allocated on first need */

extern GPUVarsList ConsGPUVarsList (GPUVars e, GPUVarsList l);
   /* Constructs a GPUVarsList of an element e and a given tail l.
    * e is the first element of the list. */

extern GPUVars HeadGPUVarsList (GPUVarsList l);
   /* Returns the first element of the list l.
    * The list l must not be empty. */

extern GPUVarsList TailGPUVarsList (GPUVarsList l);
   /* Returns the tail of the list l.
    * If l is empty, an empty list is returned. */

extern int LengthGPUVarsList (GPUVarsList l);
   /* Returns the number of elements in the list l. */

extern GPUVars IthElemGPUVarsList (GPUVarsList l, int i);
   /* Returns the i-th element of the List l. The head of l
    * is referred to as 1. If the value of
    * i is greater than the length of the list, an error
    * is reported and the program exits.
    */

extern GPUVarsList CopyGPUVarsList (GPUVarsList l, GPUVarsMapFct cp);
   /* Copies the list l. Elements are copied by calls of cp. */

extern GPUVarsList AppGPUVarsList (GPUVarsList l1, GPUVarsList l2);
   /* Concatenates two lists l1 and l2. The resulting list contains l2 at
    * the end of a copy of list l1. */

extern GPUVarsList AppElGPUVarsList (GPUVarsList l, GPUVars e);
   /* Appends an element e to the list l.
    * The list l is not copied, it is modified as a side-effect
    * of this function. */

extern void InsertAfterGPUVarsList (GPUVarsList l, GPUVars e);
   /* This function requires a non-empty list l. The element e is inserted
    * just after the first element of l. 
    * The list l is modified as a side-effect of this function. */

extern GPUVarsList OrderedInsertGPUVarsList (GPUVarsList l, GPUVars e, GPUVarsCmpFctType fcmp);
   /* Inserts the element e into the list l maintaining l in
    * ascending order with respect to the compare fcmp. 
    * The list l is modified as a side-effect of this function. */

extern GPUVarsListPtr RefEndConsGPUVarsList (GPUVarsListPtr addr, GPUVars e);
   /* Appends an element e to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern GPUVarsListPtr RefEndAppGPUVarsList (GPUVarsListPtr addr, GPUVarsList l);
   /* Appends a list l to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern int ElemInGPUVarsList (GPUVars e, GPUVarsList l, GPUVarsCmpFctType cmpfct);
   /* This function returns true (1) iff the element e is in the List l.
    * List elements are compared by the function cmpfct. */

extern GPUVarsList AddToSetGPUVarsList (GPUVars e, GPUVarsList l, GPUVarsCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. */

extern GPUVarsList AddToOrderedSetGPUVarsList 
       (GPUVars e, GPUVarsList l, GPUVarsCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. l is assumed to be ordered increasingly in the sense of
    * cmpfct. */

extern GPUVarsList MapGPUVarsList (GPUVarsList l, GPUVarsMapFct f);
   /* Returns a new GPUVarsList obtained by applying f to each element of l. */

extern int CompGPUVarsList (GPUVarsList l1, GPUVarsList l2, GPUVarsCmpFctType f);
   /* Compares the lists l1 and l2 lexicographically by applying f
    * to the corresponding elements. */

extern GPUVars SumGPUVarsList (GPUVarsList l, GPUVarsSumFct f, GPUVars a);
   /* Applies the binary function f to the elements of the List:
    *   f( f(... f(a, e1), e2, ...), en)
    * If l is empty a is returned. */

#else

extern void FinlGPUVarsList ();
extern GPUVarsList ConsGPUVarsList ();
extern GPUVars HeadGPUVarsList ();
extern GPUVarsList TailGPUVarsList ();
extern int LengthGPUVarsList ();
extern GPUVars IthElemGPUVarsList ();
extern GPUVarsList CopyGPUVarsList ();
extern GPUVarsList AppGPUVarsList ();
extern GPUVarsList AppElGPUVarsList ();
extern void InsertAfterGPUVarsList ();
extern GPUVarsList OrderedInsertGPUVarsList ();
extern GPUVarsListPtr RefEndConsGPUVarsList ();
extern GPUVarsListPtr RefEndAppGPUVarsList ();
extern int ElemInGPUVarsList ();
extern GPUVarsList AddToSetGPUVarsList ();
extern GPUVarsList MapGPUVarsList ();
extern int CompGPUVarsList ();
extern GPUVars SumGPUVarsList ();

#endif

#ifdef MONITOR
#define DAPTO_RESULTGPUVarsList(l) DAPTO_RESULT_PTR(l)
#define DAPTO_ARGGPUVarsList(l)    DAPTO_ARG_PTR (l, GPUVarsList)
#endif

#endif
