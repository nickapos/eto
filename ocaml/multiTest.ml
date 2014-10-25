open EaBase
let () =
  (* create an object*)
  let obj = new eaBase  in
    Printf.printf "%f\n" (obj#calc_es 15.0 24.6)

