#!/bin/bash

make --no-print-directory format & FORMAT=$!
make --no-print-directory lint & LINT=$!
npm install git+https://github.com/sharelatex/translations-sharelatex.git#master & TRANSLATIONS=$!

npm run webpack:production & WEBPACK=$!

echo "Waiting for lint, format, translations and minify to finish"

wait $LINT && echo "Lint complete" || exit 1
wait $FORMAT && echo "Format complete" || exit 1
wait $TRANSLATIONS && echo "Translations install complete" || exit 1
wait $WEBPACK && echo "Webpack complete" || exit 1
