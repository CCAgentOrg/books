#!/bin/bash
# Build all books and deploy to docs/ for GitHub Pages.
set -euo pipefail

OUTPUT_DIR="${1:-output}"
PAGES_DIR="docs/books"

mkdir -p "$OUTPUT_DIR" "$PAGES_DIR"

for book in books/*/; do
  book_name=$(basename "$book")
  echo "=== Building: $book_name ==="
  
  if [ -f "$book/manuscript.md" ] && [ -f "$book/metadata.yaml" ]; then
    ./scripts/build-book.sh "$book" "$OUTPUT_DIR"
    
    # Copy generated PDF to Pages directory
    for pdf in "$OUTPUT_DIR"/*.pdf; do
      [ -f "$pdf" ] && cp "$pdf" "$PAGES_DIR/"
    done
  fi
done

echo "=== All books built. PDFs in $PAGES_DIR/ ==="
ls -lh "$PAGES_DIR"/
