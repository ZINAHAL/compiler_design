%{
  #include <stdio.h>

  int yylex();
  void yyerror(char const *);
  int abs(int);

  int decimal[] = {1000,900,500,400,100,90,50,40,10,9,5,4,1}; //base values
  char *symbol[] = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
%}

%token I V X L C D M EOL

%%
input: 
  %empty                                                  
| input romanexp EOL                  {
                                        if($2 == 0)
                                        {
                                          printf("Z");
                                        }else if($2 < 0)
                                        {
                                          printf("-");
                                          $2 = abs($2);
                                        }

                                        int i = 0;
                                        while($2)
                                        {
                                            while($2/decimal[i])
                                            {  
                                              printf("%s",symbol[i]);
                                              $2 -= decimal[i];  
                                            }
                                            i++;    
                                        }
                                        printf("\n");
                                      }
;

romanexp:
  factor
| romanexp '+' factor                 { $$ = $1 + $3; }
| romanexp '-' factor                 { $$ = $1 - $3; }
;

factor:
  bracketexps
| factor '*' bracketexps              { $$ = $1 * $3; }
| factor '/' bracketexps              { $$ = $3 == 0 ? printf("undefined\n") : $1 / $3; }
;

bracketexps:
  roman
| '{' romanexp '}'                    { $$ = $2; }
;

roman: thousands hundreds tens units  { $$ = $1 + $2 + $3 + $4; } ;

thousands:
  %empty                    { $$ = 0; }
| M                         
| M M                       { $$ = $1 + $2; }
| M M M                     { $$ = $1 + $2 + $3; }
;

hundreds: 
  %empty                    { $$ = 0; }
| C                         
| C C                       { $$ = $1 + $2; }
| C C C                     { $$ = $1 + $2 + $3; }
| C D                       { $$ = $2 - $1; }
| D
| D C                       { $$ = $1 + $2; }
| D C C                     { $$ = $1 + $2 + $3; }
| D C C C                   { $$ = $1 + $2 + $3 + $4; }
| C M                       { $$ = $2 - $1; }
| M
;

tens:
 %empty                     { $$ = 0; }
| X 
| X X                       { $$ = $1 + $2; }
| X X X                     { $$ = $1 + $2 + $3; }
| X L                       { $$ = $2 - $1; }
| L
| L X                       { $$ = $1 + $2; }
| L X X                     { $$ = $1 + $2 + $3; }
| L X X X                   { $$ = $1 + $2 + $3 + $4; }
| X C                       { $$ = $2 - $1; }
| C
;

units:
 %empty                     { $$ = 0; }
| I                         
| I I                       { $$ = $1 + $2; }
| I I I                     { $$ = $1 + $2 + $3; }
| I V                       { $$ = $2 - $1; }                        
| V                         
| V I                       { $$ = $1 + $2; }
| V I I                     { $$ = $1 + $2 + $3; }
| V I I I                   { $$ = $1 + $2 + $3 + $4; }
| I X                       { $$ = $2 - $1; }
| X
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