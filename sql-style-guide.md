# SQL & Code Style Guide

Apply these conventions to every SQL query and Python cell you write.

## SQL Formatting

- **Keywords**: Always UPPERCASE — `SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`, `LIMIT`, etc.
- **Commas**: Leading, not trailing

```sql
SELECT
    user_id
  , order_date
  , total_amount
FROM fct_orders AS o
```

- **Table aliases**: Always alias every table. Use short, readable abbreviations (`o` for `fct_orders`, `u` for `dim_users`).
- **No `SELECT *`**: Always name columns explicitly, even in CTEs.

## Query Structure

- **CTEs over subqueries** — always. No nested `SELECT` inside a `FROM`.

```sql
WITH completed_orders AS (
    SELECT
        o.order_id
      , o.user_id
      , o.total_amount
    FROM fct_orders AS o
    WHERE o.order_status = 'Complete'
)
SELECT ...
FROM completed_orders
```

- **Window functions over self-joins** — for running totals, rankings, and lag/lead comparisons, always prefer window functions.

```sql
-- Do this:
SUM(revenue) OVER (PARTITION BY user_id ORDER BY order_date) AS running_total

-- Not this:
SELECT a.revenue + b.revenue ...
FROM fct_orders a JOIN fct_orders b ON ...
```

## Null & Blank Handling

- Wrap any column that could be null, `NaN`, empty string, or blank with `COALESCE`:

```sql
COALESCE(NULLIF(TRIM(column_name), ''), 0)        -- numeric fallback
COALESCE(NULLIF(TRIM(column_name), ''), 'Unknown') -- string fallback
```

- Treat `NaN` as null — use `TRY_CAST` or filter explicitly when working with columns known to contain `NaN` values.

## Type Casting

- Always use explicit `CAST` — never rely on implicit type coercion.

```sql
CAST(order_date AS DATE)
CAST(revenue AS FLOAT)
```

## WHERE Clause Comments

Every non-obvious filter gets an inline comment explaining the business reason:

```sql
WHERE o.order_status = 'Complete'  -- exclude cancelled and in-progress orders
  AND o.order_date >= '2024-01-01' -- current fiscal year only
```

## Exploratory Queries

- Always add `LIMIT 1000` to any query that isn't producing a final output. Never let an exploratory query run unbounded.

```sql
SELECT
    o.order_id
  , o.total_amount
FROM fct_orders AS o
LIMIT 1000
```

## Python Cells

Every Python cell starts with a comment block:

```python
# -------------------------------------------------------
# What this does: [one sentence summary]
# Inputs: [variables or dataframes this cell uses]
# Outputs: [variable or dataframe this cell produces]
# -------------------------------------------------------
```
