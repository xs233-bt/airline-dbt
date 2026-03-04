WITH claim_equipment AS (
    SELECT 
        ce.claimequipment_claim_id,
        array_join(array_agg(ec.equipment_category_name), ', ') AS claim_equipment_names
    FROM {{ source('raw', 'raw_scootaround_claim_equipments') }} ce
    JOIN {{ source('raw', 'raw_scootaround_equipment_categories') }} ec 
        ON ce.claimequipment_equipmentcategory_id = ec.equipment_category_id
    GROUP BY ce.claimequipment_claim_id
)


SELECT 
    sbo.claim_id, 
    sbo.quote_num,  
    sbo.order_date, 
    sbo.order_num, 
    sbo.order_amount,
    sbo.customer_name,
    sbo.order_status,
    CASE 
        WHEN sbo.claim_claimcurrency_id = 1 THEN 'USD'
        WHEN sbo.claim_claimcurrency_id = 2 THEN 'CAD'
        ELSE 'Unknown'
    END AS claim_currency,
    sbo.order_currency,
    ce.claim_equipment_names,
    soi.order_equipment_names,
    scp.totalclaimPO
FROM {{ ref('stg_base_orders') }} sbo
LEFT JOIN {{ ref('stg_order_items') }} soi 
    ON soi.orderitem_order_id = sbo.order_id
LEFT JOIN {{ ref('stg_claim_po') }} scp 
    ON scp.claim_quote_id = sbo.claim_quote_id
LEFT JOIN claim_equipment ce 
    ON ce.claimequipment_claim_id = sbo.claim_id

{{ config(materialized='table') }}
