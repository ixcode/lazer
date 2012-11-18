grammar lazer;

options {
  output=AST;  
}

tokens {
}

LOWERCASE_CHAR 	: 'a'..'z';
UPPERCASE_CHAR  : 'A'..'Z';
	

WS  
  :  ('\t') {$channel=HIDDEN;}
  ;




SPACE 	: ' ';
EQL 	: '=';	
SYMBOL  : ('!'  | '$' | '£' | '%' | '.' | '/' | '\\' );

//WS_n : (options {greedy=false;} : ' '+) ;	

BOL	: ('\r' | '\n')+;


//indent 	: BOL SPACE SPACE*;

//CURLY_BLOCK_SCARF
  //  :   '{'
  //       .*
  //      '}'
  //  ;


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
	(SPACE attribute)*
	;

line_text 
	: (options {greedy=false;} : string);

indent 	: BOL SPACE*;

tagname	: indent name;

tag	: tagname attributes line_text;

test	: (tag)+ EOF;	

//tag 	: partial? tagname attributes? line_text;

//template : tag+ BOL*;

