from eaBase import eaBase
class ea (eaBase):
 ''' class with functions 
   to calculate ea from 
   min and max relative humidity values and
   minimum and maximum measurements.
   This formula is quite accurate
   and is used when RHmin and RHmax
   are available
   '''
   
 def __init__(self,tmin,tmax,rhmin,rhmax):
  self.tmin=float(tmin)
  self.tmax=float(tmax)
  self.rhmin=float(rhmin)
  self.rhmax=float(rhmax)


 def calc_ea(self):
  return (self.e(self.tmin)*(self.rhmin/100)+self.e(self.tmax)*(self.rhmax/100))/2
