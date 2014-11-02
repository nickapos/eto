import unittest
import sys
sys.path.append('../')
from ea import ea
from ea.eaPoor import eaPoor
from penMon.pen_mclass import penm

class TestEto(unittest.TestCase):
    def setUp(self):
        '''Set the reference values for eaBase
        '''
        self.tMin = 25.6
        self.tMax=34.8
        self.ea=2.85
        self.speed=2
        self.monthNum=5
        self.latDeg=13
        self.latMin=44
        self.monthlyAv=30.2
        self.monthlyAvPrev=29.2
        self.alt=2
        self.sun=8.5

    def testEto(self):
        '''Test eto
        '''
        p=penm(self.tMin,self.tMax,self.ea,self.speed,15,self.monthNum,self.latDeg,self.latMin,self.monthlyAv,self.monthlyAvPrev,self.alt,self.sun)
        print "eTo calculated value:"+str(p.calculate())+" reference value 5.72"
        self.assertAlmostEqual(round(p.calculate(),2),5.72,2)


if __name__ == '__main__':
        unittest.main()
