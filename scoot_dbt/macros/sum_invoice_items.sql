-- macros/sum_invoice_items.sql

{% macro sum_invoice_items(product_names, value_column='tii.invoiceitem_total') %}

    SUM(
        CASE
            WHEN tii.invoiceitem_product_name IN (
                {% for product in product_names %}
                    '{{ product }}'
                    {% if not loop.last %}, {% endif %}
                {% endfor %}
            )
            THEN {{ value_column }}
            ELSE 0
        END
    )

{% endmacro %}
