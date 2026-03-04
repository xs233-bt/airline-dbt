SELECT *
FROM {{ source('raw', 'raw_tbl_orders') }}
WHERE COALESCE(order_status, 0) NOT IN (9)
  AND CAST(order_date AS DATE) BETWEEN DATE '2025-06-01' AND DATE '2025-06-30'
