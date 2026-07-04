#!/bin/bash
# Build a single book PDF from markdown source.
# Usage: ./scripts/build-book.sh books/aadhaar-esign [output-dir]
set -euo pipefail

BOOK_DIR="${1:?Usage: $0 books/book-name [output-dir]}"
OUTPUT_DIR="${2:-output}"

[ -f "$BOOK_DIR/metadata.yaml" ] || { echo "ERROR: $BOOK_DIR/metadata.yaml not found"; exit 1; }
[ -f "$BOOK_DIR/manuscript.md" ] || { echo "ERROR: $BOOK_DIR/manuscript.md not found"; exit 1; }

BOOK_SLUG=$(basename "$BOOK_DIR")
mkdir -p "$OUTPUT_DIR"
OUTPUT_PDF="$OUTPUT_DIR/$BOOK_SLUG.pdf"

echo "Building: $BOOK_SLUG"

# Preprocess - replace emoji for LaTeX
TMP_MD=$(mktemp --suffix=.md)
python3 -c "
import sys
text = open('$BOOK_DIR/manuscript.md', encoding='utf-8').read()
text = text.replace('\U0001f9d2', '*')   # child emoji
text = text.replace('\u2705', '[+]')      # check mark
text = text.replace('\u274c', '[-]')      # cross mark
open('$TMP_MD', 'w', encoding='utf-8').write(text)
"

# Try Eisvogel template if installed
EISVOGEL="$HOME/.local/share/pandoc/templates/eisvogel.latex"
if [ -f "$EISVOGEL" ]; then
  pandoc "$TMP_MD" \
    --template eisvogel \
    --pdf-engine=xelatex \
    -V book -V titlepage=true -V toc-own-page=true \
    --metadata-file="$BOOK_DIR/metadata.yaml" \
    --from markdown+emoji \
    -o "$OUTPUT_PDF" 2>&1 || {
      echo "Eisvogel failed, falling back to default..."
      pandoc "$TMP_MD" --pdf-engine=xelatex \
        -V documentclass=book -V mainfont="DejaVu Serif" \
        -V sansfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" \
        --metadata-file="$BOOK_DIR/metadata.yaml" --toc -o "$OUTPUT_PDF"
    }
else
  pandoc "$TMP_MD" --pdf-engine=xelatex \
    -V documentclass=book -V mainfont="DejaVu Serif" \
    -V sansfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" \
    --metadata-file="$BOOK_DIR/metadata.yaml" --toc -o "$OUTPUT_PDF"
fi

rm -f "$TMP_MD"
echo "Built: $OUTPUT_PDF ($(du -h "$OUTPUT_PDF" | cut -f1))"
