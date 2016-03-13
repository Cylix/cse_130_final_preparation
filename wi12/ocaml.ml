(* 1a *)
let rec find d k =
  match d with
  | [] -> raise Not_found
  | (k', v')::t when k' = k -> v'
  | (k', v')::t when k' < k -> find t k
  | _ -> raise Not_found

(* 1b *)
let rec add d k v =
  match d with
  | [] -> [(k,v)]
  | (k', v')::t when k' = k -> (k,v)::t
  | (k', v')::t when k' < k -> (k',v')::(add t k v)
  | (k', v')::t when k' > k -> (k,v)::(k',v')::t

(* 1c *)
let keys d = List.map (fun (k,v) -> k) d

(* 1d *)
let values d = List.map (fun (k,v) -> v) d

(* 1e *)
let key_of_max_val d =
  let fold_fn (acc_k, acc_v) (curr_k, curr_v) =
    if curr_v > acc_v then (curr_k, curr_v) else (acc_k, acc_v) in
  match d with
  | [] -> raise Not_found
  | base::t ->
    let (max_k, max_v) = List.fold_left fold_fn base t in
    max_k
