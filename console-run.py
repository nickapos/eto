#!/usr/bin/python


class GetResults:
 
 def runner(self):
  '''This method will control
  what is run
  '''
  print "Choose your action: Calculate Ea (a), Calculate Ea-Poor(b), Calculate Eto (c)"
  decide=raw_input("")
  
  if decide == 'c':
   self.calculateEto()
  elif decide == 'a':
   self.calculateEa()
  elif decide == 'b':
   self.calculateEaPoor()
  else:
   print "Choose an appropriate letter"


 def calculateEa(self):
  '''This method will calculate the
  ea when given the appropriate data
  '''
  print "You have selected Ea calculation"
  tmax = float(raw_input("Insert Tmax: "))
  
  tmin = float(raw_input("Insert Tmin: "))
  
  rhmax = float(raw_input("Insert RHmax: "))
  
  rhmin = float(raw_input("Insert RHmin: "))
  
  import ea
  eaCalculated=ea.ea(tmin,tmax,rhmin,rhmax)
  print str(eaCalculated.calc_ea())

 def calculateEaPoor(self):
  '''This method will calculate the
  ea poor when given the appropriate data
  '''
  print "You have selected EaPoor calculation"
  tmax = float(raw_input("Insert Tmax: "))
  
  tmin = float(raw_input("Insert Tmin: "))
  
  rh = float(raw_input("Insert RH: "))
  
  import eaPoor
  eaPoorCalculated=eaPoor.eaPoor(tmin,tmax,rh)
  print eaPoorCalculated.calc_ea()

 def calculateEto(self):
  '''Method that calculates
  the ETo given the arguments it requests
  '''
  print "You have selected Eto calculation"
  tmax = float(raw_input("Insert Tmax: "))
  
  tmin = float(raw_input("Insert Tmin: "))
  
  ea = float(raw_input("Insert Ea: "))
  
  speed= float(raw_input("Insert Air Speed: "))     
  
  monthNum= int(raw_input("Insert Month Number: "))
  
  latDeg= int(raw_input("Insert Latitude Degrees: "))
  
  latMin= int(raw_input("Insert Latitude Minutes: "))
  
  monthlyAv= float(raw_input("Insert Monthly Average Temperature: "))
  
  monthlyAvPrev= float(raw_input("Insert Previoud Monthly Average Temperature: "))
  
  alt= float(raw_input("Insert Altitude: "))
  
  sun= float(raw_input("Insert Sun Hours: "))
  
 
  import pen_mclass
  p=pen_mclass.penm(tmax,tmin,ea,speed,15,monthNum,latDeg,latMin,monthlyAv,monthlyAvPrev,alt,sun)
  print str(p.calculate())




def main():
    a=GetResults()
    a.runner()

if __name__ == '__main__':
   main()

