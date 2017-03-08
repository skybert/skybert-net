#! /usr/bin/env bash

## author: torstein@escenic.com
set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob

main() {
  local file=recommended-reading.md
  cat > "${file}" <<EOF
title: Interesting Articles & Videos
category: dongxi
tags: reading
date: $(date --iso)

EOF

  cat recommended-reading-urls.md | while read -r line; do
    if [[ "${line}" == "https://"* || "${line}" == "http://"* ]]; then
      title=$(
        curl -s "${line}" |
          grep -v '<svg>' |
          sed -n -r 's@.*<title>(.*)</title>.*@\1@p')

      if [ -z "${title}" ]; then
        title=${line##*/}
      fi


      cat >> "${file}" <<EOF
[${title}](${line})

EOF

    else
      printf "%s\n" "${line}" >> "${file}"
    fi

  done

}

main "$@"
