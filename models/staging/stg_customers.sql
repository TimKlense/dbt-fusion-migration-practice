-- Staging model: customers
-- This model stages raw customer data

SELECT
    customer_id,
    customer_name,
    email,
    signup_date,
    country
FROM {{ ref('raw_customers') }}

