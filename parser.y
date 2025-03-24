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

int main(int argc, char *argv[]) {
    if (argc < 2) {  // Checking if a file was provided
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");  // Try to open the file / check if it exists
    if (yyin == NULL) { 
        printf("\nError: The file doesn't exist or it could not be open.\nProvided file name: %s\n", argv[1]);
        return 1;
    }

    if (yyparse()) {
        puts("There are syntax errors");
    } else { 
        printf("There are no syntax errors.\n");
    }

    fclose(yyin);
    return 0;
}


void yyerror(const char *s) { 
    printf("error: %s\n", s); 
    }
