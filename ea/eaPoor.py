from eaBase import eaBase
class eaPoor (eaBase):
 ''' class with functions 
   to calculate ea from 
   mean relative humidity and
   minimum and maximum measurements.
   This formula is not very accurate
   but is used when no RHmin and RHmax
   are available
   '''

 def __init__(self,tmin,tmax,rh):
  self.tmin=float(tmin)
  self.tmax=float(tmax)
  self.rh=float(rh)


 def calc_ea(self):
  return (self.rh/100)*((self.e(self.tmin)+self.e(self.tmax))/2)
