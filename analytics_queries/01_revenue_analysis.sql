/*
============================================================
Business Analytics – Revenue & Growth Analysis
============================================================
Purpose:
    This script contains business-level analytical queries
    focused on revenue performance and growth trends.

    The analysis is executed exclusively on the Gold layer
    (analytics-ready star schema) to ensure trusted,
    standardized, and decision-grade outputs.

Scope:
    - Total revenue and order volume
    - Monthly revenue trends
    - Month-over-Month growth %
    - Revenue by geography
    - Yearly revenue summaries

Business Objective:
    Enable leadership to evaluate revenue performance,
    identify growth patterns, detect seasonality, and
    assess regional contributions.

Note:
    These queries do not modify data. They are designed
    for analytical consumption and reporting purposes.
============================================================
*/


USE gold_db;

-- =============================================================
-- Revenue Overview
-- =============================================================

SELECT 
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(sales_amount) AS total_revenue,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS avg_order_value
FROM gold_db.fact_sales;


-- =============================================================
-- Monthly Revenue Trend
-- =============================================================

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS yr_month,
    SUM(sales_amount) AS monthly_revenue,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold_db.fact_sales
GROUP BY yr_month
ORDER BY yr_month;


-- =============================================================
-- Month-over-Month Growth
-- =============================================================

WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS yr_month,
        SUM(sales_amount) AS revenue
    FROM gold_db.fact_sales
    GROUP BY yr_month
)

SELECT 
    yr_month,
    revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY yr_month))
        / LAG(revenue) OVER (ORDER BY yr_month) * 100,
        2
    ) AS mom_growth_percent
FROM monthly_sales;


-- =============================================================
-- Revenue by Country
-- =============================================================

SELECT 
    dc.country,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold_db.fact_sales fs
LEFT JOIN gold_db.dim_customers dc
    ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY total_revenue DESC;


-- =============================================================
-- Yearly Revenue
-- =============================================================

SELECT 
    YEAR(order_date) AS year,
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold_db.fact_sales
GROUP BY YEAR(order_date)
ORDER BY year;




