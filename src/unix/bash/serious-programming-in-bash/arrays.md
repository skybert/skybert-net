title: Arrays in BASH
date:    2012-11-12
category: bash
## Arrays

Arrays is another hidden gem in BASH. BASH uses normal
paranthesis to denote the start and end of arrays and a space
signals the start of the next item:

    fruit_array=("apples" "oranges" "bananas" "peaches" "papayas")

### Iterating an array using indexes

Iterating using an index isn't that much different from C
style languages. The unusual bit, is the double parenthesises
and the extravagant reading of the array length:


    for (( i = 0; i &lt; ${#fruit_array[@]}; i++ )); do
      echo $i "="  ${fruit_array[$i]}
    done

### Iterating an array without an index

If you don't need the index variable, you can also just
iterate through the array values like this:

    for fruit in ${fruit_array[@]}; do
echo $fruit
done

### Starting iterating on a specified index in the array

If you wish to address just a sub set of the array, you can
add the indexes inside the curly braces. Here, I start
iterating from the second item of the array:

    for fruit in ${fruit_array[@]:1}; do
echo $fruit "(skipped the first one)"
done



Whereas here, I only want the the middle two fruits:

    for fruit in ${fruit_array[@]:1:3}; do
echo $fruit "(skipped the first and last ones)"
done

### Creating an array of files

Often, you find yourself wanting a set of files into an array.
This is easy,. simply do the following to get all
```tar.gz``` files in an array:


tarballs=($(ls /my/dir/*.tar.gz))


