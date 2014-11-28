open OUnit2
open EaBase

let tmin=15.0
let tmax=24.6
let obj = new eaBase

let e_test _=
  let should_be=1.7053462321157722 and result=obj#e tmin in
  let compare =cmp_float ~epsilon:0.01 result should_be and 
    error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be in
    assert_bool error_msg compare

let calc_es_test _=
  let should_be=2.39921378082 and result=obj#calc_es tmin tmax in
  let compare =cmp_float ~epsilon:0.01 (obj#calc_es tmin tmax) should_be and 
    error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be in
    assert_bool error_msg compare

let eabase = "eabase">::: [
    "e_test" >:: e_test; 
    "calc_es_test" >:: calc_es_test; 
  ]

let _ =
  run_test_tt_main eabase
