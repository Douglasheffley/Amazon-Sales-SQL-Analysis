SELECT
    a.product_name AS products,
    a.category,
    a.price_usd,
    TO_CHAR(a.yearly_sales, '$999,999,999.00') As yearly_sales,
    ROUND(a.yearly_sales / a.price_usd, 2) AS sales_to_price_ratio
FROM amazonsales a
ORDER BY sales_to_price_ratio DESC;