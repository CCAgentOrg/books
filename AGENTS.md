# Books — Agent Constitution & Ground Rules

## Repository Mission

This repository produces **definitive reference books** on fintech, digital public infrastructure, and consumer finance — written through the **CashlessConsumer lens**: rigorous, independent, pro-consumer, anti-fluff. Every book is designed for two audiences simultaneously: the **mass reader** who needs plain-language clarity, and the **practitioner** who needs technical depth with citations.

## Ground Rules

### 1. The CashlessConsumer Lens

Every book must carry a clear consumer-advocacy perspective. This doesn't mean anti-industry — it means:
- **Name power asymmetries.** When a design choice benefits platforms at users' expense, say so.
- **No marketing fluff.** If a source is a vendor brochure or PR piece, flag it. Do not reproduce uncritical industry narratives.
- **Practical orientation.** What does this mean for the person using the system? Not just the policymaker or the CEO.
- **Consent and autonomy as first principles.** Every technical or legal analysis should ask: does this increase or reduce the user's agency?

### 2. Chapter Structure (Every Chapter)

Every chapter MUST contain:

#### a. Plain-Language Summary (top of chapter)
3–5 sentences, zero jargon. The reader should understand the chapter's essence in 15 seconds. Write this first — it forces clarity.

Format:
```markdown
**In plain language:** [3-5 sentences]
```

#### b. Main Body
Detailed exposition. Use:
- **Headings** (h2/h3) for scannability
- **Tables** for comparative data
- **Code blocks** (where technical — API flows, configs)
- **Blockquotes** for statutes, court rulings, and key quotes

#### c. Balanced Assessment (end of chapter)
Impartial weighing of what works vs. what doesn't. Separate from the plain-language summary — this is analytical, not simplified.

Format:
```markdown
## Assessment

**What works well:**
- Point 1
- Point 2

**What's wrong or missing:**
- Point 1
- Point 2
```

**Key rule:** The assessment must be genuinely balanced. If you can't find a genuine negative, you haven't looked hard enough. If you can't find a genuine positive, you're being tendentious.

#### d. References
Every factual claim gets a numeric footnote citation `[^n]`. References section at the end of each chapter or book. Prefer primary sources (statutes, court rulings, govt data, peer-reviewed papers). Secondary sources (news, analyst reports) are acceptable but must be identified as such.

### 3. Structural Requirements (Per Book)

Every book MUST include:

| Component | Location | Format |
|-----------|----------|--------|
| Title page | Front matter | Cover title, subtitle, author, date, edition |
| Table of contents | After title | Auto-generated from headings |
| Glossary | End matter | A-Z of key terms with 1-sentence definitions |
| Reference list | End matter | Full URLs and access dates for all citations |
| Timeline (if applicable) | End matter | Chronological table of key events |
| Index (if feasible) | End matter | Key terms with page references |

### 4. Output Formats

Every book MUST be built in ALL of these formats:

| Format | Tool | Notes |
|--------|------|-------|
| **PDF** | pandoc + Eisvogel (LaTeX) | Primary review format, book-quality typesetting |
| **EPUB** | pandoc | For Apple Books, Google Play Books, standard readers |
| **MOBI** | calibre (`ebook-convert` from EPUB) | For Kindle |
| **Markdown** | Source (no conversion needed) | GitHub rendering, diffs, collaboration |
| **HTML / Website** | pandoc or custom build | Deployed to GitHub Pages library |

### 5. Versioning & Release

- **Draft status**: Each book metadata.yaml has `status: draft` or `status: published`
- **Edition numbering**: `1.0` for first published, `1.1`, `2.0`, etc.
- **Pull request to main**: Books merge to main only when they compile cleanly in all formats
- **GitHub release**: Each edition gets a tagged release (e.g. `aadhaar-esign-v1.0`)

### 6. The Library Website (`docs/`)

The GitHub Pages site at `https://ccagentorg.github.io/books/` is the public library:

- **SEO requirements**:
  - Semantic HTML (h1-h6 hierarchy, proper `<title>` per page)
  - Meta descriptions on each page
  - Open Graph tags (og:title, og:description, og:image)
  - Twitter Card tags
  - Structured data (JSON-LD for book schema)
  - Sitemap.xml for crawlers
  - robots.txt

- **GEO (Generative Engine Optimization)**:
  - Clear, factual, well-structured content that LLMs can parse
  - Schema.org/Book markup for each book
  - Author metadata (CashlessConsumer)
  - Canonical URLs

- **Library pages**:
  - `/` — Book listing / library homepage with cover cards
  - `/books/aadhaar-esign/` — Per-book detail page with download links
  - `/books/aadhaar-esign/` — Also serves the full HTML version
  - `/books/*.pdf` — PDF downloads
  - `/books/*.epub` — EPUB downloads
  - `/books/*.mobi` — MOBI downloads

### 7. Book Branch Workflow

```
main                  # Latest published versions of all books
  └─ book/aadhaar-esign    # Active development for this book
  └─ book/upi-101          # Future book
  └─ book/...
```

- Each book gets a `book/<slug>` branch
- Work on the branch, PR into main when ready
- Main branch triggers CI: build all books → deploy to Pages
- gh-pages branch: auto-deployed by CI (do not commit manually)

### 8. Writing Style

- **Tone**: Authoritative but not academic. Think Stratechery meets plain English.
- **Audience**: A smart reader who knows nothing about the topic. Define every acronym on first use.
- **Structure**: Short paragraphs (3-5 sentences max). Bullet lists for parallel points. Tables for comparisons.
- **Opinion**: Permitted and expected — but clearly labelled as opinion, not fact.
- **Citations**: Mandatory for all factual claims. No exceptions.

### 9. Quality Checklist (Pre-Merge)

- [ ] Plain-language summary at top of every chapter
- [ ] Balanced assessment at end of every chapter
- [ ] All acronyms defined on first use
- [ ] Every factual claim has a citation
- [ ] Glossary compiled and cross-referenced
- [ ] Timeline compiled (if applicable)
- [ ] All output formats build without errors
- [ ] HTML version renders correctly
- [ ] SEO meta tags present on library page
- [ ] Status in metadata.yaml reflects correct draft state
