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
MINUS   : '-';	
PIPE 	: '|';	
BOL	: ('\r' | '\n')+;

symbol  : ('!'  | '$' | '£' | '%' | '.'  | '#' | '{' | '}' | '/' | '\\' | '[' | ']' | ':' | '(' | ')' |  '\'');

variable_decl
	: (LOWERCASE_CHAR | UPPERCASE_CHAR | '.')+;	

variable: (options {greedy=false} : 
	'#{'
	variable_decl
	'}');	

string 	: (EQL | MINUS | LOWERCASE_CHAR | SPACE | UPPERCASE_CHAR | symbol | variable)+;

quotedstring
	: (options {greedy=false} :
	('"')
	string?
	('"'))
	;	

name : LOWERCASE_CHAR+;
value	:quotedstring;

id : '#' (LOWERCASE_CHAR | UPPERCASE_CHAR | MINUS)+;	
classname : '.' ( LOWERCASE_CHAR | UPPERCASE_CHAR | MINUS)+;
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
	: (options {greedy=false;} : (string | quotedstring)+);

indent 	: BOL SPACE*;

tag	: indent ((((name id) | id | name) classes?) | classes) attributes line_text?;

control : indent MINUS SPACE line_text;
evaluate : indent EQL SPACE line_text;
continuation : indent PIPE line_text;

template : (tag | control | evaluate | continuation)+ (SPACE | BOL)* EOF;

test 	:  continuation EOF;	


