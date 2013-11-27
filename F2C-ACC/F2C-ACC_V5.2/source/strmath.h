/* $Id: strmath.h,v 3.1 1995/08/25 09:14:17 cogito Exp $ */
/*	strmath.h: string mathematical routines header.
 *
 *	Revision:   1.0  
 *	Author:   Bruce K. Haddon  
 *	Log:   C:/src/strmath/vcs/strmath.h_v  
 * 
 *    Rev 1.0   20 Oct 1990 14:17:18   Bruce K. Haddon
 * Initial revision.
 *
 *	Release: 2.0 Beta 
 */
/* Copyright 1990, Bruce K. Haddon */

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
 
/***
 *~	ARITH_SIZE defines the number of digits in the significand
 *	of the string math. calculations, or the maximum digits
 *	in an integer result.
 ***/
#define ARITH_SIZE (30) 

/***
 *~	The maximum exponent may not be larger than 1/2(|x) - 4, 
 *	where |x is the maximum signed value that can be held in 
 *	that type, and 	MAX_EXP must be defined accordingly (i.e.,
 *	anything less than that value.
 ***/
#define MAX_EXP (100000)

/**	These constants define the selection of rounding
 *	modes (see operation STRM_ROUNDING of function |strmath).
 **/
	
#define STRM_EVEN_ROUND 0
#define STRM_ZERO_ROUND 1
#define STRM_UP_ROUND 2
#define STRM_DOWN_ROUND 3
#define STRM_HAND_ROUND 4

/**	The constants defined the selectable operations of the
 *	function |strmath.
 **/
#define STRM_DIGITS 1
#define STRM_EXP_SYMBOLS 2
#define STRM_SIGNS 3
#define STRM_SEPARATORS 4
#define STRM_EXP_BASE 5
#define STRM_INTEGER_SIZE 6
#define STRM_ROUND_SIZE 7
#define STRM_ROUNDING 8
#define STRM_DENORMALIZE 9
#define STRM_INEXACT 10
#define STRM_CHECK_DIGITS 11
#define STRM_IGNORE_CASE 12
		
#define STRM_DIGITS_DEFAULT "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%$"
#define STRM_EXP_SYMBOLS_DEFAULT "^"
#define STRM_SIGNS_DEFAULT "-+"
#define STRM_SEPARATORS_DEFAULT "."
#define STRM_EXP_BASE_DEFAULT (10)
#define STRM_INTEGER_SIZE_DEFAULT (ARITH_SIZE - 2)  
#define STRM_ROUND_SIZE_DEFAULT (2)
#define STRM_ROUNDING_DEFAULT (STRM_EVEN_ROUND)
#define STRM_DENORMALIZE_DEFAULT (1)
#define STRM_INEXACT_DEFAULT (1)
#define STRM_CHECK_DIGITS_DEFAULT (1)
#define STRM_IGNORE_CASE_DEFAULT (1)

#if (STRM_INTEGER_SIZE_DEFAULT + STRM_ROUND_SIZE_DEFAULT) > ARITH_SIZE
(#error) (STRM_INTEGER_SIZE_DEFAULT + STRM_ROUND_SIZE_DEFAULT) > ARITH_SIZE
#endif
	
#define STRM_PI "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651"
#define STRM_E  "2.71828182845904523536028747135266249775724709369995957496696762772407663035354759457138217852516642742746639193"

#ifndef CONST

#if defined(__cplusplus) || defined(__STDC__) || defined(__ANSI__) || \
    defined(__GNUC__) || defined(__STRICT_ANSI__)
#define CONST const
#else
#define CONST
#endif

#endif

#if defined(__STDC__) || defined(__cplusplus)
extern int strmath(int, ...);
extern char *strsqrt(CONST char *, int);
extern char *strneg(CONST char *, int);
extern char *strpow(CONST char *, CONST char *, int);
extern char *stradd(CONST char *, CONST char *, int);
extern char *strsub(CONST char *, CONST char *, int);
extern char *strmult(CONST char *, CONST char *, int);
extern char *strdivf(CONST char *, CONST char *, int);
extern char *strdivi(CONST char *, CONST char *, int);
extern char *strrem(CONST char *, CONST char *, int);
extern char *strnorm(CONST char *, int, int, CONST char *);
extern const char *strnumb(CONST char *, int *, int);
#else
extern int strmath();
extern char *strsqrt();
extern char *strneg();
extern char *strpow();
extern char *stradd();
extern char *strsub();
extern char *strmult();
extern char *strdivf();
extern char *strdivi();
extern char *strrem();
extern char *strnorm();
extern char *strnumb();
#endif
