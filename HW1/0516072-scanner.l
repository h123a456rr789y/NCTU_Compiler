%{
/*
 * scan.l
 *
 * lex input file for pascal scanner
 *
 * extensions: two ways to spell "external" and "->" ok for "^".
 */

 #include <stdio.h>

#define   AND      1
#define   ARRAY      2
#define   CASE      3
#define   CONST      4
#define   DIV      5
#define   DO      6
#define   DOWNTO      7
#define   ELSE      8
#define   END      9

#define   EXTERNAL      10
#define   FOR      11
#define   FORWARD      12
#define   FUNCTION      13
#define   GOTO      14
#define   IF      15
#define   IN      16
#define   LABEL      17
#define   MOD      18
#define   NIL      19
#define   NOT      20
#define   OF       21
#define   OR      22
#define   OTHERWISE      23
#define   PACKED      24
#define   PBEGIN      25
#define   PFILE      26
#define   PROCEDURE      27
#define   PROGRAM      28
#define   RECORD      29
#define   REPEAT      30
#define   SET      31
#define   THEN      32
#define   TO      33
#define   TYPE      34
#define   UNTIL      35
#define   VAR      36
#define   WHILE      37
#define   WITH      38
#define   IDENTIFIER      39

#define   ASSIGNMENT      40
#define   CHARACTER_STRING      41
#define   COLON      42
#define   COMMA      43
#define   DOT      45
#define   DOTDOT      46
#define   EQUAL      47
#define   GE      48
#define   GT      49
#define   LBRAC      50
#define   LE      51
#define   LPAREN      52
#define   LT      53
#define   MINUS      54
#define   NOTEQUAL      55
#define   PLUS      56
#define   RBRAC      57
#define   RPAREN      59
#define   SEMICOLON      60
#define   SLASH      61
#define   STAR      62
#define   STARSTAR      63
#define   UPARROW      64
#define   notEQUAL    65
#define   COMMENT     66
#define   STRINGCONST      67
#define   REAL 68
#define   NUM 69
#define   INTEGER 70
#define   STRINGCROSS 71

int line_no = 1;


%}

A [aA]
B [bB]
C [cC]
D [dD]
E [eE]
F [fF]
G [gG]
H [hH]
I [iI]
J [jJ]
K [kK]
L [lL]
M [mM]
N [nN]
O [oO]
P [pP]
Q [qQ]
R [rR]
S [sS]
T [tT]
U [uU]
V [vV]
W [wW]
X [xX]
Y [yY]
Z [zZ]
NQUOTE [^']

%x NUMBER

%%



[+-]?[0-9]*\.?[0-9]+([E][-+]?[0-9]+)? {
  BEGIN(NUMBER);
  return(NUM);
};

<NUMBER>\n {
  BEGIN(INITIAL);
  line_no++;
}

<NUMBER>[+]{1} {
  BEGIN(INITIAL);
  return(PLUS);
}

<NUMBER>[-]{1} {
  BEGIN(INITIAL);
  return(MINUS);
}


<NUMBER>{A}{R}{R}{A}{Y} {
  BEGIN(INITIAL);
  return(ARRAY);
}

<NUMBER>{D}{O} {
  BEGIN(INITIAL);
  return(DO);
}

<NUMBER>{E}{L}{S}{E} {
  BEGIN(INITIAL);
  return(ELSE);
}

<NUMBER>{E}{N}{D} {
  BEGIN(INITIAL);
  return(END);
}

<NUMBER>{F}{U}{N}{C}{T}{I}{O}{N} {
  BEGIN(INITIAL);
  return(FUNCTION);
}

<NUMBER>{I}{F} {
  BEGIN(INITIAL);
  return(IF);
}

<NUMBER>{I}{N}{T}{E}{G}{E}{R} {
  BEGIN(INITIAL);
  return(INTEGER);
}

<NUMBER>{O}{F} {
  BEGIN(INITIAL);
  return(OF);
}

<NUMBER>{N}{O}{T} {
  BEGIN(INITIAL);
  return(NOT);
}

<NUMBER>{B}{E}{G}{I}{N} {
  BEGIN(INITIAL);
  return(PBEGIN);
}

<NUMBER>{P}{R}{O}{C}{E}{D}{U}{R}{E} {
  BEGIN(INITIAL);
  return(PROCEDURE);
}

<NUMBER>{P}{R}{O}{G}{R}{A}{M} {
  BEGIN(INITIAL);
  return(PROGRAM);
}

<NUMBER>{R}{E}{A}{L} {
  BEGIN(INITIAL);
  return(REAL);
}

<NUMBER>{T}{H}{E}{N} {
  BEGIN(INITIAL);
  return(THEN);
}

<NUMBER>{V}{A}{R} {
  BEGIN(INITIAL);
  return(VAR);
}

<NUMBER>{W}{H}{I}{L}{E} {
  BEGIN(INITIAL);
  return(WHILE);
}

<NUMBER>[a-zA-Z]([_a-zA-Z0-9])* {
  BEGIN(INITIAL);
  return(IDENTIFIER);
}


<NUMBER>":=" {
  BEGIN(INITIAL);
  return(ASSIGNMENT);
}

<NUMBER>":" {
  BEGIN(INITIAL);
  return(COLON);
}

<NUMBER>"," {
  BEGIN(INITIAL);
  return(COMMA);
}

<NUMBER>"." {
  BEGIN(INITIAL);
  return(DOT);
}

<NUMBER>".." {
  BEGIN(INITIAL);
  return(DOTDOT);
}

<NUMBER>"=" {
  BEGIN(INITIAL);
  return(EQUAL);
}

<NUMBER>"!=" {
  BEGIN(INITIAL);
  return(notEQUAL);
}

<NUMBER>">=" {
  BEGIN(INITIAL);
  return(GE);
}

<NUMBER>">" {
  BEGIN(INITIAL);
  return(GT);
}

<NUMBER>"[" {
  BEGIN(INITIAL);
  return(LBRAC);
}

<NUMBER>"<=" {
  BEGIN(INITIAL);
  return(LE);
}

<NUMBER>"(" {
  BEGIN(INITIAL);
  return(LPAREN);
}

<NUMBER>"<" {
  BEGIN(INITIAL);
  return(LT);
}

<NUMBER>"]" {
  BEGIN(INITIAL);
  return(RBRAC);
}

<NUMBER>")" {
  BEGIN(INITIAL);
  return(RPAREN);
}

<NUMBER>";" {
  BEGIN(INITIAL);
  return(SEMICOLON);
}

<NUMBER>"/" {
  BEGIN(INITIAL);
  return(SLASH);
}

<NUMBER>"*" {
  BEGIN(INITIAL);
  return(STAR);
}

<NUMBER>"**" {
  BEGIN(INITIAL);
  return(STARSTAR);
}

<NUMBER>\/\/.*$ {
  BEGIN(INITIAL);
  return(COMMENT);
}

<NUMBER>\"[^\"\\\r\n]*(?:\\.[^\"\\\r\n]*)*\" {
  BEGIN(INITIAL);
  return(STRINGCONST);
}

<NUMBER>\"[^\n\\\r"]+ {
  BEGIN(INITIAL);
  return(STRINGCROSS);
}

<NUMBER>(\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/) {
  BEGIN(INITIAL);
  return(COMMENT);
}

<NUMBER>. {
  BEGIN(INITIAL);
  fprintf(stderr,"Lexical analyzer error at line %d : %s\n",line_no,yytext);
}

{A}{R}{R}{A}{Y}              return(ARRAY);
{D}{O}                       return(DO);
{E}{L}{S}{E}                 return(ELSE);
{E}{N}{D}                    return(END);
{F}{U}{N}{C}{T}{I}{O}{N}     return(FUNCTION);
{I}{F}                       return(IF);
{I}{N}{T}{E}{G}{E}{R}        return(INTEGER);
{O}{F}                       return(OF); ;
{N}{O}{T}                    return(NOT);
{B}{E}{G}{I}{N}              return(PBEGIN);
{P}{R}{O}{C}{E}{D}{U}{R}{E}  return(PROCEDURE);
{P}{R}{O}{G}{R}{A}{M}        return(PROGRAM);
{R}{E}{A}{L}                 return(REAL);
{T}{H}{E}{N}                 return(THEN);
{V}{A}{R}                    return(VAR);
{W}{H}{I}{L}{E}              return(WHILE);
[a-zA-Z]([_a-zA-Z0-9])*      return(IDENTIFIER);


":="                         return(ASSIGNMENT);
":"                          return(COLON);
","                          return(COMMA);
"."                          return(DOT);
".."                         return(DOTDOT);
"="                          return(EQUAL);
"!="                         return(notEQUAL);
">="                         return(GE);
">"                          return(GT);
"["                          return(LBRAC);
"<="                         return(LE);
"("                          return(LPAREN);
"<"                          return(LT);
"-"                          return(MINUS);
"+"                          return(PLUS);
"]"                          return(RBRAC);
")"                          return(RPAREN);
";"                          return(SEMICOLON);
"/"                          return(SLASH);
"*"                          return(STAR);
"**"   		 	                 return(STARSTAR);

\/\/.*$                                         return(COMMENT);
\"[^\"\\\r\n]*(?:\\.[^\"\\\r\n]*)*\"            return(STRINGCONST);
\"[^\n\\\r"]+                                   return(STRINGCROSS);    
(\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/)   return(COMMENT);




"(*"   |
"{"    { register int c;
     while ((c = input()))
     {
      if (c == '}')
       break;
      else if (c == '*')
      {
       if ((c = input()) == ')')
        break;
       else
        unput (c);
      }
      else if (c == '\n')
       line_no++;
      else if (c == 0)
        fprintf (stderr, "Unexpected EOF inside comment at line %d\n",line_no);
     }
    }

[ \t\f]    ;

\r         ;
\n    line_no++;

.    {fprintf(stderr,"Lexical analyzer error at line %d : %s\n",line_no,yytext);}

%%

int main(int argc, char** argv) {
  int i, tok, tok_count=0;
  yyin = fopen("test.txt", "r");
  for (i = 0; 1==1; i ++) {
    tok = yylex();
    if(tok==71)
      printf("Lexical Analyzer Sting Error at line %d : %s\n",line_no,yytext);
    else{
        fprintf(stderr, "%3d-th token(type:%d) on line %d : %s\n", tok_count, tok,line_no, yytext);
        tok_count++;
    }
    
  }
  return(0);
} /* end of main */

yywrap() {
  fclose(yyin);
  exit(1);
}

