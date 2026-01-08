Sales & Customer Analytics Data Warehouse (SQL)
📖 Project Overview

This project focuses on building an analytics-ready data warehouse to support sales and customer analysis. Data from multiple operational systems (CRM and ERP) is consolidated into a centralized warehouse designed for reliable reporting and business insights.

The solution enables analysis of sales performance, customer behavior, product trends, and regional contributions through structured data modeling and SQL-based analytics. The final output is a scalable analytics layer that can be directly consumed by dashboards and ad-hoc SQL queries for data-driven decision-making.

🎯 Business Goals & Analytics Objectives

Build a centralized, analytics-ready data warehouse to support business decision-making
Enable reliable sales and revenue analysis over time
Analyze customer behavior and customer value
Evaluate product and category-level performance
Support regional and location-based insights
Provide a scalable foundation for BI reporting and analytics

🗂️ Data Sources

CRM System: Customer, product, and sales transaction data
ERP System: Customer master data, location information, and product classification data
These systems are integrated to create a unified source of truth for analytics.

🏗️ Data Architecture

The project follows a layered data warehouse architecture to separate raw ingestion, data transformation, and analytics consumption.
Bronze Layer: Raw data ingestion and traceability
Silver Layer: Data cleaning, standardization, and enrichment
Gold Layer: Analytics-ready fact and dimension tables optimized for querying
This design ensures data quality, scalability, and efficient analytics.

🧱 Data Modeling

Dimensional modeling using a star schema
Fact tables represent sales transactions
Dimension tables represent customers, products, and locations
Designed to support fast aggregations and business analysis

📊 Analytics Use Cases

Sales trend analysis (monthly, quarterly, yearly)
Top customers by revenue contribution
Repeat vs one-time customer analysis
Product and category performance analysis
Regional sales performance analysis

🧮 Key SQL Queries

Revenue and growth trends
Customer contribution analysis
Product-level aggregations
Region-wise performance metrics

🔍 Insights & Findings

Identification of high-value customers and products
Revenue concentration patterns across customers
Regional growth opportunities

📈 Dashboard

Analytics-ready data is designed to be consumed by BI tools such as Power BI or Excel.
Dashboards focus on sales trends, customer insights, and product performance.

📚 Learnings & Improvements

Improved understanding of data warehouse architecture and analytics modeling
Practical experience designing SQL analytics pipelines
Opportunities for future enhancements include incremental loads, historical tracking, and advanced customer analytics

📂 Repository Structure
sales-customer-analytics-dwh/
│
├── datasets/
├── docs/
├── scripts/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
├── analytics_queries/
└── README.md
