%{
	open Prop_def;;
%}

%token K S I  LPAR RPAR  QUIT EOF App
%token <string> VAR

%start programme

%type <Prop_def.cl_term> programme 

%%

programme   : 
          proplog EOF                   { $1}
;

proplog:
	       QUIT					                  { exit 0}
       	 |VAR					                  { Var (V ($1))}
         | K                  	        { Base K}
         | S                  	        { Base S}
         | I                  	        { Base I}
	       | proplog proplog1			        { App ($1,$2)}
	       | proplog LPAR proplog RPAR		{ App($1,$3)}
	       | LPAR proplog RPAR			      { $2}
;

proplog1: 
       	 |VAR					                  { Var (V ($1))}
         | K                            { Base K}
         | S                            { Base S}
         | I                            { Base I}
;
