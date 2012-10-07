#! /usr/bin/env bash

echo "Content-type: text/html"
echo ""

t=`env | grep REQUEST_URI | cut -d'=' -f2 | sed 's/\// \:\: /g'`
echo -n $t | sed 's/\-i\-/ I /g' | sed 's/\-/ /g' | sed 's/\_/ /g'
echo "."



