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

```
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
Again, this is a caveat if you have a ```@EqualsAndHashCode``` on your
```javax.persistence``` entity and this entity has a many to one/one
to many field.

The remedy is to implement the ```equals()``` method yourself.

