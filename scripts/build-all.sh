#!/bin/bash
# Build all books in all output formats + generate library.
set -euo pipefail

OUTPUT_DIR="${1:-output}"
mkdir -p "$OUTPUT_DIR"

for book in books/*/; do
  if [ -f "$book/manuscript.md" ]; then
    bash scripts/build-book.sh "$book" "$OUTPUT_DIR"
  fi
done

echo ""
echo "=== Generating library site ==="
mkdir -p docs/books docs/assets
cp -r "$OUTPUT_DIR"/* docs/books/ 2>/dev/null || true
cp assets/* docs/assets/ 2>/dev/null || true

python3 scripts/generate-library.py "$OUTPUT_DIR"
python3 scripts/update-books-json.py "$OUTPUT_DIR" docs

echo "=== Library generated in docs/ ==="
echo "  docs/index.html"
echo "  docs/books.json"
echo "  docs/feed.xml"
echo "  docs/books/*.pdf .epub .mobi .html .md"
# Trigger build
