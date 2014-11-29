open OUnit2
open EaPoor

let test_precision=0.01
let tmin=18.0
let tmax=25.0
let rhmean=0.68
let obj = new eaPoor


let test2 _=
  let should_be=1.78 and result=(obj#calc_ea rhmean tmin tmax)*.100.  in
  let compare =cmp_float ~epsilon:test_precision result  should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be in
    assert_bool error_msg compare


let eapoor_test = "eapoor_test">::: ["test2" >:: test2; ]

let _ =
  run_test_tt_main eapoor_test
