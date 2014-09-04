title: Strings
date:    2012-10-07
category: bash
## Testing if a string ends with a sub string

Here, I test if the passed argument to the function ends with
```.zip```:

```
function check_if_file_is_a_zip_archive() {
  if [[ $1 == *.zip ]]; then
    echo $1 is a ZIP archive
  else
    echo $1 is not a ZIP
  fi
}
```

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

