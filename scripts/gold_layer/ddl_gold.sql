/*
===============================================================================
DDL Script: Create Gold Views
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)
    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.
===============================================================================
*/



--===========================================
  -- Create Dimention:  gold.dim_customers
--===========================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE  VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	el.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE WHEN ci.cst_gndr != N/A THEN ci.cst_gndr
		ELSE COALESCE(ec.gen, N/A)
	END AS gender,
	ec.bdate AS birthdate,
	ci.cst_create_date as create_date
	FROM silver.crm_cust_info ci
	LEFT JOIN silver.erp_cust_az12 ec on ci.cst_key = ec.cid
	LEFT JOIN silver.erp_loc_a101 el on ci.cst_key = el.cid
	WHERE ci.cst_id IS NOT NULL 
GO

--===========================================
  -- Create Dimention: gold.dim_product
--===========================================

IF OBJECT_ID('gold.dim_product', 'V') IS NOT NULL
    DROP VIEW gold.dim_product;
GO
CREATE VIEW gold.dim_product AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY pr.prd_start_dt,pr.prd_key ) AS product_key,
	pr.prd_id AS product_id,
	pr.prd_key AS product_code,
	pr.prd_nm AS product_name,
	pr.cat_id AS category_id,
	ISNULL(px.cat,'N/A') AS category,
	ISNULL(px.subcat, 'N/A') AS sub_category,
	ISNULL(px.maintenance,'N/A') AS maintenance,
	pr.prd_cost AS product_cost,
	pr.prd_line AS product_line,
	pr.prd_start_dt AS product_start_date
FROM silver.crm_prd_info pr
LEFT JOIN silver.erp_px_cat_g1v2 px on pr.cat_id = px.id
WHERE pr.prd_end_dt IS NULL
GO

--===========================================
  -- Create Dimention: gold.fact_sales
--===========================================
  
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT 
	sd.sls_ord_num AS order_number,
	pr.product_key,
	ci.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS ship_date,
	sd.sls_due_dt As due_date,
	sd.sls_sales As sales_amount,
	sd.sls_quantity As quantity,
	sd.sls_price As price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_product pr on sd.sls_prd_key = pr.product_code
LEFT JOIN gold.dim_customers ci on sd.sls_cust_id = ci.customer_id
GO
