%{

/********************** 
 * Declaraciones en C *
 **********************/


  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>
  #include "string.h"
  extern int yylex(void);
  extern char *yytext;
  extern int linea;
  extern FILE *yyin;
  void yyerror(char *s);
%}

/*************************
  Declaraciones de Bison *
 *************************/


%union
{
  int num; 
  char* texto;
  char* iden;
}


%start lista_i;

%token <num> NUMERO
%token TYPE
%token NAME
%token PREFIX
%token PORT
%token PUNTOCOMA
%token DOSPUNTOS
%token <iden> IDENTIFICADOR


%%
/***********************
 * Reglas Gramaticales *
 ***********************/


lista_i 	: i lista_i
			| i
			;

i           : instruccion PUNTOCOMA
			| error PUNTOCOMA
			;

instruccion : TYPE DOSPUNTOS IDENTIFICADOR {printf("db_type => %s\n", $3);}
			| NAME DOSPUNTOS IDENTIFICADOR {printf("db_name => %s\n", $3);}
			| PREFIX DOSPUNTOS IDENTIFICADOR {printf("db_prefix => %s\n", $3);}
			| PORT DOSPUNTOS NUMERO {printf("db_port => %d\n", $3);}			
			;

%%
/**********************
 * Codigo C Adicional *
 **********************/
void yyerror(char *msg)
{
	printf("Error en la linea %d: %s -> Se encontro %s\n", linea, msg, yytext);
}

int main(int argc,char **argv)
{
	
	if (argc>1)
		yyin=fopen(argv[1],"rt");
	else
		//yyin=stdin;
		yyin=fopen("entrada.txt","rt");
		

	yyparse();
	return 0;
}