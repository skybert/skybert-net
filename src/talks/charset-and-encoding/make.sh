#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

to=revealjs

blockdiag different-encodings.blockdiag -T svg -o different-encodings.svg

# --self-contained
pandoc \
    --standalone \
    -f markdown \
    --variable revealjs-url=../reveal.js \
    --variable transition=none \
    --template ../escenic.revealjs.template \
    -t $to \
    slides.md  \
    -o  index.html
