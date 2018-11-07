#! /usr/bin/env python3

import types
import unittest.mock
import unittest


class ExploringMocking(unittest.TestCase):
    def test_using_the_real_class(self):
        waterfall = Waterfall()
        assert waterfall.height_in_feet() == 164

    def test_mocking_a_class(self):
        waterfall = unittest.mock.create_autospec(Waterfall)
        waterfall.height_in_feet = types.MethodType(self.my_height_func, self)
        assert waterfall.height_in_feet() == 10

    def my_height_func(self, ref):
        return 10


class Waterfall:
  def height_in_feet(self):
    return 164
