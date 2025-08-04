--EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_full_load DATETIME, @end_time_full_load DATETIME
	BEGIN TRY
		PRINT '==================== LOADING BRONZE LAYER ====================='
		SET @start_time_full_load = GETDATE()

		PRINT '>> Truncate table crm_cust_info'
		SET @start_time= GETDATE()
		truncate table bronze.crm_cust_info;
	
		PRINT '>> Insert table crm_cust_info'
		bulk insert bronze.crm_cust_info
		from 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' seconds'
		PRINT '-----------------------'

		PRINT '>> Truncate table crm_prd_info'
		SET @start_time= GETDATE()
		truncate table [bronze].[crm_prd_info];

		PRINT '>> Insert table crm_prd_info'
		bulk insert [bronze].[crm_prd_info]
		from 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' seconds'
		PRINT '-----------------------'

		PRINT '>> Truncate table crm_sales_details'
		SET @start_time= GETDATE()
		truncate table [bronze].[crm_sales_details];

		PRINT '>> Insert table crm_sales_details'
		bulk insert [bronze].[crm_sales_details]
		from 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' seconds'
		PRINT '-----------------------'

		PRINT '>> Truncate table erp_cust_az12'
		SET @start_time= GETDATE()
		truncate table [bronze].[erp_cust_az12];

		PRINT '>> Insert table erp_cust_az12'
		bulk insert [bronze].[erp_cust_az12]
		from 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' seconds'
		PRINT '-----------------------'

		PRINT '>> Truncate table erp_loc_a101'
		SET @start_time= GETDATE()
		truncate table [bronze].[erp_loc_a101];

		PRINT '>> Insert table erp_cust_az12'
		bulk insert [bronze].[erp_loc_a101]
		from 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' seconds'
		PRINT '-----------------------'

		PRINT '>> Truncate table erp_px_cat_g1v2'
		SET @start_time= GETDATE()
		truncate table [bronze].[erp_px_cat_g1v2];

		PRINT '>> Insert table erp_px_cat_g1v2'
		bulk insert [bronze].[erp_px_cat_g1v2]
		from 'C:\Users\IsabelleFerreira\Documents\1. Isabelle Ferreira\Formações\Data Warehouse\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' seconds'
		PRINT '-----------------------'

		SET @end_time_full_load = GETDATE()
		PRINT 'Batching Bronze Layer is completed'
		PRINT '>> Full load duration: ' + CAST( DATEDIFF(second, @start_time_full_load, @end_time_full_load) AS NVARCHAR ) + ' seconds'

	END TRY

	BEGIN CATCH
		PRINT '============================================='
		PRINT 'An error occurred during load of Bronze Layer'
		PRINT 'Error name: ' + error_message()
		PRINT 'Error number: ' + CAST(error_number() AS NVARCHAR)
		PRINT '============================================='
	END CATCH

END
