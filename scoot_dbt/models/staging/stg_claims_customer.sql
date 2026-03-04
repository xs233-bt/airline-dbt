SELECT
    sc.claim_quote_id,
    tc.customer_name AS claims_customer_name
FROM {{ source('raw', 'raw_scootaround_claims') }} sc
JOIN {{ source('raw', 'raw_tbl_customers') }} tc
    ON sc.claim_airline_id = tc.customer_id
