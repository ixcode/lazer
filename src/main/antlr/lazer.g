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

string 	: (LOWERCASE_CHAR | UPPERCASE_CHAR | SYMBOL | SPACE)*;

quotedstring
	:
	('"' | '\'')
	string
	('"' | '\'')
	;

name : LOWERCASE_CHAR+;
value	:quotedstring;

htmlid : '#' (LOWERCASE_CHAR | UPPERCASE_CHAR | '-')+;	
classname : '.' ( LOWERCASE_CHAR | UPPERCASE_CHAR | '-')+;
classes	: classname+;

htmltag : name? htmlid? classes?;	
	
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

tagname	: indent htmltag;

tag	: tagname attributes line_text;

template : (tag)+ EOF;

	


