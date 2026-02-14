/*
============================================================
Business Analytics – Product Performance Analysis
============================================================
Purpose:
    This script evaluates product-level performance using
    the Gold layer star schema.

Scope:
    - Top and bottom performing products
    - Revenue by category and subcategory
    - Product line contribution
    - Volume vs revenue comparison
    - Product revenue distribution

Business Objective:
    Identify high-performing products, detect weak
    performers, understand category contribution,
    and support pricing and inventory decisions.

Note:
    All queries operate on analytics-ready Gold views.
============================================================
*/


-- Top 10 Products by Revenue

SELECT 
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue,
    SUM(fs.quantity) AS total_units_sold
FROM gold_db.fact_sales fs
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Bottom 10 Products by Revenue

SELECT 
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold_db.fact_sales fs
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue ASC
LIMIT 10;


-- Revenue by Category

SELECT 
    dp.category,
    SUM(fs.sales_amount) AS total_revenue,
    ROUND(SUM(fs.sales_amount) * 100 / 
          (SELECT SUM(sales_amount) FROM gold_db.fact_sales), 2) 
          AS revenue_percentage
FROM gold_db.fact_sales fs
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.category
ORDER BY total_revenue DESC;


-- Revenue by Product Line

SELECT 
    dp.product_line,
    SUM(fs.sales_amount) AS total_revenue,
    SUM(fs.quantity) AS total_units
FROM gold_db.fact_sales fs
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_line
ORDER BY total_revenue DESC;


-- Revenue vs Volume Comparison

SELECT 
    dp.product_name,
    SUM(fs.sales_amount) AS revenue,
    SUM(fs.quantity) AS units_sold,
    ROUND(SUM(fs.sales_amount) / SUM(fs.quantity), 2) AS avg_price
FROM gold_db.fact_sales fs
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY revenue DESC;


-- Monthly Category Revenue Trend

SELECT 
    DATE_FORMAT(fs.order_date, '%Y-%m') AS yr_month,
    dp.category,
    SUM(fs.sales_amount) AS revenue
FROM gold_db.fact_sales fs
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY yr_month, dp.category
ORDER BY yr_month, revenue DESC;



