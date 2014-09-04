title: Variables
date:    2012-11-12
category: bash
## Variable Scoping

Another hiddem gem in BASH, is that you can scope variables,
using the```local``` keyword:

```
my_variable="Global value"

function my_function()
{
  local my_variable="My function local value"
  echo "my_variable=$my_variable"
}

my_function
echo "my_variable=$my_variable"
my_function
```

