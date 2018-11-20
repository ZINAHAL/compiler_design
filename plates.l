%x PLATES8712
%x PLATES13
%x PLATES14G
%x ERROR

%{
int num;
int current_year = 2018;
int reg_year;
int reg_length;
%}

YEAR            [0-9]
COUNTYS         C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|W|WH|WX|WW
EXTRAC1         LK|TN|TS|WD
EXTRAC2         T
NUMBER          [0-9]

%%

{YEAR}{2}/"-"                                              {   
                                                                if((num = atoi(yytext)) <= 12)
                                                                {
                                                                    reg_year = 2000 + num;
                                                                    BEGIN(PLATES8712);
                                                                }else if(num >= 87){
                                                                    reg_year = 1900 + num;
                                                                    BEGIN(PLATES8712);
                                                                }
                                                            }
<PLATES8712>"-"({COUNTYS}|{EXTRAC1})"-"{NUMBER}{1,6}         { }
<PLATES8712>(" "|\t|\n)+                                    { 
                                                                reg_length = current_year - reg_year;
                                                                printf("%d\n", reg_length);
                                                                BEGIN(INITIAL); 
                                                            }
<PLATES8712>.                                               {   BEGIN(ERROR);   }



{YEAR}{2}/(1|2)"-"                                         {
                                                                if((num = atoi(yytext)) == 13)
                                                                {
                                                                    reg_year = 2000 + num;
                                                                    BEGIN(PLATES13);
                                                                }else if(num > 13 && num <= 18){
                                                                    reg_year = 2000 + num;
                                                                    BEGIN(PLATES14G);
                                                                }
                                                            }
<PLATES14G>(1|2)"-"({COUNTYS}|{EXTRAC2})"-"{NUMBER}{1,6}              { }
<PLATES14G>(" "|\t|\n)+                                     { 
                                                                reg_length = current_year - reg_year;
                                                                printf("%d\n", reg_length);
                                                                BEGIN(INITIAL); 
                                                            }
<PLATES14G>.                                                {   BEGIN(ERROR);   }

<PLATES13>(1|2)"-"({COUNTYS}|{EXTRAC1})"-"{NUMBER}{1,6}      { }
<PLATES13>(" "|\t|\n)+                                      { 
                                                                reg_length = current_year - reg_year;
                                                                printf("%d\n", reg_length);
                                                                BEGIN(INITIAL); 
                                                            }
<PLATES13>.                                                 {   BEGIN(ERROR);   }



.                                                           {   BEGIN(ERROR);   }
<ERROR>.*                                                   { }
<ERROR>(" "|\t|\n)+                                         { 
                                                               printf("INVALID\n"); 
                                                               BEGIN(INITIAL); 
                                                            }

%%

int main()
{
    yylex();
    return 0;
}