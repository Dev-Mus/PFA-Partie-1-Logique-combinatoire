exception EndSession;;
exception LexError;;
exception EOF;;

(** S, K, I appelées combinateurs de base. **)
type base = 
	S | K | I 
;;

(** ensemble de variables **)
type variable = 
	V of string 
;;

(** cl_term **)
type cl_term = 
	Base of base 
	|Var of variable (* K, S, I et chaque variable est un CL-terme *)
	|App of cl_term*cl_term (* l'application d'un CL-terme à un CL-terme donne un CL-terme. *)
;; 

let lines = ref 0;;
let words = ref 0;;
