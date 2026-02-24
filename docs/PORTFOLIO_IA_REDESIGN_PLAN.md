# Portfolio IA Redesign Plan

## Goal
Make the portfolio easier to understand in under 60 seconds for recruiters, hiring managers, and technical leads, while reducing maintenance overhead from a large static-page set.

## Current State (observed)
- `89` HTML pages total.
- `41` project detail pages (`project-*.html`).
- `12` demo pages (`*-demo.html` / demo-like pages).
- `8` long-form article pages (`article-*.html`).
- Multiple navigation systems coexist:
  - per-page inline nav
  - page-specific sidebars
  - `global-sidebar.js`
- Duplicate/legacy routes still present (for example `blog.html` vs `blog-articles.html`, `about.html` redirect page, `projects-new.html`).

## External User Perspective (unbiased)
- First impression: strong technical depth and output volume.
- Friction: too many entry points with equal visual weight, unclear "start here" path, and repeated navigation patterns.
- Result: power users can explore deeply; time-constrained recruiters may miss your strongest work.

## Target Information Architecture
Use one primary nav and three audience routes.

### Primary Nav (site-wide)
- `Home`
- `Projects`
- `Case Studies` (optional label: keep as `Projects` if you want fewer items)
- `Articles`
- `Resume`
- `Contact`

### Home Page Sections (single-scroll narrative)
- Value proposition (who you are, what outcomes you deliver)
- 3 flagship case studies (with measurable outcomes)
- Core capability matrix (Platform, Cloud, CI/CD, Observability, Security)
- Selected demos (2-4 only)
- Proof strip (certifications, clients, metrics, links)
- CTA block (`View Resume`, `Book Intro`, `See All Projects`)

### Projects Structure
- `/projects` as canonical listing with filters by:
  - `Platform Engineering`
  - `Cloud Architecture`
  - `CI/CD & Delivery`
  - `Observability & Reliability`
  - `Security & Secrets`
- Each project card includes:
  - business problem
  - architecture snapshot
  - outcome metrics
  - stack
  - links (repo/demo/writeup)

### Content Consolidation
- Keep `blog-articles.html` as canonical articles index.
- Retire or redirect `blog.html` to `blog-articles.html`.
- Keep cloud pages (`aws/azure/gcp`) only if they serve distinct buyer intent; otherwise merge into one `cloud-solutions` hub with tabs.
- Keep demos discoverable from project pages instead of standalone top-level nav destinations.

## URL and Canonical Policy
- Define one canonical URL per content item.
- Keep old routes but 301 redirect to canonical pages.
- Ensure sitemap only includes canonical pages.

## Navigation Standardization
- Make `global-sidebar.js` (or a new shared header/footer include) the single source of truth.
- Remove per-page bespoke nav markup over time.
- Add breadcrumb standard to all project/article detail pages:
  - `Home > Projects > [Project Name]`
  - `Home > Articles > [Article Name]`

## Portfolio Content Model (recommended even for static hosting)
Move authoring to content-driven generation while staying static at deploy-time.

### Suggested model
- `content/projects/*.md` (frontmatter + markdown)
- `content/articles/*.md`
- `content/demos/*.md`
- shared templates/layout components

### Why
- easier updates
- less drift across pages
- better SEO consistency
- safer refactors

## Recommended Stack Migration Path
Keep static hosting; upgrade authoring system.

### Option A (recommended): Astro
- Excellent static output + content collections.
- Good for case-study heavy sites.
- Easy component reuse.

### Option B: Eleventy
- Minimal and fast.
- Strong markdown/content workflows.

## Rollout Plan

### Phase 1 (1-2 days) - IA cleanup without framework migration
- Freeze nav labels and primary route set.
- Add canonical tags + redirect map for duplicate pages.
- Reduce homepage links to top-priority paths only.
- Keep `Projects`, `Articles`, `Resume`, `Contact` as primary conversion paths.

### Phase 2 (2-4 days) - Content hierarchy hardening
- Re-rank projects into:
  - flagship (6-8)
  - strategic (10-12)
  - archive (rest)
- Update `/projects` to default to flagship first.
- Ensure every flagship project has metrics + architecture + outcome.

### Phase 3 (1-2 weeks) - Static generator migration
- Port core layouts.
- Migrate project/article content to structured files.
- Generate pages from templates.
- Keep existing slugs with redirects.

### Phase 4 - Optimization
- Add search/filter index.
- Add analytics funnels (home -> projects -> resume/contact).
- Add structured data for person/project/article.

## Success Metrics
- Time-to-first-meaningful-understanding <= 60s on home.
- Decrease bounce on `/projects`.
- Increase clicks to `resume-ats.html` and `contact.html`.
- Fewer orphan pages and duplicate nav systems.

## Immediate Next Step (highest ROI)
Implement a "Flagship Projects" experience first:
- Select top 6-8 projects.
- Move them to top of `projects.html` with outcome metrics.
- Demote remaining items into expandable "More Work" sections.

This gives clarity quickly without a full rewrite.
