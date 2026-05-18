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

## Query Structure

- **CTEs over subqueries** — always. No nested `SELECT` inside a `FROM`.

```sql
WITH completed_orders AS (
    SELECT ...
    FROM fct_orders AS o
    WHERE o.order_status = 'Complete'
)
SELECT ...
FROM completed_orders
```

## Null & Blank Handling

- Wrap any column that could be null, `NaN`, empty string, or blank with `COALESCE`:

```sql
COALESCE(NULLIF(TRIM(column_name), ''), 0)        -- numeric fallback
COALESCE(NULLIF(TRIM(column_name), ''), 'Unknown') -- string fallback
```

- Treat `NaN` as null — use `TRY_CAST` or filter explicitly when working with columns known to contain `NaN` values.

## WHERE Clause Comments

Every non-obvious filter gets an inline comment explaining the business reason:

```sql
WHERE o.order_status = 'Complete'  -- exclude cancelled and in-progress orders
  AND o.order_date >= '2024-01-01' -- current fiscal year only
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
