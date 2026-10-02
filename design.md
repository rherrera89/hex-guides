---
name: design.md
description: >
  Workspace design system — a clean, modern pastel aesthetic. Warm off-white
  surfaces, soft ink, a periwinkle accent, and a gentle pastel chart palette
  (periwinkle, rose, mint, apricot, lavender, sky). Rounded corners, airy
  spacing, and soft diffused shadows, set in Inter. Apply to every data app so
  generated apps feel calm, friendly, and current. Tokens left unset keep the
  Hex default.

colors:
  # ── Surfaces ──────────────────────────────────────────────────────────────
  bg: "#FBFAF8" # app/page background — warm off-white, never stark white
  bg-muted: "#F4F2F8" # secondary surface: zebra rows, grouped sections, wells (lavender mist)

  # ── Ink ───────────────────────────────────────────────────────────────────
  text: "#2A2838" # headlines + primary body text — soft plum-charcoal, not black
  text-muted: "#6E6A80" # captions, axis labels, metadata
  text-placeholder: "#A19DB2" # input placeholders, empty-state copy
  text-inverted: "#FFFFFF" # text/icons on the accent fill

  # ── Lines ─────────────────────────────────────────────────────────────────
  border: "#E4E1EC" # card + input borders, dividers
  border-muted: "#EEECF3" # faint internal rules inside tables/forms

  # ── Accent (the single interactive color) ─────────────────────────────────
  # A deeper periwinkle so white text on buttons passes WCAG AA; the pastel
  # tint of it (accent-soft) carries hover states and selected rows.
  accent: "#5B5FC7" # CTAs, links, focus rings
  accent-soft: "#EDEEFC" # hover fills, selected rows, active nav pill
  link: "#5B5FC7" # hyperlink color (same as accent)

  # ── Semantic status (status only, never decoration) ───────────────────────
  success: "#3E9C76" # positive / on-track — mint, deepened for legibility
  success-text: "#226148" # darker success ink, readable on the soft fill below
  danger: "#D0566E" # negative / critical — rose, deepened for legibility
  danger-text: "#962E44" # darker danger ink, readable on the soft fill below
  warning: "#C98A2E" # needs attention — apricot, deepened for legibility

  # Soft pastel fills behind status chips
  intent-success-bg: "#E3F5EC"
  intent-danger-bg: "#FCE8EC"
  intent-warning-bg: "#FDF1DE"
  intent-neutral-bg: "rgba(42,40,56,0.06)"

  # ── App chrome ─────────────────────────────────────────────────────────────
  hex-chrome-bg: "#FBFAF8" # the Hex title bar above the app — matches bg

  # ── Chart palette (categorical, assigned to series in order) ──────────────
  # Mid-tone pastels: soft enough to feel pastel, saturated enough to read as
  # bars and lines on the off-white bg. Neighbors alternate cool/warm so
  # adjacent series stay distinct. viz-9..viz-14 also exist — add only past 8.
  viz-1: "#7C8CF0" # periwinkle (accent family)
  viz-2: "#F28FA5" # rose
  viz-3: "#5CC3A0" # mint
  viz-4: "#F4B266" # apricot
  viz-5: "#A88BE6" # lavender
  viz-6: "#5DB8D6" # sky
  viz-7: "#E59BD0" # orchid
  viz-8: "#B3C76A" # pistachio

typography:
  body:
    family: "'Inter', 'Helvetica Neue', Arial, system-ui, sans-serif"
  mono:
    family: "'JetBrains Mono', ui-monospace, SFMono-Regular, Menlo, monospace" # IDs, codes, SQL
  serif:
    family: "'Fraunces', Georgia, 'Times New Roman', serif" # optional: data-story titles only

  weights:
    normal: 400
    medium: 500
    semibold: 600
    bold: 700

  scale:
    xs: "12px" # small labels, axis ticks
    sm: "13px" # captions, deltas, chart legends
    base: "15px" # body default — slightly larger for an airy read
    lg: "17px" # large body / small section headings
    xl: "20px" # h2
    2xl: "24px" # section titles
    3xl: "30px" # h1
    4xl: "38px" # KPI values, page hero number
    5xl: "52px" # display / hero

  leading:
    tight: "1.2" # headlines, KPI values
    normal: "1.55" # body copy
    relaxed: "1.7" # long-form prose

# 4px grid, generous use of the larger steps.
spacing:
  1: "4px"
  2: "8px"
  3: "12px"
  4: "16px"
  5: "20px"
  6: "24px"
  8: "32px"
  10: "40px"
  12: "48px"
  16: "64px"
  20: "80px"
  24: "96px"

# Soft and rounded, but not bubbly.
rounded:
  base: "12px" # cards, panels, modals
  sm: "8px" # buttons, inputs, dropdowns
  pill: "9999px" # status chips, toggles, filter tags

# Diffused, low-contrast shadows tinted with the ink color — elevation should
# be felt, not seen.
shadow:
  sm: "0 1px 2px rgba(42,40,56,0.04), 0 1px 3px rgba(42,40,56,0.06)" # inputs, small controls
  md: "0 2px 6px rgba(42,40,56,0.04), 0 6px 16px rgba(42,40,56,0.06)" # cards, dropdowns
  lg: "0 8px 24px rgba(42,40,56,0.08), 0 20px 48px rgba(42,40,56,0.10)" # modals
  popover: "0 4px 12px rgba(42,40,56,0.08), 0 12px 32px rgba(42,40,56,0.08)" # menus, tooltips

# Content widths.
layout:
  max: "1200px" # standard dashboards (the default here)
  wide: "1440px" # dense operational hubs
  narrow: "880px" # single-column reports / data stories

# Component theming. Reference tokens with {dot.path} instead of raw values.
components:
  card:
    background: "#FFFFFF"
    border: "1px solid {colors.border}"
    radius: "{rounded.base}"
    padding: "{spacing.6}"
    shadow: "{shadow.md}"
  kpi-card:
    value-size: "{typography.scale.4xl}"
    value-weight: "{typography.weights.semibold}"
    label-size: "{typography.scale.sm}"
    label-color: "{colors.text-muted}"
  button-primary:
    background: "{colors.accent}"
    color: "{colors.text-inverted}"
    radius: "{rounded.sm}"
  button-secondary:
    background: "{colors.accent-soft}"
    color: "{colors.accent}"
    radius: "{rounded.sm}"
  badge-success:
    background: "{colors.intent-success-bg}"
    color: "{colors.success-text}"
    radius: "{rounded.pill}"
  badge-danger:
    background: "{colors.intent-danger-bg}"
    color: "{colors.danger-text}"
    radius: "{rounded.pill}"
---

# Pastel design

Calm, light, and modern. Warm off-white surfaces, white cards that float on
soft shadows, plum-charcoal ink, and a periwinkle accent. Color comes from a
gentle pastel palette used mostly in charts and status chips, so the page
feels fresh without getting loud. Generous whitespace does most of the work:
each page has one hero figure, one primary action, and supporting detail that
stays quiet.

## Voice & feel

Friendly, clear, and concise. Plain-language headings ("How revenue is
trending", "Top customers this month") over jargon. Currency in `USD`, dates as
`Oct 2, 2026` in prose and `2026-10-02` in tables, numbers localized `en-US`.
No emoji as data indicators, no gradients on text, no neon or fully saturated
colors.

## Color usage

- **Accent** (periwinkle `#5B5FC7`) carries interaction: primary buttons, links,
  focus rings. Use `accent-soft` for hover, selected rows, and the active nav
  item. One primary button per view.
- **Pastels live in data, not chrome.** Keep backgrounds, cards, and text
  neutral. Color shows up in charts, status chips, and small highlights.
- **Text** is plum-charcoal. Don't use pure black anywhere, and don't set body
  copy in a pastel. Pastels fail contrast as text; use the `*-text` inks.
- **Semantic colors** (mint, rose, apricot) are deepened versions of the
  pastels so they stay legible. Pair them with a `▲`/`▼` glyph so the meaning
  survives for color-blind viewers.
- **Chart palette** (`viz-1…`) is for categories. Assign in order and keep a
  field's color the same across every chart in the app. For sequential data,
  build a single-hue ramp from `accent-soft` to `accent` rather than mixing
  pastels.

## Typography

Inter for the interface, JetBrains Mono for IDs, codes, and SQL. Fraunces is
optional and only for the title of a long-form data story. KPI values use `4xl`
at `semibold`. Bold reads heavy against pastels. Use sentence case for headings
and buttons.

## Layout & density

- Default to the `max` shell (1200px). Use `wide` only for dense ops views and
  `narrow` for reports.
- Separate page sections by `spacing.12`. Space cards within a section by
  `spacing.5`. Pad cards with `spacing.6`.
- KPI rows: 3–4 cards across on desktop, stacking below 768px.
- Let pages breathe. When in doubt, add space rather than a divider.

## Components

- **Cards:** white on the off-white `bg`, 1px `border`, `rounded.base`, `md`
  shadow. Never nest a shadowed card inside another one. Inner groups use
  `bg-muted` with no shadow.
- **KPI cards:** label (caption, `text-muted`) · value (`4xl`, semibold) · delta
  chip (pill, semantic soft fill + ink + glyph). An optional 4px top border in
  the card's series color ties it to its chart.
- **Tables:** no outer border. Header row in `text-muted`, `sm`, medium weight.
  Rows separated by `border-muted` hairlines, hover in `accent-soft`. Right-align
  numbers, left-align text, `mono` for IDs.
- **Charts:** legend on top, light horizontal gridlines in `border-muted`, no
  vertical gridlines. Rounded bar ends (4px), 2px lines with round caps, and
  area fills at ~20% opacity of the series color. Data labels only when there
  are fewer than ~8 marks. Most-recent time on the right.
- **Inputs & filters:** a horizontal filter bar above the content it controls.
  White inputs, `rounded.sm`, `sm` shadow, 1px `border`. On focus, use a 3px ring
  in `accent-soft` with an `accent` border. Filter tags are pills in `bg-muted`.
- **Status chips:** pill shape, pastel soft fill + darker ink, sentence-case
  short labels ("On track", "At risk", "Behind").
- **Empty / error states:** always present and sized to the content they
  replace. Say what's missing and what to do next, in a warm, plain sentence.
  A soft pastel illustration or icon is welcome here.
- **Loading:** skeleton blocks in `bg-muted` with a slow, subtle shimmer. No
  spinners on content areas.

## Do / Don't

**Do** lead each page with its most important number. Round currency to whole
dollars in headlines and show cents only in detail tables. Keep chrome
neutral and let the pastel palette color the data. Use soft shadows and
rounded corners consistently.

**Don't** use hard black borders, heavy drop shadows, or square corners. Don't
fill large areas (headers, page backgrounds) with saturated color or more than
one pastel. Don't put pastel text on a white background. Don't use 3D charts or
legends on the side, and don't introduce a fourth typeface.

## Light mode only

This theme is designed for light surfaces. Don't author a separate dark theme;
the app stays light even if the viewer's OS is in dark mode.

## How to use this file

Apply the tokens above to the app's theme, then build every component with
them. Never hardcode a color, font, size, radius, or shadow. The token names
are the contract: keep them as written so the built-in components inherit the
theme. Follow the prose sections above when laying out pages, choosing chart
treatments, and writing UI copy.
