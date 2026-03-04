WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),
invoices AS (
    SELECT * FROM {{ ref('stg_invoices') }}
),
fallback AS (
    SELECT * FROM {{ ref('stg_claims_customer') }}
)

SELECT 
    o.order_id,
    c.claim_id,
    q.quote_num,
    COALESCE(cust.customer_name, fallback.claims_customer_name) AS customer_name,
    o.order_date,
    o.order_num,
    o.order_status,
    o.order_amount,
    c.claim_quote_id,
    c.claim_claimcurrency_id,
    CASE
        WHEN v.vendor_country = 'USA' THEN 'USD'
        WHEN v.vendor_country = 'Canada' THEN 'CAD'
        ELSE 'USD'
    END AS order_currency
FROM orders o
LEFT  JOIN {{ source('raw', 'raw_scootaround_claims') }} c
    ON o.order_quote_id = c.claim_quote_id
LEFT JOIN {{ source('raw', 'raw_tbl_quotes') }} q
    ON c.claim_quote_id = q.quote_id
LEFT JOIN invoices i
    ON i.invoice_quote_id = q.quote_id
LEFT JOIN {{ source('raw', 'raw_tbl_customers') }} cust
    ON i.invoice_customerid = cust.customer_id
LEFT JOIN fallback
    ON c.claim_quote_id = fallback.claim_quote_id
LEFT JOIN {{ source('raw', 'raw_tbl_vendors') }} v
    ON o.order_vendor_id = v.vendor_id

{{ config(materialized='table') }}
