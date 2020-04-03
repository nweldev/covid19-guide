#!/usr/bin/env bash

data="$(
    cat "$1" \
      | sed 's/"/\\"/g' \
      | sed ':a;N;$!ba;s/\n/\\n/g' \
)"

if [[ -z "$2" ]]; then
    context=''
else
    context=",\"context\":\"$2\""
fi

echo '<!DOCTYPE html>'
echo '<html><head>'
echo '<link rel="stylesheet" type="text/css" href="index.css" >'
echo '</head><body>'
curl -s --data "{\"text\":\"$data\",\"mode\":\"gfm\"$context}" 'https://api.github.com/markdown'
echo '</body></html>'
