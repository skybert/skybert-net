#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

to=revealjs

blockdiag different-encodings.blockdiag -T svg -o different-encodings.svg

# --self-contained
pandoc \
    --standalone \
    -f markdown \
    -t $to \
    slides.md  \
    -o  index.html
