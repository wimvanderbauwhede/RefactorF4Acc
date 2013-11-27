
#ifndef _ProgDeclsLIST_H
#define _ProgDeclsLIST_H

/* include header file defining ProgDecls if myDataList is set: */
#define EMPTYmyDataListHDR
#ifndef EMPTYHDR
#include "myDataList.h"
#endif
#undef EMPTYmyDataListHDR

#include "ProgDeclsFunctionTypes.h"

typedef struct _ProgDeclsLE *ProgDeclsList;
typedef ProgDeclsList    *ProgDeclsListPtr;

struct _ProgDeclsLE {
ProgDecls               head;
ProgDeclsList   tail;
};

#define NULLProgDeclsList               ((ProgDeclsList)0)
#define NullProgDeclsList()     ((ProgDeclsList)0)
#define SingleProgDeclsList(e)  (ConsProgDeclsList((e),NULLProgDeclsList))

#if defined(__STDC__) || defined(__cplusplus)

extern void FinlProgDeclsList(void);
   /* Deallocates all ProgDeclsLists. */
   /* Dynamic storage is allocated on first need */

extern ProgDeclsList ConsProgDeclsList (ProgDecls e, ProgDeclsList l);
   /* Constructs a ProgDeclsList of an element e and a given tail l.
    * e is the first element of the list. */

extern ProgDecls HeadProgDeclsList (ProgDeclsList l);
   /* Returns the first element of the list l.
    * The list l must not be empty. */

extern ProgDeclsList TailProgDeclsList (ProgDeclsList l);
   /* Returns the tail of the list l.
    * If l is empty, an empty list is returned. */

extern int LengthProgDeclsList (ProgDeclsList l);
   /* Returns the number of elements in the list l. */

extern ProgDecls IthElemProgDeclsList (ProgDeclsList l, int i);
   /* Returns the i-th element of the List l. The head of l
    * is referred to as 1. If the value of
    * i is greater than the length of the list, an error
    * is reported and the program exits.
    */

extern ProgDeclsList CopyProgDeclsList (ProgDeclsList l, ProgDeclsMapFct cp);
   /* Copies the list l. Elements are copied by calls of cp. */

extern ProgDeclsList AppProgDeclsList (ProgDeclsList l1, ProgDeclsList l2);
   /* Concatenates two lists l1 and l2. The resulting list contains l2 at
    * the end of a copy of list l1. */

extern ProgDeclsList AppElProgDeclsList (ProgDeclsList l, ProgDecls e);
   /* Appends an element e to the list l.
    * The list l is not copied, it is modified as a side-effect
    * of this function. */

extern void InsertAfterProgDeclsList (ProgDeclsList l, ProgDecls e);
   /* This function requires a non-empty list l. The element e is inserted
    * just after the first element of l. 
    * The list l is modified as a side-effect of this function. */

extern ProgDeclsList OrderedInsertProgDeclsList (ProgDeclsList l, ProgDecls e, ProgDeclsCmpFctType fcmp);
   /* Inserts the element e into the list l maintaining l in
    * ascending order with respect to the compare fcmp. 
    * The list l is modified as a side-effect of this function. */

extern ProgDeclsListPtr RefEndConsProgDeclsList (ProgDeclsListPtr addr, ProgDecls e);
   /* Appends an element e to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern ProgDeclsListPtr RefEndAppProgDeclsList (ProgDeclsListPtr addr, ProgDeclsList l);
   /* Appends a list l to the end of a list given by its address addr.
    * The address where the next element may be appended is returned.
    * The list is modified as a side-effect of this function. */

extern int ElemInProgDeclsList (ProgDecls e, ProgDeclsList l, ProgDeclsCmpFctType cmpfct);
   /* This function returns true (1) iff the element e is in the List l.
    * List elements are compared by the function cmpfct. */

extern ProgDeclsList AddToSetProgDeclsList (ProgDecls e, ProgDeclsList l, ProgDeclsCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. */

extern ProgDeclsList AddToOrderedSetProgDeclsList 
       (ProgDecls e, ProgDeclsList l, ProgDeclsCmpFctType cmpfct);
   /* A list is returned that has e as an element.
    * l is checked whether it already contains e using the compare
    * function cmpfct. l is assumed to be ordered increasingly in the sense of
    * cmpfct. */

extern ProgDeclsList MapProgDeclsList (ProgDeclsList l, ProgDeclsMapFct f);
   /* Returns a new ProgDeclsList obtained by applying f to each element of l. */

extern int CompProgDeclsList (ProgDeclsList l1, ProgDeclsList l2, ProgDeclsCmpFctType f);
   /* Compares the lists l1 and l2 lexicographically by applying f
    * to the corresponding elements. */

extern ProgDecls SumProgDeclsList (ProgDeclsList l, ProgDeclsSumFct f, ProgDecls a);
   /* Applies the binary function f to the elements of the List:
    *   f( f(... f(a, e1), e2, ...), en)
    * If l is empty a is returned. */

#else

extern void FinlProgDeclsList ();
extern ProgDeclsList ConsProgDeclsList ();
extern ProgDecls HeadProgDeclsList ();
extern ProgDeclsList TailProgDeclsList ();
extern int LengthProgDeclsList ();
extern ProgDecls IthElemProgDeclsList ();
extern ProgDeclsList CopyProgDeclsList ();
extern ProgDeclsList AppProgDeclsList ();
extern ProgDeclsList AppElProgDeclsList ();
extern void InsertAfterProgDeclsList ();
extern ProgDeclsList OrderedInsertProgDeclsList ();
extern ProgDeclsListPtr RefEndConsProgDeclsList ();
extern ProgDeclsListPtr RefEndAppProgDeclsList ();
extern int ElemInProgDeclsList ();
extern ProgDeclsList AddToSetProgDeclsList ();
extern ProgDeclsList MapProgDeclsList ();
extern int CompProgDeclsList ();
extern ProgDecls SumProgDeclsList ();

#endif

#ifdef MONITOR
#define DAPTO_RESULTProgDeclsList(l) DAPTO_RESULT_PTR(l)
#define DAPTO_ARGProgDeclsList(l)    DAPTO_ARG_PTR (l, ProgDeclsList)
#endif

#endif
