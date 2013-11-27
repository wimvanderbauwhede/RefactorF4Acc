/* $Id: Strings.c,v 3.4 2007/02/26 08:18:42 peter Exp $ */
/* Copyright, 1995, AG-Kastens, University Of Paderborn */

/* This file is part of the Eli Module Library.

The Eli Module Library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public License as
published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

The Eli Module Library is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with the Eli Module Library; see the file COPYING.LIB.
If not, write to the Free Software Foundation, Inc., 59 Temple Place -
Suite 330, Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Eli into the
   directory resulting from a :source derivation, you may use that
   created file as a part of that directory without restriction. */

#include "Strings.h"
#if defined(__cplusplus)
#include <string.h>
#endif

#if defined(__cplusplus) || defined(__STDC__)
CharPtr CatStrStr (CharPtr s1, CharPtr s2)
#else
CharPtr CatStrStr (s1, s2) CharPtr s1, s2;
#endif
{
  obstack_grow(Csm_obstk, s1, strlen(s1));
  CsmStrPtr = (char *)obstack_copy0(Csm_obstk, s2, strlen(s2));
  return CsmStrPtr;
} /* CatStrStr */

#if defined(__cplusplus) || defined(__STDC__)
int IndCatStrStr (CharPtr s1, CharPtr s2)
#else
int IndCatStrStr (s1, s2) CharPtr s1, s2;
#endif
{
  obstack_grow(Csm_obstk, s1, strlen(s1));
  CsmStrPtr = (char *)obstack_copy0(Csm_obstk, s2, strlen(s2));
  return stostr(CsmStrPtr, strlen(CsmStrPtr));
} /* IndCatStrStr */
