-- Staging model: orders
-- This model stages raw order data

SELECT
    order_id,
    customer_id,
    product_id,
    order_date,
    quantity,
    unit_price,
    quantity * unit_price AS total_amount
FROM {{ ref('raw_orders') }}

