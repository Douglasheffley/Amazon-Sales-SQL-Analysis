SELECT
    a.product_name,
    c.purchasechannel,
    c.region,
    TO_CHAR(ROUND(AVG(a.yearly_sales), 2), '$999,999,999.00') AS avg_yearly_sales,
    RANK() OVER (ORDER BY AVG(a.yearly_sales) DESC) AS sales_rank
FROM amazonsales a
LEFT JOIN amazondemographics c
    ON a.product_id = c.product_id
GROUP BY a.product_name, c.purchasechannel, c.region
ORDER BY avg_yearly_sales DESC;