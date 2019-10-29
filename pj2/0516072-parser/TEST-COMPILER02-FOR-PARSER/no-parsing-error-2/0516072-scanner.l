%{
/*
 * scan.l
 *
 * lex input file for pascal scanner
 *
 * extensions: two ways to spell "external" and "->" ok for "^".
 */

 #include <stdio.h>
 #include <string.h>
 #include "y.tab.h"
  

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
{A}{N}{D}                    return(AND);
{O}{R}                       return(OR);
[a-zA-Z]([_a-zA-Z0-9])*      return(IDENTIFIER);



":="                         return(ASSIGNMENT);
":"                          return(COLON);
","                          return(COMMA);
"."                          return(DOT);
".."                         return(DOTDOT);
"="                          return(EQUAL);
"!="                         return(NOTEQUAL);
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

\/\/.*$                                         //return(COMMENT);
\"[^"\n]*\"             						  	      return(CHARACTER_STRING);
(\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/)   {
  int index=0;
  while(index <= strlen(yytext)){
    if(yytext[index] == '\n') line_no++;
    index++;
  }  
  //return(COMMENT);
}
[0-9]*\.?[0-9]+([E][-+]?[0-9]+)?              return(NUM);



[ \t\f]    ;

\r         ;
\n    line_no++;


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

.    {fprintf(stderr,"Lexical analyzer error at line %d : %s\n",line_no,yytext);}

%%








