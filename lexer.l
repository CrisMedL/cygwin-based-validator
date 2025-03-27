%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}
%option noyywrap
%%

\[              { return OPEN_BRACKET; }
\]              { return CLOSING_BRACKET; }
,               { return COMMA; }
\+              { return PLUS; }
[0-9]+          { yylval = atof(yytext); }
[ \t\n\r]+      { /* Ignore all standard whitespace*/ }
.               { printf("Unrecognized character: %s\n", yytext); }
%%