open Prop_def;;
open Fichier;;
 
open List;;
open Prop_lexer;;


 

let boucle in_channel =
	let lexbuffer = Lexing.from_channel in_channel in
			let cl = Prop_parser.programme Prop_lexer.token lexbuffer in 
				let k p = 			
			print_string "\nCl_term :\t"; affichier p;
			print_string "\nReduction :\t"; affichier (reduction p);
			print_string "\n\n";
		  		in 
					k cl ;
	exit 0;;

boucle stdin;;




