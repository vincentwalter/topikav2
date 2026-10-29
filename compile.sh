#!/usr/bin/env sh
set -eu

mkdir -p build

# Slides for presenting (with animation steps) and pdfpc notes file
typst compile main.typ build/presentation.pdf
typst eval --in main.typ 'query(<pdfpc-file>).first().value' > build/presentation.pdfpc

# One page per slide, plus the page of every #notes/#handout block
typst compile --input mode=thumbs main.typ build/thumbs.pdf
typst eval --in main.typ --input mode=thumbs \
  'import "ukt-talk.typ": thumbs-map; thumbs-map()' > build/thumbs.json

# Companion documents
typst compile --input mode=handout --input handout-slides=true main.typ build/handout.pdf
typst compile --input mode=handout --input handout-slides=false main.typ build/handout-text.pdf
typst compile --input mode=script main.typ build/script.pdf
