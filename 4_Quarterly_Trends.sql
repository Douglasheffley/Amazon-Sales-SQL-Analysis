SELECT
    a.category,
    a.product_name AS products,
    TO_CHAR(ROUND(AVG(a.q1_sales), 2), '$999,999,999.00') AS avg_q1_sales,
    TO_CHAR(ROUND(AVG(a.q2_sales), 2), '$999,999,999.00') AS avg_q2_sales,
    TO_CHAR(ROUND(AVG(a.q3_sales), 2), '$999,999,999.00') AS avg_q3_sales,
    TO_CHAR(ROUND(AVG(a.q4_sales), 2), '$999,999,999.00') AS avg_q4_sales,
    TO_CHAR(
        ROUND(
            AVG(a.q4_sales) -
            (
                AVG(a.q1_sales) +
                AVG(a.q2_sales) +
                AVG(a.q3_sales)
            ) / 3,
        2),
    '$999,999,999.00') AS q4_growth
FROM amazonsales a
GROUP BY a.category, a.product_name
ORDER BY q4_growth DESC;