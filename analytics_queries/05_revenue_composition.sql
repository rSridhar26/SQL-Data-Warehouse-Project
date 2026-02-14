/*
============================================================
Business Analytics – Advanced Revenue Composition
============================================================
Purpose:
    This script performs deeper analytical breakdowns of
    revenue composition across customers, products,
    demographics, and segments.

Scope:
    - Pareto (80/20) revenue analysis
    - Revenue concentration risk
    - Category contribution breakdown
    - Demographic revenue segmentation
    - High-value segment identification

Business Objective:
    Identify structural revenue dependencies, assess
    risk concentration, and uncover strategic growth
    opportunities.

Note:
    All analysis is performed on Gold layer views.
============================================================
*/


-- Customer Revenue Contribution Ranking

WITH customer_revenue AS (
    SELECT 
        customer_key,
        SUM(sales_amount) AS total_revenue
    FROM gold_db.fact_sales
    GROUP BY customer_key
),
ranked_customers AS (
    SELECT
        customer_key,
        total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) 
            AS cumulative_revenue,
        SUM(total_revenue) OVER () AS overall_revenue
    FROM customer_revenue
)

SELECT 
    customer_key,
    total_revenue,
    ROUND(cumulative_revenue * 100 / overall_revenue, 2) 
        AS cumulative_percentage
FROM ranked_customers
ORDER BY total_revenue DESC;


-- Product Revenue Concentration

WITH product_revenue AS (
    SELECT 
        product_key,
        SUM(sales_amount) AS total_revenue
    FROM gold_db.fact_sales
    GROUP BY product_key
),
ranked_products AS (
    SELECT
        product_key,
        total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) 
            AS cumulative_revenue,
        SUM(total_revenue) OVER () AS overall_revenue
    FROM product_revenue
)

SELECT 
    product_key,
    total_revenue,
    ROUND(cumulative_revenue * 100 / overall_revenue, 2) 
        AS cumulative_percentage
FROM ranked_products
ORDER BY total_revenue DESC;


-- Revenue by Marital Status

SELECT 
    dc.marital_status,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT dc.customer_key) AS unique_customers
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.marital_status
ORDER BY total_revenue DESC;


-- Revenue by Age Segment

SELECT 
    CASE
        WHEN TIMESTAMPDIFF(YEAR, dc.birthdate, CURDATE()) < 30 THEN 'Under 30'
        WHEN TIMESTAMPDIFF(YEAR, dc.birthdate, CURDATE()) BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END AS age_group,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT dc.customer_key) AS unique_customers
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY age_group
ORDER BY total_revenue DESC;


-- Category Revenue by Country

SELECT 
    dc.country,
    dp.category,
    SUM(fs.sales_amount) AS revenue
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
JOIN gold_db.dim_products dp
    ON fs.product_key = dp.product_key
GROUP BY dc.country, dp.category
ORDER BY dc.country, revenue DESC;


-- High Value Customers (Top 10%)

WITH customer_revenue AS (
    SELECT 
        customer_key,
        SUM(sales_amount) AS total_revenue
    FROM gold_db.fact_sales
    GROUP BY customer_key
),
ranked_customers AS (
    SELECT
        customer_key,
        total_revenue,
        NTILE(10) OVER (ORDER BY total_revenue DESC) AS revenue_decile
    FROM customer_revenue
)

SELECT *
FROM ranked_customers
WHERE revenue_decile = 1;


