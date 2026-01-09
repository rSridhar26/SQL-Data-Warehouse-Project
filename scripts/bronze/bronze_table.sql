/*
=============================================================
Bronze Layer – Table Definitions
=============================================================
Script Purpose:
    This script creates the Bronze layer tables for the data
    warehouse. These tables represent raw ingested data from
    CRM and ERP source systems.

    The Bronze layer is designed to store source data with
    minimal assumptions and without applying business rules
    or transformations. It serves as the foundational layer
    for downstream data cleaning and standardization in the
    Silver layer.

Design Principles:
    - Tables closely mirror source system structures
    - No transformations or business logic applied
    - Focus on reliable ingestion and traceability

WARNING:
    Dropping and recreating tables will permanently remove
    existing data in the Bronze layer. Execute with caution.
=============================================================
*/


DROP TABLE IF EXISTS bronze_db.crm_cust_info ;
CREATE TABLE bronze_db.crm_cust_info (
cst_id INT,
cst_key VARCHAR(50),
cst_firstname VARCHAR(50),
cst_lastname VARCHAR(50),
cst_marital_status VARCHAR(50),
cst_gender VARCHAR(50),
cst_create_date DATE
);


DROP TABLE IF EXISTS bronze_db.crm_prd_info;
CREATE TABLE bronze_db.crm_prd_info (
prd_id INT,
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);


DROP TABLE IF EXISTS bronze_db.crm_sales_details ;
CREATE TABLE bronze_db.crm_sales_details (
sls_ord_num VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);


DROP TABLE IF EXISTS bronze_db.erp_loc_a101 ;
CREATE TABLE bronze_db.erp_loc_a101 (
cid VARCHAR(50),
cntry VARCHAR(50)
);


DROP TABLE IF EXISTS bronze_db.erp_cust_az12 ;
CREATE TABLE bronze_db.erp_cust_az12 (
cid VARCHAR(50),
bdate DATE,
gen VARCHAR(50)
);


DROP TABLE IF EXISTS bronze_db.erp_px_cat_g1v2 ;
CREATE TABLE bronze_db.erp_px_cat_g1v2 (
id VARCHAR(50),
cat VARCHAR(50),
subcat VARCHAR(50),
maintenance VARCHAR(50)
);
