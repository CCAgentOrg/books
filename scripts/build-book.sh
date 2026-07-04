#!/bin/bash
set -euo pipefail

BOOK_DIR="${1:?Usage: $0 books/book-name [output-dir]}"
OUTPUT_DIR="${2:-output}"

[ -f "$BOOK_DIR/metadata.yaml" ] || { echo "ERROR: $BOOK_DIR/metadata.yaml not found"; exit 1; }

BOOK_SLUG=$(basename "$BOOK_DIR")
mkdir -p "$OUTPUT_DIR/$BOOK_SLUG"

echo ""
echo "========================================"
echo " Building: $BOOK_SLUG"
echo "========================================"

MANUSCRIPT_MD="$BOOK_DIR/manuscript.md"
CHAPTER_INDEX="$BOOK_DIR/chapter-index.yml"
CHAPTER_DIR="$BOOK_DIR/manuscript"
TMP_MD=$(mktemp --suffix=.md)

# ── Assemble manuscript from chapter files or monolithic ──
if [ -f "$CHAPTER_INDEX" ] && [ -d "$CHAPTER_DIR" ]; then
  echo "  Mode: per-chapter files"
  python3 -c "
import yaml, os, sys
idx = yaml.safe_load(open(sys.argv[1]))
based = os.path.dirname(sys.argv[1])
out = open(sys.argv[2], 'w')
def add(f):
    path = os.path.join(based, f)
    if os.path.exists(path):
        out.write(open(path).read() + chr(10) + chr(10))
for p in idx.get('parts', []):
    for c in p.get('chapters', []):
        add(c['file'])
    for f in p.get('files', []):
        add(f)
" "$CHAPTER_INDEX" "$TMP_MD"
elif [ -f "$MANUSCRIPT_MD" ]; then
  echo "  Mode: monolithic"
  cp "$MANUSCRIPT_MD" "$TMP_MD"
else
  echo "ERROR: No manuscript found at $CHAPTER_INDEX or $MANUSCRIPT_MD"
  exit 1
fi

# Preprocess emoji for LaTeX safety
python3 -c "
import sys
text = open(sys.argv[1]).read()
text = text.replace('\U0001f9d2', '*')
text = text.replace('\u2705', '[+]')
text = text.replace('\u274c', '[-]')
open(sys.argv[1], 'w').write(text)
" "$TMP_MD"

META_FLAGS="--metadata-file=$BOOK_DIR/metadata.yaml --metadata=lang:en"

# ── 1. PDF ───────────────────────────────────
echo "  > PDF ..."
PDF_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.pdf"

if [ -f "$HOME/.local/share/pandoc/templates/eisvogel.latex" ]; then
  pandoc "$TMP_MD" --template eisvogel --pdf-engine=xelatex \
    -V book -V titlepage=true -V toc-own-page=true \
    $META_FLAGS -o "$PDF_OUT" 2>/dev/null || {
    echo "  Eisvogel failed, falling back..."
    pandoc "$TMP_MD" --pdf-engine=xelatex \
      -V documentclass=book $META_FLAGS --toc -o "$PDF_OUT"
  }
else
  pandoc "$TMP_MD" --pdf-engine=xelatex \
    -V documentclass=book $META_FLAGS --toc -o "$PDF_OUT"
fi
echo "       $(du -h "$PDF_OUT" | cut -f1)"

# ── 2. EPUB ──────────────────────────────────
echo "  > EPUB ..."
EPUB_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.epub"
pandoc "$TMP_MD" $META_FLAGS --toc -o "$EPUB_OUT"
echo "       $(du -h "$EPUB_OUT" | cut -f1)"

# ── 3. MOBI from EPUB ────────────────────────
echo "  > MOBI ..."
MOBI_OUT="$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.mobi"
if command -v ebook-convert &>/dev/null; then
  ebook-convert "$EPUB_OUT" "$MOBI_OUT" --output-profile kindle 2>/dev/null && \
    echo "       $(du -h "$MOBI_OUT" | cut -f1)" || \
    echo "       SKIPPED (conversion failed)"
else
  echo "       SKIPPED (ebook-convert not installed)"
fi

# ── 4. HTML ──────────────────────────────────
echo "  > HTML ..."
HTML_OUT="$OUTPUT_DIR/$BOOK_SLUG/index.html"
mkdir -p "$OUTPUT_DIR/$BOOK_SLUG"
pandoc "$TMP_MD" $META_FLAGS --toc --standalone \
  --to html5 --css=../../assets/book.css -o "$HTML_OUT"
echo "       $(du -h "$HTML_OUT" | cut -f1)"

# ── 5. Clean Markdown ────────────────────────
echo "  > Markdown ..."
cp "$TMP_MD" "$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.md"
echo "       $(du -h "$OUTPUT_DIR/$BOOK_SLUG/$BOOK_SLUG.md" | cut -f1)"

rm -f "$TMP_MD"
echo ""
echo "  ok $BOOK_SLUG built"
echo "    $OUTPUT_DIR/$BOOK_SLUG/"
echo "========================================"
echo ""
