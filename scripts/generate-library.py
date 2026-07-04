#!/usr/bin/env python3
"""Generate the library landing page (SEO-optimised HTML) from built books."""
import json, os, sys
from datetime import datetime

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "output"
INDEX_PATH = sys.argv[2] if len(sys.argv) > 2 else "docs/index.html"

books = []
for slug in os.listdir(OUTPUT_DIR):
    meta_path = os.path.join(OUTPUT_DIR, slug, "metadata.json")
    pdf_path = os.path.join(OUTPUT_DIR, slug, f"{slug}.pdf")
    if not os.path.isfile(meta_path):
        # Try reading from books/ dir instead
        src_meta = os.path.join("books", slug, "metadata.yaml")
        if os.path.isfile(src_meta):
            import yaml
            with open(src_meta) as f:
                meta = yaml.safe_load(f) or {}
        else:
            continue
    else:
        with open(meta_path) as f:
            meta = json.load(f)

    books.append({
        "slug": slug,
        "title": meta.get("title", slug),
        "subtitle": meta.get("subtitle", ""),
        "author": meta.get("author", "CashlessConsumer"),
        "description": meta.get("description", ""),
        "topics": meta.get("tags", []),
        "has_pdf": os.path.exists(os.path.join(OUTPUT_DIR, slug, f"{slug}.pdf")),
        "has_epub": os.path.exists(os.path.join(OUTPUT_DIR, slug, f"{slug}.epub")),
        "has_mobi": os.path.exists(os.path.join(OUTPUT_DIR, slug, f"{slug}.mobi")),
        "has_html": os.path.exists(os.path.join(OUTPUT_DIR, slug, "index.html")),
        "has_md": os.path.exists(os.path.join(OUTPUT_DIR, slug, f"{slug}.md")),
    })

books.sort(key=lambda b: b["title"])

# Schema.org structured data for SEO
schema_org = {
    "@context": "https://schema.org",
    "@type": "Collection",
    "name": "CashlessConsumer Books",
    "author": {"@type": "Person", "name": "CashlessConsumer"},
    "description": "Independent research on fintech, digital public infrastructure, and consumer rights.",
}

html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CashlessConsumer Books — Research Library</title>
<meta name="description" content="Independent research library covering fintech, digital public infrastructure, UPI, Aadhaar eSign, ONDC, and consumer rights in India's digital economy.">
<meta name="keywords" content="fintech, digital public infrastructure, DPI, UPI, Aadhaar, eSign, ONDC, India, CashlessConsumer">
<meta name="author" content="CashlessConsumer">
<link rel="canonical" href="https://ccagentorg.github.io/books/">
<meta property="og:title" content="CashlessConsumer Books — Research Library">
<meta property="og:description" content="Independent research on fintech, DPI, and consumer rights.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://ccagentorg.github.io/books/">
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="CashlessConsumer Books">
<meta name="twitter:description" content="Independent research on fintech, DPI, and consumer rights.">
<script type="application/ld+json">
{json.dumps(schema_org, indent=2)}
</script>
<style>
  *, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{ font-family: Georgia, 'Times New Roman', serif; background: #faf8f5; color: #1a1a1a; line-height: 1.7; }}
  .container {{ max-width: 960px; margin: 0 auto; padding: 2rem 1.5rem; }}
  header {{ border-bottom: 2px solid #d4a574; padding-bottom: 1.5rem; margin-bottom: 2rem; }}
  h1 {{ font-size: 2rem; font-weight: 700; color: #2d1b0e; }}
  .subtitle {{ color: #666; font-size: 0.95rem; margin-top: 0.3rem; }}
  .book {{ background: #fff; border: 1px solid #e0d5c8; border-radius: 8px; padding: 1.5rem; margin-bottom: 1.5rem; }}
  .book h2 {{ font-size: 1.3rem; color: #2d1b0e; margin-bottom: 0.3rem; }}
  .book h2 a {{ color: #8b4513; text-decoration: none; }}
  .book h2 a:hover {{ text-decoration: underline; }}
  .book-meta {{ font-size: 0.85rem; color: #888; margin-bottom: 0.5rem; }}
  .book-desc {{ color: #444; margin-bottom: 0.75rem; }}
  .formats {{ display: flex; gap: 0.5rem; flex-wrap: wrap; }}
  .formats a {{ display: inline-block; padding: 0.25rem 0.75rem; font-size: 0.8rem; border-radius: 4px; background: #f0ebe4; color: #555; text-decoration: none; border: 1px solid #ddd; }}
  .formats a:hover {{ background: #d4a574; color: #fff; border-color: #d4a574; }}
  .tags {{ margin-top: 0.5rem; }}
  .tag {{ display: inline-block; font-size: 0.75rem; padding: 0.15rem 0.5rem; border-radius: 3px; background: #e8e0d6; color: #666; margin-right: 0.3rem; }}
  .rss-sub {{ margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #e0d5c8; font-size: 0.9rem; color: #666; }}
  footer {{ margin-top: 3rem; padding-top: 1.5rem; border-top: 1px solid #e0d5c8; font-size: 0.85rem; color: #999; }}
</style>
</head>
<body>
<div class="container">
<header>
  <h1>📚 CashlessConsumer Books</h1>
  <p class="subtitle">Independent research on fintech, digital public infrastructure, and consumer rights.</p>
</header>

<main>
"""

for b in books:
    title = b["title"]
    desc = b.get("description", "")
    topics = b.get("topics", [])
    html += f'<article class="book">\n'
    html += f'  <h2><a href="books/{b["slug"]}/">{title}</a></h2>\n'
    if b.get("subtitle"):
        html += f'  <p class="book-meta">{b["subtitle"]}</p>\n'
    if desc:
        html += f'  <p class="book-desc">{desc}</p>\n'
    html += f'  <div class="formats">\n'
    if b["has_pdf"]:
        html += f'    <a href="books/{b["slug"]}/{b["slug"]}.pdf" download>PDF</a>\n'
    if b["has_epub"]:
        html += f'    <a href="books/{b["slug"]}/{b["slug"]}.epub" download>EPUB</a>\n'
    if b["has_mobi"]:
        html += f'    <a href="books/{b["slug"]}/{b["slug"]}.mobi" download>MOBI</a>\n'
    if b["has_html"]:
        html += f'    <a href="books/{b["slug"]}/">Read Online</a>\n'
    if b["has_md"]:
        html += f'    <a href="books/{b["slug"]}/{b["slug"]}.md" download>Markdown</a>\n'
    html += f'  </div>\n'
    if topics:
        html += f'  <div class="tags">\n'
        for t in topics:
            html += f'    <span class="tag">{t}</span>\n'
        html += f'  </div>\n'
    html += f'</article>\n'

html += """
</main>

<div class="rss-sub">
  <p>📖 All books available as PDF, EPUB, MOBI, HTML, and Markdown source.</p>
  <p>🔍 Research compiled from primary sources, court rulings, regulatory filings, and industry data.</p>
</div>

<footer>
  <p>By CashlessConsumer • <a href="https://github.com/CCAgentOrg/books">Source Repository</a></p>
</footer>

</div>
</body>
</html>
"""

os.makedirs(os.path.dirname(INDEX_PATH), exist_ok=True)
with open(INDEX_PATH, "w") as f:
    f.write(html)
print(f"Generated: {INDEX_PATH}")
