title: Loops
date:    2012-11-12
category: bash
## Iterating a predefined number of times

BASH offers```in {0..5}``` style of loops which are
useful if you just want to iterate e.g.: 10 times and
(optionally) do something with the index variable:


for i in {0..9}; do
echo "i=$i"
done


## Indexed for loops

If you need a proper indexed for loop where the start and stop
conditions must be read from a variable, or you want the step
to be different from one, you'll be happy to learn that BASH
has a loop constructs which looks very similiar to C-style
for-loops.


```
apple_array=("red" "yellow" "green")

for (( i = 0; i &lt; ${#apple_array[@]}; i++ )); do
  echo "Apple number" $i "is" ${apple_array[$i]}
done
```



Apple number 0 is red
Apple number 1 is yellow
Apple number 2 is green


