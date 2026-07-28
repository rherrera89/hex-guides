---
name: Inventory metrics
description: This guide defines how inventory and sales analyses should be constructed, measured, and presented. It governs entity definitions, canonical metrics, join patterns, and edge case handling for this domain.
---

# Domain Overview

Inventory management analysis tracks product-level sales performance, category and brand trends, and the relationship between inventory items and customer orders. The goal is to understand which products drive revenue, monitor sales volume by category, and support merchandising and replenishment decisions.

- The primary inventory entity is **`fct_order_inventory`**, which contains product-level attributes (`PRODUCT_NAME`, `PRODUCT_CATEGORY`, `PRODUCT_BRAND`) and inventory item identifiers.
- The primary transaction source is **`fct_orders`**, which records each order with `SALE_PRICE`, `ORDER_ID`, `USER_ID`, `CREATED_AT`, and status information.
- An order is included in inventory sales analysis when its `"Status"` is **not** `'Cancelled'`. This means completed, pending, and processing orders are all counted for volume and revenue unless otherwise specified. 
- Always review the @project 032YCTy37ZgwQVrOgPuXGS project to see the SQL patterns you can copy.

---

# Canonical Metrics & Interpretation Rules

These are the standard metrics for this domain. Do not redefine or approximate them without explicit user direction.

- **Total Revenue:** `SUM(SALE_PRICE)` from `fct_orders` where `"Status" NOT IN ('Cancelled')`. For strict revenue reporting, further filter to `"Status" = 'Complete'` per workspace rules.
- **Total Orders:** `COUNT(DISTINCT ORDER_ID)` from `fct_orders` where `"Status" NOT IN ('Cancelled')`.
- **Unique Customers:** `COUNT(DISTINCT USER_ID)` from `fct_orders` where `"Status" NOT IN ('Cancelled')`.
- **Average Order Value:** `AVG(SALE_PRICE)` from `fct_orders` where `"Status" NOT IN ('Cancelled')`.
- **Units Sold (per product/category/brand):** `COUNT(*)` from the joined `fct_orders` ↔ `fct_order_inventory` result, grouped by the desired product dimension.
- **Monthly Revenue Trend:** `SUM(SALE_PRICE)` grouped by `DATE_TRUNC('month', CREATED_AT)` from `fct_orders`, excluding cancelled orders.
- **Customer Lifetime Value (lightweight):** Per-user `SUM(SALE_PRICE)`, `COUNT(DISTINCT ORDER_ID)`, and `COUNT(DISTINCT PRODUCT_CATEGORY)` from the joined orders and inventory tables.

---

# Entity Relationships & Join Patterns

Correct joins are critical to avoid duplication and ensure accurate inventory-level metrics.

- **Orders ↔ Inventory:** Join `fct_orders.INVENTORY_ITEM_ID = fct_order_inventory.ID`. This links each order line to its specific inventory item record.
- **Critical workspace join rule:** When joining `fct_orders` to `fct_order_inventory`, always join on **both** `product_id = product_id` **AND** `inventory_id = id`. Omitting either condition produces 1:many duplication and inflated metrics. The Inventory Sales Insights Dashboard currently joins on `INVENTORY_ITEM_ID = ID` alone — verify this produces correct row counts before extending.
- **Cancelled order exclusion:** Always apply `"Status" NOT IN ('Cancelled')` on `fct_orders` when calculating sales metrics. For strict revenue reporting, use `"Status" = 'Complete'`.
- **Product dimensions** (`PRODUCT_NAME`, `PRODUCT_CATEGORY`, `PRODUCT_BRAND`) live on `fct_order_inventory`, not on `fct_orders`. Always join to inventory to access product attributes.

---

# Schema Preferences for This Domain

All tables referenced in this domain must follow workspace-level schema and naming rules.

- Use **`HEX_APP_DATA`** schema exclusively.
- Core tables: **`fct_orders`** (transactions) and **`fct_order_inventory`** (product/inventory attributes).
- **`dim_users`** may be joined via `USER_ID` when customer-level context is needed (e.g., user-level spend analysis).
- Do not use unprefixed or raw tables for inventory analysis under any circumstances.

---

# Domain-Specific Risk Areas

These are concrete anti-patterns specific to inventory and sales analysis.

- **Duplicate rows from incorrect joins:** Joining `fct_orders` to `fct_order_inventory` on `product_id` alone (without the `inventory_id = id` condition) inflates units sold, revenue, and all downstream metrics. Always use the dual-key join pattern.
- **Wrong status string:** Using `'Completed'` instead of `'Complete'` silently returns zero rows. The exact value is `'Complete'`.
- **Unfiltered revenue:** Including cancelled orders in revenue totals overstates actual revenue. Always exclude `'Cancelled'` at minimum; for strict revenue use `'Complete'` only.
- **Missing product dimensions:** Attempting to group by product name, category, or brand without joining to `fct_order_inventory` will fail — these fields do not exist on `fct_orders`.
- **Confusing volume vs. revenue:** Units sold (`COUNT(*)`) and revenue (`SUM(SALE_PRICE)`) answer different questions. High-volume products may not be high-revenue products. Always clarify which metric the analysis requires.
- **Cancelled order values:** When cancelled orders are included in an analysis, their monetary values must be multiplied by **-1** per workspace rules.
