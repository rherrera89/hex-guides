# Workspace Rules — Ecommerce Clothing Platform (Demo)

## Semantic-First Policy (CRITICAL)
- The `eCommerce Metrics` semantic project is the default and REQUIRED source
  for all order, revenue, user, retention, and campaign questions.
  - Use `orders_view` for any order-related question.
  - Use `users_view` for any user-related question (retention, repeat
    purchase, demographics, acquisition, campaigns).
- Do NOT write warehouse SQL (SQL cells or ad-hoc queries) without my explicit
  approval. Before proposing SQL, state: (a) what the question needs, (b) why
  the semantic model can't answer it, (c) then wait for me to approve.
- Pre-approved reasons to PROPOSE (still ask first): a metric genuinely absent
  from the model, multi-step retention logic the model can't compose, or a
  data-freshness / max-date check.
- Profiling (row counts, distinct values, date ranges) is not a silent excuse
  to bypass the model — surface the need and ask.

## Business Context
Ecommerce clothing platform. Primary unit of analysis is the order and its line
items. Core concerns: order completions, returns, cancellations, user retention.
This is demo data.

## Endorsed models
- Certified Orders  → order questions → `orders_view`
- Certified Users   → user questions  → `users_view`

## Clarification rules (always ask, never assume)
- "Active users" is ambiguous: purchases only in last 28 days, OR purchases or
  returns in last 28 days? Ask before proceeding.
- If a question is ambiguous about grain, time range, or entity, ask first.

## Charts
- Always build polished charts when I ask questions in Threads.
- Default to bar charts for categorical breakdowns; use line/other only when I
  ask for them.

## Reference
- Main Notion page: https://www.notion.so/hexhq/Distribution-Team-Retro-Returns-Problem-PDP-Improvement-Plan-36d45d6bfe7c8104a4a8d17ed0141ee1

## SQL Fallback Guardrails (only apply if I approve SQL)
- Use `HEX_APP_DATA.A_TEST_SCHEMA` only; only `dim_`/`fct_` prefixed tables.
- Order counts: `COUNT(DISTINCT ORDER_ID)` (fct_orders is line grain).
- Completed orders: `"Status" = 'Complete'` (exact casing — never 'Completed').
- Cancellations come ONLY from `dim_order_status.STATUS = 'Cancelled'`
  (fct_orders has no 'Cancelled' value). Multiply cancelled monetary values by
  -1 if included.
- Revenue defaults to `"Status" = 'Complete'`.
- AOV = order-level revenue / distinct orders (never AVG(SALE_PRICE)).
