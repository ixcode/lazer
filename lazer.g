grammar lazer;

options {
  output=AST;  
}

tokens {
  PARTIAL='**partial**';  
}

LOWERCASE_CHAR 	: 'a'..'z';
UPPERCASE_CHAR  : 'A'..'Z';
	

WS  
  :  ('\t') {$channel=HIDDEN;}
  ;




SPACE 	: ' ';
EQL 	: '=';	
SYMBOL  : ('!'  | '$' | '£' | '%' | '.' | '/' | '\\' );
	

BOL	: ('\r' | '\n')+;


//indent 	: BOL SPACE SPACE*;

//CURLY_BLOCK_SCARF
  //  :   '{'
  //       .*
  //      '}'
  //  ;

partial : PARTIAL;

//classname : ('.' ( | '-')+)+;
//htmlid : ('#' (ANY_WORD | '-')+);

//string 	: ANY_WORD+;

string 	: (LOWERCASE_CHAR | UPPERCASE_CHAR | SYMBOL | SPACE)*;

quotedstring
	:
	('"' | '\'')
	string
	('"' | '\'')
	;

name : LOWERCASE_CHAR+;
value	:quotedstring;
	

htmltag : LOWERCASE_CHAR*;	

//tagname : HTML
//          | indent htmltag htmlid? classname?;


//block_text : CURLY_BLOCK_SCARF;
//line_text 
//	: 
//	SPACE (ANY_WORD | SPACE)+;	

attribute 
	:	 	
	name
	EQL
	value
	;

attributes 
	:
	(attribute SPACE)*
	;

line_text : string;

tagname	: BOL SPACE+ LOWERCASE_CHAR+ SPACE;

test	: tagname attributes line_text EOF;	

//tag 	: partial? tagname attributes? line_text;

//template : tag+ BOL*;

