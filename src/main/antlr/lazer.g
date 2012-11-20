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
SYMBOL  : ('!'  | '$' | '£' | '%' | '.' | | '#' | '{'  '}' | '/' | '\\' );
BOL	: ('\r' | '\n')+;

variable_decl
	: (LOWERCASE_CHAR | UPPERCASE_CHAR | '.')+;	

variable: (options {greedy=false} : 
	'#{'
	variable_decl
	'}');	

string 	: (LOWERCASE_CHAR | UPPERCASE_CHAR | SYMBOL | SPACE | variable)+;

quotedstring
	:
	('"')
	string?
	('"')
	;	

name : LOWERCASE_CHAR+;
value	:quotedstring;

id : '#' (LOWERCASE_CHAR | UPPERCASE_CHAR | '-')+;	
classname : '.' ( LOWERCASE_CHAR | UPPERCASE_CHAR | '-')+;
classes	: classname+;
	
	
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

tag	: indent name? id? classes? attributes line_text;

control : indent '-' SPACE line_text;
evaluate : indent '=' SPACE line_text;

template : (tag | control | evaluate)+ EOF;

test 	:  quotedstring EOF;	


