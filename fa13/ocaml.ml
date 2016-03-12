(* 1a *)
let rec insert l i =
  match l with
  | [] -> [i]
  | h::t when h < i -> h::(insert t i)
  | h::t -> i::h::t

(* 1b *)
let insertion_sort = List.fold_left (fun acc x -> insert acc x) []

(* 2 *)
type expr =
| Var of string
| Const of int
| Plus of expr * expr

let rec simpl e =
  match e with
  | Plus (e1, e2) ->
    let e1' = simpl e1 in
    let e2' = simpl e2 in
      (match (e1', e2') with
      | (Const lhs, Const rhs) -> Const (lhs + rhs)
      | _ -> Plus (e1', e2'))
  | _ -> e
