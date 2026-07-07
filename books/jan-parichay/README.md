# Jan Parichay: The Definitive Reference — Contributor Guide

## Status

**Edition:** 1.0 (draft)
**Compiled:** July 2026
**Author:** CashlessConsumer
**Publisher:** CashlessConsumer Research
**License:** CC BY-NC-SA 4.0

---

## About This Book

A comprehensive reference on India's citizen identity layer — **Jan Parichay (Meri Pehchaan)**, the National Single Sign-On built by MeitY and NIC — with the **Digital Life Certificate (Jeevan Pramaan)** as its central applied case study. It covers the SSO architecture, the life-certificate system, national and state-wise adoption data, and the exclusion, privacy, and governance questions these systems raise.

Written through the **CashlessConsumer lens**: rigorous, independent, skeptical of corporate spin, and always asking what a design choice means for the end-user.

## How to Contribute

1. Work on the `book/jan-parichay` branch.
2. Edit individual chapter files under `manuscript/`.
3. Build locally: `bash scripts/build-book.sh books/jan-parichay /tmp/my-build`
4. Commit, push, open a PR to `main`. Merge triggers CI → all formats → library site.

## Chapter Structure

| File | Content |
|------|---------|
| `00-frontmatter.md` | Title, edition notes |
| `ch01.md` … `ch13.md` | 13 chapters across 5 parts |
| `app-appendices.md` | Timeline, ecosystem directory, key statistics, glossary |
| `back-references.md` | All footnote references |
| `90-about-this-book.md` | About this book |
| `91-about-the-author.md` | About the author |

Ordering is controlled by `chapter-index.yml`.

## Conventions

- Plain-language lead at top of each chapter.
- `### 🧒 ELI6` balanced ✅/❌ assessment at end.
- Citations as `[^n]`, all defined in `back-references.md`.
- Data claims grounded in primary sources; state survey presents fragmented datasets with explicit scope labels (no fabricated unified ranking).

## Publishing

PR to `main` triggers CI → builds all formats (Eisvogel PDF, EPUB, MOBI, HTML, MD) → deploys to `gh-pages` → library site. Tag editions `jan-parichay-v1.0`, etc.
