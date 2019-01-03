title: Lombok
date: 2014-10-09
category: java
tags: lombok

[Lombok](http://projectlombok.org) is a real time saver at times but
it can also lead to unexpected bugs in your code. Here, I've described
some of the caveats I've encountered.

## StackOverflow in @ToString
[@ToString](http://projectlombok.org/features/ToString.html) can give
you stack overflow if it's lored into an infinite loop. One place
where this can easily happen, is if you have ```javax.persistence```
entities that have fields with many to one relationships.

The remedy is to include those fields in the optional exclude
parameter of the annotation:

```java
@ToString(exclude = "tribe")
@Entity
public class Indian
{
  @ManyToOne
  private Tribe tribe;
}


@ToString(exclude = "indians")
@Entity
public class Tribe
{
  @Getter
  @OneToMany(mappedBy = "tribe")
  private List<Indian> indians = new ArrayList<>();
}
```

## Equals can trick you if you have proxied member variables
Again, this is a caveat if you have a `@EqualsAndHashCode` on your
`javax.persistence` entity and this entity has a many to one/one to
many field.

The remedy is to implement the `equals()` method yourself.

## Creating a builder while keeping a default constructor
 
I've come to love the
[@Builder](https://projectlombok.org/features/Builder) annotation:
```java
@Builder
public class IceCream {
  private int size;
  private Color color;
}
```

Allowing me to create instances using the builder flow:
```java
IceCream iceCream = IceCream.builder().
  size(10).
  color(Color.RED).
  build();
```

This is all well and good, but some frameworks (like JPA) needs a
default constructor. However, the `@Builder` annotation makes these
throw nasty exceptions at you like:

```text
Caused by: java.lang.NoSuchMethodException: net.skybert.IceCream.<init>()
  at java.lang.Class.getConstructor0(Class.java:3082)
  at java.lang.Class.newInstance(Class.java:412)
```


The reason is that when annotating a class with `@Builder` an
`@AllArgsConstructor` is implied. However, some frameworks need the
default constructor to work, so we'll need to add _both_ the Lombok
`@NoArgsConstructor` and `@AllArgsConstructor` annotations to get the
behaviour we want with the frameworks while getting the goodness of
Lombok's `@Builder`. The class then looks like this:

```java
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class IceCream {
  private int size;
  private Color color;
}

```

Easy enough when you know it 😎
