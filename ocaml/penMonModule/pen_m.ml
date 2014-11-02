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
      second part and finaly d is a Unix.localtime record, from which we can pick the tm_yday

      returns day of the year
     *)
      let now_t = Unix.localtime (Unix.time ()) in
      let inc_date=Unix.mktime{
          Unix.tm_sec = 0;
          tm_min = 0;
          tm_hour =0;
          tm_mday =d;
          tm_mon =m;
          tm_year =now_t.tm_year;
          tm_wday = -1;
          tm_yday = -1;
          tm_isdst = true;
        } and tuple_date(a,b)=b in
        let d=tuple_date(inc_date) in
          d.tm_yday

     

  method day_of_year_monthly m=
    (*
     *function that calculates
      which day of the year is
      the middle day of m month
      should really be 30.4*m-15
     *)
    30*m-15

  method inv_rel_dist j=
  (*
   *function that calculates
    the inverse relative distance
    of earth-sun depending on
    the day of the year J

    returns the distance dr
   *)
    1.+.0.033*.cos (2.0*.BatFloat.pi*.j/.365.)

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
    let angle=(2.*.BatFloat.pi/.365.)*.j-.1.39 in
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
    ws=self#sun_hour_angle j l and 
    dr=self#inv_rel_dist j in
   let expression=24.*.60.*.gsc*.dr*.(ws*.sin phi *.sin(delta)+.cos(phi)*.cos(delta)*.sin(ws)) in
    expression/.BatFloat.pi

  method stef_boltz_temp_prod t=
    (*
     *a function that calculates
      the product of the stefan boltzman
      with the temperature

      returns the product 
     *)
     let sigma=4.903*.10.**(-9.) and 
        tk=t+.273.16 in
      sigma*.tk**4.

  method calculate tmax tmin altitude u=
    (*
     *function used to calculate the ETo

      returns ETo
     *)
    let tmean= (tmax +. tmin)/. 2. and press=self#pressure altitude in
    let g=self#gamma press and temp1=1.+.0.34*.u and delt=self#delta tmean in
      delt/.(delt+.g+.temp1)
   (* 
   delt=self.delta(Tmean)
   temp2=delt/(delt+G*temp1)
   temp3=G/(delt+G*temp1)
   temp4=900*self.U/(Tmean+273)
   emax=self.e_svp(self.Tmax)
   emin=self.e_svp(self.Tmin)
   eav=(emax+emin)/2
   deltaEs = eav-self.Ea
   J=self.day_of_year(self.Day,self.Month)
   L=self.Latitude_Moires+(float(self.Latitude_Lepta)/60)
   Ra=self.clear_short_radiation(J,L)
   ws=self.sun_hour_angle(J,L)
   N=self.daylength(ws)
   nN=self.n/N
   Rs=(0.25+0.5*nN)*Ra
   Rso=(0.75+2*self.altitude/100000)*Ra
   logos1=Rs/Rso
   Rns=0.77*Rs
   sigma_t_max = self.stef_boltz_temp_prod(self.Tmax)
   sigma_t_min=self.stef_boltz_temp_prod(self.Tmin)
   temp5= 0.34-0.14*math.sqrt(self.Ea)
   temp6=1.35*logos1-0.35
   Rnl=((sigma_t_max+sigma_t_min)/2)*temp5*temp6
   Rn=Rns-Rnl
   Gday=0
   Gmonth=0.14*(self.Tmonth_i-self.Tmonth_i_1)
   temp7=Rn-Gmonth
   temp8 = 0.408*(Rn-G)
   fin1 = temp8 * temp2
   fin2 = temp4*deltaEs*temp3
   ETo=fin1+fin2
   return ETo *)


end;;


let main () =
      (*let len = (Array.length Sys.argv) in
*       let argv = (Array.sub Sys.argv 1 (len-1)) in (* skip argv0 *)
          Array.iter cat argv *)
          (* create an object*)
          let obj = new penm  in
          Printf.printf "%f\n" (obj#inv_rel_dist 301.0)


let _ = main ()

