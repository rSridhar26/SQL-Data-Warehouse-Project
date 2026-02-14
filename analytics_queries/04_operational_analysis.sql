/*
============================================================
Business Analytics – Operational Performance Analysis
============================================================
Purpose:
    This script evaluates operational efficiency metrics
    using transactional data from the Gold layer.

Scope:
    - Average Order Value (AOV)
    - Order processing and delivery time
    - On-time vs delayed shipments
    - Daily and weekday sales trends
    - Order volume patterns

Business Objective:
    Improve operational efficiency, reduce delays,
    monitor fulfillment performance, and optimize
    order management processes.

Note:
    All analysis is performed on Gold layer views.
============================================================
*/


-- Average Order Value

SELECT 
    ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) 
        AS avg_order_value
FROM gold_db.fact_sales;


-- Average Delivery Time

SELECT 
    ROUND(AVG(DATEDIFF(shipping_date, order_date)), 2) 
        AS avg_delivery_days
FROM gold_db.fact_sales
WHERE shipping_date IS NOT NULL;


-- Late Deliveries

SELECT 
    COUNT(*) AS late_orders
FROM gold_db.fact_sales
WHERE shipping_date > due_date;


-- Daily Revenue

SELECT 
    order_date,
    SUM(sales_amount) AS daily_revenue
FROM gold_db.fact_sales
GROUP BY order_date
ORDER BY order_date;


-- Revenue by Weekday

SELECT 
    DAYNAME(order_date) AS weekday,
    SUM(sales_amount) AS total_revenue
FROM gold_db.fact_sales
GROUP BY weekday
ORDER BY total_revenue DESC;


-- Monthly Order Volume

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS yr_month,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold_db.fact_sales
GROUP BY yr_month
ORDER BY yr_month;


-- Revenue Impact of Delayed Orders

SELECT 
    CASE 
        WHEN shipping_date > due_date THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status,
    SUM(sales_amount) AS total_revenue
FROM gold_db.fact_sales
GROUP BY delivery_status;

