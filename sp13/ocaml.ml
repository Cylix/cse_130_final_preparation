(* 1a *)
let count f l = List.fold_left (fun acc x -> if f x then acc + 1 else acc) 0 l

(* 1b *)
(* count ((=) 7) [1;2;3;4;5;6;7;8;9] => 1 *)
(* count ((!=) 8) [1;2;3;4;5;6;7;8;9] => 8 *)
(* count ((<) 3) [1;2;3;4;5;6;7;8;9] => 6 *)
(* count ((>=) 2) [1;2;3;4;5;6;7;8;9] => 2 *)
(* count (fun x -> x mod 2 = 0) [1;2;3;4;5;6;7;8;9] => 4 *)

(* 1c *)
let stretch l = List.fold_left (fun acc x -> acc@[x; x]) [] l

(* 2 *)
type 'a tree =
| Empty
| Node of 'a * 'a tree list;;

let rec zip l1 l2 =
  match (l1,l2) with
  | ([],[]) -> []
  | (h1::t1, h2::t2) -> (h1,h2)::(zip t1 t2)
  | _ -> raise Mismatch;;

let rec tree_zip t1 t2 =
  match (t1, t2) with
  | (Empty, Empty) -> Empty
  | (Node (lhs_val, lhs_childs), Node (rhs_val, rhs_childs)) ->
    let zipped_val = (lhs_val, rhs_val) in
    let zipped_childs = zip lhs_childs rhs_childs in
    let zipped_subtree = List.map (fun (lhs, rhs) -> tree_zip lhs rhs) zipped_childs in
    Node(zipped_val, zipped_subtree)
  | _ -> raise Mismatch
