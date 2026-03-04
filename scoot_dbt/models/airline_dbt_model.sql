{{ config(materialized='table') }}

select
    'Hello from dbt!' as message


-- Uncomment below to exclude nulls
-- where id is not null
