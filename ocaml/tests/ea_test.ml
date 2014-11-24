open OUnit2



let test2 test_ctxt=
  let a =cmp_float ~epsilon:0.00001 0.1999999 0.1999998 in
    assert_bool "failed" a


let suite2 = "suite2">::: ["test2" >:: test2; ]

let _ =
  run_test_tt_main suite2
