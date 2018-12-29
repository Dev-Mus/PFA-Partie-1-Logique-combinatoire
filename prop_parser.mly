%{
	open Prop_def;;
%}


%token K S I  LPAR RPAR  QUIT EOF App
%token <string> VAR

%start programme
%type <Prop_def.cl_term> programme 
%%

programme   : proplog      EOF                    {$1};

proplog:
       	 VAR					{Var (V ($1))}
         | K                                 	{Base K}
         | S                                 	{Base S}
         | I                                 	{Base I}

	| proplog1 proplog			{(App ($1,$2))}
	| LPAR proplog1  proplog RPAR		{(App ($2,$3))}
;
proplog1: 
	proplog {$1}
;
