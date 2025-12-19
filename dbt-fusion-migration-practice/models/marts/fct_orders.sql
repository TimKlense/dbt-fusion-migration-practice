-- Fact table: orders
-- This model creates the order fact table with customer and product details

SELECT
    o.order_id,
    o.customer_id,
    c.customer_name,
    c.country,
    o.product_id,
    p.product_name,
    p.category,
    o.order_date,
    o.quantity,
    o.unit_price,
    o.total_amount,
    p.list_price,
    (p.list_price - o.unit_price) AS discount_amount,
    CASE
        WHEN (p.list_price - o.unit_price) > 0 THEN TRUE
        ELSE FALSE
    END AS was_discounted
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_customers') }} c ON o.customer_id = c.customer_id
LEFT JOIN {{ ref('stg_products') }} p ON o.product_id = p.product_id

