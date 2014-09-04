title: Working with dictionaries
date:    2012-11-12
category: bash

Working with dictionaries / hash maps / hash tables.

declare -A my_map
my_map=(
["first_name"]="John"
["last_name"]="Doe"
)

for el in ${!my_map[@]}; do
echo $el":" ${my_map[$el]}
done



Produces:


last_name: Doe
first_name: Joh


The odd looking exclemeation mark in front of the
```my_map``` in the for loop initialiser is to make
BASH iterate over the keys and not the values, which for some
reason, are the values per default. You see this easily if we
change the for loop slightly:


for el in ${my_map[@]}; do
echo $el
done



The output then becomes:


Doe
John


