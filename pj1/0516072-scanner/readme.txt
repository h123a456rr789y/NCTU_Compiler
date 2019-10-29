Hi TAs,

To generate a scanner, run the following commands:

>> flex 0516072-scanner.l
   The above command will generate a file named ``lex.yy.c''.
   Use a C compiler to compile the C file.

>> cc lex.yy.c -ll
   The above command will produce an executable file, say ``a.out''.
   Then execute the scanner:

>> ./a.out < scanner-test01.p (can be changed to other test files like Float.p, Error.p, Comments.p etc.)


The output of your scanner should be the list of the tokens produced by the scanner, together with the line number and character position in the line:

  0-th token(type:28) on line 1 : PROGRAM
  1-th token(type:39) on line 1 : mytest
  2-th token(type:52) on line 1 : (
  3-th token(type:39) on line 1 : input
  4-th token(type:43) on line 1 : ,
  5-th token(type:39) on line 1 : output
  6-th token(type:43) on line 1 : ,
  7-th token(type:39) on line 1 : error
  8-th token(type:59) on line 1 : )
  9-th token(type:60) on line 1 : ;
This is a comment on line 3 : //incorrect symbols test
  ...



For comments, I have read them and return to COMMENT and define COMMENT with token number: 66 for the following two forms comments
1. //............
2. /*........... */
ex1:0-th token(type:66) on line 1 : // This is C++ Style Comment
ex2:1-th token(type:66) on line 2 : /* This is C Style Comment */



For num, I have read every form of num(integer, float, scientic notation) in the NUM and define NUM with the token-number: 69
ex1:   3-th token(type:69) on line 4 : 138796542348956324597 (Integers)
ex2:   1-th token(type:69) on line 2 : 1768.0126976
ex3:   5-th token(type:69) on line 6 : 1430E6


For string, I have read strings which return to STRINGCONST and define STRINGCONST with the token-number: 67
ex:   1-th token(type:67) on line 2 : "Single String"

Moreover, I have handle the cross-line string error by printing out (Lexical Analyzer Sting Error at line l : ") and doesn't counted in the token. Meanwhile, the following second line of the cross-line sting will be continued reading.
ex:	Lexical Analyzer Sting Error at line 11 : " Multi-Line
 	15-th token(type:39) on line 12 : With
 	16-th token(type:39) on line 12 : comment
 	17-th token(type:66) on line 12 : // This is a comment "

Other tokens are followed by the 00README.txt in the project1.
For more details of the tokens and defined token-number can be read in the code file 0516072-scanner.l 



