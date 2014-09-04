title: Functions
date:    2012-10-07
category: bash

## Making Functions Return Values

The clue is to let the function run in its own sub process and let the
value be```echo```-ed instead of ```return```-ed as you'd do in most
other programming languages.

```
function get_number()
{
  echo 12;
}

echo "The number is" $(get_number)
```

## Lambda functions in BASH

A great feature I love in Lisp, is lambda functions, a
function which is applied to e.g. the values inside a
loop. Doing this in BASH is so easy. I've created a simple
(and yes, silly) example to illustrate this:

```
for el in black sabbath rocks; do
  double_length=$(
    # whatever is echo-ed here, is the return value of the lambda function.
    echo $(( $(echo $el | wc -c) * 2 ))
  )

  echo "The dobule length of $el is $double_length"
done
```

