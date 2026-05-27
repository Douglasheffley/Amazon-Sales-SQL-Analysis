# Introduction

---

# Background

---

# Tools Used

---

# Insights/Analysis

1.
[1_Categories.SQL](/1_Categories.sql/)
```SQL
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
```

## Category Sales Results

| Category     | Total Sales        | Ranking |
|--------------|-------------------:|--------:|
| Accessories  | $23,999,776.00     | 1       |
| Audio        | $21,969,021.00     | 2       |
| Electronics  | $19,980,457.00     | 3       |
| Computers    | $19,873,039.00     | 4       |

[1_SQL.csv](https://github.com/user-attachments/files/28300880/1_SQL.csv)|

2.
[2_Ratings_Relationship_Sales.SQL](/2_Ratings_Relationship_Sales.sql/)
```SQL
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
```
"rating_group","total_products","avg_yearly_sales","avg_reviews","avg_price"
"4.5","3","$   1,206,667.67","5955","$         265.79"
"4.0","2","$   1,196,404.50","5785","$       1,074.47"
"3.7","4","$   1,172,089.25","5713","$         713.02"
"3.8","5","$   1,112,787.60","3624","$         671.62"
"4.3","4","$   1,045,696.50","6184","$         965.59"

[2_SQL.csv](https://github.com/user-attachments/files/28301387/2_SQL.csv)

3.
[3_Pricing_Demand.SQL](/3_Pricing_Demand.sql/)
```SQL
SELECT
    a.product_name AS products,
    a.category,
    a.price_usd,
    TO_CHAR(a.yearly_sales, '$999,999,999.00') As yearly_sales,
    ROUND(a.yearly_sales / a.price_usd, 2) AS sales_to_price_ratio
FROM amazonsales a
ORDER BY sales_to_price_ratio DESC;
```
"products","category","price_usd","yearly_sales","sales_to_price_ratio"
"USB-C Hub Model-83","Audio","47.43","$   1,719,513.00","36253.70"
"4K Monitor Model-43","Audio","40.38","$   1,409,305.00","34901.06"
"External SSD Model-90","Audio","23.23","$     496,146.00","21357.99"
"Smart Watch Model-27","Audio","35.02","$     702,406.00","20057.28"

[3_SQL.csv](https://github.com/user-attachments/files/28301421/3_SQL.csv)


4.
[4_Quarterly_Trends.SQL](/4_Quarterly_Trends.sql/)
```SQL
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
```
"category","products","avg_q1_sales","avg_q2_sales","avg_q3_sales","avg_q4_sales","q4_growth"
"Computers","Wireless Mouse Model-77","$     280,339.00","$     317,301.00","$     338,340.00","$     522,834.00","$     210,840.67"
"Accessories","Smart Watch Model-14","$     307,523.00","$     340,010.00","$     382,340.00","$     550,182.00","$     206,891.00"
"Accessories","Bluetooth Headphones Model-56","$     331,444.00","$     363,982.00","$     404,288.00","$     561,428.00","$     194,856.67"
"Electronics","Webcam Pro Model-18","$     304,774.00","$     342,313.00","$     316,917.00","$     509,018.00","$     187,683.33"
"Audio","USB-C Hub Model-83","$     353,750.00","$     372,542.00","$     428,302.00","$     564,919.00","$     180,054.33"

[4_SQL.csv](https://github.com/user-attachments/files/28301438/4_SQL.csv)


5.
Query 1
[5.1_Marketing_Investment.SQL](/5.1_Marketing_Investment.sql/)
```SQL
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
```
"product_name","purchasechannel","region","avg_yearly_sales","sales_rank"
"USB-C Hub Model-83","Online","North America","$   1,719,513.00","1"
"Bluetooth Headphones Model-56","Mobile App","Asia-Pacific","$   1,661,142.00","2"
"Webcam Pro Model-65","Retail","North America","$   1,630,317.00","3"
"Wireless Mouse Model-41","Retail","South America","$   1,580,353.00","4"

[5.1_SQL.csv](https://github.com/user-attachments/files/28301441/5.1_SQL.csv)



Query 2
[5.2_Marketing_Investment.SQL](/5.2_Marketing_Investment.sql/)
```SQL
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
```
"product_name","sales_to_price_ratio","agegroup","avg_rating"
"USB-C Hub Model-83","36253.70","55+","4.5"
"4K Monitor Model-43","34901.06","25-34","4.1"
"External SSD Model-90","21357.99","18-24","4.7"
"Smart Watch Model-27","20057.28","45-54","4.1"

[5.2_SQL.csv](https://github.com/user-attachments/files/28301446/5.2_SQL.csv)


---

# Conclusion
