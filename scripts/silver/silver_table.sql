/*
=============================================================
Silver Layer Table Creation
=============================================================
Purpose:
    This script creates the Silver layer tables used for
    cleaned, standardized, and validated data.

    The Silver layer transforms raw Bronze data into
    consistent and analytics-ready structures by:
    - Standardizing data types and formats
    - Handling nulls and invalid values
    - Applying basic business rules
    - Preparing trusted datasets for the Gold layer

    Audit columns such as dwh_create_date are included to
    track data warehouse record creation.

Note:
    No aggregations or analytical metrics are applied in
    this layer. The Silver layer focuses only on data
    correctness and consistency.
=============================================================
*/


DROP TABLE IF EXISTS silver_db.crm_cust_info ;
CREATE TABLE silver_db.crm_cust_info (
cst_id INT,
cst_key VARCHAR(50),
cst_firstname VARCHAR(50),
cst_lastname VARCHAR(50),
cst_marital_status VARCHAR(50),
cst_gender VARCHAR(50),
cst_create_date DATE,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS silver_db.crm_prd_info;
CREATE TABLE silver_db.crm_prd_info (
prd_id INT,
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS silver_db.crm_sales_details ;
CREATE TABLE silver_db.crm_sales_details (
sls_ord_num VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS silver_db.erp_loc_a101 ;
CREATE TABLE silver_db.erp_loc_a101 (
cid VARCHAR(50),
cntry VARCHAR(50),
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS silver_db.erp_cust_az12 ;
CREATE TABLE silver_db.erp_cust_az12 (
cid VARCHAR(50),
bdate DATE,
gen VARCHAR(50),
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS silver_db.erp_px_cat_g1v2 ;
CREATE TABLE silver_db.erp_px_cat_g1v2 (
id VARCHAR(50),
cat VARCHAR(50),
subcat VARCHAR(50),
maintenance VARCHAR(50),
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
