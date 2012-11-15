grammar lazer;

tokens {
  PARTIAL='**partial**';
  HTML='html';
  HEAD='head';
  TITLE='title';
  META='meta';
  BODY='body';
  DIV='div';
  P='p';
  SPAN='span';
  IMG='img';
  SCRIPT='script';
  UL='ul';
  LI='li';
  TR='tr';
  TH='th';
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

partial : PARTIAL;

classname : ('.' (ANY_WORD | '-')+)+;
htmlid : ('#' (ANY_WORD | '-')+);

htmltag : ( HEAD | TITLE | META | BODY | DIV | P | IMG);	

tagname : HTML
          | indent htmltag htmlid? classname? SPACE?;


block_text : CURLY_BLOCK_SCARF;
line_text : (.)*;	

tag 	
	: partial? tagname (block_text | line_text)? EOF?;

template : tag+ BOL?;

