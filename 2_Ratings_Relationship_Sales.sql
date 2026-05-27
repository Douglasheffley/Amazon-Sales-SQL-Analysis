SELECT
    c.customersatisfactionscore AS rating_group,
    COUNT(a.product_id) AS total_products,
    TO_CHAR(ROUND(AVG(a.yearly_sales), 2), '$999,999,999.00') AS avg_yearly_sales,
    ROUND(AVG(a.review_count), 0) AS avg_reviews,
    TO_CHAR(ROUND(AVG(a.price_usd), 2), '$999,999,999.00') AS avg_price
FROM amazonsales a
LEFT JOIN amazondemographics c
    ON a.product_id = c.product_id
GROUP BY c.customersatisfactionscore
ORDER BY avg_yearly_sales DESC;