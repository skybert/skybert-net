#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

create_html() {
  local to=revealjs
  pandoc \
      --standalone \
      -f markdown \
      --variable revealjs-url=../reveal.js \
      --variable transition=zoom \
      --template ../escenic.revealjs.template \
      -t $to \
      slides.md  \
      -o  index.html
}

create_diagrams() {
  for el in $(dirname "$0")/*.blockdiag; do
    blockdiag "${el}" -T svg -o "$(basename "${el}" .blockdiag)".svg
  done

}

create_diagrams
create_html
