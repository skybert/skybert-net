#! /usr/bin/env bash

## author: torstein@escenic.com
set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob

main() {
  local article=$1

  local out="$(dirname "${article}")/$(basename "${article}" .md)"-talk.md
  sed -e 's#<img#\n---\n\n<img#' \
      -e 's@^#@\n---\n\n#@' \
      < "${article}" > "${out}"

  ~/src/escenic-revealjs-themes/bin/create-slides \
    --dir /tmp \
    "${out}"
}

main "$@"
