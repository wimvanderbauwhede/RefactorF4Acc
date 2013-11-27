
#ifndef _VariableUseLIST_H
#define _VariableUseLIST_H

/* include header file defining VariableUse if myDataList is set: */
#define EMPTYmyDataListHDR
#ifndef EMPTYHDR
#include "myDataList.h"
#endif
#undef EMPTYmyDataListHDR

#include "VariableUseFunctionTypes.h"

typedef struct _VariableUseLE *VariableUseList;
typedef VariableUseList    *VariableUseListPtr;

struct _VariableUseLE {
VariableUse             head;
VariableUseList tail;
};

#define NULLVariableUseList             ((VariableUseList)0)
#define NullVariableUseList()   ((VariableUseList)0)
#define SingleVariableUseList(e)        (ConsVariableUseList((e),NULLVariableUseList))

#if defined(__STDC__) || defined(__cplusplus)

extern void FinlVariableUseList(void);
   /* Deallocates all VariableUseLists. */
   /* Dynamic storage is allocated on first need */

extern VariableUseList ConsVariableUseList (VariableUse e, VariableUseList l);
   /* Constructs a VariableUseList of an element e and a given tail l.
    * e is the first element of the list. */

extern VariableUse HeadVariableUseList (VariableUseList l);
   /* Returns the first element of the list l.
    * The list l must not be empty. */

extern VariableUseList TailVariableUseList (VariableUseList l);
   /* Returns the tail of the list l.
    * If l is empty, an empty list is returned. */

extern int LengthVariableUseList (VariableUseList l);
   /* Returns the number of elements in the list l. */

extern VariableUse IthElemVariableUseList (VariableUseList l, int i);
   /* Returns the i-th element of the List l. The head of l
    * is referred to as 1. If the value of
    * i is greater than the length of the list, an error
    * is reported and the program exits.
    */

extern VariableUseList CopyVariableUseList (VariableUseList l, VariableUseMapFct cp);
   /* Copies the list l. Elements are copied by calls of cp. */

extern VariableUseList AppVariableUseList (VariableUseList l1, VariableUseList l2);
   /* Concatenates two lists l1 and l2. The resulting list contains l2 at
    * the end of a copy of list l1. */

extern VariableUseList AppElVariableUseList (VariableUseList l, VariableUse e);
   /* Appends an element e to the list l.
    * The list l is not copied, it is modified as a side-effect
    * of this function. */

extern void InsertAfterVariableUseList (VariableUseList l, VariableUse e);
   /* This function requires a non-empty list l. The element e is inserted
    * just after the first element of l. 
    * The list l is modified as a side-effect of this function. */

extern VariableUseList OrderedInsertVariableUseList (VariableUseList l, VariableUse e, VariableUseCmpFctType fcmp);
   /* Inserts the element e into the list l maintaining l in
    * ascending order with respect to the compare fcmp. 
    * The list l is modified as a side-effect of this function. */

extern VariableUseListPtr RefEndConsVariableUseList (VariableUseListPtr addr, VariableUse e);
   /* Appends an element e to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern VariableUseListPtr RefEndAppVariableUseList (VariableUseListPtr addr, VariableUseList l);
   /* Appends a list l to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern int ElemInVariableUseList (VariableUse e, VariableUseList l, VariableUseCmpFctType cmpfct);
   /* This function returns true (1) iff the element e is in the List l.
    * List elements are compared by the function cmpfct. */

extern VariableUseList AddToSetVariableUseList (VariableUse e, VariableUseList l, VariableUseCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. */

extern VariableUseList AddToOrderedSetVariableUseList 
       (VariableUse e, VariableUseList l, VariableUseCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. l is assumed to be ordered increasingly in the sense of
    * cmpfct. */

extern VariableUseList MapVariableUseList (VariableUseList l, VariableUseMapFct f);
   /* Returns a new VariableUseList obtained by applying f to each element of l. */

extern int CompVariableUseList (VariableUseList l1, VariableUseList l2, VariableUseCmpFctType f);
   /* Compares the lists l1 and l2 lexicographically by applying f
    * to the corresponding elements. */

extern VariableUse SumVariableUseList (VariableUseList l, VariableUseSumFct f, VariableUse a);
   /* Applies the binary function f to the elements of the List:
    *   f( f(... f(a, e1), e2, ...), en)
    * If l is empty a is returned. */

#else

extern void FinlVariableUseList ();
extern VariableUseList ConsVariableUseList ();
extern VariableUse HeadVariableUseList ();
extern VariableUseList TailVariableUseList ();
extern int LengthVariableUseList ();
extern VariableUse IthElemVariableUseList ();
extern VariableUseList CopyVariableUseList ();
extern VariableUseList AppVariableUseList ();
extern VariableUseList AppElVariableUseList ();
extern void InsertAfterVariableUseList ();
extern VariableUseList OrderedInsertVariableUseList ();
extern VariableUseListPtr RefEndConsVariableUseList ();
extern VariableUseListPtr RefEndAppVariableUseList ();
extern int ElemInVariableUseList ();
extern VariableUseList AddToSetVariableUseList ();
extern VariableUseList MapVariableUseList ();
extern int CompVariableUseList ();
extern VariableUse SumVariableUseList ();

#endif

#ifdef MONITOR
#define DAPTO_RESULTVariableUseList(l) DAPTO_RESULT_PTR(l)
#define DAPTO_ARGVariableUseList(l)    DAPTO_ARG_PTR (l, VariableUseList)
#endif

#endif
