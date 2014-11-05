#!/usr/bin/python

 
import math
 
class penm:
 ''' This class provides the methods to calculate the penman monteith
 ETo as it is described in the FAO paper Irrigation and
 drainage paper number 56 and displayed in box 11
 and example table 17.
 '''

 def __init__(self,tma,tmin,ea,u,day,month,lat_moir,lat_dek,t_month,t_month_1,alt,iliof):
  self.Tmax=float(tma) #megisti mesi miniaia thermokrasia
  self.Tmin=float(tmin) #mesi elaxisti miniaia thermokrasia
  self.Ea=float(ea) #mesi miniaia imerisia piesi ydratmwn
  self.U=float(u) # mesi miniaia imerisia taxytita anemou
  self.Day=float(day)# i mera tou mina gia tin opoia prosdiorizoume tin ETo. xrisimopoieitai sa mesi mera tou mina 
  self.Month=int(month) #minas gia to opoio prosdiorizoume tin ETo
  self.Latitude_Moires=int(lat_moir) #gewgraiko platos se moires
  self.Latitude_Lepta=int(lat_dek) #dekadiko meros tou gewgrafikou plarous se lepta
  self.Tmonth_i=float(t_month) #mesi miniaia thermokrasia kata to mina Month
  self.Tmonth_i_1=float(t_month_1) #mesi miniaia thermokrasia kata to mina Month-1
  self.altitude=float(alt) #yposometro perioxis
  self.n=float(iliof) # meses wres iliofaneias hours/day


 def delta(self,T):
  ''' function that calculates gamma
  based on mean temperature
 
  returns gamma'''
  arith = 4098*(0.6108*math.exp(17.27*T/(T+237.3)))
  paranom = math.pow((T+237.3),2)
  return arith/paranom
 
 
 def pressure(self,z):
  ''' function that calculates pressure
  based on altitude
 
  returns pressure'''
  klasma=(293-0.0065*z)/293
  dynami=math.pow(klasma,5.26)
  return 101.3*dynami
 
 
 def gamma(self,P):
  ''' function that calculated gamma
  based on pressure
  
  returns gamma'''
  return 0.665*0.001*P
 
 
 def e_svp(self,T):
  ''' function that calculates
  saturation vapour pressure
  based on temperature
 
  returns saturation vapour presure'''
  klasma=17.27*T/(T+237.3)
  dynami=math.exp(klasma)
  return 0.6108*dynami
 
 def day_of_year(self,d,m):
  ''' function that calculates 
  which day of the year is
  the one in d day of m month
 
  returns day of the year'''
  leapYear="No"
  arMeras=((275*m/9) -30 + d)-2
  if m<3:
   arMeras=arMeras+2
  if leapYear=="Yes" and m>2 :
   arMeras =arMeras +1
  return int(arMeras)
  
  
 def day_of_year_monthly(self,m):
  ''' function that calculates 
  which day of the year is
  the middle day of m month
 
  returns day of the year'''
  return int(30.4*m-15)
 
 
 
 
 def inv_rel_dist(self,J):
  '''function that calculates
  the inverse relative distance
  of earth-sun depending on
  the day of the year J
 
 
  returns the distance dr'''
  return 1+0.033*math.cos(2*math.pi*J/365)
 
 
 
 def lat_in_rad(self,L):
  '''calculates the latidude
  in rads from degrees
 
  returns rads phi'''
  return math.pi*L/180
 
 
 
 def solar_declination(self,J):
  '''calulates the solar declination in rads
  using the day of the year J
 
  returns solar declination delta'''
  angle=(2*math.pi/365)*J-1.39
  return 0.409*math.sin(angle)
 
 
 
 
 def sun_hour_angle(self,J,L):
  ''' function that calculates the
  sunset hour angle from input the
  latitude in rad and the solar declination
 
  returns the sunset hour angle ws'''
  phi=self.lat_in_rad(L)
  delt= self.solar_declination(J)
  return math.acos(-math.tan(phi)*math.tan(delt))

 def daylength(self,ws):
  ''' function that calculates the daylength
  by using the  sunset hour angle ws

  returns daylength'''
  return 24*ws/math.pi
  
 def clear_short_radiation(self,J,L):
  ''' function that calculates the
  radiation from the sun taking under
  consideration the angle of the 
  position of the field and the
  leng of the day

  returns Ra'''
  Gsc=0.0820 #solar constant
  phi=self.lat_in_rad(L)
  delta=self.solar_declination(J)
  ws=self.sun_hour_angle(J,L)
  dr=self.inv_rel_dist(J)
  expression=24*60*Gsc*dr*(ws*math.sin(phi)*math.sin(delta)+math.cos(phi)*math.cos(delta)*math.sin(ws))
  return expression/math.pi
  

 
 def stef_boltz_temp_prod(self,T):
  ''' a function that calculates
  the product of the stefan boltzman
  with the temperature
  
  returns the product'''
  sigma=4.903*math.pow(10,-9)
  tk=T+273.16
  return sigma*math.pow(tk,4)
  





 def calculate(self):
   '''function used to calculate
   the ETo

   returns ETo'''
   Tmean=(self.Tmax+self.Tmin)/2
   Press=self.pressure(self.altitude)
   G=self.gamma(Press)
   temp1=1+0.34*self.U
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
   temp8 = 0.408*(Rn-G)
   fin1 = temp8 * temp2
   fin2 = temp4*deltaEs*temp3
   ETo=fin1+fin2
   return ETo

