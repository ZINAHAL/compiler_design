%{
    #include "calcwithvariables.tab.h"
    void yyerror(char const *);
%}

%%

[a-z]               { yylval = *yytext; return VAR; }
":="                { return ASSIGNMENT; }
[0-9]+              { yylval = atoi(yytext); return NUM; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"*"                 { return '*'; }
"/"                 { return '/'; }
"print"             { return PRINT; }
";"                 { return ';'; }
[ \n]               { }
.                   { yyerror("syntax error"); return 0; }

%%