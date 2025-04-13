/*
=============================================================
Create Database and Configure Schemas
=============================================================
Script Purpose:
    This script drops the 'DataWarehouse' database if it already exists 
    and then recreates it. It also creates three schemas within the database: 
    'bronze', 'silver', and 'gold'.

Note:
    If the 'DataWarehouse' database exists, it will be completely deleted.  
    All data will be lost. Please make sure you have proper backups 
    before running this script.
*/
-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO
--Create new database DataWarehouse
create database DataWarehouse
go

-- call the DataWarehouse
use DataWarehouse
go

--Create schema for bronze, silver and gold layer
create schema bronze;
go
create schema silver;
go
create schema gold;
go











