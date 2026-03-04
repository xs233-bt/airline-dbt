SELECT 
    toi.orderitem_order_id,
    array_join(array_distinct(array_agg(toi.orderitem_product_name)), ', ') AS order_equipment_names
FROM {{ source('raw', 'raw_tbl_order_items') }} toi
GROUP BY toi.orderitem_order_id
