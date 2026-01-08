# 📊 Sales & Customer Analytics Data Warehouse (SQL)

## 📖 Project Overview
This project focuses on building an **analytics-ready data warehouse** to support **sales and customer analytics**.  
Data from multiple operational systems (CRM and ERP) is consolidated into a centralized warehouse designed for **reliable reporting and business insights**.

The solution enables analysis of **sales performance, customer behavior, product trends, and regional contributions** through structured data modeling and SQL-based analytics.  
The final output is a **scalable analytics layer** that can be directly consumed by dashboards and ad-hoc SQL queries for **data-driven decision-making**.

---

## 🎯 Business Goals & Analytics Objectives
- Build a centralized, analytics-ready data warehouse to support business decision-making  
- Enable reliable sales and revenue analysis over time  
- Analyze customer behavior and customer value  
- Evaluate product and category-level performance  
- Support regional and location-based insights  
- Provide a scalable foundation for BI reporting and analytics  

---

## 🗂️ Data Sources
This project integrates data from multiple operational systems:

- **CRM System**
  - Customer information
  - Product details
  - Sales transaction data

- **ERP System**
  - Customer master data
  - Location and regional information
  - Product categorization and reference data

These sources are combined to create a **single source of truth** for analytics.

---

## 🏗️ Data Architecture
The project follows a **layered data warehouse architecture** designed to separate raw data ingestion, data transformation, and analytics consumption.

### Architecture Layers
- **Bronze Layer**
  - Raw data ingestion from source systems
  - Data stored as-is for traceability and auditing

- **Silver Layer**
  - Data cleaning, standardization, and enrichment
  - Resolves data quality issues and prepares data for modeling

- **Gold Layer**
  - Analytics-ready data modeled for reporting
  - Optimized for business queries and aggregations

This design ensures **data quality, scalability, and efficient analytics**.

> 📌 Architecture diagrams are available in the `docs/` folder.

---

## 🧱 Project Initialization
The project initialization phase establishes a clean and maintainable foundation before implementation.

### Naming Conventions
- Consistent naming across databases, schemas, tables, and columns  
- Clear separation between Bronze, Silver, and Gold layers  
- Descriptive names to improve readability and reduce ambiguity  

### Repository Structure
- Logical separation of datasets, scripts, analytics queries, and documentation  
- Designed to support version control and incremental development  

### Database & Schema Design
- Dedicated database for the data warehouse  
- Separate schemas for Bronze, Silver, and Gold layers  
- Logical isolation between raw, transformed, and analytics-ready data  

---

## 🧩 Data Modeling
- Dimensional modeling using a **star schema**
- **Fact tables** represent sales transactions  
- **Dimension tables** represent customers, products, and locations  
- Optimized for analytical queries and aggregations  

---

## 📊 Analytics Use Cases
- Sales trend analysis (monthly, quarterly, yearly)  
- Top customers by revenue contribution  
- Repeat vs one-time customer analysis  
- Product and category performance analysis  
- Regional sales performance analysis  

---

## 🧮 Key SQL Queries
- Revenue and growth trend analysis  
- Customer contribution and segmentation queries  
- Product-level and category-level aggregations  
- Region-wise sales performance metrics  

All analytical queries are documented and stored in the repository.

---

## 🔍 Insights & Findings
- Identification of high-value customers and products  
- Revenue concentration patterns across customers  
- Regional growth opportunities and performance differences  

---

## 📈 Dashboard
- The Gold layer is designed to be consumed by BI tools such as **Power BI** or **Excel**
- Dashboards focus on:
  - Sales trends
  - Customer insights
  - Product and regional performance  

---

## 📚 Learnings & Improvements
- Practical understanding of data warehouse architecture  
- Hands-on experience with SQL-based analytics modeling  
- Improved ability to translate business questions into analytical solutions  

**Future Improvements**
- Incremental data loading  
- Historical data tracking  
- Advanced customer analytics (CLV, cohorts)

---

## 📂 Repository Structure
sales-customer-analytics-dwh/
│
├── datasets/ # Raw CRM and ERP datasets
├── docs/ # Architecture diagrams and documentation
├── scripts/ # SQL scripts
│ ├── bronze/
│ ├── silver/
│ ├── gold/
├── analytics_queries/ # Business-focused SQL analysis queries
└── README.md

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

