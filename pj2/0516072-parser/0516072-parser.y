%{
/*
 * grammar.y
 * declear the grammar for the parser to identify whether there is any syntactic errors
 * 
 *  Course : Introduction to Compiler Design 2019 Fall
 *  Writer: Li Yu Hong
 */


#include<stdio.h>
#include<stdlib.h>
#include<string.h>


extern char *yytext;
extern int line_no;
extern FILE *yyin;

int yylex();

void yyerror(char *err){
	fprintf (stderr, "%s: at line %d symbol '%s'\n", err,line_no,yytext);
	exit(-1);
}


%}

%token AND ARRAY ASSIGNMENT CASE CHARACTER_STRING COLON COMMA CONST DIGSEQ
%token DIV DO DOT DOTDOT DOWNTO ELSE END EQUAL EXTERNAL FOR FORWARD FUNCTION
%token GE GOTO GT IDENTIFIER IF IN LABEL LBRAC LE LPAREN LT MINUS MOD NIL NOT
%token NOTEQUAL OF OR OTHERWISE PACKED PBEGIN PFILE PLUS PROCEDURE PROGRAM RBRAC
%token REALNUMBER RECORD REPEAT RPAREN SEMICOLON SET SLASH STAR STARSTAR THEN
%token TO TYPE UNTIL UPARROW VAR WHILE WITH INTEGER REAL NUM 

%%

program : PROGRAM IDENTIFIER LPAREN identifier_list RPAREN SEMICOLON declarations subprogram_declarations compound_statement DOT
		

identifier_list : IDENTIFIER 
		| identifier_list COMMA IDENTIFIER
		

declarations : declarations VAR identifier_list COLON type SEMICOLON
			 | 
			 

type : standard_type
	 | ARRAY LBRAC num DOTDOT num RBRAC OF type
	 

standard_type : INTEGER
			  | REAL
			  | CHARACTER_STRING
			  

subprogram_declarations : subprogram_declarations subprogram_declaration SEMICOLON
						| 
						

subprogram_declaration : subprogram_head declarations subprogram_declarations compound_statement
					   

subprogram_head : FUNCTION IDENTIFIER arguments COLON  standard_type SEMICOLON
				| PROCEDURE IDENTIFIER arguments SEMICOLON
				

arguments : LPAREN parameter_list RPAREN
		  |
		  

parameter_list : optional_var identifier_list COLON type
			   | optional_var identifier_list COLON type SEMICOLON parameter_list
			   

optional_var : VAR
			 | 
			 

compound_statement : PBEGIN optional_statments END
				   

optional_statments : statement_list
				   

statement_list : statement
			   | statement_list SEMICOLON statement
			   

statement : variable ASSIGNMENT expression
		  | procedure_statement
		  | compound_statement
		  | IF expression THEN statement ELSE statement
		  | WHILE expression DO statement
		  |
		  

variable : IDENTIFIER tail
		 

tail : LBRAC expression RBRAC tail
	 |
	 

procedure_statement : IDENTIFIER
					| IDENTIFIER LPAREN expression_list RPAREN
					

expression_list : expression
				| expression_list COMMA expression
				

expression : boolexpression
		   | boolexpression AND boolexpression
           | boolexpression OR  boolexpression
           

boolexpression : simple_expression
			   | simple_expression relop simple_expression
			   

simple_expression : term
				  | simple_expression addop term
				  

term : factor
	 | term mulop factor
	 

factor : IDENTIFIER tail
	   | IDENTIFIER LPAREN expression_list RPAREN
	   | num
	   | CHARACTER_STRING
	   | LPAREN expression RPAREN
	   | NOT factor
	   

addop : PLUS
	  | MINUS
	  

mulop : STAR
	  | SLASH
	  

relop : LT
	  | GT
	  | EQUAL
	  | LE
	  | GE
	  | NOTEQUAL
	  

num : NUM
	| addop NUM
	

%%


int main(int argc, char** argv) { 
	
	yyin = fopen( "test.txt", "r" );

	yyparse();

	fprintf( stdout, "OK!\n" );
	return 0;

}
 
