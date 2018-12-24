%{
    #include <stdio.h>
    #include <stdlib.h>

    int yylex();
    void yyerror(char const *);
    int get_value_for_variable(int);
    int var_position(int);

    char vars[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    int values[26];
%}

%token VAR ASSIGNMENT NUM PRINT

%%

input:
  %empty
| input stmt ';'
;

stmt:
  VAR ASSIGNMENT expr       {values[var_position($1)] = $3;}
| PRINT VAR                 {printf("%d\n", get_value_for_variable($2));}
;

expr:
  expr '+' factor           {$$ = $1 + $3;}
| expr '-' factor           {$$ = $1 - $3;}
| factor
;

factor:
  factor '*' term           {$$ = $1 * $3;}
| factor '/' term           {$$ = $1 / $3;}
| term
;

term:
  NUM
| VAR                       {$$ = get_value_for_variable($1);}
| '-' NUM                   {$$ = 0 - $2;}
;

%%

int main()
{
    yyparse();
    return 0;
}

void yyerror(char const *s)
{
  fprintf(stderr, "%s\n", s);
}

int get_value_for_variable(int var)
{
  int i = 0;
  while(vars[i] != var) { i++; }
  return values[i];
}

int var_position(int var)
{
  int i = 0;
  while(vars[i] != var) { i++; }
  return i;
}