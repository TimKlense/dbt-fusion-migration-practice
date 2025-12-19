-- Dimension table: customers
-- This model creates the customer dimension with aggregated metrics

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        SUM(total_amount) AS lifetime_value,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date
    FROM {{ ref('stg_orders') }}
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    c.signup_date,
    c.country,
    COALESCE(o.total_orders, 0) AS total_orders,
    COALESCE(o.lifetime_value, 0) AS lifetime_value,
    o.first_order_date,
    o.last_order_date,
    CASE
        WHEN o.lifetime_value > 1000 THEN 'High Value'
        WHEN o.lifetime_value > 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM {{ ref('stg_customers') }} c
LEFT JOIN customer_orders o ON c.customer_id = o.customer_id

