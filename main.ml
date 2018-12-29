open Prop_def;;
open Fichier;;
 
open List;;
open Prop_lexer;;


 

let boucle in_channel =
	let lexbuffer = Lexing.from_channel in_channel in
		let lire_prop_expr () = 
		Prop_parser.programme Prop_lexer.token lexbuffer in
			let p = lire_prop_expr () in 
				let k p = 			
			print_string "\nla proposition :\t"; affichier p;
			print_string "\nla reduction :\t"; affichier (reduction p);
			print_string "\n\n";
		  		in 
					k p ;
	exit 0;;

boucle stdin;;




