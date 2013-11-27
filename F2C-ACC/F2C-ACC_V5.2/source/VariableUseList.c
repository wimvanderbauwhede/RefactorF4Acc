

#include "VariableUseList.h"
#include "err.h"
#include "obstack.h"

typedef struct {
  Obstack space;
  void *baseptr;
} Dyn, *DynP;

static DynP VariableUseListSpace = (DynP)0;

#if defined(__STDC__) || defined(__cplusplus)
void FinlVariableUseList (void)
#else
void FinlVariableUseList ()
#endif
{
    if (VariableUseListSpace != (DynP)0)
    {  obstack_free(&(VariableUseListSpace->space), VariableUseListSpace->baseptr);
       VariableUseListSpace->baseptr = obstack_alloc(&(VariableUseListSpace->space), 0);
    }
}/* FinlVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList ConsVariableUseList (VariableUse e, VariableUseList l)
#else
VariableUseList ConsVariableUseList (e, l)
        VariableUse     e;
        VariableUseList l;
#endif
{
    VariableUseList     h;

    if (VariableUseListSpace == (DynP)0)
    {   VariableUseListSpace = (DynP) malloc (sizeof(Dyn));
        if (VariableUseListSpace == (DynP)0)
        {  message (DEADLY, "no space for VariableUseList", 0, (POSITION*)0);
           exit (1);
        }
        obstack_init(&(VariableUseListSpace->space));
        VariableUseListSpace->baseptr =
                obstack_alloc(&(VariableUseListSpace->space), 0);
    }

    h = (VariableUseList)obstack_alloc(&(VariableUseListSpace->space),
                                  sizeof (struct _VariableUseLE));
    h->head = e;
    h->tail= l;
    return (h);
}/* ConsVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUse HeadVariableUseList (VariableUseList l)
#else
VariableUse HeadVariableUseList (l)
        VariableUseList l;
#endif
{
    if (l == NULLVariableUseList)
    {
        message (DEADLY, "HeadVariableUseList: empty list", 0, (POSITION*)0);
        /* return ((VariableUse)0); */
    } /* if */
    return (l->head);
}/* HeadVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList TailVariableUseList (VariableUseList l)
#else
VariableUseList TailVariableUseList (l)
        VariableUseList l;
#endif
{
    return ((l==NULLVariableUseList) ? NULLVariableUseList : l->tail);
}/* TailVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
int LengthVariableUseList (VariableUseList l)
#else
int LengthVariableUseList (l)
        VariableUseList l;
#endif
{
    int res = 0;

    for (; l; l = l->tail)
        res++;
    return (res);
}/* LengthVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUse IthElemVariableUseList (VariableUseList l, int i)
#else
VariableUse IthElemVariableUseList (l, i)
        VariableUseList l;
        int     i;
#endif
{
    while ((i>1) && l)
    {
        i--;
        l = l->tail;
    }

    if ((i<=0) || (l==NULLVariableUseList))
        message (DEADLY, "IthElemVariableUseList: no such element",
                 0, (POSITION*)0);
    return (l->head);
}/* IthVariableUseList */


#if defined(__STDC__) || defined(__cplusplus)
VariableUseList CopyVariableUseList (VariableUseList l, VariableUseMapFct cp)
#else
VariableUseList CopyVariableUseList (l, cp)
        VariableUseList l;
        VariableUseMapFct       cp;
#endif
{
    VariableUseList NewList=NULLVariableUseList, *addr = &NewList;

    while (l)
    {
        (*addr) = ConsVariableUseList (cp (l->head), NULLVariableUseList);
        addr = &((*addr)->tail);
        l = l->tail;
    }
    return (NewList);
}/* CopyVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList AppVariableUseList (VariableUseList l1, VariableUseList l2)
#else
VariableUseList AppVariableUseList (l1, l2)
        VariableUseList l1, l2;
#endif
{
    VariableUseList     NewList;
    VariableUseList     *addr = &NewList;

    if (!l1) return (l2);
    if (!l2) return (l1);

    while (l1) {
        (*addr) = ConsVariableUseList (l1->head, NULLVariableUseList);
        addr = &((*addr)->tail);
        l1 = l1->tail;
    }
    (*addr) = l2;

    return (NewList);
}/* AppVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList AppElVariableUseList (VariableUseList l, VariableUse e)
#else
VariableUseList AppElVariableUseList (l, e)
        VariableUseList l;
        VariableUse     e;
#endif
{
    VariableUseList     res = l;
    if (!l)
        return (ConsVariableUseList (e, NULLVariableUseList));

    while (l->tail)
        l = l->tail;
    l->tail = ConsVariableUseList (e, NULLVariableUseList);

    return (res);
} /* AppElVariableUseList */


#if defined(__STDC__) || defined(__cplusplus)
void InsertAfterVariableUseList (VariableUseList l, VariableUse e)
#else
void InsertAfterVariableUseList (l, e)
        VariableUseList l;
        VariableUse     e;
#endif
{
    if (!l)
        message (DEADLY, "InsertAfterVariableUseList: null list", 0, (POSITION*)0);
    else
        l->tail = ConsVariableUseList (e, l->tail);
}/* InsertAfterVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList OrderedInsertVariableUseList (VariableUseList l, VariableUse e, VariableUseCmpFctType fcmp)
#else
VariableUseList OrderedInsertVariableUseList (l, e, fcmp)
        VariableUseList l;
        VariableUse     e;
        VariableUseCmpFctType fcmp;
#endif
{
    VariableUseList     p;
    if (!l)
        return (ConsVariableUseList (e, NULLVariableUseList));
    if (fcmp (e, l->head) <= 0)
        return (ConsVariableUseList (e, l));
    p = l;
    while (p->tail && (fcmp (e, p->tail->head) > 0))
        p = p->tail;
    p->tail = ConsVariableUseList (e, p->tail);
    return (l);
}/* OrderedInsertVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseListPtr RefEndConsVariableUseList (VariableUseListPtr addr, VariableUse e)
#else
VariableUseListPtr RefEndConsVariableUseList (addr, e)
        VariableUseListPtr      addr;
        VariableUse             e;
#endif
{
    if (!addr)
    {
        message (DEADLY, "RefEndConsVariableUseList: no VariableUseList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    (*addr) = ConsVariableUseList (e, NULLVariableUseList);
    return (&((*addr)->tail));
}/* RefEndConsVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseListPtr RefEndAppVariableUseList (VariableUseListPtr addr, VariableUseList l)
#else
VariableUseListPtr RefEndAppVariableUseList (addr, l)
        VariableUseListPtr      addr;
        VariableUseList         l;
#endif
{
    if (!addr) {
        message (DEADLY, "RefEndAppVariableUseList: no VariableUseList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    if (!l)
        return addr;

    (*addr) = l;

    while (l->tail)
        l = l->tail;
    return (&(l->tail));
}/* RefEndAppVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
int ElemInVariableUseList (VariableUse e, VariableUseList l, VariableUseCmpFctType fcmp)
#else
int ElemInVariableUseList (e, l, fcmp)
        VariableUse     e;
        VariableUseList l;
        VariableUseCmpFctType   fcmp;
#endif
{
    while (l != NULLVariableUseList) {
        if (fcmp (e, l->head) == 0)
            return (1);
        l = l->tail;
    }
    return (0);
}/* ElemInVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList AddToSetVariableUseList (VariableUse e, VariableUseList l, VariableUseCmpFctType fcmp)
#else
VariableUseList AddToSetVariableUseList (e, l, fcmp)
        VariableUse     e;
        VariableUseList l;
        VariableUseCmpFctType   fcmp;
#endif
{
    if (ElemInVariableUseList (e, l, fcmp))
        return (l);
    else
        return (ConsVariableUseList (e, l));
}/* AddToSetVariableUseList */


#if defined(__STDC__) || defined(__cplusplus)
VariableUseList AddToOrderedSetVariableUseList (VariableUse e, VariableUseList l, VariableUseCmpFctType fcmp)
#else
VariableUseList AddToOrderedSetVariableUseList (e, l, fcmp)
        VariableUse  e;
        VariableUseList      l;
        VariableUseCmpFctType fcmp;
#endif
{   int test;
    VariableUseList  p;
    if (!l)
        return (ConsVariableUseList (e, NULLVariableUseList));
    if ((test = fcmp (e, l->head)) < 0)
        return (ConsVariableUseList (e, l));
    if (test == 0) return l;
    p = l;
    while (p->tail && ((test = fcmp (e, p->tail->head)) > 0))
        p = p->tail;
    if (test) p->tail = ConsVariableUseList (e, p->tail);
    return (l);
}/* AddToOrderedSetVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUseList MapVariableUseList (VariableUseList l, VariableUseMapFct f)
#else
VariableUseList MapVariableUseList (l, f)
        VariableUseList l;
        VariableUseMapFct f;
#endif
{
    VariableUseList NewList = NULLVariableUseList;
    VariableUseList last = NULLVariableUseList;

    while (l)
    {
        if (!NewList) {
            NewList = ConsVariableUseList ((f (l->head)), NULLVariableUseList);
            last = NewList;
        }
        else
        {
            last->tail = ConsVariableUseList ((f (l->head)), NULLVariableUseList);
            last = last->tail;
        }
        l = l->tail;
    }
    return (NewList);
}/* MapVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
int CompVariableUseList (VariableUseList l1, VariableUseList l2, VariableUseCmpFctType fcmp)
#else
int CompVariableUseList (l1, l2, fcmp)
        VariableUseList l1, l2;
        VariableUseCmpFctType fcmp;
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
}/* CompVariableUseList */

#if defined(__STDC__) || defined(__cplusplus)
VariableUse SumVariableUseList (VariableUseList l, VariableUseSumFct f, VariableUse a)
#else
VariableUse SumVariableUseList (l, f, a)
        VariableUseList l;
        VariableUse ((*f) ());
        VariableUse     a;
#endif
{
    while (l) {
        a = (f (a, l->head));
        l = l->tail;
    }
    return (a);
}/* SumVariableUseList */
