title: Mocking classes and overriding methods in Python
date: 2018-11-07
category: python
tags: python, testing


I have this class `Waterfall`: 

```python
class Waterfall:
  def height_in_feet(self):
    return requests.get("https://nicaragua.waterfall.com/height").content
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
        waterfall.height_in_feet = types.MethodType(
            self.my_height_func, self
        )
        assert waterfall.height_in_feet() == 10

    def my_height_func(self, ref):
        return 10
```

The essential bit here is the `types.MethodType` which is what you
need to do when overriding the method on a class _instance_. Just
doing `waterfall.hight_in_feet = self.my_height_func` will not cut it.

With this in place, I can implement any logic I want in
`my_height_func` which will get executed whenever
`Waterfall#height_in_feet()` would have been. 

If you strive to see the point of this, consider the case where you
have a method that uses an instance `Waterfall`. When passing in an
instance of `Waterfall`, we want to control what the method is
returning depending on the input. Imagine that we have this silly
method:

```python
def get_colour_of_waterfall(waterfall: Waterfall) -> str:
    if waterfall.height_in_feet() > 10:
       return "blue"
    else:
       return "true"
```

By using the original implementation of `Waterfall`, we not only have
to be online all the time (and thus writing an integration test instead
of a unit test), but even more importantly, we cannot test what this
`get_colour_of_waterfall` method returns given different situations
and return values from the Nicaragua web service.

Overriding the `Waterfall#height_in_feet()` method solves both of
these problems. With it, we not only can write a pure unit test (no
need to interact with the other system, no need to be online) and we
can easily simulate different values, or exceptions, returned from
`Waterfall#height_in_feet()`.

Happy testing!

