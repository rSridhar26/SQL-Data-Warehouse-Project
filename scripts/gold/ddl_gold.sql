/*
=============================================================
Gold Layer – Business Views (Star Schema)
=============================================================
Purpose:
    This script defines the Gold layer of the data warehouse,
    which represents the business-ready analytics layer.

    The Gold layer exposes curated dimension and fact views
    designed using a star schema to support:
    - Reporting and dashboards
    - Ad-hoc analytical queries
    - Business performance analysis

    It integrates trusted data from the Silver layer and
    presents it in a semantic, consumption-friendly format.

Design Principles:
    - Dimensions provide descriptive business context
      (customers, products)
    - Fact tables capture measurable business events
      (sales transactions)
    - Surrogate keys are used for analytical joins
    - No data cleansing or transformation logic is applied
      in this layer

Objects Created:
    - dim_customers : Customer dimension
    - dim_products  : Product dimension
    - fact_sales    : Sales fact table

Note:
    All Gold layer objects are implemented as VIEWS to
    preserve flexibility and ensure the layer always reflects
    the most recent trusted Silver data.
=============================================================
*/



-- =============================================================
-- Gold Layer: Dimension - Customers
-- =============================================================

CREATE OR REPLACE VIEW gold_db.dim_customers AS
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	la.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE 
		WHEN ci.cst_gender != 'n/a' THEN ci.cst_gender -- CRM is the Master for Gender Info
		ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate AS birthdate,
    ci.cst_create_date AS create_date
FROM silver_db.crm_cust_info AS ci
LEFT JOIN silver_db.erp_cust_az12 AS ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver_db.erp_loc_a101 AS la
    ON ci.cst_key = la.cid;

-- =============================================================
-- Gold Layer: Dimension - Products
-- =============================================================

CREATE OR REPLACE view gold_db.dim_products AS
SELECT
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
    pn.cat_id AS category_id,
    pc.cat AS category,
    pc.subcat AS subcategory,
    pc.maintenance,
	pn.prd_cost AS cost,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
FROM silver_db.crm_prd_info AS pn
LEFT JOIN silver_db.erp_px_cat_g1v2 AS pc
	ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- Filter out all historical data
 
-- =============================================================
-- Gold Layer: Fact - Sales
-- =============================================================

CREATE OR REPLACE view gold_db.fact_sales AS
SELECT 	
	sd.sls_ord_num AS order_number,
    pr.product_key,
	cu.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM silver_db.crm_sales_details AS sd
LEFT JOIN gold_db.dim_products AS pr
	ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold_db.dim_customers AS cu
	ON sd.sls_cust_id = cu.customer_id;




