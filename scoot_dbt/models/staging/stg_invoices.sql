SELECT *
FROM {{ source('raw', 'raw_tbl_invoices') }}
WHERE COALESCE(invoice_status, 0) NOT IN (9)
