open OUnit2

let test_precision=0.09
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

let obj = new Penm.penm


let eto_test _=
  let should_be=5.72 and result=obj#calculate ~tmin:tMin ~tmax:tMax ~ea:ea ~day:15 ~avairspeed:2. ~monthNum:5 ~latitude_degrees:latDeg ~latitude_Lepta:letMin ~tmonth_i:monthlyAv ~tmonth_i_1:monthlyAvPrev ~altitude:alt ~av_sunhours:sun in
  let compare =cmp_float ~epsilon:test_precision result should_be and 
  error_msg="failed test result: "^string_of_float (result)^" should be "^string_of_float should_be^" diff is: "^string_of_float (result-.should_be) in
    assert_bool error_msg compare


let ea_test = "ea_test">::: ["test2" >:: test2; ]

let _ =
  run_test_tt_main ea_test
