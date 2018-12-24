# The Compiler Design Assignments
### comments.l
* A Flex program that removes comments from an unknown programming language and sends the remaining code to its output.
* ** means regard the two asterisks and all following characters on that line up to a \n as a comment.
* anything between { and } is a comment, potentially across multiple lines. A { inside a comment is just part of the comment.
* A { not followed by } is regarded as a syntax error and the program outputs the phrase "syntax error\n" in place of the
the remaining input and exit when it detects this. And vice versa.
* Between double-quote characters, the {} and ** are regarded as part of a string and dont indicate comments.

### plates.l
* A flex program that reads a whitespace (space tab or newline) seperated 
list of Irish car registration numbers and outputs the number of years since 
registration, followed by a new line for each one. 
* If an invalid registration is detected the program should output the word 
"INVALID" followed by a newline character.

### roman.l & roman.y
* This program does 2 things: converts Roman numbers to decimal ones & evalutes Roman expressions.
* The expressions contain + - / * (associativity is left to right, + and - have the same precedence as does * and /), and will use { and } as parentheses.
* Uses - for a negative number and Z to indicate zero. Repeated Ms to indicate thousands, ie MMMMMM for 6000.
* If an invalid input is detected the program outputs the words "syntax error" followed by a newline character to standard output
and then exit.
* The **input** to this program will be: **III * {{XII - II} / V} + I**
* The **output** : **VII**

### calcwithvariables.l & calcwithvariables.y
* This is a calculator that supports variables. 
* Variables can be any of the 26 lower case letters.
* ':=' will be used for assignment and each statement will be terminated by a semicolon ';'.
* Whitespace and newlines are ingored on input.
* Operations used are: + - * /  and supports a unary minus. 
* The calculator should support a 'print' command which prints a variable's value followed by a newline.
* **input** :   
a := 60;   
b := a + 7 - 4;   
print b;
* **output**: 63
