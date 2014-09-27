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
   calculates the e0
   from temperature'''
   
  klasma=17.27*t/(t+237.3)
  return 0.6108*math.exp(klasma)

 def calc_ea(self):
  return None

 def calc_es(self,tmin,tmax):
  '''This method will calculate the es using the above
  methods
  '''
  return (self.e(tmin)+self.e(tmax))/2

if __name__ == '__main__':
  eabase=eaBase()
  print eabase.calc_es(15,24.6)
