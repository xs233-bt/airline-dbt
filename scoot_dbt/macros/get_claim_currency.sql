{% macro get_claim_currency(currency_id) %}

    CASE
        WHEN {{ currency_id }} = 1 THEN 'USD'
        WHEN {{ currency_id }} = 2 THEN 'CAD'
        ELSE 'Unknown'
    END

{% endmacro %}
