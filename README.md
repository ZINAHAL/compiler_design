# The Compiler Design Assignments
### comments.l
* A Flex program that removes comments from an unknown programming language and sends the remaining code to its output.
* ** means regard the two asterisks and all following characters on that line up to a \n as a comment.
* anything between { and } is a comment, potentially across multiple lines. A { inside a comment is just part of the comment.
* A { not followed by } is regarded as a syntax error and the program outputs the phrase "syntax error\n" in place of the
the remaining input and exit when it detects this. And vice versa.
* Between double-quote characters, the {} and ** are regarded as part of a string and dont indicate comments.

