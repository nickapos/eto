open OUnit2



let test1 test_ctxt = assert_equal ~msg:"failed" ~printer:string_of_int 1 1
let test2 test_ctxt = assert_equal ~msg:"failed" ~printer:string_of_int 2 1

let _ =
begin
  let suite = "mytest">:::
    ["test1" >:: test1;
     "test2">:: test2 
    ] in
  run_test_tt_main suite
end
