# Creating the Program

There are two files you need to work with, those being `lexer.l` and `parser.y`.

The order in which you compile first does not matter. The commands you will need are the following:

For the flex file:
`flex filename.l`

for the bison file:
`bison -d filename.y`

after you have run those commands, you will need to run the following:

`gcc -o filenameyouwantcreate parser.tab.c lex.yy.c -lfl`.

Running this will create the program which you can run with the command:

`./yourprogramname.exe`