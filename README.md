# Introduction

### **About Me**

#### In this project, I intend to demonstrate my knowledge of and skills in Data analyis (using SQL), Data Visualization (using Power BI), and data storytelling to capture all best practices and simplified yet insightful/powerful results.

#### Exposure to SQL and Power BI has been gained previous to developing this project. However, the majority of the shown procuedures were completely self-taught through study and practice, marking it as an acceptable potential replacement to "work" experience.

### **More About The Project**

#### **You can find every section that corresponds to a specific step in the project**
#### - Tools Used: This shows all the tools used to prep the data, conduct the analyses, and create visualizations
#### - Data Cleaning: The methodology behind cleaning and prepping the data utilizing Excel (Also possible through SQL but chose to demonstrate knowledge in Excel in addition to SQL analyses)
#### - Analysis: SQL queries that were written and the logic behind them... analysis will also include the visualizations to complete the data storytelling
#### - Insights: Based on the analysis, this sections intends to demonstrate the communication piece of the data analyses, utilizing skills developed through education and experience

---

# Tools Used

### Excel
Excel was utilized to prep and clean the data for analysis. Procedures such as sorting, filtering, formulas, etc. were used to help standardize the data as a prerequisite to conducting the SQL queries. This tool can be be extremely useful, as it is the source of the original data and having it cleaned for others can be helpful to the organization, including employees such as key stakeholders or managers who are not equipped with SQL.

### SQL
Analyses were performed utilizing SQL. Creating results that are intended to be insightful to those such as key stakeholders or managers can be crucial for making business decisions. SQL is a powerful tool for conducting these analyses due to many reasons, one of which being the fact that most organizations have many sources of data and large databases which can be limiting for an application like Excel.

### PostgreSQL
The choice of software to manage the data for this project was PostgreSQL. The foundation of SQL remains the same across other software... queries can be quickly translated to other software such as MySQL.

### Power BI
Tableau was another option for data visualization, which can possess the same concepts as Power BI in creating visualizations. Power BI was utilized though to create visualizations for this project based on the analyses performed. Visualizations in this case can be extremely useful to those who may not be data-savvy, which is common throughout business. It also can be generally more useful for picturing how the data is behaving in certain instances for everyone, including data analysts.

---

# Data Cleaning

Proceeding are the following steps taken to prep and clean the data prior to performing analysis to ensure accuracy and efficiency

## Step 1: Removing any duplicates
Data can sometimes have duplicates which may skew or alter data results... emphasizing the importance of completing cleaning procedures prior to analyses

Shown below are the previous first few rows (as an example) for the data table "Amazon_Big_Sales_Dataset_2026.csv"

| Product_ID | Product_Name | Category | Price_USD | Review_Count | Q1_Sales | Q2_Sales | Q3_Sales | Q4_Sales | Yearly_Sales |
|------------|--------------|----------|----------:|-------------:|---------:|---------:|---------:|---------:|-------------:|
| AZ1001 | Power Bank Model-39 | Audio | 591.53 | 4399 | 72787 | 78832 | 87710 | 102347 | 341676 |
| AZ1002 | External SSD Model-20 | Accessories | 647.02 | 9779 | 99951 | 108995 | 113397 | 134434 | 456777 |
| AZ1003 | Smart Watch Model-72 | accessories | 419.88 | 9704 | 93945 | 96658 | 100185 | 128269 | 419057 |
| AZ1004 | Graphics Card Model-97 | Electronics  | 214.91 | 6305 | 28784 | 31368 | 30196 | 39298 | 129646 |
| AZ1004 | Graphics Card Model-97 | Electronics  | 214.91 | 6305 | 28784 | 31368 | 30196 | 39298 | 129646 |
...

### As seen in ROW 5
There is a duplicate for the following:

| Product_ID | Product_Name | Category | Price_USD | Review_Count | Q1_Sales | Q2_Sales | Q3_Sales | Q4_Sales | Yearly_Sales |
|------------|--------------|----------|----------:|-------------:|---------:|---------:|---------:|---------:|-------------:|
| AZ1004 | Graphics Card Model-97 | Electronics  | 214.91 | 6305 | 28784 | 31368 | 30196 | 39298 | 129646 |

#### To identify (in the first place) and fix this issue we will perform a "Remove Duplicates' action in the "Data" tab

## Step 2: Standardize the Data
It is important to standardize the text, as when conducting analyses some values might be left out due to the error in standardization which is not good for obtaining accurate results after analysis

#### To identify any errors in the cells, one option is to create filters for each column by hihlighting the headers and selecting "Filter" in the "Data" tab... This will identify any differences or null values
There was a difference in spacing for the following:

| Product_ID | Product_Name | Category | Price_USD | Review_Count | Q1_Sales | Q2_Sales | Q3_Sales | Q4_Sales | Yearly_Sales |
|------------|--------------|----------|----------:|-------------:|---------:|---------:|---------:|---------:|-------------:|
| AZ1004 | Graphics Card Model-97 | Electronics  | 214.91 | 6305 | 28784 | 31368 | 30196 | 39298 | 129646 |

#### However, this is a spacing issue... Therefore, we will use "Trim ()" to remove any spaces in the entire table

## Step 3: Check For More Required Data Cleaning
At first glance, data may appear to be accurate. However, a few more short steps was taken to ensure this data was clean and prepped for analysis

#### Additional actions were taken to identify anything else... "Sorting" to identify impossible values, "Unique ()" to identify any other differences, or all other steps that need to be taken...

## The following is the cleaned and prepped table found in "Amazon_Big_Sales_Dataset_2026.csv", the same was done for "customer_segmentation_data.csv"

| Product_ID | Product_Name                | Category     | Price_USD | Review_Count | Q1_Sales | Q2_Sales | Q3_Sales | Q4_Sales | Yearly_Sales |
|-----------|-----------------------------|--------------|----------:|-------------:|---------:|---------:|---------:|---------:|-------------:|
| AZ1001    | Power Bank Model-39         | Audio        | $591.53   | 4399         | 72787    | 78832    | 87710    | 102347   | 341676       |
| AZ1002    | External SSD Model-20       | Accessories  | $647.02   | 9779         | 99951    | 108995   | 113397   | 134434   | 456777       |
| AZ1003    | Smart Watch Model-72        | Accessories  | $419.88   | 9704         | 93945    | 96658    | 100185   | 128269   | 419057       |
| AZ1004    | Graphics Card Model-97      | Electronics  | $214.91   | 6305         | 28784    | 31368    | 30196    | 39298    | 129646       |
| AZ1005    | Mechanical Keyboard Model-53| Computers    | $1002.45  | 8880         | 199522   | 230831   | 243992   | 323063   | 997408       |
...

Now the data is ready for analysis...

---

# Analysis/Insights

### 1. Top Performing Categories By Sales

Source SQL file can be found here:
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

#### Results Table From Query 1


| Category     | Total Sales        | Ranking |
|--------------|-------------------:|--------:|
| Accessories  | $23,999,776.00     | 1       |
| Audio        | $21,969,021.00     | 2       |
| Electronics  | $19,980,457.00     | 3       |
| Computers    | $19,873,039.00     | 4       |
...

Full Results Table: [1_SQL.csv](https://github.com/user-attachments/files/28300880/1_SQL.csv)|


#### Visualization For Query 1
##### Original Power BI file can be found here: [Amazon Sales Visualizations Power BI](/Amazon_Sales_Analysis_Visualizations.pbix/)

<img width="1024" height="592" alt="1779983454986-912cb0c1-92ba-47bc-a18d-ac06a88f3e12_1" src="https://github.com/user-attachments/assets/c70d8761-cb9d-47dd-8c74-c4794b705329" />


#### Insights on Top Performing Categories
- 


### 2. Relationship Between Sales and Ratings

Source SQL file can be found here:
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

#### Results Table From Query 2


| Rating Group | Total Products | Avg Yearly Sales | Avg Reviews | Avg Price |
|-------------|---------------:|-----------------:|------------:|----------:|
| 4.5         | 3              | $1,206,667.67    | 5955        | $265.79   |
| 4.0         | 2              | $1,196,404.50    | 5785        | $1,074.47 |
| 3.7         | 4              | $1,172,089.25    | 5713        | $713.02   |
| 3.8         | 5              | $1,112,787.60    | 3624        | $671.62   |
| 4.3         | 4              | $1,045,696.50    | 6184        | $965.59   |
...

Full Results Table: [2_SQL.csv](https://github.com/user-attachments/files/28301387/2_SQL.csv)


#### Visualization For Query 2

<img width="1024" height="592" alt="1779983454986-912cb0c1-92ba-47bc-a18d-ac06a88f3e12_2" src="https://github.com/user-attachments/assets/6bfc4fbc-f76c-4054-aee3-12583632c797" />


#### Insights on Relationship Between Sales and Ratings
-


### 3. Influence of Pricing on Product Demand

Source SQL file can be found here:
[3_Pricing_Demand.SQL](/3_Pricing_Demand.sql/)
```SQL
SELECT
    a.product_name AS products,
    a.category,
    a.price_usd,
    TO_CHAR(a.yearly_sales, '$999,999,999.00') As yearly_sales,
    ROUND(a.yearly_sales / a.price_usd, 2) AS demand
FROM amazonsales a
ORDER BY demand DESC;
```

#### Results Table From Query 3


| Product | Category | Price (USD) | Yearly Sales | Sales-to-Price Ratio |
|----------|----------|-------------:|--------------:|----------------------:|
| USB-C Hub Model-83 | Audio | $47.43 | $1,719,513.00 | 36253.70 |
| 4K Monitor Model-43 | Audio | $40.38 | $1,409,305.00 | 34901.06 |
| External SSD Model-90 | Audio | $23.23 | $496,146.00 | 21357.99 |
| Smart Watch Model-27 | Audio | $35.02 | $702,406.00 | 20057.28 |
...

Full Results Table: [3_SQL.csv](https://github.com/user-attachments/files/28301421/3_SQL.csv)


#### Visualization For Query 3

<img width="1024" height="592" alt="1779983454986-912cb0c1-92ba-47bc-a18d-ac06a88f3e12_3" src="https://github.com/user-attachments/assets/e2e776db-0379-48e0-8df9-5eadccfe2553" />


#### Insights on Influence of Pricing on Product Demand
-


### 4. Quarterly Trends

Source SQL file can be found here:
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

#### Results Table From Query 4


| Category     | Product                        | Q1 Sales    | Q2 Sales    | Q3 Sales    | Q4 Sales    | Q4 Growth |
|--------------|--------------------------------|------------:|------------:|------------:|------------:|----------:|
| Computers    | Wireless Mouse Model-77        | $280,339.00 | $317,301.00 | $338,340.00 | $522,834.00 | $210,840.67 |
| Accessories  | Smart Watch Model-14          | $307,523.00 | $340,010.00 | $382,340.00 | $550,182.00 | $206,891.00 |
| Accessories  | Bluetooth Headphones Model-56 | $331,444.00 | $363,982.00 | $404,288.00 | $561,428.00 | $194,856.67 |
| Electronics  | Webcam Pro Model-18           | $304,774.00 | $342,313.00 | $316,917.00 | $509,018.00 | $187,683.33 |
| Audio        | USB-C Hub Model-83           | $353,750.00 | $372,542.00 | $428,302.00 | $564,919.00 | $180,054.33 |
...

Full Results Table: [4_SQL.csv](https://github.com/user-attachments/files/28301438/4_SQL.csv)


#### Visualization For Query 4

<img width="1024" height="592" alt="1779983454986-912cb0c1-92ba-47bc-a18d-ac06a88f3e12_4" src="https://github.com/user-attachments/assets/26403eea-38d9-43f8-8d85-6e25e9040004" />


#### Insights on Quarterly Trends
-


### 5. Products Marketing and Investment
##### Query 1

Source SQL file can be found here:
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

#### Results Table From Query 5


| Product | Purchase Channel | Region | Avg Yearly Sales | Sales Rank |
|----------|------------------|---------|-----------------:|-----------:|
| USB-C Hub Model-83 | Online | North America | $1,719,513.00 | 1 |
| Bluetooth Headphones Model-56 | Mobile App | Asia-Pacific | $1,661,142.00 | 2 |
| Webcam Pro Model-65 | Retail | North America | $1,630,317.00 | 3 |
| Wireless Mouse Model-41 | Retail | South America | $1,580,353.00 | 4 |
...

Full Results Table: [5.1_SQL.csv](https://github.com/user-attachments/files/28301441/5.1_SQL.csv)


#### Visualization For Query 5


##### Query 2

Source SQL file can be found here:
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

#### Results Table From Last Query


| Product | Sales-to-Price Ratio | Age Group | Avg Rating |
|----------|----------------------:|----------|-----------:|
| USB-C Hub Model-83 | 36253.70 | 55+ | 4.5 |
| 4K Monitor Model-43 | 34901.06 | 25-34 | 4.1 |
| External SSD Model-90 | 21357.99 | 18-24 | 4.7 |
| Smart Watch Model-27 | 20057.28 | 45-54 | 4.1 |
...

Full Results Table: [5.2_SQL.csv](https://github.com/user-attachments/files/28301446/5.2_SQL.csv)


#### Visualization For Query 5

<img width="1024" height="592" alt="1779983454986-912cb0c1-92ba-47bc-a18d-ac06a88f3e12_5" src="https://github.com/user-attachments/assets/3b0d9fa6-73c5-4184-9d93-7358a15cc4ca" />
-📝 Note: Loading visual is the interactable map to identify top performing regions (ArcGIS)


#### Insights on Products Marketing and Investment
-


## Dashboard

<img width="1024" height="592" alt="1779983454986-912cb0c1-92ba-47bc-a18d-ac06a88f3e12_6" src="https://github.com/user-attachments/assets/66243985-0977-4ebf-98d0-42fa98232881" />
-📝 Note: Dashboard and all other visualizations are completely interactable which can be useful for drilling down data and Dashboard and all other visualizations have a background and cleaner look as seen in the original file

##### Power BI file here: [Amazon Sales Visualizations Power BI](/Amazon_Sales_Analysis_Visualizations.pbix/)


---

# Conclusion
