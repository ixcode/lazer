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

CURLY_BLOCK_SCARF
    :   '{'
        (
            options {
                greedy=false;
            }
        :   '\r' ('\n')? {newline();}
        |   '\n'         {newline();}
        |   .
        )*
        '}'
    ;


tagname : HTML
          | indent ( HEAD | TITLE | META | BODY | P) SPACE?;


block_text : CURLY_BLOCK_SCARF;
line_text : (.)*;	

tag 	
	: tagname (block_text | line_text)?;

template : tag+;

