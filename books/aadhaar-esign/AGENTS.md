# Aadhaar eSign: The Definitive Reference — Book AGENTS.md

This file contains detailed, book-specific instructions for AI agents working on *Aadhaar eSign: The Definitive Reference*. It supplements the root-level AGENTS.md with structural, editorial, and workflow rules specific to this volume.

---

## 1. Book Overview

| Field | Value |
|-------|-------|
| **Title** | Aadhaar eSign: The Definitive Reference |
| **Subtitle** | From Inception to 2026 — Law, Technology, Markets, and Policy |
| **Author** | CashlessConsumer |
| **Compiled** | July 2026 |
| **Status** | Draft — needs structural rewrite (see §5) |
| **Branch** | `book/aadhaar-esign` (merge to main when stable) |
| **Manifest** | `chapter-index.yml` |
| **Chapters** | 13 chapters + frontmatter + appendices + backmatter |
| **Output formats** | PDF, EPUB, MOBI, HTML, Markdown |
| **Audience** | Policy professionals, fintech practitioners, legal researchers, DPI watchers, students of digital governance |

### 1.1 Origin

This book began as a single 1,602-line research markdown file (`aadhaar-esign-research.md` in the author's workspace). It was split into per-chapter files under `manuscript/` and a `chapter-index.yml` was generated. The original monolithic file was then deleted — all editing now happens on the per-chapter files.

**Do NOT recreate a monolithic manuscript.md.** The build script concatenates chapters at build time from the index.

---

## 2. File & Directory Structure

```
books/aadhaar-esign/
├── AGENTS.md                    ← THIS FILE. Book-specific instructions.
├── metadata.yaml                ← YAML frontmatter for pandoc
├── chapter-index.yml            ← Chapter ordering and part structure
├── manuscript.md                ← REMOVED. Do not recreate.
├── manuscript/
│   ├── 00-frontmatter.md        ← Title page, copyright, contents excerpt
│   ├── ch01.md                  ← Chapter 1
│   ├── ch02.md                  ← Chapter 2
│   ├── ...
│   ├── ch13.md                  ← Chapter 13
│   ├── app-appendices.md        ← Appendices (timeline, CA directory, stats, glossary)
│   ├── back-references.md       ← All footnote references
│   ├── 90-about-this-book.md    ← How to read this book (consumer lens disclosure)
│   └── 91-about-the-author.md   ← CashlessConsumer bio
```

### 2.1 Naming Conventions

- **Chapter files**: `chNN.md` where NN is 01–13 (two digits, zero-padded)
- **Frontmatter**: `00-frontmatter.md` — title page, TOC placeholder, copyright
- **Backmatter**: `90-about-this-book.md`, `91-about-the-author.md`
- **Appendices**: `app-appendices.md` (contains all appendices as sections)
- **References**: `back-references.md` — the single source of truth for all `[^n]` references

### 2.2 The Index File (`chapter-index.yml`)

This is the build manifest. It defines the part structure and ordering. Every change to chapters (add, remove, reorder, rename) MUST be reflected in this file. The build script reads it to concatenate files in order.

```yaml
# Structure:
book: 'Aadhaar eSign: The Definitive Reference'
parts:
- title: Part I — Foundations
  chapters:
  - num: 1
    title: 'Genesis: The Legal and Policy Foundation (2000–2014)'
    file: ch01.md
  - ...
- title: Appendices
  files:
  - app-appendices.md
  - back-references.md
- title: Backmatter
  files:
  - 90-about-this-book.md
  - 91-about-the-author.md
```

Key rules:
- `files:` under a part = flat list (for frontmatter, appendices, backmatter — no chapter numbers)
- `chapters:` under a part = numbered sequence with `num:` and `title:`
- The order of parts and files in the index determines the build order
- After editing, re-run `bash scripts/build-book.sh books/aadhaar-esign /tmp/test-build` to verify

---

## 3. Per-Chapter Content Template

Every chapter MUST follow this structure. This is non-negotiable — the build system, the PDF template, and the HTML rendering all assume this layout.

### 3.1 Chapter Title

H2 heading:
```markdown
## Chapter N: Title of Chapter
```

### 3.2 Plain-Language Summary

Immediately after the chapter title. 3–5 sentences, zero jargon, accessible to a smart non-specialist.

```markdown
**In plain language:** [3–5 sentences]
```

### 3.3 Main Body

Sections use H3 (`###`) for the numbered sections (e.g. `### 1.1 The IT Act, 2000`). Within sections:
- **Paragraphs**: Short (3–5 sentences max). One idea per paragraph.
- **Tables**: Use GitHub-flavoured markdown tables for comparative data. Ensure they fit in print (max 6–7 columns).
- **Code blocks**: For API flows, configs, cryptographic params.
- **Blockquotes**: For statutes, court rulings, and key quotes.
- **Bold for key terms**: Define every acronym on first use (e.g. **Digital Signature Certificate (DSC)**).
- **Footnote citations**: Every factual claim gets `[^n]`. See §4.

### 3.4 ELI6 — Explain Like I'm 6 (end of chapter)

This is mandatory. The emoji header `🧒 ELI6 — Explain Like I'm 6` is used in the source, but when building for PDF the emoji is replaced with `[ELI6]` by the preprocessor.

```markdown
### 🧒 ELI6 — Explain Like I'm 6

**What this chapter means in simple words:**
[Plain-language re-explanation — 1 paragraph, conversational, zero jargon]

**✅ What Works Well**

- **[Point]**: [Brief explanation]
- **[Point]**: [Brief explanation]

**❌ What's Wrong or Missing**

- **[Point]**: [Brief explanation]
- **[Point]**: [Brief explanation]
```

Rules for ELI6:
- **✅ must have at least 3 points.** If you can't find 3 genuine positives, you haven't looked hard enough.
- **❌ must have at least 3 points.** If you can't find 3 genuine negatives, you're being tendentious.
- Each bullet must be a **specific, concrete observation** — not vague criticism or boosterism.
- The ELI6 is NOT a summary of the chapter. It's a **critical assessment** through the CashlessConsumer lens (consumer agency, power asymmetries, transparency, inclusion).
- The `✅` and `❌` emoji will be replaced in PDF builds (to `[+]` and `[-]`) — the source should still use them for readability in Markdown.

### 3.5 Chapter Separation

End each chapter with `---` on its own line. The build concatenation adds a blank line between files.

---

## 4. Citations & References

### 4.1 Footnote System

All citations use pandoc-style inline footnotes: `[^n]`. The actual reference text is stored in `back-references.md`.

**Rule: ALL footnote definitions MUST be in `back-references.md`, NOT in individual chapter files.** This is critical because:
1. It prevents duplicate reference numbers across chapters
2. The build script concatenates chapters in order, so footnotes from each chapter would collide if defined per-file
3. You can search `back-references.md` for the highest `[^n]` to find the next available number

### 4.2 Adding a New Citation

1. Find the highest `[^n]` in `back-references.md`
2. Add `[^n+1]: URL-or-text` to the bottom of `back-references.md`
3. Reference it in any chapter as `[^n+1]`
4. Keep references in the order they first appear across the whole book (not per chapter)

### 4.3 Reference Format

Court cases:
```
[^n]: *Case Name v. Opponent* (Year) Volume SCC Page. https://...
```

Statutes:
```
[^n]: Statute Name, Section X, Year. https://...
```

News sources:
```
[^n]: Publication, "Article Title," Date. https://...
```

Data / Reports:
```
[^n]: Organization, Report Title (Year). https://...
```

### 4.4 No Footnotes in Frontmatter

Frontmatter (`00-frontmatter.md`) should not contain `[^n]` references. Copyright, edition info, and disclaimers are plain text.

---

## 5. Current State & Required Rewrite

### 5.1 What Exists

The manuscript was created by extracting chapters from a single research document. Each chapter has:
- ✅ Full technical and legal exposition (detailed, well-cited)
- ✅ ELI6 section with ✅/❌ analysis
- ✅ Consistent heading structure (H2 for chapters, H3 for sections)
- ✅ Comprehensive `back-references.md`

### 5.2 What's Needed (Structural Rewrite)

The book needs to be rewritten from a **consumer-advocacy lens**, not a neutral reference. Specifically:

| Current | Target |
|---------|--------|
| Neutral explainer | CashlessConsumer advocacy lens |
| ELI6 is an appendix to each chapter | Consumer perspective is the primary frame |
| Balance between industry/government/user perspectives | User/consumer perspective gets priority weight |
| "Here's how it works" | "Here's how it works, here's who it serves, and here's who it fails" |
| Descriptive | Analytical + prescriptive (what should change) |
| Each chapter standalone | Cross-chapter narrative arc (consumer journey through eSign) |

### 5.3 Key Editorial Directives

1. **Name power asymmetries.** When a design choice benefits platforms/incumbents at users' expense, say so explicitly. Systems don't have bugs — they have winners and losers.

2. **No marketing fluff.** If a source is a vendor brochure or PR piece, flag it. Do not reproduce uncritical industry narratives. eMudhra's market share is a fact; "eMudhra enables India's digital transformation" is not — it's a PR framing.

3. **Practical orientation.** Every analysis should answer: what does this mean for the person using the system? Not just the policymaker, the CA, or the CEO.

4. **Consent and autonomy as first principles.** Every technical or legal analysis should ask: does this increase or reduce the user's agency? Can the user say no? Can the user revoke? Is the user informed?

5. **Regulatory co-option is a theme.** The RBI's delayed approval of eSign (2015–2017), the sectoral regulator fragmentation, the CCA's narrow technical mandate — these are not accidents. They reflect a pattern of incumbents capturing regulatory processes. Name it.

6. **ELI6 is the thesis, not the appendix.** Eventually, the consumer lens should inform the main body, not just the end-of-chapter assessment. The rewrite should move toward this: lead with the consumer question, then answer it with technical depth.

### 5.4 Specific Gaps to Fill

- [ ] Cross-chapter narrative arc: a reader should feel they're progressing through a story, not reading 13 standalone Wikipedia articles
- [ ] Consumer journey thread: follow a hypothetical borrower through the eSign flow — what can go wrong at each step?
- [ ] Fraud case studies: Byju's eMandate abuse, fake eSign in rural lending, OTP interception attacks — these need dedicated treatment
- [ ] Revocability analysis: the 30-minute window problem and its implications for consumer agency (mentioned in ch03, needs to be a through-line)
- [ ] Comparative regulatory effectiveness: does India's multi-regulator model protect consumers better or worse than eIDAS or US approaches?
- [ ] Enforcement gap: the DPDP Board is not operational — what does this mean in practice for consumers whose e-KYC data is breached?
- [ ] Accessibility audit: how many people can actually complete an eSign flow? (% of population with smartphone, internet, Aadhaar-linked mobile number, literacy)

---

## 6. Editing Workflow

### 6.1 Edit a Chapter

1. Edit the individual file in `manuscript/` (e.g. `ch03.md`)
2. If adding citations, also update `back-references.md`
3. If adding/removing/reordering chapters, update `chapter-index.yml`
4. Build and verify: `bash scripts/build-book.sh books/aadhaar-esign /tmp/test-build`
5. Check the PDF opens and has the right number of pages
6. Check the EPUB renders (open in any reader)
7. Commit and push

### 6.2 Add a New Chapter

1. Create `manuscript/chNN.md` following the template (§3)
2. Add the chapter entry to the appropriate part in `chapter-index.yml`
3. Renumber subsequent chapters if inserting mid-sequence
4. Build and verify
5. Update `AGENTS.md` chapter table if needed

### 6.3 Add a New Part

1. Add a `- title: Part N — Name` block in `chapter-index.yml`
2. Add `chapters:` or `files:` under it
3. Update the root `AGENTS.md` book structure section if the part changes significantly
4. Build and verify

### 6.4 Pre-Merge Checklist

- [ ] All chapters have `**In plain language:**` summary
- [ ] All chapters have `### 🧒 ELI6` block
- [ ] ✅ has ≥3 points, ❌ has ≥3 points
- [ ] No duplicate `[^n]` numbers across the book
- [ ] `back-references.md` has the highest `[^n]` matching what's used in chapters
- [ ] `chapter-index.yml` order matches the intended reading order
- [ ] PDF builds without errors
- [ ] EPUB builds without errors
- [ ] HTML renders correctly
- [ ] All emoji that break LaTeX are handled by the preprocessor (🧒 ✅ ❌ → * [+] [-])
- [ ] No hard tabs in markdown files (use spaces)

---

## 7. Voice & Style Guide

### 7.1 The CashlessConsumer Voice

- **Authoritative but not academic.** Think Stratechery meets plain English. You know the material deeply, but you explain it to someone who doesn't.
- **Direct, not passive.** "The government chose to" not "it was decided that."
- **Opinionated but fair.** The ✅/❌ structure demands genuine balance. Acknowledge where the system works well.
- **Jargon-aware.** Define every acronym on first use. Assume the reader knows nothing about PKI, CCA, DSC, etc. but is smart enough to follow along.
- **First-person is rare.** Use "CashlessConsumer" or the institutional voice. "This book argues that..." not "I think that..."

### 7.2 Prohibited Language

- "Revolutionary," "game-changing," "transformative" (unless quoting someone)
- "Seamlessly" (always a lie)
- "Leverage," "ecosystem" (overused tech jargon)
- "Digital empowerment" without specifying who is empowered and who is disempowered
- Any formulation that treats "the market" or "innovation" as an unqualified good

### 7.3 Preferred Constructions

- Name the actor: "The RBI chose to delay" not "regulatory approval was delayed"
- Name the beneficiary: "This benefits CAs by..." not "this enables efficiency"
- Name the cost: "The user bears the risk of..." not "the system accounts for..."
- Be specific about numbers: "₹3–₹7 per signature" not "fraction of a rupee"
- Use Indian numbering where appropriate: "₹713 crore" with USD equivalent in parentheses

---

## 8. Technical Notes

### 8.1 Emoji Handling

The preprocessor in `scripts/build-book.sh` replaces these emoji before LaTeX rendering:
- `🧒` → `*` (the child emoji, used in ELI6 headers)
- `✅` → `[+]` (check mark)
- `❌` → `[-]` (cross mark)

If you add new emoji to the source, ensure they either survive LaTeX (unlikely) or add them to the preprocessor replacement list.

### 8.2 LaTeX-Unsafe Characters

Avoid these in markdown source (they'll break the PDF build):
- `&`, `%`, `$`, `#`, `_`, `{`, `}`, `~`, `^` outside of code blocks
- If needed, escape them: `\&`, `\%`, etc. — but preferably rephrase to avoid
- Unicode arrows, math symbols, rare Unicode: test in PDF before committing

### 8.3 Build Time

Full build (PDF + EPUB + MOBI + HTML + MD): ~2–3 minutes
- PDF with Eisvogel: ~60–90s (two xelatex passes)
- EPUB: ~10s
- MOBI via calibre: ~20s
- HTML: ~10s

### 8.4 Common Build Failures

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| `Missing character` in xelatex | Emoji or Unicode glyph not in font | Add to preprocessor or use DejaVu fonts |
| `! Package keyval Error: cover-image undefined` | metadata.yaml has `cover-image:` but file missing | Remove from metadata.yaml or create cover |
| `Error producing PDF` with no details | LaTeX compilation error | Check `.log` file or build with `--verbose` |
| `[WARNING] Duplicate identifier` | Two `[^n]` with same number | Find and renumber in `back-references.md` |
| EPUB has no TOC | `--toc` flag missing | Add it to pandoc command |
| HTML has no CSS | CSS path wrong | Check `--css=../../assets/book.css` is correct relative to output dir |

---

## 9. Appendices Structure

The `app-appendices.md` file contains all appendices as H2 sections:

- `## Appendix A: Complete Timeline`
- `## Appendix B: Licensed Certifying Authorities Directory`
- `## Appendix C: Key Statistics Summary`
- `## Appendix D: Glossary`

Each appendix is a separate H2. Do not split into individual files unless the appendix grows beyond ~200 lines.

### 9.1 Glossary Format

```markdown
| Term | Definition |
|------|------------|
| **AA** | Account Aggregator — consent-based financial data sharing framework |
```

### 9.2 Timeline Format

```markdown
| Date | Event |
|------|-------|
| 17 Oct 2000 | IT Act, 2000 enacted; CCA established |
```

---

## 10. Roadmap: Draft → Published Book

| Phase | Status | Tasks |
|-------|--------|-------|
| **v0.1 — Raw research** | ✅ Complete | Single markdown doc, all 13 chapters, citations, appendices |
| **v0.2 — Structural split** | ✅ Complete | Per-chapter files, chapter-index.yml, build pipeline, root AGENTS.md |
| **v0.3 — Consumer lens rewrite** | 🔴 NOT STARTED | Rewrite main body with CashlessConsumer advocacy framing (§5.2) |
| **v0.4 — Narrative arc** | 🔴 NOT STARTED | Add cross-chapter narrative, consumer journey thread, through-lines |
| **v0.5 — Gap filling** | 🔴 NOT STARTED | Fraud cases (§5.4), revocability analysis, accessibility audit, enforcement gap |
| **v0.6 — Professional typesetting** | 🔴 NOT STARTED | Custom cover design, typography refinement, print-ready PDF |
| **v1.0 — First edition** | 🔴 NOT STARTED | All formats passing, editorial review complete, published |

