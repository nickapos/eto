open EaBase
class eaPoor = object (self)
  inherit  eaBase
 (*
   class with functions
   to calculate ea from
   mean relative humidity and
   minimum and maximum measurements.
   This formula is not very accurate
   but is used when no RHmin and RHmax
   are available
  *) 
  method calc_ea rh tmin tmax=
     (rh/.100.0)*.((self#e(tmin)+.self#e(tmax))/.2.0)
end;;

let () = 
  (* create an object*)
  let obj = new eaPoor  in
    Printf.printf "%f\n" (obj#calc_ea 0.68 18.0 25.0)
