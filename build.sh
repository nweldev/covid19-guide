#!/usr/bin/env bash

set +x

for path in ./*.md; do
  echo "input: $path"

  data="$(
    cat "$path" |
      sed 's/"/\\"/g' |
      sed ':a;N;$!ba;s/\n/\\n/g'
  )"
  name=$(basename "$path" .md)

  if [ $name == "README" ]; then
    name="index"
  fi

  output="./public/${name}.html"

  echo "output: $output"

  echo '<!DOCTYPE html><html lang="en"><head>' >$output
  cat ./head.html >>$output
  echo '</head><body>' >>$output
  echo '<img src="./logo.png" alt="logo" class="logo">' >>$output
  curl -s --data "{\"text\":\"$data\",\"mode\":\"gfm\"}" 'https://api.github.com/markdown' >>$output
  echo '</body></html>' >>$output
done
