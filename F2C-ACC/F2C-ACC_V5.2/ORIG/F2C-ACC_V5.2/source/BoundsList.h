
#ifndef _BoundsLIST_H
#define _BoundsLIST_H

/* include header file defining Bounds if myParams is set: */
#define EMPTYmyParamsHDR
#ifndef EMPTYHDR
#include "myParams.h"
#endif
#undef EMPTYmyParamsHDR

#include "BoundsFunctionTypes.h"

typedef struct _BoundsLE *BoundsList;
typedef BoundsList    *BoundsListPtr;

struct _BoundsLE {
Bounds          head;
BoundsList      tail;
};

#define NULLBoundsList          ((BoundsList)0)
#define NullBoundsList()        ((BoundsList)0)
#define SingleBoundsList(e)     (ConsBoundsList((e),NULLBoundsList))

#if defined(__STDC__) || defined(__cplusplus)

extern void FinlBoundsList(void);
   /* Deallocates all BoundsLists. */
   /* Dynamic storage is allocated on first need */

extern BoundsList ConsBoundsList (Bounds e, BoundsList l);
   /* Constructs a BoundsList of an element e and a given tail l.
    * e is the first element of the list. */

extern Bounds HeadBoundsList (BoundsList l);
   /* Returns the first element of the list l.
    * The list l must not be empty. */

extern BoundsList TailBoundsList (BoundsList l);
   /* Returns the tail of the list l.
    * If l is empty, an empty list is returned. */

extern int LengthBoundsList (BoundsList l);
   /* Returns the number of elements in the list l. */

extern Bounds IthElemBoundsList (BoundsList l, int i);
   /* Returns the i-th element of the List l. The head of l
    * is referred to as 1. If the value of
    * i is greater than the length of the list, an error
    * is reported and the program exits.
    */

extern BoundsList CopyBoundsList (BoundsList l, BoundsMapFct cp);
   /* Copies the list l. Elements are copied by calls of cp. */

extern BoundsList AppBoundsList (BoundsList l1, BoundsList l2);
   /* Concatenates two lists l1 and l2. The resulting list contains l2 at
    * the end of a copy of list l1. */

extern BoundsList AppElBoundsList (BoundsList l, Bounds e);
   /* Appends an element e to the list l.
    * The list l is not copied, it is modified as a side-effect
    * of this function. */

extern void InsertAfterBoundsList (BoundsList l, Bounds e);
   /* This function requires a non-empty list l. The element e is inserted
    * just after the first element of l. 
    * The list l is modified as a side-effect of this function. */

extern BoundsList OrderedInsertBoundsList (BoundsList l, Bounds e, BoundsCmpFctType fcmp);
   /* Inserts the element e into the list l maintaining l in
    * ascending order with respect to the compare fcmp. 
    * The list l is modified as a side-effect of this function. */

extern BoundsListPtr RefEndConsBoundsList (BoundsListPtr addr, Bounds e);
   /* Appends an element e to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern BoundsListPtr RefEndAppBoundsList (BoundsListPtr addr, BoundsList l);
   /* Appends a list l to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern int ElemInBoundsList (Bounds e, BoundsList l, BoundsCmpFctType cmpfct);
   /* This function returns true (1) iff the element e is in the List l.
    * List elements are compared by the function cmpfct. */

extern BoundsList AddToSetBoundsList (Bounds e, BoundsList l, BoundsCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. */

extern BoundsList AddToOrderedSetBoundsList 
       (Bounds e, BoundsList l, BoundsCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. l is assumed to be ordered increasingly in the sense of
    * cmpfct. */

extern BoundsList MapBoundsList (BoundsList l, BoundsMapFct f);
   /* Returns a new BoundsList obtained by applying f to each element of l. */

extern int CompBoundsList (BoundsList l1, BoundsList l2, BoundsCmpFctType f);
   /* Compares the lists l1 and l2 lexicographically by applying f
    * to the corresponding elements. */

extern Bounds SumBoundsList (BoundsList l, BoundsSumFct f, Bounds a);
   /* Applies the binary function f to the elements of the List:
    *   f( f(... f(a, e1), e2, ...), en)
    * If l is empty a is returned. */

#else

extern void FinlBoundsList ();
extern BoundsList ConsBoundsList ();
extern Bounds HeadBoundsList ();
extern BoundsList TailBoundsList ();
extern int LengthBoundsList ();
extern Bounds IthElemBoundsList ();
extern BoundsList CopyBoundsList ();
extern BoundsList AppBoundsList ();
extern BoundsList AppElBoundsList ();
extern void InsertAfterBoundsList ();
extern BoundsList OrderedInsertBoundsList ();
extern BoundsListPtr RefEndConsBoundsList ();
extern BoundsListPtr RefEndAppBoundsList ();
extern int ElemInBoundsList ();
extern BoundsList AddToSetBoundsList ();
extern BoundsList MapBoundsList ();
extern int CompBoundsList ();
extern Bounds SumBoundsList ();

#endif

#ifdef MONITOR
#define DAPTO_RESULTBoundsList(l) DAPTO_RESULT_PTR(l)
#define DAPTO_ARGBoundsList(l)    DAPTO_ARG_PTR (l, BoundsList)
#endif

#endif
