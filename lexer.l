%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}
%option noyywrap
%%

"["                 { return OPEN_BRACKET; }
"]"                 { return CLOSING_BRACKET; }
","                 { return COMMA; }
"+"                 { return PLUS; }
[0-9]+              { yylval.num = atoi(yytext); return NUMBER; }
[ \t\n\r]+          { /* Ignore whitespace */ }
.                   { printf("Unrecognized character: %s\n", yytext); }

%%