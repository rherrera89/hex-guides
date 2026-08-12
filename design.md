---
name: design.md
description: >
  Workspace design system for Halcyon Systems — a cold, institutional 1990s
  enterprise-data aesthetic. Desaturated greige surfaces, deep slate ink, a
  single muted-teal accent, square corners, and hard 3D bevels (never soft
  shadows). Ships an inline SVG wordmark, a custom pixel cursor, and barber-pole
  loading bars, set in IBM Plex with monospace data readouts. Apply to every
  data app so generated apps read as sanctioned Halcyon terminals. Tokens left
  unset keep the Hex default.

colors:
  # ── Surfaces (the fluorescent-lit office) ─────────────────────────────────
  bg: "#EFF1EE" # app/page background — cold institutional greige, not pure white
  bg-muted: "#E7EAE6" # secondary surface: zebra rows, grouped sections, wells

  # ── Ink ───────────────────────────────────────────────────────────────────
  text: "#14202B" # headlines + primary body text — deep slate navy, near-black
  text-muted: "#5C6B72" # captions, axis labels, metadata, record annotations
  text-placeholder: "#8A9AA0" # input placeholders, empty-state copy
  text-inverted: "#FFFFFF" # text/icons on the teal accent fill

  # ── Lines ─────────────────────────────────────────────────────────────────
  border: "#C4CCC9" # hairlines, dividers, card + input borders
  border-muted: "#D7DDDA" # faint internal rules inside dense tables/forms

  # ── Accent (the single interactive color) ─────────────────────────────────
  accent: "#0E7A87" # CTAs, links, focus rings, selected rows — muted terminal teal
  link: "#0E7A87" # hyperlink color (same as accent)

  # ── Semantic status (status only, never decoration) ───────────────────────
  success: "#4A7C59" # compliant / on-plan status — desaturated institutional green
  success-text: "#2E5A3F" # darker success ink, readable on the soft fill below
  danger: "#A83232" # non-compliant / critical status — muted corporate brick red
  danger-text: "#7F2422" # darker danger ink, readable on the soft fill below
  warning: "#B0801E" # advisory / under review — muted brass amber

  # Soft background fills behind status tags / chips
  intent-success-bg: "#E9F0EB"
  intent-danger-bg: "#F6EAEA"
  intent-warning-bg: "#F4EEDC"
  intent-neutral-bg: "rgba(20,32,43,0.06)"

  # ── App chrome ─────────────────────────────────────────────────────────────
  hex-chrome-bg: "#EFF1EE" # the Hex title bar above the app — matches bg

  # ── Chart palette (categorical, assigned to series in order) ──────────────
  # Cold, institutional, desaturated. Led by the accent teal and kept distinct
  # from the semantic greens/reds above so a chart never implies judgment.
  # Color-blind safe. viz-9..viz-14 also exist — add only past 8 series.
  viz-1: "#0E7A87" # accent teal
  viz-2: "#2C4A63" # slate navy
  viz-3: "#4E6E7E" # steel blue
  viz-4: "#9C7A3C" # brass / ochre
  viz-5: "#5B4E7A" # muted indigo
  viz-6: "#7A8B94" # cold gray
  viz-7: "#3D8C8C" # desaturated cyan (the terminal color, dimmed)
  viz-8: "#86664F" # taupe

typography:
  body:
    family: "'IBM Plex Sans', 'Helvetica Neue', Arial, system-ui, sans-serif"
  mono:
    family: "'IBM Plex Mono', ui-monospace, SFMono-Regular, Menlo, monospace" # IDs, codes, SQL, KPI readouts
  serif:
    family: "'IBM Plex Serif', Georgia, 'Times New Roman', serif" # editorial titles on records/stories

  weights:
    normal: 400
    medium: 500
    semibold: 600
    bold: 700

  scale:
    xs: "11px" # small labels, axis ticks, record IDs
    sm: "13px" # captions, deltas, chart legends
    base: "14px" # body default — a touch tighter for dense corporate copy
    lg: "16px" # large body / small section headings
    xl: "20px" # h2
    2xl: "24px" # section titles
    3xl: "30px" # h1
    4xl: "36px" # KPI values, page hero number
    5xl: "48px" # display / record hero

  leading:
    tight: "1.15" # headlines, KPI readouts
    normal: "1.5" # body copy
    relaxed: "1.6" # long-form prose

# 4px grid. Standard corporate density.
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

# Square by mandate — Windows-95-era GUI. Nothing rounds.
rounded:
  base: "0px" # buttons, inputs, cards, tags — hard 90-degree corners
  pill: "9999px" # reserved for genuine toggles only; status uses squared tags

# Beveled, never blurred. Elevation is a hard 3D bevel (light top-left, dark
# bottom-right), the way a 1990s GUI raised a control — no soft drop shadows.
# Sunken wells/inputs invert this bevel; see "Window chrome & bevels" below.
shadow:
  sm: "inset 1px 1px 0 0 #FFFFFF, inset -1px -1px 0 0 #9AA5A1" # subtle raised edge
  md: "inset 1px 1px 0 0 #FFFFFF, inset -1px -1px 0 0 #6E7A76, inset 2px 2px 0 0 #D7DDDA, inset -2px -2px 0 0 #9AA5A1" # raised panels, buttons, dropdowns, cards
  lg: "0 0 0 2px #14202B, inset 1px 1px 0 0 #FFFFFF, inset -1px -1px 0 0 #6E7A76, inset 2px 2px 0 0 #D7DDDA, inset -2px -2px 0 0 #9AA5A1" # modals — raised panel inside a hard frame
  popover: "inset 1px 1px 0 0 #FFFFFF, inset -1px -1px 0 0 #6E7A76, inset 2px 2px 0 0 #D7DDDA, inset -2px -2px 0 0 #9AA5A1" # menus/tooltips pop raised

# Content widths. These apps skew wide and operational.
layout:
  max: "1200px" # standard dashboards
  wide: "1440px" # dense operational hubs (the default here)
  narrow: "960px" # single-column records / data stories

# Component theming that expresses the boxy, flat, institutional look.
# Reference tokens with {dot.path} instead of repeating raw values.
components:
  card:
    background: "{colors.bg}"
    border: "1px solid {colors.border}"
    radius: "{rounded.base}"
    padding: "{spacing.6}"
  kpi-card:
    value-size: "{typography.scale.4xl}"
    value-weight: "{typography.weights.bold}"
    label-size: "{typography.scale.sm}"
    label-color: "{colors.text-muted}"
  button-primary:
    background: "{colors.accent}"
    color: "{colors.text-inverted}"
    radius: "{rounded.base}"
  badge-success:
    background: "{colors.intent-success-bg}"
    color: "{colors.success-text}"
    radius: "{rounded.base}" # squared status tags, not pills
  badge-danger:
    background: "{colors.intent-danger-bg}"
    color: "{colors.danger-text}"
    radius: "{rounded.base}"
---

# Halcyon Systems design

A sanctioned enterprise terminal, not a consumer dashboard. Cold, orderly, and
faintly clinical: greige surfaces under fluorescent light, deep slate ink, hard
rectangular edges, and one disciplined teal accent. The interface should feel
issued rather than designed — every screen a record, every number accountable.
Whitespace is generous but the density is corporate; the eye lands on one hero
figure, one sanctioned action, and supporting data that stays quietly in ledger.

## Voice & feel

Precise, procedural, numbers-first — no marketing warmth, no exclamation.
Currency in `USD`, dates as `YYYY-MM-DD` (ISO, systematic), numbers localized
`en-US`. Label sections like filed records ("Quarterly Reconciliation",
"Compliance Summary") rather than friendly headings. Avoid gradients, glows,
rounded friendliness, emoji, and any ornament that undercuts the institutional
tone.

## Color usage

- **Accent** (muted teal) is the _only_ color that carries interaction — CTAs,
  links, focused inputs, selected rows. Use it once per viewport, deliberately.
  It reads as the terminal's live channel, so don't spend it on decoration.
- **Text** is deep slate navy; reserve pure black for chart axes only.
- **Semantic colors** mark compliance and variance — on-plan, non-compliant,
  under-review — never decoration. Pair red/green with a `▲`/`▼` glyph so the
  meaning survives for color-blind viewers and in grayscale printouts.
- **Chart palette** (`viz-1…`) is for _categories_. Assign in order and hold a
  field's color constant across every chart in the app. For sequential data,
  derive a single-hue scale from the accent teal instead of reusing the
  categorical hues.

## Typography

IBM Plex throughout. `body` (Plex Sans) runs the interface; `mono` (Plex Mono)
is the house voice for anything a system would emit — record IDs, codes, SQL,
and **KPI readouts** (set hero figures in mono so they read as instrument
output). `serif` (Plex Serif) is reserved for editorial titles on records and
data stories. Headlines lead, body supports, captions annotate. KPI numbers use
the `4xl` size at `bold`.

## Layout & density

- Favor the `wide` shell (1440px) for operational hubs; `max` (1200px) for
  standard dashboards; `narrow` (960px) for single-column records.
- Separate page sections by `spacing.10`; cards within a section by `spacing.4`.
- Grid everything. Align to columns hard — ragged layouts read as unofficial.
- KPI rows: 3–4 cards across on desktop, stacking below 768px.
- Vary section heights deliberately — don't stack five identical panels.

## Components

- **KPI cards:** label (caption) · value (`4xl`, bold, `mono`) · delta (caption,
  semantic color + glyph). Raise the card with the `md` bevel — square, no blur.
- **Chrome, logo, cursors, loading:** see the dedicated sections below — every
  app wears the title bar, wordmark, pixel cursor, and beveled controls by
  default.
- **Tables:** the primary surface — treat them as ledgers. Sticky header,
  right-align numbers, left-align text, `mono` for IDs and codes, zebra rows via
  `bg-muted`, thin `border-muted` rules. Dense over airy.
- **Charts:** legend on top, horizontal gridlines only, no data labels unless the
  chart has fewer than ~8 marks, most-recent time on the right. No 3D, no
  drop-shadowed bars.
- **Inputs & filters:** a horizontal filter bar above the content it governs;
  square 2px corners; focus ring in accent teal.
- **Status tags:** squared (not pills), semantic fill + darker ink, uppercase
  short labels ("COMPLIANT", "UNDER REVIEW", "FLAGGED").
- **Empty / error states:** always present, sized to the content they replace;
  state what record is missing and what to do — phrased as a system notice, not
  an apology.

## Logo & wordmark

Every app carries the Halcyon Systems wordmark, top-left in the title bar: an
IBM-style striped block (a punch-card mark) beside a stacked monospace wordmark
with the registered mark. Render it **inline as SVG** so it stays crisp and
themable — never a raster. Ready asset:

```svg
<svg viewBox="0 0 232 40" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Halcyon Systems">
  <g fill="#0E7A87">
    <rect x="0" y="5"  width="30" height="4"/>
    <rect x="0" y="12" width="30" height="4"/>
    <rect x="0" y="19" width="30" height="4"/>
    <rect x="0" y="26" width="22" height="4"/>
    <rect x="0" y="33" width="14" height="4"/>
  </g>
  <text x="42" y="22" font-family="'IBM Plex Mono', monospace" font-size="19" font-weight="700" letter-spacing="1.5" fill="#14202B">HALCYON</text>
  <text x="42" y="35" font-family="'IBM Plex Mono', monospace" font-size="9"  letter-spacing="4"   fill="#5C6B72">SYSTEMS  ®</text>
</svg>
```

- Clear space around the mark equals the height of the striped block.
- On the accent-teal title bar, swap both text inks to `text-inverted` and the
  stripes to `#FFFFFF`.
- Favicon / avatar variant: the striped block alone, on `bg`.
- Footer lockup on every page: `HALCYON SYSTEMS® · EST. 1994 · INTERNAL USE ONLY`
  in `xs` mono, `text-muted`.

## Cursors

The pointer is part of the era. Apply a pixel arrow as the default cursor on the
app root, and switch by context the way a period OS did:

```css
/* app root */
cursor: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16'%3E%3Cpath d='M1 1 L1 12 L4 9 L6 14 L8 13 L6 8 L10 8 Z' fill='%2314202B' stroke='%23FFFFFF'/%3E%3C/svg%3E") 1 1, auto;
```

- Links & buttons: `pointer`.
- Data / selectable table cells: `cell` (the plus reticle).
- Editable inputs: `text`.
- Loading or disabled during a run: `progress`; full-screen block: `wait`.

Keep the custom image ≤16px with the `auto` fallback so it degrades cleanly.

## Loading & progress

Loads are shown, never hidden — a running job is the whole point of a terminal.
Two treatments, both mono-captioned, uppercase:

**Indeterminate — barber pole.** A sunken track of animated diagonal teal
stripes, captioned `WORKING…`:

```css
.hx-progress-indeterminate {
  height: 18px;
  box-shadow: inset 1px 1px 0 0 #6E7A76, inset -1px -1px 0 0 #FFFFFF; /* sunken */
  background-image: repeating-linear-gradient(45deg, #0E7A87 0 10px, #0B5F69 10px 20px);
  background-size: 28px 100%;
  animation: hx-barber 0.6s linear infinite;
}
@keyframes hx-barber { from { background-position: 0 0 } to { background-position: 28px 0 } }
```

**Determinate — segmented meter.** A sunken well of discrete blocks that fill
left-to-right, with a mono percentage `LOADING…  47%`. Filled block = `accent`,
empty = `border-muted`, 2px gaps, hard corners, no smooth easing — blocks snap.

- A blinking block caret `▓` may trail an in-progress figure or the `WORKING…`
  label — only there, never as decoration.
- Full-page loads get a centered raised (`md` bevel) panel: the barber-pole bar
  plus a single line of status text.

## Window chrome & bevels

Frame apps like a period desktop application.

- **Title bar:** full-width top bar in `accent` teal, `text-inverted` wordmark
  at left and the page/record title at right. Squared, `md`-beveled.
- **Menu strip (optional):** a mono row under the title bar mapped to real nav —
  `FILE   VIEW   RECORDS   REPORTS   HELP`. Uppercase, `sm`, letter-spaced.
- **Bevels are the elevation language.** Raised controls use the `md` bevel;
  **sunken** surfaces — inputs, data wells, table bodies, progress tracks —
  invert it:
  `box-shadow: inset 1px 1px 0 0 #6E7A76, inset -1px -1px 0 0 #FFFFFF, inset 2px 2px 0 0 #9AA5A1, inset -2px -2px 0 0 #D7DDDA;`
  Buttons depress on `:active` by swapping raised → sunken.
- **Status bar:** fixed bottom strip of sunken mono fields, e.g.
  `READY  │  RECORDS: 1,204  │  2026-08-12  │  ▓ SECURE CHANNEL`. The right-most
  field mirrors app state (READY / WORKING… / DONE).
- **Optional dither:** a faint 2px checker on `bg-muted` behind empty regions for
  the tiled-desktop feel — texture, not pattern.

## Do / Don't (brand specifics)

**Do** lead each page with the single most important figure, set in mono; round
currency to whole dollars in headlines and show cents only in detail ledgers.
Raise controls with hard bevels and keep every edge square. Show the title bar,
wordmark, and status bar on every app. Write labels as if they were filed.

**Don't** use soft/blurred drop shadows, gradients, or rounded "friendly" corners;
don't use stacked bar/area charts for distinct counts; don't place chart legends
on the sides; don't introduce a fourth typeface or use emoji as data indicators;
don't spend the accent teal on anything non-interactive.

## Light mode only

Halcyon ships light only — the fluorescent-office surface is the brand. Don't
author a separate dark theme; the app stays light even if the viewer's OS is in
dark mode.

## How to use this file

Apply the tokens above to the app's theme, then build every component with them —
never hardcode a color, font, size, radius, or shadow. The token names are the
contract: keep them as written so the built-in components inherit the brand.
Honor the brand rules in the prose sections above when laying out pages, choosing
chart treatments, and writing UI copy.
