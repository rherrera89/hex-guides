---
name: Order Metrics
description: Order-lifecycle metrics (volume, completion, cancellation, returns,
  fulfillment timing, repeat purchase). Use for questions about orders,
  completions, cancellations, returns, fulfillment, shipping time, or order volume.
---

# Source of truth: the semantic model
Answer order questions from `eCommerce Metrics` → `orders_view`. Do not write
SQL without approval (see workspace Semantic-First Policy).

## Use these pre-built measures (do not re-derive)
- Volume: `total_orders`
- Lifecycle: `completed_orders`, `shipped_orders`, `delivered_orders`,
  `returned_orders`
- Rates: `completion_rate`, `return_rate_vs_completed`,
  `return_rate_vs_delivered`
- Value: `total_revenue`, `avg_order_value`, `customer_ltv`
- Per-user: `orders_per_user`, `unique_customers`
- Fulfillment timing: `avg_time_to_ship_hours`, `avg_time_to_deliver_days`
- Header status (from dim_order_status group): `cancelled_orders`,
  `cancellation_rate`, `processing_status_orders`, `shipped_status_orders`

## Dimensions for grouping/filtering
`created_at`, `order_month`, `status`, plus user demographics via the Users group.
For time trends group by `order_month` (or `created_at` at the needed grain).

## Interpretation notes
- Header status (current state of an order) vs. lifecycle measures ("ever
  reached stage X") are different. `shipped_orders` counts orders ever shipped,
  including delivered/returned. For current status use the header-status group.
- Always state the denominator when quoting a return rate (vs completed vs
  delivered) — both are available as separate measures.

## Only if SQL is approved
See the SQL Fallback Guardrails in the workspace rules for casing, grain, and
cancellation-source rules.
