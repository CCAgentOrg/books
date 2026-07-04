#!/usr/bin/env python3
"""Scan books/ directory and produce books.json + RSS feed for the library site."""
import json, os, sys, hashlib
from datetime import datetime, timezone

def main():
    books_dir = sys.argv[1] if len(sys.argv) > 1 else 'books'
    output_dir = sys.argv[2] if len(sys.argv) > 2 else 'docs'

    books = []
    for entry in sorted(os.listdir(books_dir)):
        book_dir = os.path.join(books_dir, entry)
        meta_file = os.path.join(book_dir, 'metadata.yaml')
        if not os.path.isdir(book_dir) or not os.path.isfile(meta_file):
            continue
        meta = {}
        with open(meta_file) as f:
            for line in f:
                if ':' in line:
                    k, v = line.split(':', 1)
                    meta[k.strip()] = v.strip().strip('"').strip("'")

        slug = entry
        title = meta.get('title', slug)
        description = meta.get('description', '')
        subtitle = meta.get('subtitle', '')
        status = meta.get('status', 'draft')
        date = meta.get('date', '')

        formats = []
        url_base = f'https://ccagentorg.github.io/books'
        for ext, label in [('pdf', 'PDF'), ('epub', 'EPUB'), ('mobi', 'MOBI'), ('html', 'Read Online')]:
            fpath = os.path.join(output_dir, 'books', slug, f'{slug}.{ext}')
            if os.path.isfile(fpath):
                formats.append({'label': label, 'url': f'{url_base}/books/{slug}/{slug}.{ext}'})

        # Also check markdown
        md_path = os.path.join(output_dir, 'books', slug, f'{slug}.md')
        if os.path.isfile(md_path):
            formats.append({'label': 'Markdown', 'url': f'{url_base}/books/{slug}/{slug}.md'})

        books.append({
            'slug': slug,
            'title': title,
            'subtitle': subtitle,
            'description': description,
            'status': status,
            'date': date,
            'formats': formats
        })

    os.makedirs(output_dir, exist_ok=True)
    with open(os.path.join(output_dir, 'books.json'), 'w') as f:
        json.dump(books, f, indent=2)
    print(f"books.json: {len(books)} books indexed")

    # Generate RSS feed
    rss_items = []
    for b in books:
        pub_date = b.get('date') or datetime.now(timezone.utc).strftime('%Y-%m-%d')
        rss_items.append(f"""    <item>
      <title>{b['title']}</title>
      <description>{b['description']}</description>
      <link>https://ccagentorg.github.io/books/</link>
      <guid isPermaLink="false">{b['slug']}-{hashlib.md5(b['title'].encode()).hexdigest()[:8]}</guid>
      <pubDate>{pub_date}</pubDate>
    </item>""")

    rss = f"""<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>CashlessConsumer Books — New Releases</title>
    <link>https://ccagentorg.github.io/books/</link>
    <description>New book releases from CashlessConsumer's independent DPI reference library</description>
    <language>en</language>
    <atom:link href="https://ccagentorg.github.io/books/feed.xml" rel="self" type="application/rss+xml"/>
{chr(10).join(rss_items)}
  </channel>
</rss>"""

    with open(os.path.join(output_dir, 'feed.xml'), 'w') as f:
        f.write(rss)
    print(f"feed.xml: {len(books)} entries")

if __name__ == '__main__':
    main()
