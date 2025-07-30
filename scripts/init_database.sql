/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


USE master;
GO

/* In case of creating a backup:
DECLARE @BackupPath NVARCHAR(500) = 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\backups\'; -- Altere conforme o local desejado
DECLARE @Timestamp NVARCHAR(20) = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');
DECLARE @BackupFile NVARCHAR(600) = @BackupPath + 'DataWarehouse_Backup_' + @Timestamp + '.bak';
*/

IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN

/* In case of creating a backup:
	BACKUP database DataWarehouse
	TO DISK = @BackupPath
	WITH FORMAT, INIT, NAME = 'Backup do DataWarehouse antes da exclusão';
*/

	ALTER database DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	DROP database DataWarehouse;
END;
GO

CREATE database DataWarehouse;
GO

/*
Second option:

-- Restaurar o backup no mesmo nome de banco
RESTORE DATABASE DataWarehouse
FROM DISK = 'C:\Backup\DataWarehouse_Backup_20250730_101500.bak'
WITH 
    REPLACE, -- Substitui o banco existente (se houver)
    RECOVERY; -- Deixa o banco pronto para uso
GO

*/


USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
