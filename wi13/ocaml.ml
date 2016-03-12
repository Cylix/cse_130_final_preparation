(* 1 *)
let sum_matrix m =
  let sum_list = List.fold_left (+) 0 in
  List.fold_left (fun acc l -> acc + (sum_list l)) 0 m
