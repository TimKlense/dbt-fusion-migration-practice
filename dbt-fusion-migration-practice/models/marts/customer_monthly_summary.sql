-- Model using some deprecated patterns
-- This model demonstrates old dbt patterns that should be migrated

{{ config(
    materialized='table',
    schema='marts'
) }}

-- DEPRECATED: Using adapter_macro pattern (defined in macros/deprecated_macros.sql)
WITH date_truncated AS (
    SELECT
        order_id,
        customer_id,
        -- This would use the deprecated adapter_macro if we called the custom macro
        DATE_TRUNC('month', order_date) AS order_month,
        total_amount
    FROM {{ ref('stg_orders') }}
),

monthly_summary AS (
    SELECT
        customer_id,
        order_month,
        COUNT(*) AS monthly_orders,
        SUM(total_amount) AS monthly_revenue
    FROM date_truncated
    GROUP BY customer_id, order_month
)

SELECT
    c.customer_id,
    c.customer_name,
    m.order_month,
    m.monthly_orders,
    m.monthly_revenue
FROM {{ ref('stg_customers') }} c
INNER JOIN monthly_summary m ON c.customer_id = m.customer_id

