open Prop_def;;
(** Définition de la réduction **)
let rec test = function 
	|App(App(App((Base S),_),_),_)   (* SXYZ *)
	|App(App((Base K),_),_) (* KXY *)
	|App((Base I),_) (* IX *) -> true
	|App(App(a,b),App(c,d)) -> 	if ((a=c)||(b=d))||(b=c) then true
								else (test (App(a,b))) || (test (App(a,b)))
	|App(a,b)				-> 	(test a)||(test b)
	|_						-> false
;;
(*
	@param : cl_term 
	@return : true si on peut simplifie sinon false
	val test : cl_term -> bool = <fun>

*)
let rec reduction = function (* "left (" *)
	|App(App(App((Base S),x),y),z)   (* SXYZ → XZ(YZ) *)
		-> reduction ( App(App(x,z),App(y,z)) )
	|App(App((Base K),x),y) (* KXY → X *)
		-> reduction (x)
	|App((Base I),x) (* IX → X *)
		-> reduction (x)
	|App(App(a,b),App(c,d)) 
		-> 	if a=c then reduction (App(b,d)) (* X → Y ⇒ ZX → ZY *)
			else 	if b=d then reduction (App(a,c)) (* X → Y ⇒ XZ → YZ *)
				else 	if b=c then reduction (App(a,d)) (* X → Y et Y → Z ⇒ X → Z *)
					else reduction (App(reduction (App(a,b)), reduction (App(c,d))))
	|App(a,b)-> 	if (test a) then reduction(App(reduction a,b))
					else if (test b) then reduction(App(a, reduction b))
						else App(a,b)
	|x 	-> x	(* X → X *)
;;

(*
	@param :  cl_term
	@return : cl_term simplifie
	val reduction : cl_term -> cl_term = <fun>
*)

(* functio d'affichage ...*)
let rec affichier = function
	|Base K -> print_string "Base_K "
	|Base S -> print_string "Base_S "
	|Base I -> print_string "Base_I "
	|Var (V x) -> print_string x; print_string " "
	|App(x,y)  -> print_string "( "; affichier x; print_string " "; affichier y; print_string") ";
;; 
(*
	@param :  cl_term
	@return : affich prop
	val reduction : cl_term -> Unit = <fun>
*)

(* functio d'affichage avec type ...*)
let rec affichiertype = function
	|Base K -> print_string "(Base K) "
	|Base S -> print_string "(Base S) "
	|Base I -> print_string "(Base I) "
	|Var (V x) -> print_string "Var (V \""; print_string x; print_string "\") "
	|App(x,y)  -> print_string "App( "; affichiertype x; print_string ", "; affichiertype y; print_string") ";
;; 
(*
	@param :  cl_term
	@return : affich prop
	val reduction : cl_term -> Unit = <fun>
*)
