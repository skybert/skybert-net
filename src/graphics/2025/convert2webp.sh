#! /usr/bin/env bash

## author: torstein

set -o errexit
set -o nounset
set -o pipefail

main() {
  for el in *.png *.jpg ; do
    bn=$(basename "${el}" .png)
    bn=$(basename "${bn}" .jpg)
    w="${bn}".webp
    test -r "${w}" && continue
    cwebp -q 75 "${el}" -o "${w}"
  done
}

main "$@"
