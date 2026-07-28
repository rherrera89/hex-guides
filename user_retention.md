---
name: User Retention & Activity
description: How user retention and activity analyses are constructed. Use for
  retention, repeat purchase, churn, power purchasers, and active users.
---

# Source of truth: the semantic model
Answer user questions from `eCommerce Metrics` → `users_view`. Do not write SQL
without approval (see workspace Semantic-First Policy).

## Available in users_view
- User demographics/acquisition: `user_id`, `age`, `gender`, `state`, `city`,
  `country`, `traffic_source`, `created_at`, measure `user_count`.
- Per-user order activity (Order Lines group): `total_orders`,
  `completed_orders`, `returned_orders`, `total_revenue`, `avg_order_value`,
  `orders_per_user`, `customer_ltv`, etc.
- Per-user header status (Orders Header group): `cancelled_orders`,
  `cancellation_rate`.
- Campaign attribution: Last Touch (default) and First Touch groups
  (`campaign_name`, `campaign_channel`, `campaign_source`, budgets, etc.).
  Default to last-touch and say so.

## Canonical definitions (ask before deviating)
- Retention: monthly cohorts by month of first qualifying order; retained in
  month N = ≥1 qualifying order that month. Always show cohort sizes.
- Churn: no qualifying order in the last 90 days.
- Power Purchaser: >3 qualifying orders in a single calendar month.
- Active Users: AMBIGUOUS — always ask purchases-only vs purchases-or-returns
  (last 28 days).

## Gaps the model does NOT fully express (require approved SQL)
- "Qualifying order" = `Status = 'Complete'` AND `RETURNED_AT IS NULL`. The
  model's `completed_orders` does NOT exclude later-returned orders, so it is
  not a drop-in for qualifying orders. Flag this and get approval before
  composing cohort/churn/power-purchaser logic in SQL.
- Internal-user exclusion (`email` ending `@ourcompany.com`) is not filtered in
  the model. Apply it when doing retention work; ideally ask the model owner to
  add it as a built-in filter.

## Only if SQL is approved
Follow the SQL Fallback Guardrails in the workspace rules.
