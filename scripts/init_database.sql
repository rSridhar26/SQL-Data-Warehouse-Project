/*
=============================================================
Create Databases for Data Warehouse Layers (MySQL)
=============================================================
Script Purpose:
    This script creates separate databases to represent the 
    Bronze, Silver, and Gold layers of the data warehouse.

    Since MySQL treats databases and schemas equivalently,
    each layer is implemented as its own database to maintain
    logical separation between raw, transformed, and 
    analytics-ready data.

WARNING:
    Running this script will DROP existing databases if they
    already exist. All data inside them will be permanently
    deleted. Use with caution.
=============================================================
*/

-- Drop existing databases if they exist
DROP DATABASE IF EXISTS bronze_db;
DROP DATABASE IF EXISTS silver_db;
DROP DATABASE IF EXISTS gold_db;

-- Create databases
CREATE DATABASE bronze_db;
CREATE DATABASE silver_db;
CREATE DATABASE gold_db;
