%{
#define YYSTYPE double
#include <stdio.h>
#include <stdlib.h>
#include <math.h> // This is to use the floor function.
extern FILE *yyin;
extern int yylex(void);
void yyerror(const char*);


// This array stores all the numbers found in the input file
double* concatenated_array = NULL;
int final_size = 0;

// Function to add any number found in an array in the final array
void add_number_to_array(double num){
    concatenated_array = realloc(concatenated_array, (final_size + 1) * sizeof(double)); // Reallocating and specifying how much is needed
    concatenated_array[final_size] = num; // Add the number at the current last position.
    final_size = final_size + 1; // Increasing the array size count.  
}

%}

%token OPEN_BRACKET CLOSING_BRACKET COMMA PLUS NUMBER
%left PLUS 
%%

S: CONCATENATION {
    printf("Final Result: [");
    for (int i = 0; i < final_size; i++) {
        // If the number remains the same after applying floor(), it means it has no decimal part.
        if (floor(concatenated_array[i]) == concatenated_array[i]){
            printf("%d", (int)concatenated_array[i]); // If it's an integer we print it that way
        } else {
            printf("%.15g", concatenated_array[i]); // If it's a double/float, we print it as such
            // "%.15g" will print numbers with the minimal required number of decimal places, removing trailing zeros
        }
        if (i < final_size - 1) printf(", "); // Check if the current element is not the last one.
    }
    printf("]\n");
    free(concatenated_array); // Freeing the allocated memory for the array.
};

CONCATENATION: ARRAY CONCATENATION_REST;
CONCATENATION_REST: PLUS ARRAY CONCATENATION_REST | /*empty*/;
ARRAY: OPEN_BRACKET ELEMENTS CLOSING_BRACKET;
// Switched rule from NUMBER COMMA ELEMENTS to ELEMENTS COMMA NUMBER
ELEMENTS: /*empty*/ | NUMBER {add_number_to_array($1); } | 
ELEMENTS COMMA NUMBER {add_number_to_array($3); }; // Using $3 will add the numbers to the array in the order it encounters them, if it finds many numbers in an array


%%

int main(int argc, char *argv[]) {
    if (argc < 2) {  // Checking if a file was provided
        printf("Usage: %s. + <input_file>\n", argv[0]);
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