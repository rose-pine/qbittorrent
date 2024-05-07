#!/usr/bin/env bash

npx @rose-pine/build@latest    \
    --template ./src/template/ \
    --output ./src/

themes=("main" "moon" "dawn")

for theme in "${themes[@]}"; do
  themePath="$theme.qbtheme"
  themeSrc="./src/$theme"
  if ! command -v rcc &> /dev/null; then
    echo "rcc not found" >&2
    break
  elif [ ! -f "$themeSrc/resources.qrc" ]; then
    echo "Missing resources.qrc for $theme theme." >&2
    continue
  else
    mkdir -p ./dist
    rcc "$themeSrc/resources.qrc" -o "./dist/$themePath" -binary
    echo "Compiled $themePath."
    rm -rf $themeSrc
  fi
done
