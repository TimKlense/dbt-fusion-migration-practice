-- Staging model: products
-- This model stages raw product data

SELECT
    product_id,
    product_name,
    category,
    list_price
FROM {{ ref('raw_products') }}

