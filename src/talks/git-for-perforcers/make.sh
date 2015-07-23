#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

# --self-contained
create_html() {
  local to=revealjs
  pandoc \
      --standalone \
      -f markdown \
      --variable revealjs-url=../reveal.js \
      --variable transition=none \
      --template ../torstein.revealjs.template \
      -t $to \
      slides.md  \
      -o  index.html
}
create_pdf() {
  pandoc \
      -f markdown \
      --standalone \
      -t beamer slides.md \
      --latex-engine=xelatex \
      -o slides.pdf
}

# create_pdf
create_html
