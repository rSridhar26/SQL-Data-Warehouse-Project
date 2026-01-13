# 📘 Data Catalog — Gold Layer

## Overview
The **Gold Layer** represents the business-facing analytics layer of the data warehouse.  
It is designed using a **star schema** and provides clean, trusted, and analytics-ready data for reporting, dashboarding, and ad-hoc SQL analysis.

The Gold layer consists of **dimension views** and **fact views** derived from the Silver layer.

---

## 1. `gold_db.dim_customers`

### Purpose
Stores consolidated customer information enriched with demographic and geographic attributes.  
Provides a single, trusted customer entity for analytics.

### Columns

| Column Name      | Data Type     | Description |
|------------------|--------------|-------------|
| customer_key     | INT          | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id      | INT          | Business identifier representing the customer ID from source systems. |
| customer_number  | VARCHAR(50)  | Alphanumeric customer identifier used for cross-system reference. |
| first_name       | VARCHAR(50)  | Customer’s first name. |
| last_name        | VARCHAR(50)  | Customer’s last name or family name. |
| country          | VARCHAR(50)  | Country associated with the customer’s location. |
| marital_status   | VARCHAR(50)  | Customer’s marital status (e.g., Married, Single, n/a). |
| gender           | VARCHAR(50)  | Standardized gender value (e.g., Male, Female, n/a). |
| birthdate        | DATE         | Customer’s date of birth. |
| create_date      | DATE         | Date when the customer record was originally created. |

---

## 2. `gold_db.dim_products`

### Purpose
Provides descriptive product information including categorization and classification attributes.  
Supports product-level and category-level analysis.

### Columns

| Column Name    | Data Type     | Description |
|----------------|--------------|-------------|
| product_key    | INT          | Surrogate key uniquely identifying each product record in the dimension table. |
| product_id     | INT          | Business identifier for the product. |
| product_number | VARCHAR(50)  | Alphanumeric product code used for identification and tracking. |
| product_name   | VARCHAR(50)  | Descriptive name of the product. |
| category_id    | VARCHAR(50)  | Identifier representing the product’s category. |
| category       | VARCHAR(50)  | High-level product category (e.g., Bikes, Components). |
| subcategory    | VARCHAR(50)  | Detailed classification within the product category. |
| maintenance    | VARCHAR(50)  | Indicates whether the product requires maintenance. |
| cost           | INT          | Base cost of the product in monetary units. |
| product_line   | VARCHAR(50)  | Product line or series (e.g., Road, Mountain, Touring). |
| start_date     | DATE         | Date when the product became active or available. |
| end_date       | DATE         | Date when the product was discontinued (NULL if active). |

---

## 3. `gold_db.fact_sales`

### Purpose
Stores transactional sales data at order-line level.  
Captures measurable business events and links to customer and product dimensions.

### Columns

| Column Name   | Data Type     | Description |
|---------------|--------------|-------------|
| order_number  | VARCHAR(50)  | Unique identifier for each sales order. |
| product_key   | INT          | Surrogate key referencing `dim_products`. |
| customer_key  | INT          | Surrogate key referencing `dim_customers`. |
| order_date    | DATE         | Date when the order was placed. |
| shipping_date | DATE         | Date when the order was shipped. |
| due_date      | DATE         | Date when payment was due. |
| sales_amount  | INT          | Total sales amount for the order line. |
| quantity      | INT          | Number of product units sold. |
| price         | INT          | Price per unit of the product. |

---

## Notes
- All Gold layer objects are implemented as **views**.
- No data cleansing or transformation logic is applied in the Gold layer.
- Aggregations and KPIs are calculated at query or BI-tool level to preserve analytical flexibility.

