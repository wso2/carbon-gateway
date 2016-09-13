grammar WUML;

// starting point for parsing a java file
sourceFile
    :   definition
        constants?
        resources
        EOF
    ;

definition
    :   path?
        source
        api?
        packageDef
    ;

constants
    :   constant*
    ;

resources
    :   resource+
    ;

packageDef
    :   PACKAGE qualifiedName ';'
    ;

path
    :AT 'Path'  LPAREN  StringLiteral RPAREN
    ;

source
    :   AT 'Source'  LPAREN sourceElementValuePairs RPAREN
    ;

api
    :   '@' 'Api'  ( '(' ( apiElementValuePairs ) ')' )
    ;

resourcePath
    :   '@' 'Path' ( '(' StringLiteral ')' )
    ;


getMethod
    :   '@' 'GET' ( '(' ')' )?
    ;

postMethod
    :'@' 'POST' ( '('  ')' )?
    ;

putMethod
    :   '@' 'PUT' ( '(' ')' )?
    ;

deleteMethod
    :'@' 'DELETE' ( '(' ')' )?
    ;

headMethod
    :'@' 'HEAD' ( '(' ')' )?
    ;

prodAnt
    : '@' 'Produces' ( '(' elementValue ? ')' )?
    ;

conAnt
    :   '@' 'Consumes' ( '(' elementValue ? ')' )?
    ;

antApiOperation
    :   '@' 'ApiOperation' ( '(' ( elementValuePairs | elementValue )? ')' )?
    ;

antApiResponses
    :   '@' 'ApiResponses' ( '(' ( elementValuePairs | elementValue )? ')' )?
    ;

elementValuePairs
    :   elementValuePair (',' elementValuePair)*
    ;

sourceElementValuePairs
        :   protoclo (',' host)?  (','  port)?
        ;

apiElementValuePairs
    :  tags? ','  descripton? ',' producer
    ;

protoclo
    :   'protocol' '=' StringLiteral
    ;

host
    :   'host' '=' StringLiteral
    ;

port
    :   'port' '=' IntegerLiteral
    ;

tags
    :   'tags' '=' tag+
    ;

tag
    :   '{' StringLiteral (',' StringLiteral)* '}'
    ;

descripton
    :   'description' '=' StringLiteral
    ;

producer
    :   'produces' '=' mediaType
    ;

constant
    :   CONSTANT type variableDeclaratorId  '=' literal ';'
    |   CONSTANT classType variableDeclaratorId  '=' 'new' Identifier '(' (StringLiteral)? ')' ';'
    ;

resource
    :   httpMethods
        prodAnt?
        conAnt ?
        antApiOperation?
        resourcePath
        resourceDeclaration
    ;

httpMethods
    :(getMethod
    | postMethod
    | putMethod
    | deleteMethod
    | headMethod)*
    ;

qualifiedName
    :   Identifier ('.' Identifier)*
    ;

resourceDeclaration
    :   'resource' Identifier '(' 'message' Identifier ')'
        block
    ;

elementValuePair
    :   Identifier '=' elementValue
    ;

elementValue
    :   StringLiteral
    |   IntegerLiteral
;

block
    :   '{' blockStatement* '}'
    ;

blockStatement
    :   localVariableDeclarationStatement
    |   tryBlock
    |   ifBlock
    |   statementExpression ';'
    ;

tryBlock
    :   'try' block (catchClause+ finallyBlock? | finallyBlock)
    ;

ifBlock
    :   'if' parExpression statement ('else' statement)?
    ;

statement
    :   block
    |   ifBlock
    |   tryBlock
    |   ';'
    |   statementExpression
    ;

statementExpression
     :  'reply' Identifier
     |  expression
     |  Identifier '=' expression
    ;

parExpression
    :   '(' expression ')'
    ;

expressionList
    :   expression (',' expression)*
    ;

catchClause
    :   'catch' '(' catchType Identifier ')' block
    ;

catchType
    :   qualifiedName ('|' qualifiedName)*
    ;

finallyBlock
    :   'finally' block
    ;


localVariableDeclarationStatement
    :(type | classType) variableDeclarator ';'
    ;

variableDeclarator
      :   variableDeclaratorId ('=' expression)?
      ;

variableDeclaratorId
      :   Identifier
      ;

expression
    :   primary
    |  'new' Identifier '(' methodParams? ')'
    |  Identifier '.' Identifier '(' methodParams? ')'
    |  Identifier '(' methodParams? ')'
//    |   expression ('++' | '--')
//    |   ('+'|'-'|'++'|'--') expression
//    |   ('~'|'!') expression
//    |   expression ('*'|'/'|'%') expression
//    |   expression ('+'|'-') expression
//    |   expression ('<' '<' | '>' '>' '>' | '>' '>') expression
//    |   expression ('<=' | '>=' | '>' | '<') expression
//    |   expression ('==' | '!=') expression
//    |   expression '&' expression
//    |   expression '^' expression
//    |   expression '|' expression
//    |   expression '&&' expression
//    |   expression '||' expression
//    |   expression '?' expression ':' expression
//    |   <assoc=right> expression
//        (   '='
//        |   '+='
//        |   '-='
//        |   '*='
//        |   '/='
//        |   '&='
//        |   '|='
//        |   '^='
//        |   '>>='
//        |   '>>>='
//        |   '<<='
//        |   '%='
//        )
//        expression
    ;

primary
    :   '(' expression ')'
    |  literal
    ;

literal
      :   IntegerLiteral
      |   FloatingPointLiteral
      |   CharacterLiteral
      |   StringLiteral
      |   BooleanLiteral
      |   'null'
 ;

methodParams
    :    ((literal | Identifier) (',' (literal | Identifier))*)?
    ;

type
      :   'boolean'
      |   'char'
      |   'byte'
      |   'short'
      |   'int'
      |   'long'
      |   'float'
      |   'double'
      ;

classType
      :   'endpoint'
      |   'message'
      ;

mediaType
      : 'MediaType.APPLICATION_JSON'
      | 'MediaType.APPLICATION_XML'
;


// LEXER

// §3.9 Keywords

ABSTRACT      : 'abstract';
ASSERT        : 'assert';
BOOLEAN       : 'boolean';
BREAK         : 'break';
BYTE          : 'byte';
CASE          : 'case';
CATCH         : 'catch';
CHAR          : 'char';
CLASS         : 'class';
CONST         : 'const';
CONTINUE      : 'continue';
CONSTANT      : 'constant';
DEFAULT       : 'default';
DO            : 'do';
DOUBLE        : 'double';
ELSE          : 'else';
ENUM          : 'enum';
EXTENDS       : 'extends';
FINAL         : 'final';
FINALLY       : 'finally';
FLOAT         : 'float';
FOR           : 'for';
IF            : 'if';
GOTO          : 'goto';
IMPLEMENTS    : 'implements';
IMPORT        : 'import';
INSTANCEOF    : 'instanceof';
INT           : 'int';
INTERFACE     : 'interface';
LONG          : 'long';
NATIVE        : 'native';
NEW           : 'new';
PACKAGE       : 'package';
PRIVATE       : 'private';
PROTECTED     : 'protected';
PUBLIC        : 'public';
RETURN        : 'return';
SHORT         : 'short';
STATIC        : 'static';
STRICTFP      : 'strictfp';
SUPER         : 'super';
SWITCH        : 'switch';
SYNCHRONIZED  : 'synchronized';
THIS          : 'this';
THROW         : 'throw';
THROWS        : 'throws';
TRANSIENT     : 'transient';
TRY           : 'try';
VOID          : 'void';
VOLATILE      : 'volatile';
WHILE         : 'while';

// §3.10.1 Integer Literals

IntegerLiteral
    :   DecimalIntegerLiteral
    |   HexIntegerLiteral
    |   OctalIntegerLiteral
    |   BinaryIntegerLiteral
    ;

fragment
DecimalIntegerLiteral
    :   DecimalNumeral IntegerTypeSuffix?
    ;

fragment
HexIntegerLiteral
    :   HexNumeral IntegerTypeSuffix?
    ;

fragment
OctalIntegerLiteral
    :   OctalNumeral IntegerTypeSuffix?
    ;

fragment
BinaryIntegerLiteral
    :   BinaryNumeral IntegerTypeSuffix?
    ;

fragment
IntegerTypeSuffix
    :   [lL]
    ;

fragment
DecimalNumeral
    :   '0'
    |   NonZeroDigit (Digits? | Underscores Digits)
    ;

fragment
Digits
    :   Digit (DigitOrUnderscore* Digit)?
    ;

fragment
Digit
    :   '0'
    |   NonZeroDigit
    ;

fragment
NonZeroDigit
    :   [1-9]
    ;

fragment
DigitOrUnderscore
    :   Digit
    |   '_'
    ;

fragment
Underscores
    :   '_'+
    ;

fragment
HexNumeral
    :   '0' [xX] HexDigits
    ;

fragment
HexDigits
    :   HexDigit (HexDigitOrUnderscore* HexDigit)?
    ;

fragment
HexDigit
    :   [0-9a-fA-F]
    ;

fragment
HexDigitOrUnderscore
    :   HexDigit
    |   '_'
    ;

fragment
OctalNumeral
    :   '0' Underscores? OctalDigits
    ;

fragment
OctalDigits
    :   OctalDigit (OctalDigitOrUnderscore* OctalDigit)?
    ;

fragment
OctalDigit
    :   [0-7]
    ;

fragment
OctalDigitOrUnderscore
    :   OctalDigit
    |   '_'
    ;

fragment
BinaryNumeral
    :   '0' [bB] BinaryDigits
    ;

fragment
BinaryDigits
    :   BinaryDigit (BinaryDigitOrUnderscore* BinaryDigit)?
    ;

fragment
BinaryDigit
    :   [01]
    ;

fragment
BinaryDigitOrUnderscore
    :   BinaryDigit
    |   '_'
    ;

// §3.10.2 Floating-Point Literals

FloatingPointLiteral
    :   DecimalFloatingPointLiteral
    |   HexadecimalFloatingPointLiteral
    ;

fragment
DecimalFloatingPointLiteral
    :   Digits '.' Digits? ExponentPart? FloatTypeSuffix?
    |   '.' Digits ExponentPart? FloatTypeSuffix?
    |   Digits ExponentPart FloatTypeSuffix?
    |   Digits FloatTypeSuffix
    ;

fragment
ExponentPart
    :   ExponentIndicator SignedInteger
    ;

fragment
ExponentIndicator
    :   [eE]
    ;

fragment
SignedInteger
    :   Sign? Digits
    ;

fragment
Sign
    :   [+-]
    ;

fragment
FloatTypeSuffix
    :   [fFdD]
    ;

fragment
HexadecimalFloatingPointLiteral
    :   HexSignificand BinaryExponent FloatTypeSuffix?
    ;

fragment
HexSignificand
    :   HexNumeral '.'?
    |   '0' [xX] HexDigits? '.' HexDigits
    ;

fragment
BinaryExponent
    :   BinaryExponentIndicator SignedInteger
    ;

fragment
BinaryExponentIndicator
    :   [pP]
    ;

// §3.10.3 Boolean Literals

BooleanLiteral
    :   'true'
    |   'false'
    ;

// §3.10.4 Character Literals

CharacterLiteral
    :   '\'' SingleCharacter '\''
    |   '\'' EscapeSequence '\''
    ;

fragment
SingleCharacter
    :   ~['\\]
    ;
// §3.10.5 String Literals

StringLiteral
    :   '"' StringCharacters? '"'
    ;
fragment
StringCharacters
    :   StringCharacter+
    ;
fragment
StringCharacter
    :   ~["\\]
    |   EscapeSequence
    ;
// §3.10.6 Escape Sequences for Character and String Literals
fragment
EscapeSequence
    :   '\\' [btnfr"'\\]
    |   OctalEscape
    |   UnicodeEscape
    ;

fragment
OctalEscape
    :   '\\' OctalDigit
    |   '\\' OctalDigit OctalDigit
    |   '\\' ZeroToThree OctalDigit OctalDigit
    ;

fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

fragment
ZeroToThree
    :   [0-3]
    ;

// §3.10.7 The Null Literal

NullLiteral
    :   'null'
    ;

// §3.11 Separators

LPAREN          : '(';
RPAREN          : ')';
LBRACE          : '{';
RBRACE          : '}';
LBRACK          : '[';
RBRACK          : ']';
SEMI            : ';';
COMMA           : ',';
DOT             : '.';

// §3.12 Operators

ASSIGN          : '=';
GT              : '>';
LT              : '<';
BANG            : '!';
TILDE           : '~';
QUESTION        : '?';
COLON           : ':';
EQUAL           : '==';
LE              : '<=';
GE              : '>=';
NOTEQUAL        : '!=';
AND             : '&&';
OR              : '||';
INC             : '++';
DEC             : '--';
ADD             : '+';
SUB             : '-';
MUL             : '*';
DIV             : '/';
BITAND          : '&';
BITOR           : '|';
CARET           : '^';
MOD             : '%';

ADD_ASSIGN      : '+=';
SUB_ASSIGN      : '-=';
MUL_ASSIGN      : '*=';
DIV_ASSIGN      : '/=';
AND_ASSIGN      : '&=';
OR_ASSIGN       : '|=';
XOR_ASSIGN      : '^=';
MOD_ASSIGN      : '%=';
LSHIFT_ASSIGN   : '<<=';
RSHIFT_ASSIGN   : '>>=';
URSHIFT_ASSIGN  : '>>>=';



// §3.8 Identifiers (must appear after all keywords in the grammar)

Identifier
    :   JavaLetter JavaLetterOrDigit*
    ;

fragment
JavaLetter
    :   [a-zA-Z$_] // these are the "java letters" below 0x7F
    ;

fragment
JavaLetterOrDigit
    :   [a-zA-Z0-9$_] // these are the "java letters or digits" below 0x7F
    ;

//
// Additional symbols not defined in the lexical specification
//

AT : '@';
ELLIPSIS : '...';

//
// Whitespace and comments
//

WS  :  [ \t\r\n\u000C]+ -> skip
    ;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;