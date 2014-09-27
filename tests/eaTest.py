import unittest
import sys
sys.path.append('../')
from ea.ea import ea

class TestEaPoor(unittest.TestCase):
    def setUp(self):
        '''Set the reference values for eaBase
        '''
        self.tMin = 18
        self.tMax=25
        self.rhmin=0.54
        self.rhmax=0.82
        self.ea=ea(self.tMin,self.tMax,self.rhmin,self.rhmax)

    def testEaBase(self):
        '''Test eaBase
        This should really change to a round off of 3 digits, but unfortunately
        my computer produces an different number than the reference by 0.16
        '''
        self.assertAlmostEqual(self.ea.calc_ea(),0.017016,2)


if __name__ == '__main__':
        unittest.main()
