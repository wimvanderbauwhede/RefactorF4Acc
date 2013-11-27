switch (CaseTbl[c = *p++]) {
case 0:	/* sentinel - probably EOB */
  if (c == '\0') {
    p = TokenStart = TokenEnd = auxNUL(TokenStart, 0);
    if (*p) extcode = NORETURN;
    else {
      p = TokenStart = TokenEnd = auxEOF(TokenStart, 0);
      if (*p) extcode = NORETURN;
      else { extcode = EOFTOKEN; EndOfText(p, 0, &extcode, v); }
    }
    goto done;
  } else {
    obstack_grow(Csm_obstk, "char '", 6);
    obstack_cchgrow(Csm_obstk, c);
    message(
      ERROR,
      (char *)obstack_copy0(Csm_obstk, "' is not a token", 16),
      0,
      &curpos);
    TokenEnd = p;
    continue;
  }
  
case 1:	/* space */
  while (scanTbl[c = *p++] & 1<<0) ;
  TokenEnd = p - 1;
  continue;
case 2:	/* tab */
  do { StartLine -= TABSIZE(p - StartLine); }
  while (scanTbl[c = *p++] & 1<<1);
  TokenEnd = p - 1;
  continue;
case 4:	/* carriage return */
  if (*p == '\n') { TokenEnd = p; continue; }
case 3:	/* newline */
  do { LineNum++; } while (scanTbl[c = *p++] & 1<<2);
  StartLine = (TokenEnd = p - 1) - 1;
  continue;

case 5:	/* Entered on:  A C H J-N P-Y a h j-n p-r t v-y */
	St_22:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 6:	/* Entered on: 0-9 */
	St_16:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_51;}
		else if( scanTbl[c+0] & 1<< 6){ /*  X x */
			goto St_56;}
		else if( scanTbl[c+0] & 1<< 7){ /*  P p */
			goto St_55;}
		else if( scanTbl[c+256] & 1<< 0){ /*  H h */
			goto St_54;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_53;}
		else if( scanTbl[c+256] & 1<< 2){ /*  D d */
		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_52;}
		else if(c ==46) {			goto St_50;}
		else if(c ==32) {			goto St_49;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 30;
			mkfint(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 7:	/* Entered on:  D F I b d f i o z */
	St_24:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_70;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_67;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 8:	/* Entered on:  G g */
	St_26:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_72;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_71;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 9:	/* Entered on:  " ' */
	St_5:
			TokenEnd=p=fstr(TokenStart, p-TokenStart);
			extcode = 92;
			mkstr(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;

case 10:	/* Entered on: u */
	St_35:
		if( scanTbl[(c= *p++)+256] & 1<< 3){ /*  A-Z a-m o-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==110) {			goto St_81;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 11:	/* Entered on: s */
	St_34:
		if( scanTbl[(c= *p++)+256] & 1<< 4){ /*  A-Z a-l n-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==109) {			goto St_80;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 12:	/* Entered on: e */
	St_33:
		if( scanTbl[(c= *p++)+256] & 1<< 5){ /*  A-M O-R T-Z a-m o-r t-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_72;}
		else if( scanTbl[c+256] & 1<< 6){ /*  N S n s */
			goto St_79;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_71;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 13:	/* Entered on: c */
	St_32:
		if( scanTbl[(c= *p++)+256] & 1<< 7){ /*  A-Z a-n p-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==111) {			goto St_78;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 14:	/* Entered on: Z */
	St_28:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_70;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==39) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_77;}
		else if(c ==34) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_76;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_67;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 15:	/* Entered on: O */
	St_27:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_70;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==39) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_75;}
		else if(c ==34) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_74;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_67;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 16:	/* Entered on: E */
	St_25:
		if( scanTbl[(c= *p++)+256] & 1<< 5){ /*  A-M O-R T-Z a-m o-r t-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_72;}
		else if( scanTbl[c+256] & 1<< 6){ /*  N S n s */
			goto St_73;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_71;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 17:	/* Entered on: B */
	St_23:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_70;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==39) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_69;}
		else if(c ==34) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_68;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_67;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 18:	/* Entered on: > */
	St_21:
		if((c= *p++) ==61) {			goto St_62;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 23;
			goto done;
			}

case 19:	/* Entered on: = */
	St_20:
		if((c= *p++) ==62) {			goto St_61;}
		else if(c ==61) {			goto St_60;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 17;
			goto done;
			}

case 20:	/* Entered on: < */
	St_19:
		if((c= *p++) ==61) {			goto St_59;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 22;
			goto done;
			}

case 21:	/* Entered on: ; */
	St_18:
		if((c= *p++) ==59) {			goto St_58;}
		else if(c ==32) {		extcode = 5;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = EndOfStmt;
			goto St_57;}
		else if(c ==10) {			goto St_4;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 5;
			EndOfStmt(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 22:	/* Entered on: / */
	St_15:
		if((c= *p++) ==61) {			goto St_48;}
		else if(c ==47) {			goto St_47;}
		else if(c ==41) {			goto St_46;}
		else if(c ==32) {		extcode = 15001;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkslsh;
			goto St_45;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 15001;
			mkslsh(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 23:	/* Entered on: . */
	St_14:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */

		TokenEnd = TokenStart; /* prepare for error fallback */
			goto St_44;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_43;}
		else if(c ==32) {
		TokenEnd = TokenStart; /* prepare for error fallback */
			goto St_42;}
		else {TokenEnd=TokenStart;--p; goto fallback; }

case 24:	/* Entered on: - */
	St_13:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
		extcode = 20;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_41;}
		else if(c ==32) {		extcode = 20;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_40;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 20;
			goto done;
			}

case 25:	/* Entered on: + */
	St_11:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
		extcode = 19;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_41;}
		else if(c ==32) {		extcode = 19;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_40;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 19;
			goto done;
			}

case 26:	/* Entered on: * */
	St_10:
		if((c= *p++) ==42) {			goto St_39;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 18;
			goto done;
			}

case 27:	/* Entered on: ) */
	St_9:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 15001;
			mkrpar(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;

case 28:	/* Entered on: ( */
	St_8:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
		extcode = 15001;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mklpar;
			goto St_38;}
		else if(c ==47) {			goto St_37;}
		else if(c ==32) {		extcode = 15001;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mklpar;
			goto St_36;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 15001;
			mklpar(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}

case 29:	/* Entered on:  10. */
	St_4:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 5;
			EndOfStmt(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;


default: TokenEnd=p; extcode=ExtCodeTbl[c]; goto done; /*  $-% , : [ ] _ */
}
	St_36:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_38;}
		else if(c ==47) {			goto St_37;}
		else {--p; goto fallback; }
	St_37:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 15001;
			mklabr(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_38:
		if((c= *p++) ==45) {			goto St_85;}
		else if(c ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else if(c ==32) {			goto St_82;}
		else {--p; goto fallback; }
	St_82:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if((c= *p++) ==45) {			goto St_85;}
		else if(c ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else {--p; goto fallback; }
	St_83:
		if( scanTbl[(c= *p++)+512] & 1<< 0){ /*   10. , ; */
			goto St_122;}
		else if(c ==32) {			goto St_123;}
		else {--p; goto fallback; }
	St_123:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+512] & 1<< 0){ /*   10. , ; */
			goto St_122;}
		else {--p; goto fallback; }
	St_122:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 169;
			mkimpl(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_84:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_125;}
		else if(c ==32) {			goto St_124;}
		else {--p; goto fallback; }
	St_124:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_125;}
		else {--p; goto fallback; }
	St_125:
		if((c= *p++) ==45) {			goto St_163;}
		else if(c ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else if(c ==32) {			goto St_162;}
		else {--p; goto fallback; }
	St_162:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if((c= *p++) ==45) {			goto St_163;}
		else if(c ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else {--p; goto fallback; }
	St_163:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_189;}
		else if(c ==32) {			goto St_188;}
		else {--p; goto fallback; }
	St_188:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_189;}
		else {--p; goto fallback; }
	St_189:
		if((c= *p++) ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else if(c ==32) {			goto St_200;}
		else {--p; goto fallback; }
	St_200:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if((c= *p++) ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else {--p; goto fallback; }
	St_85:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_127;}
		else if(c ==32) {			goto St_126;}
		else {--p; goto fallback; }
	St_126:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_127;}
		else {--p; goto fallback; }
	St_127:
		if((c= *p++) ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else if(c ==32) {			goto St_164;}
		else {--p; goto fallback; }
	St_164:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if((c= *p++) ==44) {			goto St_84;}
		else if(c ==41) {			goto St_83;}
		else {--p; goto fallback; }
	St_39:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 201;
			goto done;
	St_40:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_41;}
		else {--p; goto fallback; }
	St_41:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_87;}
		else if( scanTbl[c+0] & 1<< 7){ /*  P p */
			goto St_55;}
		else if(c ==32) {			goto St_86;}
		else {--p; goto fallback; }
	St_86:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_87;}
		else {--p; goto fallback; }
	St_87:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 7){ /*  P p */
			goto St_55;}
		else if(c ==32) {			goto St_86;}
		else {--p; goto fallback; }
	St_55:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 165;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_42:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_44;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_43;}
		else {--p; goto fallback; }
	St_43:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_89;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_91;}
		else if( scanTbl[c+256] & 1<< 2){ /*  D d */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_90;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_88;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_88:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_89;}
		else {--p; goto fallback; }
	St_89:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+256] & 1<< 1){ /*  E e */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_91;}
		else if( scanTbl[c+256] & 1<< 2){ /*  D d */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_90;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_88;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_90:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_130;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_129;}
		else if(c ==32) {			goto St_128;}
		else {--p; goto fallback; }
	St_128:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_130;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_129;}
		else {--p; goto fallback; }
	St_129:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_130;}
		else if(c ==32) {			goto St_165;}
		else {--p; goto fallback; }
	St_165:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_130;}
		else {--p; goto fallback; }
	St_130:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_167;}
		else if(c ==32) {		extcode = 227;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_166;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 227;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_166:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_167;}
		else {--p; goto fallback; }
	St_167:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 227;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_166;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 227;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_91:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_133;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_132;}
		else if(c ==32) {			goto St_131;}
		else {--p; goto fallback; }
	St_131:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_133;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_132;}
		else {--p; goto fallback; }
	St_132:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_133;}
		else if(c ==32) {			goto St_168;}
		else {--p; goto fallback; }
	St_168:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_133;}
		else {--p; goto fallback; }
	St_133:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_170;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_169;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_169:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_170;}
		else {--p; goto fallback; }
	St_170:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_169;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_44:
		if( scanTbl[(c= *p++)+512] & 1<< 2){ /*    A-Z a-z */
			goto St_92;}
		else if(c ==46) {			goto St_93;}
		else {--p; goto fallback; }
	St_93:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 125;
			mkfopr(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_92:
		/*    A-Z a-z*/
		while(scanTbl[(c= *p++)+512] & 1<< 2);--p;
		if((c= *p++) ==46) {			goto St_93;}
		else {--p; goto fallback; }
	St_45:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if((c= *p++) ==47) {			goto St_47;}
		else if(c ==41) {			goto St_46;}
		else {--p; goto fallback; }
	St_46:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 15001;
			mkrabr(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_47:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 15001;
			mkconc(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_48:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 26;
			goto done;
	St_57:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if((c= *p++) ==59) {			goto St_58;}
		else if(c ==10) {			goto St_4;}
		else {--p; goto fallback; }
	St_58:
		/*  ;*/
		while(scanTbl[(c= *p++)+512] & 1<< 3);--p;
		if((c= *p++) ==32) {		extcode = 5;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = EndOfStmt;
			goto St_57;}
		else if(c ==10) {			goto St_4;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 5;
			EndOfStmt(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_59:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 27;
			goto done;
	St_60:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 28;
			goto done;
	St_61:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 46;
			goto done;
	St_62:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 29;
			goto done;
	St_67:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_70;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else {--p; goto fallback; }
	St_65:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 15001;
			mkiokw(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_64:
		/*  0-9 A-Z _ a-z*/
		while(scanTbl[(c= *p++)+512] & 1<< 4);--p;
		if((c= *p++) ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_106:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else {--p; goto fallback; }
	St_70:
		if( scanTbl[(c= *p++)+512] & 1<< 5){ /*  A-Z _ a-z */
			goto St_64;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_111;}
		else if(c ==46) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_110;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_109;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_109:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+512] & 1<< 5){ /*  A-Z _ a-z */
			goto St_64;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_111;}
		else {--p; goto fallback; }
	St_111:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+512] & 1<< 5){ /*  A-Z _ a-z */
			goto St_64;}
		else if(c ==46) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_110;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_109;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_110:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_151;}
		else if(c ==32) {			goto St_150;}
		else {--p; goto fallback; }
	St_150:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_151;}
		else {--p; goto fallback; }
	St_151:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_178;}
		else if(c ==32) {		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_177;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 129;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_177:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_178;}
		else {--p; goto fallback; }
	St_178:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_177;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 129;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_66:
		/*  A-Z a-z*/
		while(scanTbl[(c= *p++)+0] & 1<< 3);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_63:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else {--p; goto fallback; }
	St_68:
		if( scanTbl[(c= *p++)+512] & 1<< 6){ /*  0-1 */
			goto St_107;}
		else {--p; goto fallback; }
	St_107:
		/*  0-1*/
		while(scanTbl[(c= *p++)+512] & 1<< 6);--p;
		if((c= *p++) ==34) {			goto St_149;}
		else {--p; goto fallback; }
	St_149:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 89;
			goto done;
	St_69:
		if( scanTbl[(c= *p++)+512] & 1<< 6){ /*  0-1 */
			goto St_108;}
		else {--p; goto fallback; }
	St_108:
		/*  0-1*/
		while(scanTbl[(c= *p++)+512] & 1<< 6);--p;
		if((c= *p++) ==39) {			goto St_149;}
		else {--p; goto fallback; }
	St_71:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_72;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else {--p; goto fallback; }
	St_72:
		if( scanTbl[(c= *p++)+512] & 1<< 5){ /*  A-Z _ a-z */
			goto St_64;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_114;}
		else if(c ==46) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_113;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_112;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_112:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+512] & 1<< 5){ /*  A-Z _ a-z */
			goto St_64;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_114;}
		else {--p; goto fallback; }
	St_114:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+512] & 1<< 5){ /*  A-Z _ a-z */
			goto St_64;}
		else if(c ==46) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_113;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_112;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_113:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_153;}
		else if(c ==32) {			goto St_152;}
		else {--p; goto fallback; }
	St_152:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_153;}
		else {--p; goto fallback; }
	St_153:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_180;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_181;}
		else if(c ==32) {		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_179;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 129;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_179:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_180;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
			goto St_181;}
		else {--p; goto fallback; }
	St_181:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_193;}
		else if(c ==32) {			goto St_192;}
		else {--p; goto fallback; }
	St_192:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_193;}
		else {--p; goto fallback; }
	St_193:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_202;}
		else if(c ==32) {		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_201;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 129;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_201:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_202;}
		else {--p; goto fallback; }
	St_202:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_201;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 129;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_180:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+256] & 1<< 1){ /*  E e */
		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_181;}
		else if(c ==32) {		extcode = 129;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkidn;
			goto St_179;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 129;
			mkidn(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_73:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_72;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_71;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_74:
		if( scanTbl[(c= *p++)+512] & 1<< 7){ /*  0-7 */
			goto St_115;}
		else {--p; goto fallback; }
	St_115:
		/*  0-7*/
		while(scanTbl[(c= *p++)+512] & 1<< 7);--p;
		if((c= *p++) ==34) {			goto St_154;}
		else {--p; goto fallback; }
	St_154:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 90;
			goto done;
	St_75:
		if( scanTbl[(c= *p++)+512] & 1<< 7){ /*  0-7 */
			goto St_116;}
		else {--p; goto fallback; }
	St_116:
		/*  0-7*/
		while(scanTbl[(c= *p++)+512] & 1<< 7);--p;
		if((c= *p++) ==39) {			goto St_154;}
		else {--p; goto fallback; }
	St_76:
		if( scanTbl[(c= *p++)+768] & 1<< 0){ /*  0-9 A-F a-f */
			goto St_117;}
		else {--p; goto fallback; }
	St_117:
		/*  0-9 A-F a-f*/
		while(scanTbl[(c= *p++)+768] & 1<< 0);--p;
		if((c= *p++) ==34) {			goto St_155;}
		else {--p; goto fallback; }
	St_155:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 91;
			goto done;
	St_77:
		if( scanTbl[(c= *p++)+768] & 1<< 0){ /*  0-9 A-F a-f */
			goto St_118;}
		else {--p; goto fallback; }
	St_118:
		/*  0-9 A-F a-f*/
		while(scanTbl[(c= *p++)+768] & 1<< 0);--p;
		if((c= *p++) ==39) {			goto St_155;}
		else {--p; goto fallback; }
	St_78:
		if( scanTbl[(c= *p++)+768] & 1<< 1){ /*  A-Z a-q s-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==114) {			goto St_119;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_119:
		if( scanTbl[(c= *p++)+256] & 1<< 3){ /*  A-Z a-m o-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==110) {			goto St_156;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_156:
		if( scanTbl[(c= *p++)+768] & 1<< 2){ /*  A-Z a-d f-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==101) {			goto St_182;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_182:
		if( scanTbl[(c= *p++)+768] & 1<< 1){ /*  A-Z a-q s-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==114) {			goto St_194;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_194:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_64;}
		else if(c ==95) {			goto St_203;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_203:
		if( scanTbl[(c= *p++)+768] & 1<< 3){ /*  0-9 A-Z _ a-c e-z */
			goto St_64;}
		else if(c ==100) {			goto St_210;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_210:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_216;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_216:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_224;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_224:
		if( scanTbl[(c= *p++)+768] & 1<< 6){ /*  0-9 A-Z _ a-s u-z */
			goto St_64;}
		else if(c ==116) {			goto St_232;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_232:
		if( scanTbl[(c= *p++)+768] & 1<< 7){ /*  0-9 A-Z _ a-g i-z */
			goto St_64;}
		else if(c ==104) {			goto St_241;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_241:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 54;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 54;
			goto done;
			}
	St_79:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_72;}
		else if(c ==95) {			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_71;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_80:
		if( scanTbl[(c= *p++)+1024] & 1<< 0){ /*  A-Z a-r t-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==115) {			goto St_120;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_120:
		if( scanTbl[(c= *p++)+1024] & 1<< 1){ /*  A-Z a-b e-g i-s u-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==116) {			goto St_160;}
		else if(c ==104) {			goto St_159;}
		else if(c ==100) {			goto St_158;}
		else if(c ==99) {			goto St_157;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_157:
		if( scanTbl[(c= *p++)+768] & 1<< 1){ /*  A-Z a-q s-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==114) {			goto St_183;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_183:
		if( scanTbl[(c= *p++)+768] & 1<< 2){ /*  A-Z a-d f-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==101) {			goto St_195;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_195:
		if( scanTbl[(c= *p++)+1024] & 1<< 2){ /*  A-Z b-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==97) {			goto St_204;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_204:
		if( scanTbl[(c= *p++)+1024] & 1<< 3){ /*  A-Z a-s u-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==116) {			goto St_211;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_211:
		if( scanTbl[(c= *p++)+768] & 1<< 2){ /*  A-Z a-d f-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==101) {			goto St_217;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_217:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_64;}
		else if(c ==95) {			goto St_225;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_225:
		if( scanTbl[(c= *p++)+1024] & 1<< 4){ /*  0-9 A-Z _ a-c e-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_234;}
		else if(c ==100) {			goto St_233;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_233:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_242;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_242:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_250;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_250:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_256;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_256:
		if( scanTbl[(c= *p++)+1024] & 1<< 7){ /*  0-9 A-Z _ a-l n-z */
			goto St_64;}
		else if(c ==109) {			goto St_262;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_262:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_266;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_266:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 119;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 119;
			goto done;
			}
	St_234:
		if( scanTbl[(c= *p++)+1280] & 1<< 0){ /*  0-9 A-Z _ b-z */
			goto St_64;}
		else if(c ==97) {			goto St_243;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_243:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_251;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_251:
		if( scanTbl[(c= *p++)+1280] & 1<< 1){ /*  0-9 A-Z _ a-j l-z */
			goto St_64;}
		else if(c ==107) {			goto St_257;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_257:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_263;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_263:
		if( scanTbl[(c= *p++)+768] & 1<< 3){ /*  0-9 A-Z _ a-c e-z */
			goto St_64;}
		else if(c ==100) {			goto St_267;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_267:
		if( scanTbl[(c= *p++)+1280] & 1<< 2){ /*  0-9 A-Z a-z */
			goto St_64;}
		else if(c ==95) {			goto St_270;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_270:
		if( scanTbl[(c= *p++)+1280] & 1<< 3){ /*  0-9 A-Z _ a-r t-z */
			goto St_64;}
		else if(c ==115) {			goto St_273;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_273:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_275;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_275:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_277;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_277:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_279;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_279:
		if( scanTbl[(c= *p++)+1280] & 1<< 2){ /*  0-9 A-Z a-z */
			goto St_64;}
		else if(c ==95) {			goto St_281;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_281:
		if( scanTbl[(c= *p++)+768] & 1<< 3){ /*  0-9 A-Z _ a-c e-z */
			goto St_64;}
		else if(c ==100) {			goto St_283;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_283:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_285;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_285:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_287;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_287:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_289;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_289:
		if( scanTbl[(c= *p++)+1024] & 1<< 7){ /*  0-9 A-Z _ a-l n-z */
			goto St_64;}
		else if(c ==109) {			goto St_291;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_291:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_293;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_293:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 120;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 120;
			goto done;
			}
	St_158:
		if( scanTbl[(c= *p++)+768] & 1<< 2){ /*  A-Z a-d f-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==101) {			goto St_184;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_184:
		if( scanTbl[(c= *p++)+1280] & 1<< 4){ /*  A-Z a-b d-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==99) {			goto St_196;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_196:
		if( scanTbl[(c= *p++)+1280] & 1<< 5){ /*  A-Z a-k m-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==108) {			goto St_205;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_205:
		if( scanTbl[(c= *p++)+1024] & 1<< 2){ /*  A-Z b-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==97) {			goto St_212;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_212:
		if( scanTbl[(c= *p++)+768] & 1<< 1){ /*  A-Z a-q s-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==114) {			goto St_218;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_218:
		if( scanTbl[(c= *p++)+768] & 1<< 2){ /*  A-Z a-d f-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==101) {			goto St_226;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_226:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_64;}
		else if(c ==95) {			goto St_235;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_235:
		if( scanTbl[(c= *p++)+1024] & 1<< 4){ /*  0-9 A-Z _ a-c e-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_245;}
		else if(c ==100) {			goto St_244;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_244:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_252;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_252:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_258;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_258:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_264;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_264:
		if( scanTbl[(c= *p++)+1024] & 1<< 7){ /*  0-9 A-Z _ a-l n-z */
			goto St_64;}
		else if(c ==109) {			goto St_268;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_268:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_271;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_271:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 123;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 123;
			goto done;
			}
	St_245:
		if( scanTbl[(c= *p++)+1280] & 1<< 0){ /*  0-9 A-Z _ b-z */
			goto St_64;}
		else if(c ==97) {			goto St_253;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_253:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_259;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_259:
		if( scanTbl[(c= *p++)+1280] & 1<< 1){ /*  0-9 A-Z _ a-j l-z */
			goto St_64;}
		else if(c ==107) {			goto St_265;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_265:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_269;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_269:
		if( scanTbl[(c= *p++)+768] & 1<< 3){ /*  0-9 A-Z _ a-c e-z */
			goto St_64;}
		else if(c ==100) {			goto St_272;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_272:
		if( scanTbl[(c= *p++)+1280] & 1<< 2){ /*  0-9 A-Z a-z */
			goto St_64;}
		else if(c ==95) {			goto St_274;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_274:
		if( scanTbl[(c= *p++)+1280] & 1<< 3){ /*  0-9 A-Z _ a-r t-z */
			goto St_64;}
		else if(c ==115) {			goto St_276;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_276:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_278;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_278:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_280;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_280:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_282;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_282:
		if( scanTbl[(c= *p++)+1280] & 1<< 2){ /*  0-9 A-Z a-z */
			goto St_64;}
		else if(c ==95) {			goto St_284;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_284:
		if( scanTbl[(c= *p++)+768] & 1<< 3){ /*  0-9 A-Z _ a-c e-z */
			goto St_64;}
		else if(c ==100) {			goto St_286;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_286:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_288;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_288:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_290;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_290:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_292;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_292:
		if( scanTbl[(c= *p++)+1024] & 1<< 7){ /*  0-9 A-Z _ a-l n-z */
			goto St_64;}
		else if(c ==109) {			goto St_294;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_294:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_295;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_295:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 124;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 124;
			goto done;
			}
	St_159:
		if( scanTbl[(c= *p++)+1024] & 1<< 2){ /*  A-Z b-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==97) {			goto St_185;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_185:
		if( scanTbl[(c= *p++)+1280] & 1<< 5){ /*  A-Z a-k m-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==108) {			goto St_197;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_197:
		if( scanTbl[(c= *p++)+256] & 1<< 7){ /*  A-Z a-n p-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==111) {			goto St_206;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_206:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_64;}
		else if(c ==95) {			goto St_213;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_213:
		if( scanTbl[(c= *p++)+1280] & 1<< 6){ /*  0-9 A-Z _ a-b d-f h-t v-z */
			goto St_64;}
		else if(c ==117) {			goto St_221;}
		else if(c ==103) {			goto St_220;}
		else if(c ==99) {			goto St_219;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_219:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_227;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_227:
		if( scanTbl[(c= *p++)+1024] & 1<< 7){ /*  0-9 A-Z _ a-l n-z */
			goto St_64;}
		else if(c ==109) {			goto St_236;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_236:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_246;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_246:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 128;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 128;
			goto done;
			}
	St_220:
		if( scanTbl[(c= *p++)+1280] & 1<< 0){ /*  0-9 A-Z _ b-z */
			goto St_64;}
		else if(c ==97) {			goto St_228;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_228:
		if( scanTbl[(c= *p++)+768] & 1<< 6){ /*  0-9 A-Z _ a-s u-z */
			goto St_64;}
		else if(c ==116) {			goto St_237;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_237:
		if( scanTbl[(c= *p++)+768] & 1<< 7){ /*  0-9 A-Z _ a-g i-z */
			goto St_64;}
		else if(c ==104) {			goto St_247;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_247:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_254;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_254:
		if( scanTbl[(c= *p++)+1280] & 1<< 7){ /*  0-9 A-Z _ a-q s-z */
			goto St_64;}
		else if(c ==114) {			goto St_260;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_260:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 52;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 52;
			goto done;
			}
	St_221:
		if( scanTbl[(c= *p++)+768] & 1<< 5){ /*  0-9 A-Z _ a-o q-z */
			goto St_64;}
		else if(c ==112) {			goto St_229;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_229:
		if( scanTbl[(c= *p++)+768] & 1<< 3){ /*  0-9 A-Z _ a-c e-z */
			goto St_64;}
		else if(c ==100) {			goto St_238;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_238:
		if( scanTbl[(c= *p++)+1280] & 1<< 0){ /*  0-9 A-Z _ b-z */
			goto St_64;}
		else if(c ==97) {			goto St_248;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_248:
		if( scanTbl[(c= *p++)+768] & 1<< 6){ /*  0-9 A-Z _ a-s u-z */
			goto St_64;}
		else if(c ==116) {			goto St_255;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_255:
		if( scanTbl[(c= *p++)+768] & 1<< 4){ /*  0-9 A-Z _ a-d f-z */
			goto St_64;}
		else if(c ==101) {			goto St_261;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_261:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 53;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 53;
			goto done;
			}
	St_160:
		if( scanTbl[(c= *p++)+256] & 1<< 7){ /*  A-Z a-n p-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==111) {			goto St_186;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_186:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_64;}
		else if(c ==95) {			goto St_198;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_198:
		if( scanTbl[(c= *p++)+1536] & 1<< 0){ /*  0-9 A-Z _ a-f h-k m-z */
			goto St_64;}
		else if(c ==108) {			goto St_208;}
		else if(c ==103) {			goto St_207;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_207:
		if( scanTbl[(c= *p++)+1536] & 1<< 1){ /*  0-9 A-Z _ a-k m-z */
			goto St_64;}
		else if(c ==108) {			goto St_214;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_214:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_222;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_222:
		if( scanTbl[(c= *p++)+1536] & 1<< 2){ /*  0-9 A-Z _ a c-z */
			goto St_64;}
		else if(c ==98) {			goto St_230;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_230:
		if( scanTbl[(c= *p++)+1280] & 1<< 0){ /*  0-9 A-Z _ b-z */
			goto St_64;}
		else if(c ==97) {			goto St_239;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_239:
		if( scanTbl[(c= *p++)+1536] & 1<< 1){ /*  0-9 A-Z _ a-k m-z */
			goto St_64;}
		else if(c ==108) {			goto St_249;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_249:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 47;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 47;
			goto done;
			}
	St_208:
		if( scanTbl[(c= *p++)+1024] & 1<< 6){ /*  0-9 A-Z _ a-n p-z */
			goto St_64;}
		else if(c ==111) {			goto St_215;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_215:
		if( scanTbl[(c= *p++)+1024] & 1<< 5){ /*  0-9 A-Z _ a-b d-z */
			goto St_64;}
		else if(c ==99) {			goto St_223;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_223:
		if( scanTbl[(c= *p++)+1280] & 1<< 0){ /*  0-9 A-Z _ b-z */
			goto St_64;}
		else if(c ==97) {			goto St_231;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_231:
		if( scanTbl[(c= *p++)+1536] & 1<< 1){ /*  0-9 A-Z _ a-k m-z */
			goto St_64;}
		else if(c ==108) {			goto St_240;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_240:
		if( scanTbl[(c= *p++)+512] & 1<< 4){ /*  0-9 A-Z _ a-z */
			goto St_64;}
		else if(c ==32) {		extcode = 56;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_106;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 56;
			goto done;
			}
	St_81:
		if( scanTbl[(c= *p++)+768] & 1<< 1){ /*  A-Z a-q s-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==114) {			goto St_121;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_121:
		if( scanTbl[(c= *p++)+256] & 1<< 7){ /*  A-Z a-n p-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==111) {			goto St_161;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_161:
		if( scanTbl[(c= *p++)+1280] & 1<< 5){ /*  A-Z a-k m-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==108) {			goto St_187;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_187:
		if( scanTbl[(c= *p++)+1280] & 1<< 5){ /*  A-Z a-k m-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==108) {			goto St_199;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 31;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = keycheck;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_199:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {			goto St_209;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 31;
			keycheck(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_209:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_66;}
		else if( scanTbl[c+0] & 1<< 4){ /*  0-9 _ */
			goto St_64;}
		else if(c ==61) {			goto St_65;}
		else if(c ==32) {		extcode = 232;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = NULL;
			goto St_63;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 232;
			goto done;
			}
	St_49:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_51;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_94;}
		else if(c ==46) {			goto St_50;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 30;
			mkfint(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_50:
		if( scanTbl[(c= *p++)+1536] & 1<< 3){ /*  A-C F-Z a-c f-z */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_97;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_96;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_99;}
		else if( scanTbl[c+256] & 1<< 2){ /*  D d */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_98;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_95;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_95:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_97;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_96;}
		else {--p; goto fallback; }
	St_96:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+256] & 1<< 1){ /*  E e */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_91;}
		else if( scanTbl[c+256] & 1<< 2){ /*  D d */
		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_90;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_136;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_136:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_96;}
		else {--p; goto fallback; }
	St_97:
		if( scanTbl[(c= *p++)+512] & 1<< 2){ /*    A-Z a-z */
			goto St_137;}
		else if(c ==46) {			goto St_138;}
		else {--p; goto fallback; }
	St_138:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 30;
			mkfint(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_137:
		/*    A-Z a-z*/
		while(scanTbl[(c= *p++)+512] & 1<< 2);--p;
		if((c= *p++) ==46) {			goto St_138;}
		else {--p; goto fallback; }
	St_98:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_137;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_130;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_129;}
		else if(c ==46) {			goto St_138;}
		else if(c ==32) {			goto St_139;}
		else {--p; goto fallback; }
	St_139:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_137;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_130;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_129;}
		else if(c ==46) {			goto St_138;}
		else {--p; goto fallback; }
	St_99:
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_137;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_133;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_132;}
		else if(c ==46) {			goto St_138;}
		else if(c ==32) {			goto St_140;}
		else {--p; goto fallback; }
	St_140:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 3){ /*  A-Z a-z */
			goto St_137;}
		else if( scanTbl[c+0] & 1<< 5){ /*  0-9 */
			goto St_133;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_132;}
		else if(c ==46) {			goto St_138;}
		else {--p; goto fallback; }
	St_94:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_135;}
		else if(c ==32) {			goto St_134;}
		else {--p; goto fallback; }
	St_134:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_135;}
		else {--p; goto fallback; }
	St_135:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_172;}
		else if(c ==46) {			goto St_147;}
		else if(c ==32) {			goto St_171;}
		else {--p; goto fallback; }
	St_171:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_172;}
		else if(c ==46) {			goto St_147;}
		else {--p; goto fallback; }
	St_147:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_176;}
		else if(c ==32) {			goto St_175;}
		else {--p; goto fallback; }
	St_175:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_176;}
		else {--p; goto fallback; }
	St_176:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_191;}
		else if(c ==32) {		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_190;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 30;
			mkfint(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_190:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_191;}
		else {--p; goto fallback; }
	St_191:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_190;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 30;
			mkfint(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_172:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==46) {			goto St_147;}
		else if(c ==32) {			goto St_171;}
		else {--p; goto fallback; }
	St_51:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 6){ /*  X x */
			goto St_56;}
		else if( scanTbl[c+0] & 1<< 7){ /*  P p */
			goto St_55;}
		else if( scanTbl[c+256] & 1<< 0){ /*  H h */
			goto St_54;}
		else if( scanTbl[c+256] & 1<< 1){ /*  E e */
		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_53;}
		else if( scanTbl[c+256] & 1<< 2){ /*  D d */
		extcode = 30;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfint;
			goto St_52;}
		else if(c ==46) {			goto St_50;}
		else if(c ==32) {			goto St_49;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 30;
			mkfint(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_52:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_102;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_101;}
		else if(c ==32) {			goto St_100;}
		else {--p; goto fallback; }
	St_100:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_102;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_101;}
		else {--p; goto fallback; }
	St_101:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_102;}
		else if(c ==32) {			goto St_141;}
		else {--p; goto fallback; }
	St_141:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_102;}
		else {--p; goto fallback; }
	St_102:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_143;}
		else if(c ==32) {		extcode = 227;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_142;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 227;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_142:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_143;}
		else {--p; goto fallback; }
	St_143:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 227;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_142;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 227;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_53:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_105;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_104;}
		else if(c ==32) {			goto St_103;}
		else {--p; goto fallback; }
	St_103:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_105;}
		else if( scanTbl[c+512] & 1<< 1){ /*  + - */
			goto St_104;}
		else {--p; goto fallback; }
	St_104:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_145;}
		else if(c ==32) {			goto St_144;}
		else {--p; goto fallback; }
	St_144:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_145;}
		else {--p; goto fallback; }
	St_145:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_174;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_173;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_173:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_174;}
		else {--p; goto fallback; }
	St_174:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_173;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_105:
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_148;}
		else if(c ==46) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_147;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_146;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_146:
		/*   */
		while(scanTbl[(c= *p++)+0] & 1<< 0);--p;
		if( scanTbl[(c= *p++)+0] & 1<< 5){ /*  0-9 */
			goto St_148;}
		else if(c ==46) {			goto St_147;}
		else {--p; goto fallback; }
	St_148:
		/*  0-9*/
		while(scanTbl[(c= *p++)+0] & 1<< 5);--p;
		if((c= *p++) ==46) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_147;}
		else if(c ==32) {		extcode = 228;/* remember fallback*/
		TokenEnd = p-1;

		scan = NULL;
		proc = mkfloat;
			goto St_146;}
		else {
			TokenEnd= (--p); /* FINAL, no auxscan, must set */
			extcode = 228;
			mkfloat(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
			}
	St_54:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 115;
			mkholl(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
	St_56:
			TokenEnd= p; /* FINAL, no auxscan, must set */
			extcode = 166;
			mkfmti(TokenStart, TokenEnd-TokenStart,&extcode,v);
			goto done;
