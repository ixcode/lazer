grammar lazer;

tokens {
  HTML='html';
  HEAD='head';
  TITLE='title';
  META='meta';
  BODY='body';
  P='p';
}

ANY_WORD
  :  ('a'..'z' | 'A'..'Z')+
  ;

WS  
  :  ('\t') {$channel=HIDDEN;}
  ;



SPACE 	: ' ';
SYMBOL  : ('!' | '"' | '$' | '£' | '%');

INDENT  : SPACE SPACE;	

BOL	: ('\r' | '\n')+;



indent 	: BOL INDENT INDENT*;

tagname : HTML
          | indent ( HEAD | TITLE | META | BODY | P) SPACE?;


tagbody : .*;

tag 	: tagname tagbody?;

template : tag+;

