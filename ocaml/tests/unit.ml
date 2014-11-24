open OUnit2
let _ =
begin
  let suite = "mytest">::
  (fun test_ctxt ->
   assert_equal 
     ~msg:"failed" 
     ~printer:string_of_int
     1 1
  ) in
  run_test_tt_main suite
end
