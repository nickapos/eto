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
let day_of_year=246

let test_reporter should_be result =
  (* This function will be used by all the other test functions to reduce boilerplate code*)
  let compare =cmp_float ~epsilon:test_precision result should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be^" diff is: "^string_of_float (result-.should_be) in
    assert_bool error_msg compare

let pressure_test _=
  let pressure_test_val=100. and should_be=100.123508 in
    let result=obj#pressure pressure_test_val in
      test_reporter should_be result

let gamma_test _=
  let gamma_p_test_val=100. and should_be=0.0665 in
    let result=obj#gamma gamma_p_test_val in
      test_reporter should_be result

let e_svp_test _=
  let should_be=3.28277117 and result=obj#e_svp tMin in
    test_reporter should_be result

let is_leap_y_test _=
  (* test a leap year *)
  let year=2012 in
    let result=obj#is_leap year and error_msg="failed test result year "^string_of_int (year)^" is not leap " in
      assert_bool error_msg result

let is_leap_f_test _=
  (* test a non leap year*)
  let year=2010 in
  let result=obj#is_leap year and error_msg="failed test result year "^string_of_int (year)^" is leap " in
    let negated_result= not result in
      assert_bool error_msg negated_result

let day_of_year_test _=
  let should_be=334 and result=obj#day_of_year 30 11 and error_msg="failed test result: " in
    assert_equal ~msg:error_msg ~printer:string_of_int should_be result

let day_of_year_monthly_test _=
  let should_be=289 and result=obj#day_of_year_monthly 10 and error_msg="failed test result: " in
    assert_equal ~msg:error_msg ~printer:string_of_int should_be result

let inv_rel_dist_test _=
  let should_be=0.985 and result=obj#inv_rel_dist day_of_year in
    test_reporter should_be result

let lat_in_rad_test _=
  let should_be=0.2268928 and result=obj#lat_in_rad latDeg in
    test_reporter should_be result

let solar_declination_test _=
  let should_be=0.11965509 and result=obj#solar_declination day_of_year in
    test_reporter should_be result
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
  "e_svp_test">:: e_svp_test;
  "is_leap_y_test">:: is_leap_y_test;
  "is_leap_f_test">:: is_leap_f_test;
  "day_of_year_test">:: day_of_year_test;
  "inv_rel_dist_test">:: inv_rel_dist_test;
  "lat_in_rad_test">:: lat_in_rad_test;
  "solar_declination_test">:: solar_declination_test;
  (*"eto_fin_test">:: eto_fin_test;*)
   ]

let _ =
  run_test_tt_main eto_test
