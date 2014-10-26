class penm = object (self)
 (*
  This class provides the methods to calculate the penman monteith
  ETo as it is described in the FAO paper Irrigation and
  drainage paper number 56 and displayed in box 11
  and example table 17.
  *) 
  method delta t=
    (*
     *function that calculates gamma based on mean temperature
     *)
    let denominator=(t+.237.3)**2.0 and arith=4098.0*.(0.6108*.exp(17.27*.t/.(t+.237.3))) in 
      arith/.denominator

      
  method pressure z=
    (*function that calculates pressure
      based on altitude
      returns pressure*)
    let fraction=(293.-.0.0065*.z)/.293. in
      101.3*.fraction**5.26

    (*
  method gamma p=
  method e_svp t=
  method e_svp t=
  method day_of_year d m=
  method day_of_year_monthly m=
  method inv_rel_dist J=
  method lat_in_rad L=
  method solar_declination J=
  method sun_hour_angle J L=
  method daylength ws=
  method clear_short_radiation J L=
  method stef_boltz_temp_prod T=
  method calculate =
*)

end;;


let main () =
      (*let len = (Array.length Sys.argv) in
*       let argv = (Array.sub Sys.argv 1 (len-1)) in (* skip argv0 *)
          Array.iter cat argv *)
          (* create an object*)
          let obj = new penm  in
            Printf.printf "%f\n" (obj#delta (25.0+.273.0))


let _ = main ()

