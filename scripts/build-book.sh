#!/bin/bash
# Build a single book in ALL output formats.
# Usage: ./scripts/build-book.sh books/aadhaar-esign [output-dir]
set -euo pipefail

BOOK_DIR="${1:?Usage: $0 books/book-name [output-dir]}"
OUTPUT_DIR="${2:-output}"

[ -f "$BOOK_DIR/metadata.yaml" ] || { echo "ERROR: $BOOK_DIR/metadata.yaml not found"; exit 1; }
[ -f "$BOOK_DIR/manuscript.md" ] || { echo "ERROR: $BOOK_DIR/manuscript.md not found"; exit 1; }

BOOK_SLUG=$(basename "$BOOK_DIR")
mkdir -p "$OUTPUT_DIR/$BOOK_SLUG"

echo ""
echo "=========================================="
echo " Building: $BOOK_SLUG"
echo "=========================================="

# Preprocess manuscript
TMP_MD=$(mktemp --suffix=.md)
python3 -c "
import sys
text = open('$BOOK_DIR/manuscript.md', encoding='utf-8').read()
text = text.replace('\U0001f9d2', '*')
text = text.replace('\u2705', '[+]')
text = text.replace('\u274c', '[-]')
open('$TMP_MD', 'w', encoding='utf-8').write(text)
"

META_FLAGS="--metadata-file=$BOOK_DIR/metadata.yaml --metadata=lang:en"

# ── 1. PDF ──────────────────────────────────────────────
echo "  → PDF ..."
PDF_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.pdf"
EISVOGEL="$HOME/.local/share/pandoc/templates/eisvogel.latex"
if [ -f "$EISVOGEL" ]; then
  pandoc "$TMP_MD" --template eisvogel --pdf-engine=xelatex \
    -V book -V titlepage=true -V toc-own-page=true \
    $META_FLAGS -o "$PDF_OUT" 2>/dev/null || {
    echo "  Eisvogel failed, falling back to default..."
    pandoc "$TMP_MD" --pdf-engine=xelatex \
      -V documentclass=book -V mainfont="DejaVu Serif" \
      -V sansfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" \
      $META_FLAGS --toc -o "$PDF_OUT"
  }
else
  pandoc "$TMP_MD" --pdf-engine=xelatex \
    -V documentclass=book -V mainfont="DejaVu Serif" \
    -V sansfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" \
    $META_FLAGS --toc -o "$PDF_OUT"
fi
echo "       $(du -h "$PDF_OUT" | cut -f1)"

# ── 2. EPUB ─────────────────────────────────────────────
echo "  → EPUB ..."
EPUB_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.epub"
pandoc "$TMP_MD" $META_FLAGS --toc -o "$EPUB_OUT"
echo "       $(du -h "$EPUB_OUT" | cut -f1)"

# ── 3. MOBI (from EPUB via calibre) ─────────────────────
echo "  → MOBI ..."
MOBI_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.mobi"
if command -v ebook-convert &>/dev/null; then
  ebook-convert "$EPUB_OUT" "$MOBI_OUT" --output-profile kindle 2>/dev/null && \
    echo "       $(du -h "$MOBI_OUT" | cut -f1)" || \
    echo "       SKIPPED (conversion failed)"
else
  echo "       SKIPPED (ebook-convert not installed)"
fi

# ── 4. HTML / Website (single-page) ─────────────────────
echo "  → HTML ..."
HTML_OUT="$OUTPUT_DIR/$BOOK_SLUG/index.html"
mkdir -p "$OUTPUT_DIR/$BOOK_SLUG"
pandoc "$TMP_MD" $META_FLAGS --toc --standalone \
  --metadata=title:"$(grep '^title:' "$BOOK_DIR/metadata.yaml" | head -1 | cut -d'"' -f2)" \
  --to html5 \
  --css=../../assets/book.css \
  -o "$HTML_OUT"
echo "       $(du -h "$HTML_OUT" | cut -f1)"

# ── 5. Clean Markdown (standalone, with working refs) ────
echo "  → Markdown ..."
MD_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.md"
cp "$TMP_MD" "$MD_OUT"
echo "       $(du -h "$MD_OUT" | cut -f1)"

# Cleanup
rm -f "$TMP_MD"
echo ""
echo "  ✓ $BOOK_SLUG built successfully"
echo "    $OUTPUT_DIR/$BOOK_SLUG/"
echo "=========================================="
echo ""
