title: Numbers in BASH
date: 2015-11-18
category: bash
tags: unix, bash

## Testing if a variable is numeric

```bash
local days=$1
if [[ $days =~ ^[0-9]*$ ]]; then
   echo "You entered number of days: ${days}"
fi
```

## Testing if a variable is not numeric

```bash
local days=$1
if [[ ! $days =~ ^[0-9]*$ ]]; then
  echo "Usage: $(basename $0) <number-of-days>"
  exit 1
fi
```
