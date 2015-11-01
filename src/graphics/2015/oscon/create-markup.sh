#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com
set -e
set -u
set -o pipefail

read_user_input() {
  :
}

main() {
  read_user_input "$@"

  for el in *.jpg; do
     cat <<EOF
<img src="/graphics/2015/oscon/${el}"
     alt=${el}
     style="float: left"
/>
EOF
  done
}

main "$@"
