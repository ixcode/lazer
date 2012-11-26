grammar lazer;

options {
  output=AST;  
}

tokens {
}

LOWERCASE_CHAR 	: 'a'..'z';
UPPERCASE_CHAR  : 'A'..'Z';
NUMBER	: '0'..'9';	
	

WS  
  :  ('\t') {$channel=HIDDEN;}
  ;

SPACE 	: ' ';
EQL 	: '=';
MINUS   : '-';	
PIPE 	: '|';	
COLON 	: ':';
BOL	: ('\r' | '\n');

symbol  : ('!' | '@' | '$' | '£' | '%' | '.'  | '#' | '{' | '}' | '/' | '\\' | '[' | ']' | '(' | ')' |  '\'');

variable_decl
	: (LOWERCASE_CHAR | UPPERCASE_CHAR | '.')+;	

variable: (options {greedy=false} : 
	'#{'
	variable_decl
	'}');	

string 	: (EQL | MINUS | COLON | PIPE | LOWERCASE_CHAR | SPACE | UPPERCASE_CHAR | NUMBER | symbol | variable)+;

quotedstring
	: (options {greedy=false} :
	('"')
	string?
	('"'))
	;	

name : ((LOWERCASE_CHAR)+ | (LOWERCASE_CHAR NUMBER));
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

indent 	: BOL+ SPACE*;

tag_declaration	: ((((name id) | id | name) classes?) | classes);	
tag	: tag_declaration attributes line_text?;
indented_tag : indent tag;

embedded_code_line : indent line_text;
embedded_code : indent name COLON (embedded_code_line)+ BOL;	


inline_tag: indent tag_declaration COLON SPACE tag;	

control : indent MINUS SPACE line_text;
evaluate : indent EQL SPACE line_text;
continuation : indent PIPE line_text;

template : (inline_tag | indented_tag | control | evaluate | continuation)+ (SPACE | BOL)* EOF;

test 	:  embedded_code EOF;	


