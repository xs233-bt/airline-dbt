WITH unique_orders AS (
    SELECT DISTINCT order_id, claim_quote_id, order_amount
    FROM {{ ref('stg_base_orders') }}
)
SELECT 
    claim_quote_id,
    SUM(order_amount) AS totalclaimPO
FROM unique_orders
GROUP BY claim_quote_id

{{ config(materialized='table') }}
