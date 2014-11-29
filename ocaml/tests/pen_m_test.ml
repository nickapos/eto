open OUnit2
open Pen_m

let obj = new penm

let test_precision=0.01
let tMin = 25.6
let tMax=34.8
let ea=2.85
let speed=2.0
let monthNum=5.0
let latDeg=13.0
let latMin=44.0
let monthlyAv=30.2
let monthlyAvPrev=29.2
let alt=2.0
let sun=8.5


let pressure_test_val=100.

let pressure_test _=
  let should_be=100.123508 and result=obj#pressure pressure_test_val in
  let compare =cmp_float ~epsilon:test_precision result should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be^" diff is: "^string_of_float (result-.should_be) in
    assert_bool error_msg compare

let gamma_p_test_val=100.

let gamma_test _=
  let should_be=0.0665 and result=obj#gamma gamma_p_test_val in
  let compare =cmp_float ~epsilon:test_precision result should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be^" diff is: "^string_of_float (result-.should_be) in
    assert_bool error_msg compare
(*
let eto_fin_test _=
  let should_be=5.72 and result=obj#calculate ~tmin:tMin ~tmax:tMax ~ea:ea ~day:15 ~avairspeed:2. ~monthNum:5 ~latitude_degrees:latDeg ~latitude_Lepta:latMin ~tmonth_i:monthlyAv ~tmonth_i_1:monthlyAvPrev ~altitude:alt ~av_sunhours:sun in
  let compare =cmp_float ~epsilon:test_precision result should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be^" diff is: "^string_of_float (result-.should_be) in
    assert_bool error_msg compare

*)
let eto_test = "eto_test">::: [
  "pressure_test">:: pressure_test;
  "gamma_test">:: gamma_test;
   ]

let _ =
  run_test_tt_main eto_test
