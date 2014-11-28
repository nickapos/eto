open OUnit2
open EaPoor

let tmin=18.0
let tmax=25.0
let rhmean=0.68
let obj = new eaPoor


let test2 _=
  let should_be=1.78 and result=(obj#calc_ea rhmean tmin tmax)*.100.  in
  let compare =cmp_float ~epsilon:0.01 result  should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be in
    assert_bool error_msg compare


let suite2 = "suite2">::: ["test2" >:: test2; ]

let _ =
  run_test_tt_main suite2
