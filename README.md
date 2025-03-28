# Creating the Concatenation of Arrays Program
This document will guide you through the process of creating and running this program using **Flex**, **Bison**, and **Cygwin** commands.

## 1. Files required
This repo has two important files, those being the `lexer.l` and `parser.y` file:

- `lexer.l` (the Flex file) defines the lexical rules for tokenizing input.
- `parser.y` (the Bison file) specifies the grammar for parsing and handling syntax.

## 2. Commands Used for Compilation

### 2.1 Running Flex Command

If you decide to modify the `Flex` file, to process it, use the following command:

`flex filename`

### 2.2 Running Bison Command

If you decide to modify the `Bison` file, to process it, use the following command:

`bison -d filename`

### 2.3 Compiling the Files

After running the above commands, compile the generated files`parser.tab.c` and `lex.yy.c` into an executable program using the following command:

`gcc -o your_program_name parser.tab.c lex.yy.c -lfl`

This command will produce an executable file which you will then be able to run with Cygwin.

## 3. Running the Program

For this program, the file to open is not hard-coded, so you will need to provide the name of your input file^[It only accepts text files] to run the program. Say your program name is `validator`, and the input file you want to use is named `input.txt`, then, you would run the command like this:

`./validator.exe input.txt`

I hope this guide was helpful.