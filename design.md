---
name: design.md
description: >
  Workspace design system — the Hex brand theme. Dark Obsidian surfaces, Opal
  ink, a Rose quartz accent, and a gemstone chart palette (rose quartz, jade,
  amethyst, citrine, sugilite, cement) taken from the Hex Media Kit. Set in
  GT Cinetype with PP Formula for display type. Apply to every data app so
  generated apps look and feel like Hex. Tokens left unset keep the Hex
  default.

colors:
  # ── Surfaces ──────────────────────────────────────────────────────────────
  bg: "#14141C" # app/page background — Obsidian
  bg-muted: "#24242F" # secondary surface: zebra rows, wells inside cards (lifted Obsidian)

  # ── Ink ───────────────────────────────────────────────────────────────────
  text: "#FBF9F9" # headlines + primary body text — Opal
  text-muted: "#A0A7BC" # captions, axis labels, metadata — lifted Cement (7.6:1 on bg)
  text-placeholder: "#717A94" # input placeholders, empty-state copy — Cement
  text-inverted: "#14141C" # text/icons on the Rose quartz accent fill — Obsidian

  # ── Lines ─────────────────────────────────────────────────────────────────
  border: "#2E2E3A" # card + input borders, dividers
  border-muted: "#22222C" # faint internal rules inside tables/forms

  # ── Accent (the single interactive color) ─────────────────────────────────
  # Rose quartz is Hex's signature color. Obsidian text on it is 11.5:1.
  accent: "#F5C0C0" # CTAs, links, focus rings — Rose quartz
  accent-soft: "rgba(245,192,192,0.14)" # hover fills, selected rows, active nav pill
  link: "#F5C0C0" # hyperlink color (same as accent)

  # ── Semantic status (status only, never decoration) ───────────────────────
  success: "#5CB198" # positive / on-track — Jade
  success-text: "#8FD6BE" # lighter Jade ink, readable on the soft fill below
  danger: "#E8747C" # negative / critical — derived coral; the brand has no red
  danger-text: "#F4A3A8" # lighter danger ink, readable on the soft fill below
  warning: "#CDA849" # needs attention — Citrine

  # Soft tinted fills behind status chips
  intent-success-bg: "rgba(92,177,152,0.16)"
  intent-danger-bg: "rgba(232,116,124,0.16)"
  intent-warning-bg: "rgba(205,168,73,0.16)"
  intent-neutral-bg: "rgba(251,249,249,0.08)"

  # ── App chrome ─────────────────────────────────────────────────────────────
  hex-chrome-bg: "#14141C" # the Hex title bar above the app — matches bg

  # ── Chart palette (categorical, assigned to series in order) ──────────────
  # The Media Kit gemstones. Sugilite and Cement are lifted for viz-5/viz-6 so
  # they read against Obsidian; the raw brand values follow as viz-7/viz-8
  # for low-emphasis series. viz-9..viz-14 also exist — add only past 8.
  viz-1: "#F5C0C0" # Rose quartz (accent family)
  viz-2: "#5CB198" # Jade
  viz-3: "#A477B2" # Amethyst
  viz-4: "#CDA849" # Citrine
  viz-5: "#8B7FCC" # Sugilite, lifted
  viz-6: "#A0A7BC" # Cement, lifted
  viz-7: "#5F509D" # Sugilite (brand)
  viz-8: "#717A94" # Cement (brand)

typography:
  body:
    family: "'GT Cinetype', 'Inter', 'Helvetica Neue', Arial, system-ui, sans-serif"
  display:
    family: "'PP Formula', 'Inter Tight', 'Inter', 'Helvetica Neue', Arial, sans-serif" # page titles, KPI values, hero numbers
  mono:
    family: "'GT Cinetype Mono', 'JetBrains Mono', ui-monospace, SFMono-Regular, Menlo, monospace" # IDs, codes, SQL

  weights:
    normal: 400
    medium: 500
    semibold: 600
    bold: 700

  scale:
    xs: "12px" # small labels, axis ticks
    sm: "13px" # captions, deltas, chart legends
    base: "15px" # body default
    lg: "17px" # large body / small section headings
    xl: "20px" # h2
    2xl: "24px" # section titles
    3xl: "30px" # h1
    4xl: "38px" # KPI values, page hero number
    5xl: "52px" # display / hero

  leading:
    tight: "1.15" # headlines, KPI values
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

# Crisp, lightly rounded corners.
rounded:
  base: "8px" # cards, panels, modals
  sm: "6px" # buttons, inputs, dropdowns
  pill: "9999px" # status chips, toggles, filter tags

# On a dark ground, elevation comes from lighter surfaces and borders more than
# shadow. Shadows stay deep and soft.
shadow:
  sm: "0 1px 2px rgba(0,0,0,0.30)" # inputs, small controls
  md: "0 2px 8px rgba(0,0,0,0.35)" # cards, dropdowns
  lg: "0 12px 32px rgba(0,0,0,0.45)" # modals
  popover: "0 6px 20px rgba(0,0,0,0.45)" # menus, tooltips

# Content widths.
layout:
  max: "1200px" # standard dashboards (the default here)
  wide: "1440px" # dense operational hubs
  narrow: "880px" # single-column reports / data stories

# Component theming. Reference tokens with {dot.path} instead of raw values.
components:
  card:
    background: "#1C1C26"
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

# Hex brand design

Apps should look like Hex: dark Obsidian surfaces, Opal type, and Rose quartz
as the one signature color. The gemstone palette (Jade, Amethyst, Citrine,
Sugilite, Cement) colors the data, so the page stays calm while the charts
carry the color. Each page has one hero figure, one primary action, and
supporting detail that stays quiet.

Source: the Hex Media Kit (Brand Design → Media Kit → Colors, and PP Formula &
GT Cinetype).

## Voice & feel

Confident, clear, and concise. Use plain-language headings ("How revenue is
trending", "Top customers this month") over jargon. Currency in `USD`, dates as
`Oct 2, 2026` in prose and `2026-10-02` in tables, numbers localized `en-US`.
No emoji as data indicators, and no gradients on body text.

## Color usage

- **Accent** (Rose quartz `#F5C0C0`) carries interaction: primary buttons,
  links, and focus rings. Primary buttons use Obsidian text. Use `accent-soft`
  for hover, selected rows, and the active nav item. One primary button per
  view.
- **Gemstones live in data, not chrome.** Keep backgrounds, cards, and text
  neutral (Obsidian, Opal, Cement). Color shows up in charts, status chips, and
  small highlights.
- **Text** is Opal on Obsidian. Use `text-muted` (lifted Cement) for secondary
  copy; raw Cement is for placeholders only. Never put body copy in a gemstone
  color.
- **Semantic colors:** Jade for good, Citrine for caution. The brand has no
  red, so `danger` is a derived coral that sits alongside Rose quartz without
  being confused for it. Pair status colors with a `▲`/`▼` glyph so the
  meaning survives for color-blind viewers.
- **Chart palette** (`viz-1…`) is for categories. Assign in order and keep a
  field's color the same across every chart in the app. For sequential data,
  build a single-hue ramp from `accent-soft` to `accent` rather than mixing
  gemstones. Raw Sugilite (`viz-7`) is too dark to use for thin lines or small
  marks on Obsidian. Use it only for large fills.

## Typography

GT Cinetype for the interface and body copy. PP Formula for display type: page
titles, section titles, KPI values, and hero numbers. GT Cinetype Mono for IDs,
codes, and SQL. These are licensed brand fonts; when they aren't available,
the fallbacks (Inter, Inter Tight, JetBrains Mono) keep the same proportions.
KPI values use `4xl` at `semibold` in the display face. Use sentence case for
headings and buttons.

## Layout & density

- Default to the `max` shell (1200px). Use `wide` only for dense ops views and
  `narrow` for reports.
- Separate page sections by `spacing.12`. Space cards within a section by
  `spacing.5`. Pad cards with `spacing.6`.
- KPI rows: 3–4 cards across on desktop, stacking below 768px.
- Let pages breathe. When in doubt, add space rather than a divider.

## Components

- **Cards:** `#1C1C26` on the Obsidian `bg`, 1px `border`, `rounded.base`,
  `md` shadow. Never nest a shadowed card inside another one. Inner groups use
  `bg-muted` with no shadow.
- **KPI cards:** label (caption, `text-muted`) · value (`4xl`, semibold, display
  face) · delta chip (pill, semantic soft fill + ink + glyph). An optional 2px
  top border in the card's series color ties it to its chart.
- **Tables:** no outer border. Header row in `text-muted`, `sm`, medium weight.
  Rows separated by `border-muted` hairlines, hover in `accent-soft`.
  Right-align numbers, left-align text, `mono` for IDs.
- **Charts:** legend on top, light horizontal gridlines in `border`, no
  vertical gridlines. 2px lines with round caps, area fills at ~20% opacity of
  the series color. Data labels only when there are fewer than ~8 marks.
  Most-recent time on the right.
- **Inputs & filters:** a horizontal filter bar above the content it controls.
  Inputs on `bg-muted`, `rounded.sm`, 1px `border`. On focus, use a 3px ring in
  `accent-soft` with an `accent` border. Filter tags are pills in `bg-muted`.
- **Status chips:** pill shape, tinted soft fill + lighter ink, sentence-case
  short labels ("On track", "At risk", "Behind").
- **Empty / error states:** always present and sized to the content they
  replace. Say what's missing and what to do next, in a plain sentence.
- **Loading:** skeleton blocks in `bg-muted` with a slow, subtle shimmer. No
  spinners on content areas.

## Do / Don't

**Do** lead each page with its most important number. Round currency to whole
dollars in headlines and show cents only in detail tables. Keep chrome neutral
and let the gemstone palette color the data. Use Rose quartz sparingly so it
stays the signature.

**Don't** use pure black (`#000`) or pure white (`#FFF`); use Obsidian and Opal.
Don't fill large areas (headers, page backgrounds) with Rose quartz or any
gemstone. Don't put Sugilite or Cement text on Obsidian. Don't use 3D charts or
legends on the side, and don't introduce a typeface outside the three above.

## Dark mode only

This theme is designed for dark Obsidian surfaces, matching the Hex brand.
Don't author a separate light theme; the app stays dark even if the viewer's
OS is in light mode.

## How to use this file

Apply the tokens above to the app's theme, then build every component with
them. Never hardcode a color, font, size, radius, or shadow. The token names
are the contract: keep them as written so the built-in components inherit the
theme. Follow the prose sections above when laying out pages, choosing chart
treatments, and writing UI copy.
