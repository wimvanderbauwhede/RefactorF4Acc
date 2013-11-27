
#ifndef _CoordPtrLIST_H
#define _CoordPtrLIST_H

/* include header file defining CoordPtr if err is set: */
#define EMPTYerrHDR
#ifndef EMPTYHDR
#include "err.h"
#endif
#undef EMPTYerrHDR

#include "CoordPtrFunctionTypes.h"

typedef struct _CoordPtrLE *CoordPtrList;
typedef CoordPtrList    *CoordPtrListPtr;

struct _CoordPtrLE {
CoordPtr                head;
CoordPtrList    tail;
};

#define NULLCoordPtrList                ((CoordPtrList)0)
#define NullCoordPtrList()      ((CoordPtrList)0)
#define SingleCoordPtrList(e)   (ConsCoordPtrList((e),NULLCoordPtrList))

#if defined(__STDC__) || defined(__cplusplus)

extern void FinlCoordPtrList(void);
   /* Deallocates all CoordPtrLists. */
   /* Dynamic storage is allocated on first need */

extern CoordPtrList ConsCoordPtrList (CoordPtr e, CoordPtrList l);
   /* Constructs a CoordPtrList of an element e and a given tail l.
    * e is the first element of the list. */

extern CoordPtr HeadCoordPtrList (CoordPtrList l);
   /* Returns the first element of the list l.
    * The list l must not be empty. */

extern CoordPtrList TailCoordPtrList (CoordPtrList l);
   /* Returns the tail of the list l.
    * If l is empty, an empty list is returned. */

extern int LengthCoordPtrList (CoordPtrList l);
   /* Returns the number of elements in the list l. */

extern CoordPtr IthElemCoordPtrList (CoordPtrList l, int i);
   /* Returns the i-th element of the List l. The head of l
    * is referred to as 1. If the value of
    * i is greater than the length of the list, an error
    * is reported and the program exits.
    */

extern CoordPtrList CopyCoordPtrList (CoordPtrList l, CoordPtrMapFct cp);
   /* Copies the list l. Elements are copied by calls of cp. */

extern CoordPtrList AppCoordPtrList (CoordPtrList l1, CoordPtrList l2);
   /* Concatenates two lists l1 and l2. The resulting list contains l2 at
    * the end of a copy of list l1. */

extern CoordPtrList AppElCoordPtrList (CoordPtrList l, CoordPtr e);
   /* Appends an element e to the list l.
    * The list l is not copied, it is modified as a side-effect
    * of this function. */

extern void InsertAfterCoordPtrList (CoordPtrList l, CoordPtr e);
   /* This function requires a non-empty list l. The element e is inserted
    * just after the first element of l. 
    * The list l is modified as a side-effect of this function. */

extern CoordPtrList OrderedInsertCoordPtrList (CoordPtrList l, CoordPtr e, CoordPtrCmpFctType fcmp);
   /* Inserts the element e into the list l maintaining l in
    * ascending order with respect to the compare fcmp. 
    * The list l is modified as a side-effect of this function. */

extern CoordPtrListPtr RefEndConsCoordPtrList (CoordPtrListPtr addr, CoordPtr e);
   /* Appends an element e to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern CoordPtrListPtr RefEndAppCoordPtrList (CoordPtrListPtr addr, CoordPtrList l);
   /* Appends a list l to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern int ElemInCoordPtrList (CoordPtr e, CoordPtrList l, CoordPtrCmpFctType cmpfct);
   /* This function returns true (1) iff the element e is in the List l.
    * List elements are compared by the function cmpfct. */

extern CoordPtrList AddToSetCoordPtrList (CoordPtr e, CoordPtrList l, CoordPtrCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. */

extern CoordPtrList AddToOrderedSetCoordPtrList 
       (CoordPtr e, CoordPtrList l, CoordPtrCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. l is assumed to be ordered increasingly in the sense of
    * cmpfct. */

extern CoordPtrList MapCoordPtrList (CoordPtrList l, CoordPtrMapFct f);
   /* Returns a new CoordPtrList obtained by applying f to each element of l. */

extern int CompCoordPtrList (CoordPtrList l1, CoordPtrList l2, CoordPtrCmpFctType f);
   /* Compares the lists l1 and l2 lexicographically by applying f
    * to the corresponding elements. */

extern CoordPtr SumCoordPtrList (CoordPtrList l, CoordPtrSumFct f, CoordPtr a);
   /* Applies the binary function f to the elements of the List:
    *   f( f(... f(a, e1), e2, ...), en)
    * If l is empty a is returned. */

#else

extern void FinlCoordPtrList ();
extern CoordPtrList ConsCoordPtrList ();
extern CoordPtr HeadCoordPtrList ();
extern CoordPtrList TailCoordPtrList ();
extern int LengthCoordPtrList ();
extern CoordPtr IthElemCoordPtrList ();
extern CoordPtrList CopyCoordPtrList ();
extern CoordPtrList AppCoordPtrList ();
extern CoordPtrList AppElCoordPtrList ();
extern void InsertAfterCoordPtrList ();
extern CoordPtrList OrderedInsertCoordPtrList ();
extern CoordPtrListPtr RefEndConsCoordPtrList ();
extern CoordPtrListPtr RefEndAppCoordPtrList ();
extern int ElemInCoordPtrList ();
extern CoordPtrList AddToSetCoordPtrList ();
extern CoordPtrList MapCoordPtrList ();
extern int CompCoordPtrList ();
extern CoordPtr SumCoordPtrList ();

#endif

#ifdef MONITOR
#define DAPTO_RESULTCoordPtrList(l) DAPTO_RESULT_PTR(l)
#define DAPTO_ARGCoordPtrList(l)    DAPTO_ARG_PTR (l, CoordPtrList)
#endif

#endif
