%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "semantico.tab.h"	
	
	int linea=1;
%}

%option noyywrap

DIGITO [0-9]
LETRA [a-zA-Z]
ALFANUM [a-zA-Z0-9]
NUMERO {DIGITO}+"."?{DIGITO}*
IDENTIFICADOR {LETRA}{ALFANUM}*


%%


 /*********************
  * Reglas y Acciones *
 **********************/

{NUMERO} 			{yylval.num=strtol(yytext, (char **)NULL, 10); return(NUMERO);}
{IDENTIFICADOR} 	{yylval.iden=yytext; return(IDENTIFICADOR);}
":" 			    {return(DOSPUNTOS);}
"db_type" 			{return(TYPE);}
"db_name" 			{return(NAME);}
"db_table_prefix" 	{return(PREFIX);}
"db_port" 			{return(PORT);}
";" 				{return(PUNTOCOMA);}
"\n" 				{linea++;}
[\t\r\f] 			{}
" "					{}
.	{printf("Error lexico en linea %d \n", linea);}
%%



