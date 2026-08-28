{% macro get_order_currency(country_col) %}

    CASE
        WHEN {{ country_col }} = 'USA' THEN 'USD'
        WHEN {{ country_col }} = 'Canada' THEN 'CAD'
        ELSE 'Unknown'
    END

{% endmacro %}
