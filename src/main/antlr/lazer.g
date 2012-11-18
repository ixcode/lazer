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
BOL	: ('\r' | '\n')+;



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

template : (tag)+ EOF;	


