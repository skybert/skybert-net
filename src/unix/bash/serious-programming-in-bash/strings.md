title: Strings
date:    2012-10-07
category: bash

## Testing if a string ends with a sub string

Here, I test if the passed argument to the function ends with
```.zip```:

```bash
function check_if_file_is_a_zip_archive() {
  if [[ $1 == *.zip ]]; then
    echo $1 is a ZIP archive
  else
    echo $1 is not a ZIP
  fi
}
```

## Search and replace in a string

Say you have the string "hello brave new world" and you want to
replace all spaces with a hyphen. It's quite common for people to
shell out a sub process to let sed search and replace a string for us:

```
greeting="hello brave new world"
echo ${greeting} | sed 's# #-#g'
```

There's no need to go to that drastic measures, however, BASH has
string search and replace already built in: greeting="hello brave new
world"

```
echo ${greeting// /-}
```

The <from> and <to> fields can themselves be variables:

```
greeting="hello brave new world"
from=" "
to="-"
echo ${greeting//${from}/${to}}
```

If you replace the double slash with a single one, BASH will only
replace the first occurrence.

Neat, eh?

## Newline handling

Here, I demonstrate storing a newline character and using it
for string concatination, storing this in a variable and
outputting it with the newline intact.

```
NEW_LINE=$'\n'

my_string="hi"
my_string=${my_string}${NEW_LINE}"world"

# newline intact
echo "${my_string}"

#without newline
echo ${my_string}
```

