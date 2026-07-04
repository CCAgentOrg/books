# Books

Source-controlled manuscripts with automated PDF publishing.

Each book lives in its own directory under `books/` with raw markdown content.
A CI workflow builds PDFs on every push to `main` and publishes them to GitHub Pages.

**Browse the library:** https://srikanthlogic.github.io/books

## Structure

```
books/
├── aadhaar-esign/       # Book 1: Aadhaar eSign
│   ├── manuscript.md    # Full manuscript
│   └── metadata.yaml    # Title, author, config
├── next-book/           # Next book...
│   ├── manuscript.md
│   └── metadata.yaml
└── ...
```

## Workflow

1. Create a branch: `git checkout -b books/your-book-name`
2. Add your manuscript in `books/your-book-name/manuscript.md`
3. Add `metadata.yaml` with title, author, etc.
4. Commit and push
5. Open a PR to `main`
6. Merge → CI builds PDF → Pages updates
