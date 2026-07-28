---
name: User Retention & Activity
description: This guide defines how user retention and activity analyses should be constructed, measured, and presented. It governs entity definitions, canonical metrics, join patterns, and edge case handling for this domain.
---

# Domain Overview

User retention and activity analysis tracks how users engage with the platform over time after their first purchase. The goal is to understand repeat purchasing behavior, identify high-value users, and detect churn.

Always use the Certified_user endorsed tables for these questions.

- The canonical user entity is **`dim_users`**, joined to activity via `USER_ID`.
- The primary activity source is **`fct_orders`**. A user is considered active only if they have a qualifying order.
- A **qualifying order** is one with `order_status = 'Complete'` where `RETURNED_AT` is `NULL` — i.e., the order was not subsequently returned or cancelled. Orders that were completed but later reversed do not count as activity.
- Use the @project 032YCTy37ZgwQVrOgPuXGS project for reference and mirror the SQL used here to calculate this metric

---

# Canonical Metrics & Interpretation Rules

These are the standard metrics for this domain. Do not redefine or approximate them without explicit user direction.

- **Retention (cohort-based):** Group users by the month of their first qualifying order. A user is retained in month N if they have at least one qualifying order in that month. Always default to **monthly** cohorts unless the user requests a different granularity.
- **Churn:** A user is churned if they have no qualifying order in the last **90 days**.
- **Power Purchaser:** A user who completes **more than 3** qualifying orders in a single calendar month. Returned or cancelled orders do not count toward this threshold.
- **Active Users:** Definition is ambiguous — always ask whether the user means active based on **purchases only** or **purchases or returns** in the last 28 days before proceeding.

---

# Entity Relationships & Join Patterns

Correct joins are critical to avoid duplication and ensure accurate user-level metrics.

- **User ↔ Orders:** Join `dim_users.USER_ID = fct_orders.USER_ID`.
- **Qualifying order filter:** Always apply `Status = 'Complete'` AND `RETURNED_AT IS NULL` on `fct_orders` to identify qualifying orders. Orders that were completed then later returned or cancelled must be excluded.
- **`dim_order_status`** is used for order-level summaries and reporting. It is **not** used directly in retention analysis.
- All workspace-level join rules still apply — especially the `fct_orders` ↔ `fct_order_inventory` dual-key join (`product_id` + `inventory_id = id`) if inventory data is incorporated.

---

# Schema Preferences for This Domain

All tables referenced in this domain must follow workspace-level schema and naming rules.

- Use **`HEX_APP_DATA`** schema exclusively.
- Only **`dim_users`**, **`fct_orders`**, and **`dim_order_status`** (when needed for order summaries) are relevant to this domain.
- Do not use unprefixed or raw tables for retention analysis under any circumstances.

---

# Domain-Specific Risk Areas

These are concrete anti-patterns specific to user retention and activity analysis.

- **Counting reversed orders as activity:** If a completed order is later returned or cancelled, it must be excluded. Failing to check `RETURNED_AT` inflates retention rates and power purchaser counts.
- **Including internal users:** Users with emails ending in **`@ourcompany.com`** must be excluded from all retention and activity analyses. Failing to do so contaminates cohort metrics.
- **Missing cohort sizes:** Never present retention rates without accompanying cohort sizes. Small cohorts can produce misleading retention percentages.
- **Assuming "active users" definition:** Presenting active user counts without first clarifying the definition (purchases only vs. purchases + returns) leads to misinterpretation.
- **Wrong status string:** Using `'Completed'` instead of `'Complete'` returns zero rows and silently breaks retention calculations.
