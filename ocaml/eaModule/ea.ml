class ea = object (self)
  inherit  EaBase.eaBase
 (*
   class with functions
   to calculate ea from
   min and max relative humidity values and
   minimum and maximum measurements.
   This formula is quite accurate
   and is used when RHmin and RHmax
   are available
  *) 
  method calc_ea rhmin rhmax tmin tmax=
    (self#e(tmin)*.(rhmin/.100.0)+.self#e(tmax)*.(rhmax/.100.0))/.2.0
end;;

let main () =
    (*let len = (Array.length Sys.argv) in
      let argv = (Array.sub Sys.argv 1 (len-1)) in (* skip argv0 *)
          Array.iter cat argv *)
    (* create an object*)
      let obj = new ea in
          Printf.printf "%f\n" (obj#calc_ea 0.54 0.82 18.0 25.0)


(*let _ = main ()*)
