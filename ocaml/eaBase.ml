class eaBase = object (self)
 (*
  2class with functions
   to calculate ea from
   mean relative humidity and
   minimum and maximum measurements.
   This formula is not very accurate
   but is used when no RHmin and RHmax
   are available
  *) 
  method e t =
    (*
     *method that
     *calculates the e0
     *from temperature
     *)
    0.6108*.exp(17.27*.t/.(t+.237.3))
  
  method calc_es tmin tmax = 
    (*
     * This method will calculate the es using the above 
     * methods
    *)
    (self#e tmin +. self#e tmax )/.2.0

end;;

let () = 
  (* create an object*)
  let obj = new eaBase  in
  Printf.printf "%f\n" (obj#calc_es 15.0 24.6)
