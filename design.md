---
name: design.md
description: >
  Workspace design system for Halcyon Systems — a cold, institutional 1990s
  enterprise-data aesthetic. Desaturated greige surfaces, deep slate ink, a
  single muted-teal accent, boxy corners, hard-edged outlines instead of soft
  shadows, and IBM Plex type with monospace data readouts. Apply to every data
  app so generated apps read as sanctioned Halcyon terminals. Tokens left unset
  keep the Hex default.

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

# Boxy and institutional. Controls barely round; pills only for toggles.
rounded:
  base: "2px" # buttons, inputs, cards, tags — crisp, near-square
  pill: "9999px" # toggles and the progress dot only

# Flat by mandate. No soft glows — elevation is a hard hairline outline.
shadow:
  sm: "none" # resting cards sit flat on the surface
  md: "0 0 0 1px rgba(20,32,43,0.12)" # dropdowns, raised panels — crisp outline
  lg: "0 0 0 1px rgba(20,32,43,0.18)" # modals — outline, not a drop shadow
  popover: "0 0 0 1px rgba(20,32,43,0.16)" # popovers, tooltips, menus

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
  semantic color + glyph). Keep the frame flat with a hairline border.
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

## Do / Don't (brand specifics)

**Do** lead each page with the single most important figure, set in mono; round
currency to whole dollars in headlines and show cents only in detail ledgers.
Keep surfaces flat and edges square. Write labels as if they were filed.

**Don't** use soft drop shadows, gradients, or rounded "friendly" corners;
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
