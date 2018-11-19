%x COMMENT
%{

%}
%%

\*{2}(.)*               { }
\{                      { BEGIN(COMMENT); }
<COMMENT>\}             { BEGIN(INITIAL); }
<COMMENT>\n|.           { }
<COMMENT><<EOF>>        { printf("syntax error\n"); return 0;}
\}                      { printf("syntax error\n"); return 0;}
\"(.)*\"                { printf("%s", yytext); }

%%

int main()
{
    yylex();
    return 0;
}
