open OUnit2



let test1 test_ctxt = assert_equal ~msg:"failed" ~printer:string_of_int 1 1
let test2 test_ctxt=
  let a =cmp_float ~epsilon:0.1 10. 9. in
    assert_bool "failed" a


let suite1 = "suite1">::: ["test1" >:: test1;"test2" >:: test2; ]
let suite2 = "suite2">::: ["test2" >:: test2; ]

let _ =
  run_test_tt_main suite1
