import math

class eaBase:
 ''' class with functions 
   to calculate ea from 
   mean relative humidity and
   minimum and maximum measurements.
   This formula is not very accurate
   but is used when no RHmin and RHmax
   are available
   '''

  
 def e(self,t):
  '''method that
   calculates the  vapour pressure
   from temperature'''
   
  klasma=17.27*t/(t+237.3)
  return 0.6108*math.exp(klasma)

 def calc_ea(self):
  return None
