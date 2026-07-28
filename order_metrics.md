---
name: Order Metrics
description: How order-lifecycle metrics (completion rate, cancellation rate, return rate, fulfillment timing, repeat purchase, order volume trends) are constructed. Use when questions mention orders, completions, cancellations, returns, fulfillment, shipping time, repeat customers, or order volume.
---

# Semantic Model: First Pass Guidance

Before writing SQL for order or user questions, check the **ecommerce metrics** semantic model as a first pass. It contains pre-defined, validated logic for the most common metrics in this domain.

- **Orders view** — use this for order volume, revenue, completion rate, cancellation rate, AOV, and return rate. The metric definitions here are canonical and match the rules in this guide.
- **Users view** — use this for user-level aggregations, repeat purchase behavior, and customer lifetime value cuts.

If the semantic model covers the question, prefer it over writing raw SQL. Fall back to the patterns in this guide when the question requires logic not covered by the model.

---

# Domain Overview

Order analysis tracks the lifecycle of an order from creation through fulfillment, return, or cancellation. The goal is to monitor operational health (completion, cancellation, returns), fulfillment speed, and repeat purchase behavior. For product/category/brand sales cuts, see the Inventory Metrics guide.

- The primary order fact is **`fct_orders`** — one row per order line, with `SALE_PRICE`, lifecycle timestamps (`CREATED_AT`, `SHIPPED_AT`, `DELIVERED_AT`, `RETURNED_AT`), and a line-level `"Status"`.
- The order-header status source of record is **`dim_order_status`** — one row per `ORDER_ID`, SCD Type 1. This is the **only** table that carries the `'Cancelled'` status.
- User context comes from **`dim_users`** joined on `USER_ID`.

---

# Canonical Metrics & Interpretation Rules

Do not redefine or approximate these without explicit user direction.

- **Total Orders:** `COUNT(DISTINCT ORDER_ID)` from `fct_orders`. For status-sensitive counts, join to `dim_order_status` (see Cancellations).
- **Completed Orders:** `COUNT(DISTINCT ORDER_ID)` where `"Status" = 'Complete'` (exact casing, no `'Completed'`).
- **Completion Rate:** Completed orders ÷ all orders created in the period. Use `CREATED_AT` for the denominator window.
- **Cancellation Rate:** `dim_order_status` orders where `STATUS = 'Cancelled'` ÷ all orders in the period. **Always source cancellations from `dim_order_status`**, not `fct_orders`.
- **Total Revenue (strict):** `SUM(SALE_PRICE)` where `"Status" = 'Complete'`.
- **Total Revenue (inclusive):** `SUM(SALE_PRICE)` where `"Status" NOT IN ('Returned')` and excluding cancelled orders via `dim_order_status`. Cancelled order values must be multiplied by `-1` if included.
- **Average Order Value (AOV):** `SUM(SALE_PRICE) / COUNT(DISTINCT ORDER_ID)` on completed orders. Do not use `AVG(SALE_PRICE)` directly — that averages line items, not orders.
- **Time to Ship:** `DATEDIFF('hour', CREATED_AT, SHIPPED_AT)` where `SHIPPED_AT IS NOT NULL`.
- **Time to Deliver:** `DATEDIFF('day', SHIPPED_AT, DELIVERED_AT)` where `DELIVERED_AT IS NOT NULL`.
- **Order Volume Trend:** `COUNT(DISTINCT ORDER_ID)` grouped by `DATE_TRUNC('day' | 'week' | 'month', CREATED_AT)`.
- **Repeat Purchase Rate:** Share of users with `COUNT(DISTINCT ORDER_ID) > 1` over the period.
- **Orders per User:** `COUNT(DISTINCT ORDER_ID) / COUNT(DISTINCT USER_ID)`.
- **Return Rate:** `COUNT(DISTINCT ORDER_ID)` where `"Status" = 'Returned'` (or `RETURNED_AT IS NOT NULL`) ÷ delivered or completed orders in the period. State the denominator explicitly.

---

# Entity Relationships & Join Patterns

- **Order line ↔ Order header status:** Join `fct_orders.ORDER_ID = dim_order_status.ORDER_ID`. Required whenever cancellations are in scope.
- **Orders ↔ Users:** Join `fct_orders.USER_ID = dim_users.ID`.
- **Orders ↔ Inventory (product attributes):** Workspace rule — join on **both** `product_id = product_id` **AND** `inventory_id = id`. Omitting either condition produces 1:many duplication.
- **Grain awareness:** `fct_orders` is line-level; `dim_order_status` is order-level. Always `COUNT(DISTINCT ORDER_ID)` when reporting order counts off `fct_orders`.
- **Campaign <> Users <> Orders:** `dim_campaigns` is at the campaign level and should join to `dim_users` on first_touch_campaign_id or last_touch_campaign_id depending on what the user asks for. Default to last_touch unless otherwise specified and tell the user that's what you did. Then you should join the result to `fct_orders` on user_id to understand campaign attribution to orders.

---

# Schema Preferences for This Domain

- Use **`HEX_APP_DATA.A_TEST_SCHEMA`** exclusively.
- Core tables: **`fct_orders`**, **`dim_order_status`**, **`dim_users`**.
- Only `dim_`/`fct_` prefixed tables are trusted. Never query raw or unprefixed tables.

---

# Domain-Specific Risk Areas

- **Cancellations are missing from `fct_orders`.** The `"Status"` column shows `'None'` for cancelled orders — there is no `'Cancelled'` value on this table. Always source cancellation status from `dim_order_status.STATUS = 'Cancelled'`. Filtering `fct_orders` for `'Cancelled'` silently returns zero rows.
- **Wrong status casing:** `'Complete'` is the only valid completed value — not `'Completed'`. `'Cancelled'` uses British spelling and lives only on `dim_order_status`.
- **Line vs. order grain:** Summing or counting `fct_orders` rows without `DISTINCT ORDER_ID` overstates order counts (multiple line items per order).
- **AOV from `AVG(SALE_PRICE)`:** That returns average line-item price, not average order value. Always divide order-level revenue by distinct order count.
- **Return rate denominator drift:** Stating "return rate" without specifying the denominator (all orders vs. delivered vs. completed) produces inconsistent numbers across analyses. Always declare it.
- **Revenue including returns or cancellations:** Strict revenue uses `'Complete'` only. If cancellations are explicitly included, multiply their `SALE_PRICE` by `-1`.
- **Fulfillment timing nulls:** `SHIPPED_AT`/`DELIVERED_AT`/`RETURNED_AT` are null for orders that haven't reached that stage. Always filter `IS NOT NULL` before computing durations.

---

# Example Questions

- "What's our order completion rate over the last 90 days?"
- "How has cancellation rate trended month-over-month this year?"
- "What share of customers placed more than one order in Q1?"
- "What's the average time from order creation to delivery?"
