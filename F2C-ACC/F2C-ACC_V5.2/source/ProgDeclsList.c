

#include "ProgDeclsList.h"
#include "err.h"
#include "obstack.h"

typedef struct {
  Obstack space;
  void *baseptr;
} Dyn, *DynP;

static DynP ProgDeclsListSpace = (DynP)0;

#if defined(__STDC__) || defined(__cplusplus)
void FinlProgDeclsList (void)
#else
void FinlProgDeclsList ()
#endif
{
    if (ProgDeclsListSpace != (DynP)0)
    {  obstack_free(&(ProgDeclsListSpace->space), ProgDeclsListSpace->baseptr);
       ProgDeclsListSpace->baseptr = obstack_alloc(&(ProgDeclsListSpace->space), 0);
    }
}/* FinlProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList ConsProgDeclsList (ProgDecls e, ProgDeclsList l)
#else
ProgDeclsList ConsProgDeclsList (e, l)
        ProgDecls       e;
        ProgDeclsList   l;
#endif
{
    ProgDeclsList       h;

    if (ProgDeclsListSpace == (DynP)0)
    {   ProgDeclsListSpace = (DynP) malloc (sizeof(Dyn));
        if (ProgDeclsListSpace == (DynP)0)
        {  message (DEADLY, "no space for ProgDeclsList", 0, (POSITION*)0);
           exit (1);
        }
        obstack_init(&(ProgDeclsListSpace->space));
        ProgDeclsListSpace->baseptr =
                obstack_alloc(&(ProgDeclsListSpace->space), 0);
    }

    h = (ProgDeclsList)obstack_alloc(&(ProgDeclsListSpace->space),
                                  sizeof (struct _ProgDeclsLE));
    h->head = e;
    h->tail= l;
    return (h);
}/* ConsProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDecls HeadProgDeclsList (ProgDeclsList l)
#else
ProgDecls HeadProgDeclsList (l)
        ProgDeclsList   l;
#endif
{
    if (l == NULLProgDeclsList)
    {
        message (DEADLY, "HeadProgDeclsList: empty list", 0, (POSITION*)0);
        /* return ((ProgDecls)0); */
    } /* if */
    return (l->head);
}/* HeadProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList TailProgDeclsList (ProgDeclsList l)
#else
ProgDeclsList TailProgDeclsList (l)
        ProgDeclsList   l;
#endif
{
    return ((l==NULLProgDeclsList) ? NULLProgDeclsList : l->tail);
}/* TailProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
int LengthProgDeclsList (ProgDeclsList l)
#else
int LengthProgDeclsList (l)
        ProgDeclsList   l;
#endif
{
    int res = 0;

    for (; l; l = l->tail)
        res++;
    return (res);
}/* LengthProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDecls IthElemProgDeclsList (ProgDeclsList l, int i)
#else
ProgDecls IthElemProgDeclsList (l, i)
        ProgDeclsList   l;
        int     i;
#endif
{
    while ((i>1) && l)
    {
        i--;
        l = l->tail;
    }

    if ((i<=0) || (l==NULLProgDeclsList))
        message (DEADLY, "IthElemProgDeclsList: no such element",
                 0, (POSITION*)0);
    return (l->head);
}/* IthProgDeclsList */


#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList CopyProgDeclsList (ProgDeclsList l, ProgDeclsMapFct cp)
#else
ProgDeclsList CopyProgDeclsList (l, cp)
        ProgDeclsList l;
        ProgDeclsMapFct cp;
#endif
{
    ProgDeclsList NewList=NULLProgDeclsList, *addr = &NewList;

    while (l)
    {
        (*addr) = ConsProgDeclsList (cp (l->head), NULLProgDeclsList);
        addr = &((*addr)->tail);
        l = l->tail;
    }
    return (NewList);
}/* CopyProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList AppProgDeclsList (ProgDeclsList l1, ProgDeclsList l2)
#else
ProgDeclsList AppProgDeclsList (l1, l2)
        ProgDeclsList   l1, l2;
#endif
{
    ProgDeclsList       NewList;
    ProgDeclsList       *addr = &NewList;

    if (!l1) return (l2);
    if (!l2) return (l1);

    while (l1) {
        (*addr) = ConsProgDeclsList (l1->head, NULLProgDeclsList);
        addr = &((*addr)->tail);
        l1 = l1->tail;
    }
    (*addr) = l2;

    return (NewList);
}/* AppProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList AppElProgDeclsList (ProgDeclsList l, ProgDecls e)
#else
ProgDeclsList AppElProgDeclsList (l, e)
        ProgDeclsList   l;
        ProgDecls       e;
#endif
{
    ProgDeclsList       res = l;
    if (!l)
        return (ConsProgDeclsList (e, NULLProgDeclsList));

    while (l->tail)
        l = l->tail;
    l->tail = ConsProgDeclsList (e, NULLProgDeclsList);

    return (res);
} /* AppElProgDeclsList */


#if defined(__STDC__) || defined(__cplusplus)
void InsertAfterProgDeclsList (ProgDeclsList l, ProgDecls e)
#else
void InsertAfterProgDeclsList (l, e)
        ProgDeclsList   l;
        ProgDecls       e;
#endif
{
    if (!l)
        message (DEADLY, "InsertAfterProgDeclsList: null list", 0, (POSITION*)0);
    else
        l->tail = ConsProgDeclsList (e, l->tail);
}/* InsertAfterProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList OrderedInsertProgDeclsList (ProgDeclsList l, ProgDecls e, ProgDeclsCmpFctType fcmp)
#else
ProgDeclsList OrderedInsertProgDeclsList (l, e, fcmp)
        ProgDeclsList   l;
        ProgDecls       e;
        ProgDeclsCmpFctType fcmp;
#endif
{
    ProgDeclsList       p;
    if (!l)
        return (ConsProgDeclsList (e, NULLProgDeclsList));
    if (fcmp (e, l->head) <= 0)
        return (ConsProgDeclsList (e, l));
    p = l;
    while (p->tail && (fcmp (e, p->tail->head) > 0))
        p = p->tail;
    p->tail = ConsProgDeclsList (e, p->tail);
    return (l);
}/* OrderedInsertProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsListPtr RefEndConsProgDeclsList (ProgDeclsListPtr addr, ProgDecls e)
#else
ProgDeclsListPtr RefEndConsProgDeclsList (addr, e)
        ProgDeclsListPtr        addr;
        ProgDecls               e;
#endif
{
    if (!addr)
    {
        message (DEADLY, "RefEndConsProgDeclsList: no ProgDeclsList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    (*addr) = ConsProgDeclsList (e, NULLProgDeclsList);
    return (&((*addr)->tail));
}/* RefEndConsProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsListPtr RefEndAppProgDeclsList (ProgDeclsListPtr addr, ProgDeclsList l)
#else
ProgDeclsListPtr RefEndAppProgDeclsList (addr, l)
        ProgDeclsListPtr        addr;
        ProgDeclsList           l;
#endif
{
    if (!addr) {
        message (DEADLY, "RefEndAppProgDeclsList: no ProgDeclsList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    if (!l)
        return addr;

    (*addr) = l;

    while (l->tail)
        l = l->tail;
    return (&(l->tail));
}/* RefEndAppProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
int ElemInProgDeclsList (ProgDecls e, ProgDeclsList l, ProgDeclsCmpFctType fcmp)
#else
int ElemInProgDeclsList (e, l, fcmp)
        ProgDecls       e;
        ProgDeclsList   l;
        ProgDeclsCmpFctType     fcmp;
#endif
{
    while (l != NULLProgDeclsList) {
        if (fcmp (e, l->head) == 0)
            return (1);
        l = l->tail;
    }
    return (0);
}/* ElemInProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList AddToSetProgDeclsList (ProgDecls e, ProgDeclsList l, ProgDeclsCmpFctType fcmp)
#else
ProgDeclsList AddToSetProgDeclsList (e, l, fcmp)
        ProgDecls       e;
        ProgDeclsList   l;
        ProgDeclsCmpFctType     fcmp;
#endif
{
    if (ElemInProgDeclsList (e, l, fcmp))
        return (l);
    else
        return (ConsProgDeclsList (e, l));
}/* AddToSetProgDeclsList */


#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList AddToOrderedSetProgDeclsList (ProgDecls e, ProgDeclsList l, ProgDeclsCmpFctType fcmp)
#else
ProgDeclsList AddToOrderedSetProgDeclsList (e, l, fcmp)
        ProgDecls  e;
        ProgDeclsList      l;
        ProgDeclsCmpFctType fcmp;
#endif
{   int test;
    ProgDeclsList  p;
    if (!l)
        return (ConsProgDeclsList (e, NULLProgDeclsList));
    if ((test = fcmp (e, l->head)) < 0)
        return (ConsProgDeclsList (e, l));
    if (test == 0) return l;
    p = l;
    while (p->tail && ((test = fcmp (e, p->tail->head)) > 0))
        p = p->tail;
    if (test) p->tail = ConsProgDeclsList (e, p->tail);
    return (l);
}/* AddToOrderedSetProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDeclsList MapProgDeclsList (ProgDeclsList l, ProgDeclsMapFct f)
#else
ProgDeclsList MapProgDeclsList (l, f)
        ProgDeclsList   l;
        ProgDeclsMapFct f;
#endif
{
    ProgDeclsList NewList = NULLProgDeclsList;
    ProgDeclsList last = NULLProgDeclsList;

    while (l)
    {
        if (!NewList) {
            NewList = ConsProgDeclsList ((f (l->head)), NULLProgDeclsList);
            last = NewList;
        }
        else
        {
            last->tail = ConsProgDeclsList ((f (l->head)), NULLProgDeclsList);
            last = last->tail;
        }
        l = l->tail;
    }
    return (NewList);
}/* MapProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
int CompProgDeclsList (ProgDeclsList l1, ProgDeclsList l2, ProgDeclsCmpFctType fcmp)
#else
int CompProgDeclsList (l1, l2, fcmp)
        ProgDeclsList   l1, l2;
        ProgDeclsCmpFctType fcmp;
#endif
{
    int res = 0;
    while (l1 && l2 && (res == 0)) {
        res = (fcmp (l1->head, l2->head));
        l1 = l1->tail;
        l2 = l2->tail;
    }
    if (l1 && !l2)
        return (1);
    if (!l1 && l2)
        return (-1);
    return (res);
}/* CompProgDeclsList */

#if defined(__STDC__) || defined(__cplusplus)
ProgDecls SumProgDeclsList (ProgDeclsList l, ProgDeclsSumFct f, ProgDecls a)
#else
ProgDecls SumProgDeclsList (l, f, a)
        ProgDeclsList   l;
        ProgDecls ((*f) ());
        ProgDecls       a;
#endif
{
    while (l) {
        a = (f (a, l->head));
        l = l->tail;
    }
    return (a);
}/* SumProgDeclsList */
