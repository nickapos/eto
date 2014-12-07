open Unix
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

    
  method gamma p=
  (*
    function that calculates gamma
      based on pressure
   *)
    0.665*.0.001*.p
  
  method e_svp t= 
  (*
  function that calculates
  saturation vapour pressure
  based on temperature

  n vapour presure
  *)
    0.6108*.exp(17.27*.t/.(t+.237.3))


  method is_leap y=
    (*
     *this method will detect if a year is leap year or not
     *it will return a boolean
     *)
    if (y mod 4) ==0 then true else (if (y mod 100)==0 then false else (if (y mod 400)==0 then true else false))
 
  method day_of_year d m= 
    (*
     function that calculates 
     which day of the year is 
     the one in d day of m month.
     It uses the current year. That is in the now_t variable
      and uses it to find the number of the day d in month m
      of the current year.
      The inc_date returns a tuple, the tuple_date filters the tuple to its
      second part and finaly d is a Unix.localtime record, from which we can pick the tm_year

      returns day of the year
     *)
    let dayNo=((275*m/9) -30 + d)-2 and now_t = Unix.localtime (Unix.time ()) in
      let this_year = now_t.tm_year+1900 in
      if m < 3 
      then
        dayNo+2
      else if (self#is_leap this_year) && m >2
      then
        dayNo+1
      else 
        dayNo

     

  method day_of_year_monthly m=
    (*
     *function that calculates
      which day of the year is
      the middle day of m month
      should really be 30.4*m-15
     *)
    int_of_float(30.4*.float_of_int m -.15.)

  method inv_rel_dist j=
  (*
   *function that calculates
    the inverse relative distance
    of earth-sun depending on
    the day of the year J

    returns the distance dr
   *)
    let day_of_year_float= float_of_int j in
      1.+.0.033*.cos (2.0*.BatFloat.pi*.day_of_year_float/.365.)

  method lat_in_rad l=
    (*
     *calculates the latidude
      in rads from degrees

      returns rads phi
     *
     *)
    BatFloat.pi*.l/.180.


  method solar_declination j=
    (*
     *calulates the solar declination in rads
      using the day of the year J

      returns solar declination delta
     *
     *)
    let j_float= float_of_int j in
    let angle=(2.*.BatFloat.pi/.365.)*.j_float-.1.39 in
      0.409*.sin(angle)

  method sun_hour_angle j l=
    (*
     *function that calculates the
      sunset hour angle from input the
      latitude in rad and the solar declination

      returns the sunset hour angle ws
     *)
      acos(-.tan(self#lat_in_rad l)*.tan(self#solar_declination j))


  method daylength ws=
    (*
     *function that calculates the daylength
      by using the  sunset hour angle ws

      returns daylength
     *)
     24.*.ws/.BatFloat.pi

  method clear_short_radiation j l=
    (*
     function that calculates the
    radiation from the sun taking under
    consideration the angle of the
    position of the field and the
    leng of the day.
    gsc is the solar constant

    returns Ra
   *)
   let gsc=0.0820 and 
    phi=self#lat_in_rad l and 
    delta=self#solar_declination j and 
    ws=self#sun_hour_angle j l in
   let dr=self#inv_rel_dist j in
   let expression=24.*.60.*.gsc*.dr*.(ws*.sin phi *.sin(delta)+.cos(phi)*.cos(delta)*.sin(ws)) in
    expression/.BatFloat.pi

  method stef_boltz_temp_prod ~t:t=
    (*
     *a function that calculates
      the product of the stefan boltzman
      with the temperature

      returns the product 
     *)
     let sigma=4.903*.10.**(-9.) and 
        tk=t+.273.16 in
      sigma*.tk**4.


  method tmean tMax tMin =
    (*
     * returns the mean of two temperatures
     *)
    (tMax +. tMin)/. 2.

  method temp1 avairspeed =
    1.+.0.34*.avairspeed

  method temp2 delta g temp1 =
    delta/.(delta+.g*.temp1)

  method temp3 delta g temp1 =
    g/.(delta+.g*.temp1)

  method temp4 avairspeed tmean =
    900.*.avairspeed/.(tmean+.273.)

  method calculate ~tmax:tmax ~tmin:tmin ~altitude:altitude ~avairspeed:avairspeed ~ea:ea ~day:day ~monthNum:monthNum ~latitude_degrees:latitude_degrees ~latitude_Lepta:latitude_Lepta ~av_sunhours:av_sunhours ~tmonth_i:tmonth_i ~tmonth_i_1:tmonth_i_1=
    (*
     *function used to calculate the ETo

      returns ETo
     *)
    let tmean= self#tmean tmax tmin and press=self#pressure altitude in
    let g=self#gamma press and temp1=self#temp1 avairspeed and delt=self#delta tmean in
    let  temp2=self#temp2 delt g temp1 and temp3=self#temp3 delt g temp1 and temp4=self#temp4 avairspeed tmean and emax=self#e_svp tmax and
      emin=self#e_svp tmin in
      let eav=(emax+.emin)/.2. in
      let deltaEs = eav-.ea and j=self#day_of_year day monthNum and l= latitude_degrees+. latitude_Lepta/.60. in
      let ra=self#clear_short_radiation j l and ws=self#sun_hour_angle j l in
      let daylength=self#daylength ws in
      let nN= daylength/.av_sunhours in
      let rs=(0.25+.0.5*.nN)*.ra and rso=(0.75+.2.*.altitude/.100000.)*.ra in
      let fraction1=rs/.rso and rns=0.77*.rs and sigma_t_max = self#stef_boltz_temp_prod tmax and sigma_t_min=self#stef_boltz_temp_prod tmin 
        and temp5= 0.34-.0.14*.sqrt ea in
      let temp6=1.35*.fraction1-.0.35 in
      let rnl=((sigma_t_max+.sigma_t_min)/.2.)*.temp5*.temp6 in
      let rn=rns-.rnl and gmonth=0.14*.(tmonth_i-.tmonth_i_1) in
      let temp7=rn-.gmonth and temp8=0.408*.(rn-.g) in
      let fin1=temp8 *. temp2 and fin2= temp4*.deltaEs*.temp3 in
      fin1+.fin2
end;;

let main () =
      (*let len = (Array.length Sys.argv) in
          create an object *)
          let obj = new penm in
          Printf.printf "%f\n" (obj#calculate ~tmin:25.6 ~tmax:34.8 ~ea:2.85 ~day:15 ~avairspeed:2. ~monthNum:5 ~latitude_degrees:13. ~latitude_Lepta:44. ~tmonth_i:30.2 ~tmonth_i_1:29.2 ~altitude:2. ~av_sunhours:8.5)


(* let _ = main () *)

