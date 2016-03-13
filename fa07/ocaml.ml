(* 1a *)
(* ans = 100 *)

(* 1b *)
(* ans = (101, 1001) *)

(* 1c *)
(* ans = [(1,"a"); (2,"b")] *)
(* however, there are multiple syntax error: maybe should we report that? *)

(* 1d *)
(* ans = Int 12 *)

(* 1e *)
(* ans = 10000 *)

(* 2a *)
(* ans: int -> mix *)

(* 2b *)
(* ans: ('a -> bool) -> ('a -> 'a) -> 'a -> 'a *)

(* 2c *)
(* ans: int -> ('a -> 'a) -> 'a -> 'a *)

(* 2d *)
(* ans: bool -> ('a -> 'b) -> ('a -> 'b) -> ('a -> 'b) *)

(* 2e *)
(* ans: 'a -> ('a -> 'a) list -> 'a *)

(* 3a *)
let fac x =
  let rec fac_helper acc x =
    if x > 1 then fac_helper (acc * x) (x - 1)
    else acc
  in fac_helper 1 x

(* 3b *)
let map f xs =
  let rec map_helper acc xs =
    match xs with
    | [] -> acc
    | h::t -> map_helper (acc@[f h]) t
  in map_helper [] xs

(* 3c *)
let rec foldr f xs b =
  let rec rev l =
    match l with
    | [] -> []
    | h::t -> (rev t)@[h]
  in let rec fold_left f xs acc =
    match xs with
    | [] -> acc
    | h::t -> fold_left f t (f h acc)
  in fold_left f (rev xs) b

(* 4a *)
type ty = Tyint | Tybool | Tyfun of ty * ty
(* int -> int -> int => Tyfun (Tyint, Tyfun(Tyint, Tyint)) *)

(* 4b *)
type tyenv = (string * ty) list

let rec lookup tenv x =
  match tenv with
  | [] -> None
  | (xi,ti)::t when xi = x -> Some ti
  | _::t -> lookup t x

(* 4c *)
type binop = Plus | Minus | Eq | Lt | And | Or
type expr =
  | Const of int
  | Var of string
  | Bin of expr * binop * expr
  | If of expr * expr * expr
  | Let of string * expr * expr (* let X = E1 in E2 ---> Let (X,E1,E2) *)
  | App of expr * expr (* E1 E2 ---> App(E1,E2) *)
  | Fun of string * ty * expr (* fun X:T -> E ---> Fun(X,T,E) *)

(* let x = 10 in
   let y = x + 12 in
   x + y *)
(* Let("x", Const(10),
   Let("y", Bin(Var("x"), Plus, Const(12)),
   Bin(Var("x"), Plus, Var("y")))) *)

(* 4d *)
(* Could not verify because the skeleton code does not compile *)
(* But most of the code should be ok *)
let rec check env e =
  match e with
  | Const i -> Some Tyint
  | Var x -> lookup env x
  | Plus (e1, e2) | Minus (e1, e2) ->
    let t1 = check env e1 in
    let t2 = check env e2 in
    if t1 = Tyint && t2 = Tyint then Some Tyint else None
  | Leq (e1, e2) | Eq (e1, e2) ->
    let t1 = check env e1 in
    let t2 = check env e2 in
    if t1 = Tyint && t2 = Tyint then Some Tybool else None
  | And (e1, e2) | Or (e1, e2) ->
    let t1 = check env e1 in
    let t2 = check env e2 in
    if t1 = Tybool && t2 = Tybool then Some Tybool else None
  | App (e1, e2) ->
    let t1 = check env e1 in
    let t2 = check env e2 in
    (match (t1, t2) with
    | (None, _) | (_, None) -> None
    | (Some (Tyfun (t_param, t_ret)), Some t_rhs) when t_param = r_rhs -> Some t_ret )
    | _ -> None
  | Fun (x, t, e) ->
    (match (check ((x, t)::env) e) with
    | None -> None
    | Some t_ret -> Some (Tyfun (t, t_ret)))
  | Let (x, e1, e2) ->
    (match check env e1 with
    | None -> None
    | _ -> check env e2)
  | If (p, t, f) ->
    let tp = check env p in
    let tt = check env t in
    let tf = check env f in
    if tp = Tybool && tt = tf then Some tt else None
