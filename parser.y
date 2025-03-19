%{
#include <stdio.h>
extern FILE *yyin;
extern int yylex(void);
void yyerror(const char*);
%}

%token OPEN_BRACKET CLOSING_BRACKET COMMA PLUS NUMBER
%left PLUS 
%%

S: CONCATENATION;
CONCATENATION: ARRAY CONCATENATION_REST;
CONCATENATION_REST: PLUS ARRAY CONCATENATION_REST | /*empty*/;
ARRAY: OPEN_BRACKET ELEMENTS CLOSING_BRACKET;
ELEMENTS: /*empty*/ | NUMBER | NUMBER COMMA ELEMENTS;


%%

int main(void) {
    yyin = fopen("testprogram.txt", "r");
    if (yyin == NULL) {
        printf("Error: Could not open file.\n");
        return 1;
    }
    if (yyparse()) {
        puts("There are syntax errors");
    } else { 
        printf("There are no syntax errors.\n");
    }
    return 0;
}

void yyerror(const char *s) { 
    printf("error: %s\n", s); 
    }
