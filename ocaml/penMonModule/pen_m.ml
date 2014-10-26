class penm = object (self)
 (*
  This class provides the methods to calculate the penman monteith
  ETo as it is described in the FAO paper Irrigation and
  drainage paper number 56 and displayed in box 11
  and example table 17.
  *) 
  method delta t=
  method pressure z=
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


end;;


let main () =
      (*let len = (Array.length Sys.argv) in
*       let argv = (Array.sub Sys.argv 1 (len-1)) in (* skip argv0 *)
          Array.iter cat argv *)
          (* create an object*)
          let obj = new penm  in
            Printf.printf "%f\n" ( 25.0)


let _ = main ()

