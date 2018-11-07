title: Mocking classes and overriding methods in Python
date: 2018-11-07
category: python
tags: python, testing


I have this class `Waterfall`: 

```python
class Waterfall:
  def height_in_feet(self):
    # calls https://nicaragua.waterfall.com/height
    return 164
```

It's making web service calls to Nicaragua all the time, requiring me
to be online whenever I run my tests:

```python    
import unittest


class ExploringMocking(unittest.TestCase):
    def test_using_the_real_class(self):
        waterfall = Waterfall()
        assert waterfall.height_in_feet() == 164
```

For this reason, I'd like to mock the `Waterfall` class (as it has so
many methods and I want the method signatures to all be correct, I use
`unittest.mock.create_autospec`) and provide my own implementation of
the `height_in_feet()` method:

```python
import types
import unittest.mock


class ExploringMocking(unittest.TestCase):
    def test_mocking_a_class(self):
        waterfall = unittest.mock.create_autospec(Waterfall)
        waterfall.height_in_feet = types.MethodType(self.my_height_func, self)
        assert waterfall.height_in_feet() == 10

    def my_height_func(self, ref):
        return 10
```

The essential bit here is the `types.MethodType` which is what you
need to do when overriding the method on a class _instance_. Just
doing `waterfall.hight_in_feet = self.my_height_func` will not cut it.

With this in place, I can implement any logic I want in
`my_height_func` which will get executed whenever
`Waterfall#height_in_feet()` would have been. This is very useful when
passing this mock instance of `Waterfall` around to other components.

Happy testing!

