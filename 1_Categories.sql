SELECT
    a.category,
    TO_CHAR(SUM(a.yearly_sales), '$999,999,999.00') AS total_sales,
    rank () over (
        order by SUM(a.yearly_sales) desc
    ) As Ranking
FROM amazonsales a
GROUP BY a.category
HAVING SUM(a.yearly_sales) > (
    SELECT AVG(yearly_sales)
    FROM amazonsales
)
ORDER BY total_sales DESC;