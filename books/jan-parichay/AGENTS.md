# Jan Parichay: The Definitive Reference — Book AGENTS.md

Book-specific instructions for AI agents working on *Jan Parichay: The Definitive Reference*. Supplements the root `AGENTS.md` with structure, editorial, and workflow rules specific to this volume.

---

## 1. Book Overview

| Field | Value |
|-------|-------|
| **Title** | Jan Parichay: The Definitive Reference |
| **Subtitle** | India's Citizen Identity Layer and the Pensioner Life Certificate (2014-2026) |
| **Author** | CashlessConsumer |
| **Compiled** | July 2026 |
| **Status** | Draft (first full draft complete) |
| **Branch** | `book/jan-parichay` (merge to main when stable) |
| **Manifest** | `chapter-index.yml` |
| **Chapters** | 13 chapters + frontmatter + appendices + backmatter |
| **Output formats** | PDF, EPUB, MOBI, HTML, Markdown |
| **Audience** | Policy professionals, fintech practitioners, legal researchers, DPI watchers, pension rights advocates, students of digital governance |

### 1.1 Scope

This book covers India's citizen identity layer — Jan Parichay (Meri Pehchaan), the National Single Sign-On built by MeitY and NIC — with the **Digital Life Certificate (Jeevan Pramaan)** as its central applied case study. The book explains the SSO, then zooms into the life certificate: what it is, how it works, the national and state adoption data, and the exclusion, privacy, and governance questions it raises.

---

## 2. File & Directory Structure

```
books/jan-parichay/
├── AGENTS.md                    ← THIS FILE
├── metadata.yaml                ← YAML frontmatter for pandoc
├── chapter-index.yml            ← Chapter ordering and part structure
├── README.md                    ← Contributor guide
├── manuscript/
│   ├── 00-frontmatter.md        ← Title page, copyright
│   ├── ch01.md … ch13.md        ← Chapters
│   ├── app-appendices.md        ← Appendices (timeline, ecosystem, stats, glossary)
│   ├── back-references.md       ← All [^n] footnote references (single source of truth)
│   ├── 90-about-this-book.md
│   └── 91-about-the-author.md
```

---

## 3. Per-Chapter Content Template

Every chapter follows this structure (mirrors the `aadhaar-esign` volume):

- H1 title: `# Chapter N: Title`
- `**In plain language:**` lead (3-5 sentences, zero jargon)
- Main body in H3 sections (`### N.1 ...`), short paragraphs, tables for data, blockquotes for statutes
- `### 🧒 ELI6 — Explain Like I'm 6` at the end with a one-paragraph plain re-explanation, then `**✅ The Positive**` and `**❌ The Negative**` each with >=3 specific bullets
- End with `---`

The build preprocessor converts 🧒 → `*`, ✅ → `[+]`, ❌ → `[-]` for the PDF.

---

## 4. Citations & References

- All citations use pandoc inline footnotes `[^n]`.
- ALL footnote definitions live in `back-references.md` (numbers run sequentially across the whole book; current max is [^30]).
- When adding a citation: find the highest `[^n]`, add `[^n+1]` to `back-references.md`, reference it anywhere.
- Every factual claim gets a citation. Prefer primary sources (MeitY/NIC/DoPPW/UIDAI portals, PIB, court/CAG) over vendor or secondary.
- Format: `Organization, "Title," Date. URL` or `URL — Description`.

---

## 5. Voice & Style

- **CashlessConsumer lens**: independent, pro-consumer, anti-fluff. Name power asymmetries (who benefits, who bears risk), flag vendor/PR framings, prioritise user agency.
- Define every acronym on first use (e.g. **Digital Life Certificate (DLC)**).
- Use Indian numbering (crore, lakh) with context.
- Avoid marketing words ("seamless", "transformative", "empowerment" without naming who is empowered/disempowered).
- LaTeX-unsafe characters to avoid in prose: `% & $ # _ { } ~ ^`. Write "per cent" not "%". The preprocessor handles the emoji.

---

## 6. Build & Verify

```bash
cd repo
bash scripts/build-book.sh books/jan-parichay /tmp/jp-build
```

Check: PDF builds, EPUB builds, HTML renders, no duplicate `[^n]`, `back-references.md` max matches usage.

---

## 7. Roadmap

| Phase | Status | Tasks |
|-------|--------|-------|
| v0.1 — Research + draft | ✅ Complete | 13 chapters, appendices, references, glossary |
| v0.2 — Build verification | ✅ In progress | Run build, fix LaTeX/footnote errors |
| v0.3 — Consumer-lens polish | 🔴 Not started | Tighten ✅/❌ balance, add state case studies |
| v0.4 — PR / publish | 🔴 Not started | Open PR to main, CI builds, deploy |
