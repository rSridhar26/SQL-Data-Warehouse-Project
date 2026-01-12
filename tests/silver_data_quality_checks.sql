/*
=============================================================
Data Quality & Validation Tests
=============================================================
Purpose:
    This script contains data quality checks used to validate
    Bronze and Silver layer data after ingestion and
    transformation.

    The checks focus on:
    - Duplicate detection
    - Null and invalid values
    - Data standardization consistency
    - Business rule validation
    - Date integrity checks

    These tests are used for validation only and do not
    modify any data.
=============================================================
*/

-------------------------------------------------------------
-- 1. SILVER LAYER – PRODUCT DATA QUALITY CHECKS
-------------------------------------------------------------

-- Check for duplicate or NULL product IDs
SELECT 
    prd_id,
    COUNT(*) AS record_count
FROM silver_db.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1
    OR prd_id IS NULL;


-- Check for unwanted leading or trailing spaces in product names
SELECT 
    prd_nm
FROM silver_db.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);



-------------------------------------------------------------
-- 2. BRONZE LAYER – SALES DATA VALIDATION CHECKS
-------------------------------------------------------------

-- Check for NULLs, negative values, or incorrect sales calculation
SELECT 
    sls_sales,
    sls_quantity,
    sls_price
FROM bronze_db.crm_sales_details
WHERE sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <> sls_quantity * sls_price;



-------------------------------------------------------------
-- 3. SILVER LAYER – DATA STANDARDIZATION CHECKS
-------------------------------------------------------------

-- Review standardized country values
SELECT DISTINCT
    cntry
FROM silver_db.erp_loc_a101;



-------------------------------------------------------------
-- 4. BRONZE LAYER – DATE VALIDATION CHECKS
-------------------------------------------------------------

-- Check for invalid or malformed due dates
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze_db.crm_sales_details
WHERE sls_due_dt <= 0
   OR LENGTH(sls_due_dt) <> 8;


-- Check for logically invalid order dates
-- (order date occurring after ship or due date)
SELECT *
FROM bronze_db.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;



-------------------------------------------------------------
-- 5. REFERENCE DATA SANITY CHECK (OPTIONAL)
-------------------------------------------------------------

-- Review ERP product category reference data
SELECT *
FROM silver_db.erp_px_cat_g1v2;
