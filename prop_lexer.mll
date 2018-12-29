{
	open Prop_def
	open Prop_parser
}
rule token = parse
	 [' ' '\t']		          { token lexbuf}
	| '\n'			          { incr lines;EOF} 
        | "->"			          { incr words;App} 

       	| "("                             {incr words; LPAR}
	| "Quit."		          { incr words;QUIT}
        | "K"                             { incr words; K}
        | "S"                             {incr words ; S}
        | "I"                             {incr words ; I}
        | ")"                             {incr words; RPAR} 
	| ['a'-'z' 'A'-'H''L'-'R' 'T'-'Z' 'J' '0'-'9' '/' '\''] 
		{ let nom = Lexing.lexeme lexbuf in incr words; VAR nom}
	| "(*"			          { comment lexbuf}

	| _			          { raise LexError  }

and comment = parse
	  "*)"			          { token lexbuf}
	| '\n'			          { incr words;EOF}
	| _			          { comment lexbuf}
