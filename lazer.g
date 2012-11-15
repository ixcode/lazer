grammar lazer;

tokens {
  HTML='html';
  HEAD='head';
  TITLE='title';
  META='meta';
  BODY='body';
  P='p';
}

CHAR 	: ('a'..'z' |'A'..'Z');
SPACE 	: ' ';
SYMBOL  : ('!' | '"' | '$' | '£' | '%');
INDENT  : SPACE SPACE;	
NEWLINE	: ('\r'? '\n') | ('\r');

WORD 	: CHAR+;

indent 	: INDENT*;

tagname : HTML | HEAD | TITLE | META | BODY | P;

content : (CHAR | SYMBOL | SPACE)+;

tag 	: tagname NEWLINE?;

template : (tag)+;
