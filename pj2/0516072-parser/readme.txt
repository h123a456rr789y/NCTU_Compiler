To generate parser run the following commands:

>> flex 0516072-scanner.l
   The above command will generate a file named 'lex.yy.c'.
   Use a C compiler to compile the C file.

>> yacc -d 0516072-parser.y 
   The above command will produce 2 files which are 'y.tab.c' and 'y.tab.h'

>> cc lex.yy.c y.tab.c -ly -ll
   The aboce command will generate an executable file 'a.out' which is the result of parser

>> ./a.out < test-parser-error.p (can be changed to other test files like test00-runtime-range-check.p, test04.p, test-minus-neg.p etc.)
   This is for testing our result with .p file



The grammar in .y file is basically followed by the MINI-PASCAL-GRAMMAR.txt in the PROJECT2019-00MINI-PASCAL-LANGUAGE-SPEC and the announcement for changes on the course.
For more details of the Grammar can be read in the code file 0516072-parser.y



