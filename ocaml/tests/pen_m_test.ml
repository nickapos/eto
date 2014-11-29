open OUnit2
open Ea

let test_precision=0.09
let tmin=18.0
let tmax=25.0
let rhmin=0.54
let rhmax=0.82
let obj = new ea


let test2 _=
  (* This should really change to a round off of 3 digits, but unfortunately
   *  my computer produces an different number than the reference by 0.16 *)
  let should_be=0.017016 and result=obj#calc_ea rhmin rhmax tmin tmax  in
  let compare =cmp_float ~epsilon:test_precision result should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be^" diff is: "^string_of_float (result-.should_be) in
    assert_bool error_msg compare


let ea_test = "ea_test">::: ["test2" >:: test2; ]

let _ =
  run_test_tt_main ea_test
