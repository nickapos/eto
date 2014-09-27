import unittest
import sys
sys.path.append('../')
from ea.eaPoor import eaPoor

class TestEaPoor(unittest.TestCase):
    def setUp(self):
        '''Set the reference values for eaBase
        '''
        self.tMin = 18
        self.tMax=25
        self.rhmean=0.68
        self.eapoor=eaPoor(self.tMin,self.tMax,self.rhmean)

    def testEaBase(self):
        '''Test eaBase
        '''
        print "calculated value: "+str(round(self.eapoor.calc_ea()*100,2)) + " reference value: 1.78"
        self.assertAlmostEqual(round(self.eapoor.calc_ea()*100,2),round(100*0.017788007528568933,2))


if __name__ == '__main__':
        unittest.main()
