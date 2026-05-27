SELECT 
    a.product_name,
    ROUND(AVG(a.yearly_sales / a.price_usd), 2) AS sales_to_price_ratio,
    c.agegroup,
    ROUND(AVG(c.customersatisfactionscore), 1) AS avg_rating
FROM amazonsales a
LEFT JOIN amazondemographics c
    ON a.product_id = c.product_id
GROUP BY 
    a.product_name,
    c.agegroup
ORDER BY 
    sales_to_price_ratio DESC,
    avg_rating DESC;