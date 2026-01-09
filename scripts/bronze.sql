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



-- Customer Master Table 
TRUNCATE TABLE bronze_db.crm_cust_info;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info.csv'
INTO TABLE bronze_db.crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  @cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_marital_status,
  cst_gender,
  @cst_create_date
)
SET
  cst_id = NULLIF(@cst_id, ''),
  cst_create_date = NULLIF(@cst_create_date, '');

-- Product Master Table
TRUNCATE TABLE bronze_db.crm_prd_info;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv'
INTO TABLE bronze_db.crm_prd_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  @prd_id,
  prd_key,
  prd_nm,
  @prd_cost,
  prd_line,
  @prd_start_dt,
  @prd_end_dt
)
SET
  prd_id       = NULLIF(@prd_id, ''),
  prd_cost     = NULLIF(@prd_cost, ''),
  prd_start_dt = NULLIF(@prd_start_dt, ''),
  prd_end_dt   = NULLIF(@prd_end_dt, '');

-- Sales Transaction Table
TRUNCATE TABLE bronze_db.crm_sales_details;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv'
INTO TABLE bronze_db.crm_sales_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  sls_ord_num,
  sls_prd_key,
  @sls_cust_id,
  @sls_order_dt,
  @sls_ship_dt,
  @sls_due_dt,
  @sls_sales,
  @sls_quantity,
  @sls_price
)
SET
  sls_cust_id  = NULLIF(@sls_cust_id, ''),
  sls_order_dt = NULLIF(@sls_order_dt, ''),
  sls_ship_dt  = NULLIF(@sls_ship_dt, ''),
  sls_due_dt   = NULLIF(@sls_due_dt, ''),
  sls_sales    = NULLIF(@sls_sales, ''),
  sls_quantity = NULLIF(@sls_quantity, ''),
  sls_price    = NULLIF(@sls_price, '');

-- Customer Demographics Table
TRUNCATE TABLE bronze_db.erp_cust_az12;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_az12.csv'
INTO TABLE bronze_db.erp_cust_az12
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  @cid,
  @bdate,
  @gen
)
SET
  cid   = NULLIF(@cid, ''),
  bdate = NULLIF(@bdate, ''),
  gen   = NULLIF(@gen, '');

-- Customer Location Reference Table
TRUNCATE TABLE bronze_db.erp_loc_a101;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loc_a101.csv'
INTO TABLE bronze_db.erp_loc_a101
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  cid,
  cntry
);


-- Product Category Reference Table
TRUNCATE TABLE bronze_db.erp_px_cat_g1v2;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/px_cat_g1v2.csv'
INTO TABLE bronze_db.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  @id,
  @cat,
  @subcat,
  @maintenance
)
SET
id          = NULLIF(@id, ''),
cat         = NULLIF(@cat, ''),
subcat      = NULLIF(@subcat, ''),
maintenance = NULLIF(@maintenance, '');
