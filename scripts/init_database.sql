/*
============================
Create Database and Schemas
============================
Script Purpose:
	This script creates database named 'DataWarehouse'. 
	It will check first if the database exist, If exist it will drop and recreate the database.
	Additionally, the scrip sets up three schemas within the database: 'bronze', 'silver', 'gold'.

WARNING:
	Running this script will drop the entire 'DataWarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution and ensure
	you have a backups before running this script.
*/

USE master;
Go

--Drop and recreate the 'DataWarehouse' database
IF EXISTS(SELECT 1 FROM	sys.databases WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

--Create the 'DataWareHouse' database
CREATE DATABASE DataWareHouse;
GO

USE DataWarehouse;


--Create Schemas
Go
CREATE SCHEMA bronze;
Go
CREATE SCHEMA silver;
Go
CREATE SCHEMA gold;
