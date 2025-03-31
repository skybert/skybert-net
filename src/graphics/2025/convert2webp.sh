#! /usr/bin/env bash

## author: torstein

set -o errexit
set -o nounset
set -o pipefail

main() {
  for el in *.png *.jpg ; do
    bn=$(basename "${el}" .png)
    bn=$(basename "${bn}" .jpg)
    cwebp -q 80 "${el}" -o "${bn}".webp
  done
}

main "$@"
