title: Auto boxing can fool you
category: java
date: 2014-10-14

## Assigning null objects to primitives

```java
public class FalseSafetyWithAutoBoxing {
  private static class Car {
    public Car(Double price) {
      double value = price;
    }
  }

  public static void main(String[] args) throws Exception {
    Double price = null;
    Car car = new Car(price);
  }
}
```

When you run this, you get:
```
$ javac FalseSafetyWithAutoBoxing.java && java FalseSafetyWithAutoBoxing
Exception in thread "main" java.lang.NullPointerException
  at FalseSafetyWithAutoBoxing$Car.<init>(FalseSafetyWithAutoBoxing.java:12)
  at FalseSafetyWithAutoBoxing.main(FalseSafetyWithAutoBoxing.java:18)
```
