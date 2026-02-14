/*
============================================================
Business Analytics – Customer Performance Analysis
============================================================
Purpose:
    This script analyzes customer-level behavior and revenue
    contribution using the Gold layer star schema.

Scope:
    - Top customers by revenue
    - Customer revenue distribution
    - Customer lifetime value (basic)
    - Repeat vs one-time buyers
    - Revenue by demographic segments
    - Geographic customer performance

Business Objective:
    Identify high-value customers, understand behavioral
    patterns, and support customer retention and growth
    strategies.

Note:
    All queries operate exclusively on Gold views.
============================================================
*/


-- Top 10 Customers by Revenue

SELECT 
    dc.first_name,
    dc.last_name,
    dc.country,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.first_name, dc.last_name, dc.country
ORDER BY total_revenue DESC
LIMIT 10;


-- Customer Revenue Ranking

SELECT 
    dc.customer_key,
    dc.first_name,
    dc.last_name,
    SUM(fs.sales_amount) AS lifetime_revenue,
    RANK() OVER (ORDER BY SUM(fs.sales_amount) DESC) AS revenue_rank
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name;


-- Repeat vs One-Time Buyers

SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-Time Buyer'
        ELSE 'Repeat Buyer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT 
        customer_key,
        COUNT(DISTINCT order_number) AS order_count
    FROM gold_db.fact_sales
    GROUP BY customer_key
) t
GROUP BY customer_type;


-- Customer Lifetime Value (Total Revenue Per Customer)

SELECT 
    dc.customer_key,
    dc.first_name,
    dc.last_name,
    SUM(fs.sales_amount) AS customer_lifetime_value,
    ROUND(SUM(fs.sales_amount) / COUNT(DISTINCT fs.order_number), 2) 
        AS avg_order_value
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name
ORDER BY customer_lifetime_value DESC;


-- Revenue by Gender

SELECT 
    dc.gender,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.gender
ORDER BY total_revenue DESC;


-- Revenue by Customer Country

SELECT 
    dc.country,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT dc.customer_key) AS unique_customers
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY total_revenue DESC;


-- Revenue by Age Group

SELECT 
    CASE
        WHEN TIMESTAMPDIFF(YEAR, dc.birthdate, CURDATE()) < 30 THEN 'Under 30'
        WHEN TIMESTAMPDIFF(YEAR, dc.birthdate, CURDATE()) BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END AS age_group,
    SUM(fs.sales_amount) AS total_revenue
FROM gold_db.fact_sales fs
JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY age_group
ORDER BY total_revenue DESC;
