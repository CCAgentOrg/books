# Aadhaar eSign: The Definitive Reference — Contributor Guide

## Status

**Edition:** 1.0 (draft)  
**Compiled:** July 2026  
**Author:** CashlessConsumer  
**Publisher:** CashlessConsumer Research  
**License:** CC BY-NC-SA 4.0

---

## About This Book

This is a comprehensive reference work covering India's Aadhaar eSign ecosystem — the law, the technology architecture, the market structure, adoption data, security and privacy risks, international comparisons, and the road ahead. It is written through the **CashlessConsumer lens**: rigorous, independent, skeptical of corporate spin, and always asking what a design choice means for the end-user.

## How to Contribute

### Workflow

1. All work happens on the `book/aadhaar-esign` branch.
2. Edit individual chapter files under `manuscript/`.
3. Run the build locally to verify: `bash scripts/build-book.sh books/aadhaar-esign`
4. Commit, push, and open a PR to `main`.
5. Merge triggers CI → all formats rebuilt → library site updated.

### Building Locally

```bash
# From repo root
bash scripts/build-book.sh books/aadhaar-esign /tmp/my-build
```

Outputs all formats to `/tmp/my-build/aadhaar-esign/`.

## Chapter Structure

Every chapter consists of per-chapter markdown files in `manuscript/` named `NN-slug.md`.

**Naming convention:**

| File | Content |
|------|---------|
| `00-frontmatter.md` | Title, TOC, edition notes |
| `01-ch1.md` | Chapter 1 |
| `02-ch2.md` | … |
| `13-ch13.md` | Chapter 13 |
| `80-app-timeline.md` | Appendix: Timeline |
| `81-app-providers.md` | Appendix: Provider directory |
| `82-app-stats.md` | Appendix: Key statistics |
| `83-app-glossary.md` | Appendix: Glossary |
| `90-about-this-book.md` | About this book |
| `91-about-the-author.md` | About the author |
| `99-references.md` | Full reference list |

The ordering is controlled by `chapter-index.yml`. Edit that file to reorder, add, or remove chapters.

## Conventions (per AGENTS.md)

Every chapter MUST contain:

1. **Plain-language summary** (top, 3–5 sentences, zero jargon)
2. **Main body** (heads, tables, blockquotes, code blocks)
3. **Balanced assessment** (labelled ✓/✗ analysis at end)
4. **References** (numeric `[^n]` citations throughout)

The **CashlessConsumer lens** means:
- Name power asymmetries between platforms and users
- No marketing fluff or uncritical reproduction of industry narratives
- Consent and autonomy as first principles
- Practical orientation: what does this mean for the person using the system?

## Current Gaps / Work Needed

- [ ] **ELI5 at chapter tops** — Some chapters (especially Part III onward) lack the plain-language summary. This is the highest-priority edit.
- [ ] **Assessment sections** — Not all chapters have the balanced ✓/✗ section at the end. Add them.
- [ ] **Cover image** — Need a cover image for the Eisvogel PDF title page.
- [ ] **Glossary cross-references** — Glossary terms should be cross-linked to first use in each chapter.
- [ ] **Index** — The printed PDF lacks a back-of-book index. Needs tooling (pandoc index generation or custom).
- [ ] **RSS feed** — A per-edition RSS feed for the library site would notify subscribers of updates.

## Key Editing Tools

| Task | Approach |
|------|----------|
| Edit chapter | Edit `manuscript/NN-slug.md` directly |
| Reorder | Update `chapter-index.yml` |
| Add new chapter | Create `manuscript/NN-slug.md` + add to `chapter-index.yml` |
| Add reference | Add `[^n]:` line at chapter bottom or in `99-references.md` |
| Build | `bash scripts/build-book.sh books/aadhaar-esign` |
| Preview PDF | Check `output/aadhaar-esign/aadhaar-esign.pdf` |
| Preview HTML | Open `output/aadhaar-esign/index.html` in browser |

## Publishing

- **PR to `main`** triggers CI
- CI builds all formats using Eisvogel template
- Outputs deploy to `gh-pages` branch → library site
- Each published edition should get a git tag: `aadhaar-esign-v1.0`, `aadhaar-esign-v1.1`, etc.
