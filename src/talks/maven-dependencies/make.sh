#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

to=revealjs

# --self-contained
pandoc \
    --standalone \
    -f markdown \
    --variable revealjs-url=../reveal.js \
    --template ../escenic.revealjs.template \
    -t $to \
    slides.md  \
    -o  index.html
