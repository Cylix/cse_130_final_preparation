(* 1a *)
type 'a dict = Empty | Node of string * 'a * 'a dict * 'a dict
let rec find d k =
  match d with
  | Empty -> raise Not_found
  | Node (k', v', l, r) ->
    if k = k' then v' else
    if k < k' then find l k else
    find r k

(* 1b *)
let rec add d k v =
  match d with
  | Empty -> Node (k, v, Empty, Empty)
  | Node (k', v', l, r) ->
    if k = k' then Node (k, v, l, r) else
    if k < k' then Node (k', v', (add l k v), r) else
    Node (k', v', l, (add r k v))

(* 1c *)
let rec fold f b d =
  match d with
  | Empty -> b
  | Node (k, v, l, r) ->
    let res_left = fold f b l in
    let res_node = f k v res_left in
    let res_right = fold f res_node r in
    res_right

(* 2a *)
type name_space = EmptyNameSpace | Info of (string * value) list * name_space
and value = Int of int | Method of (name_space -> int -> int)

let rec lookup namespace name =
  match namespace with
  | EmptyNameSpace -> raise Not_found
  | Info (content, parent) ->
    try
      let rec find_name name l =
        match l with
        | [] -> raise Not_found
        | (k,v)::t when k = name -> v
        | _::t -> find_name name t in
      find_name name content
    with
      Not_found -> lookup parent name

(* 2b *)
exception TypeError
let to_int value =
  match value with
  | Int(i) -> i
  | _ -> raise TypeError

let to_method value =
  match value with
  | Method(m) -> m
  | _ -> raise TypeError

let method_f self i = (to_int (lookup self "a")) + i
let obj3 = Info([("a", Int(10)); ("f", Method(method_f))], EmptyNameSpace)

(* 2c *)
let invoke_method self name i = (to_method (lookup self name)) self i
invoke_method obj3 "f" 3
