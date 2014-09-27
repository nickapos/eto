import unittest
from ../eaBase import eaBase

class TestEaBase(unittest.TestCase):
    eabase=eaBase()
    def setUp(self):
        '''Set the reference values for eaBase
        '''
        self.tMin = 15
        self.tMax=24.6

    def testEaBase(self):
        '''Test eaBase
        '''
        self.assertAlmostEqual(self.eabase.calc_es(self.tMin,self.tMax),2.39921378082)

    def testE0(self):
        '''Test e0
        '''
        self.assertAlmostEqual(self.eabase.e(self.tMin),1.7053462321157722)

if __name__ == '__main__':
        unittest.main()
